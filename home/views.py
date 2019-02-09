from django.shortcuts import render, redirect
from .models import Station, TypeOfBike,Stationroutes, StationOnReservation, Reservation, BikeOnReservation, ReservationType,Bike, StatusOfBike
from .forms import ExampleForm, RegistrationForm, EditProfileForm
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from datetime import datetime, timedelta,timezone
from django.http import HttpResponse,JsonResponse
import json
import time
from django.core.mail import EmailMessage
from django.utils.crypto import get_random_string
import pytz
utc=pytz.UTC
def home(request):
    return render(request, 'user/home.html')

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request,'You are now registered!')
        else:
            messages.error(request,'The form is invalid.')

        return render(request,'user/reg_form.html',{'form': form})
    else:
        form = RegistrationForm()
        return render(request,'user/reg_form.html',{'form': form})


def reserve(request):
    if request.method == 'POST':
            #EDGAR --------------------------------------------------------------------------------------
            if request.POST.get('formtype','') == 'time':
                startdatetime = datetime.strptime(request.POST.get('startdate','')+' '+request.POST.get('starttime',''),'%d %b %Y %I:%M %p')
                enddatetime = datetime.strptime(request.POST.get('enddate','')+' '+request.POST.get('endtime',''),'%d %b %Y %I:%M %p')
                startstationid = Station.objects.get(name = request.POST.get('startstation','')).station_id
                endstationid = Station.objects.get(name = request.POST.get('endstation','')).station_id
                return HttpResponse(
                    json.dumps(getBikes(startdatetime,enddatetime,startstationid,endstationid,1)),
                    content_type="application/json"
                    )
            else:
                startstation = Station.objects.get(name=(request.POST.get("inputstartstation","")))
                endstation = Station.objects.get(name=(request.POST.get("inputendstation","")))
                startstationid = startstation.station_id
                endstationid = endstation.station_id
                route = Stationroutes.objects.get(start_station_id=startstationid,end_station_id=endstationid)
                startdatetime = datetime.strptime(request.POST.get("inputstartdate","")+' '+request.POST.get("inputstarttime",""),'%d %b %Y %I:%M %p')
                enddatetime = datetime.strptime(request.POST.get("inputenddate","")+' '+request.POST.get("inputendtime",""),'%d %b %Y %I:%M %p')
                totalcost = float(request.POST.get("inputtotal",""))
                currentDateTime=datetime.now()
                reservationType = ReservationType.objects.get(res_type_name='future')
                bikes = {}
                inputbikelen = 0
                for i in range(len(TypeOfBike.objects.all())):
                    bikes[i] = int(request.POST.get("inputbike"+str(i+1)))
                    print(bikes[i])
                    inputbikelen += 1   #gets the total number of bikes that user wanted on the bike select page
                #For each bike type
                biked = {}  #these are the bikes that are allowed to be reserved by the user
                finalbikes = {} #these are the bikes that WILL be reserved to the user

                # for each of the bike types
                biked = getBikes(startdatetime, enddatetime, startstationid, endstationid, 2)
                print (biked[0].bike_type.bike_type_id)
                if inputbikelen > len(biked): #Check if the total number of bikes selected is greater than the no of bikes that can be reserved, then do an error as we cannot reserve the amount the user wanted
                       #do error here
                    print('error123')
                else:
                    #this whole part checks the biked tuple and selects the bikes of certain types on what the user wanted, the bikes gets stored in the finalbikes tuple
                    x = 0
                    for b in range(len(biked)):
                        print('asdasdasd $s', biked[b])
                        print('123', bikes[biked[b].bike_type.bike_type_id-1])
                        if bikes[biked[b].bike_type.bike_type_id-1] > 0:
                            bikes[biked[b].bike_type.bike_type_id-1] -= 1
                            print(bikes[biked[b].bike_type.bike_type_id])
                            finalbikes[x] = biked[b]
                            inputbikelen -= 1
                            x += 1
                            if inputbikelen == 0:
                                break

                    user = User.objects.get(id=request.user.id)
                    random = get_random_string(length=6, allowed_chars='1234567890')
                    while(Reservation.objects.filter(res_code=random).exists()):
                        random = get_random_string(length=6, allowed_chars='1234567890')
                    reservation = Reservation.objects.create(res_type=reservationType,res_cost=totalcost,res_date=currentDateTime,starttime=startdatetime,endtime=enddatetime,c=user,res_code=random)
                    stationreservation = StationOnReservation.objects.create(sor_reservation=reservation,sor_route=route)
                    for biken in range(len(finalbikes)):
                        bikereservation = BikeOnReservation.objects.create(bor_bike=finalbikes[biken],bor_reservation_id=reservation.reservation_id)

                    # this is the part that takes time when reserving
                    messagew= 'Hi there '+request.user.first_name+' '+request.user.last_name+',      \nHere are the details of the reservation you just made on TooTyred.com! \n Your reservation starts on '+startdatetime.strftime('%d %b %Y %I:%M %p')+' at the station '+startstation.name+', '+startstation.address+'\n Your reservation ends on '+enddatetime.strftime('%d %b %Y %I:%M %p')+' at the station '+endstation.name+', '+endstation.address+'\n Your reservation ID is '+str(reservation.reservation_id)+ '\n Your reservation QR code is '+reservation.res_code+'\n The bikes you selected are \n'
                    for i in range(len(finalbikes)):
                        messagew+=str(i+1)+' '+finalbikes[i].bike_type.bike_type+' \n'
                    messagew+='\n Your total cost that you paid for this reservation is €'+str(totalcost)+'\n Thank you for reserving a bike on our website! Hope you have a great ride!'
                    email = EmailMessage('Your TooTyred Reservation', messagew, to=[request.user.email])
                    email.send()
                    return redirect('/home/reservations/')
    else:
        cost=20
        reservationdays = 14
        if not Reservation.objects.filter(c=request.user.id).exists():
            messages.success(request,'Double click markers to select start and end station! Click once to learn more about the station!')
        return render(request, 'user/reserve.html', {'station':Station.objects.all(),'bike_type':TypeOfBike.objects.all(),'reservationdays':reservationdays,'costperhour':cost})

def reservations(request):
    if request.method == 'POST':
            # --------------------------------------------------------------------------------------
            if request.POST.get('formtype','') == 'timeedit':
                reservationnumber = request.POST.get('reservationnumber','')
                response_data={}
                response_data[0]=request.POST.get('reservationnumber','')
                #get all the times available for start time and end time
                # if there is a reservation for Bikes A,B,C from 5PM to 6PM on Jan 1
                #get all times the reservations can be moved backwards or forward
                #so if the bikes A,B,C are at the station from 3PM to 8PM on Jan 1
                # return the times 3PM Jan1,3:15PM Jan1,3:30PM Jan1,3:45PM Jan 1.....6PM Jan1

                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            elif request.POST.get('formtype','') == 'cancel':
                reservationnumber = request.POST.get('reservationcode','')
                reservation = Reservation.objects.get(reservation_id=reservationnumber)
                cost = reservation.res_cost
                messagew= 'Hi there '+request.user.first_name+' '+request.user.last_name+',      \nYour reservation of code '+reservation.res_code+' is cancelled successfully! \n'
                messagew+='\n Your total cost that will be refunded is €'+str(reservation.res_cost)+'\n Hope you had a great experience on our website! And keep reserving!'
                email = EmailMessage('Your TooTyred Reservation', messagew, to=[request.user.email])
                email.send()
                bikes = BikeOnReservation.objects.filter(bor_reservation_id=reservation.reservation_id)
                bikes.delete()
                    #print(bike.id)
                StationOnReservation.objects.filter(sor_reservation_id=reservation.reservation_id).delete()
                #remove the reservations
                reservation.delete()
                #remove all station on that reservation
                response_data={}
                response_data[0]=str(cost)
                #get all the times available for start time and end time
                # if there is a reservation for Bikes A,B,C from 5PM to 6PM on Jan 1
                #get all times the reservations can be moved backwards or forward
                #so if the bikes A,B,C are at the station from 3PM to 8PM on Jan 1
                # return the times 3PM Jan1,3:15PM Jan1,3:30PM Jan1,3:45PM Jan 1.....6PM Jan1
                # this is the part that takes time when reserving
                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            #-------------------------------------------
            elif request.POST.get('formtype','') == 'time':
                startdatetime = datetime.strptime(request.POST.get('startdate','')+' '+request.POST.get('starttime',''),'%d %b %Y %I:%M %p')
                enddatetime = datetime.strptime(request.POST.get('enddate','')+' '+request.POST.get('endtime',''),'%d %b %Y %I:%M %p')
                startstationid = Station.objects.get(name = request.POST.get('startstation','')).station_id
                endstationid = Station.objects.get(name = request.POST.get('endstation','')).station_id
                return HttpResponse(
                    json.dumps(getBikes(startdatetime,enddatetime,startstationid,endstationid,1)),
                    content_type="application/json"
                    )
            else:
                reservationnumber = request.POST.get("reservation","")
                startstation = Station.objects.get(name=(request.POST.get("inputstartstation","")))
                endstation = Station.objects.get(name=(request.POST.get("inputendstation","")))
                startstationid = startstation.station_id
                endstationid = endstation.station_id
                route = Stationroutes.objects.get(start_station_id=startstation,end_station_id=endstation)
                startdatetime = datetime.strptime(request.POST.get("inputstartdate","")+' '+request.POST.get("inputstarttime",""),'%d %b %Y %I:%M %p')
                enddatetime = datetime.strptime(request.POST.get("inputenddate","")+' '+request.POST.get("inputendtime",""),'%d %b %Y %I:%M %p')
                totalcost = float(request.POST.get("inputtotal",""))
                currentDateTime=datetime.now()
                reservationType = ReservationType.objects.get(res_type_name='future')
                bikes = {}
                inputbikelen = 0
                for i in range(len(TypeOfBike.objects.all())):
                    bikes[i] = int(request.POST.get("inputbike"+str(i+1)))
                    print(bikes[i])
                    inputbikelen += 1   #gets the total number of bikes that user wanted on the bike select page
                #For each bike type
                biked = {}  #these are the bikes that are allowed to be reserved by the user
                finalbikes = {} #these are the bikes that WILL be reserved to the user

                # for each of the bike types
                biked = getBikes(startdatetime, enddatetime, startstationid, endstationid, 2)
                print (biked[0].bike_type.bike_type_id)
                if inputbikelen > len(biked): #Check if the total number of bikes selected is greater than the no of bikes that can be reserved, then do an error as we cannot reserve the amount the user wanted
                    #do error here
                    print('error123')
                else:
                    #this whole part checks the biked tuple and selects the bikes of certain types on what the user wanted, the bikes gets stored in the finalbikes tuple
                    x = 0
                    for b in range(len(biked)):
                        print('asdasdasd $s', biked[b])
                        print('123', bikes[biked[b].bike_type.bike_type_id-1])
                        if bikes[biked[b].bike_type.bike_type_id-1] > 0:
                            bikes[biked[b].bike_type.bike_type_id-1] -= 1
                            print(bikes[biked[b].bike_type.bike_type_id])
                            finalbikes[x] = biked[b]
                            inputbikelen -= 1
                            x += 1
                            if inputbikelen == 0:
                                break
                    reservation = Reservation.objects.get(reservation_id=reservationnumber)
                    reservation.res_cost = totalcost
                    reservation.res_date = currentDateTime
                    for biken in range(len(finalbikes)):
                        bikereservation = BikeOnReservation.objects.create(bor_bike=finalbikes[biken],bor_reservation_id=reservation.reservation_id)
                    user = User.objects.get(id=request.user.id)
                    reservation.save()
                    return redirect('/home/reservations/')
    else:
        futurereservations = Reservation.objects.raw("select r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname, sse.name as endname  from stationroutes sr,station_on_reservation s, reservation r,station ss,station sse where s.sor_route_id=sr.route_id and r.reservation_id = s.sor_reservation_id and sr.start_station_id = ss.station_id and sr.end_station_id = sse.station_id and r.c_id=%s and r.res_type=3",(request.user.id,))
        pastreservations = Reservation.objects.raw("select r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname, sse.name as endname  from stationroutes sr,station_on_reservation s, reservation r,station ss,station sse where s.sor_route_id=sr.route_id and r.reservation_id = s.sor_reservation_id and sr.start_station_id = ss.station_id and sr.end_station_id = sse.station_id and r.c_id=%s and r.res_type=1",(request.user.id,))
        bikesonreservations =  Bike.objects.raw("select b.bike_id as bike_id, b.bike_type as bike_type,br.bor_reservation_id as bor_reservation_id from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id");
        cost=20
        reservationdays = 14
        nows =  utc.localize(datetime.now()) + timedelta(days=1)
        return render(request,"user/reservations.html",{'now': nows,'pastreservations':pastreservations,'station':Station.objects.all(),'futurereservations': futurereservations,'bikesonreservations':bikesonreservations,'bike_type':TypeOfBike.objects.all(),'reservationdays':reservationdays,'costperhour':cost})

def getBikes(startdatetime,enddatetime,startstationid,endstationid,typeindicator): #typeindicator indicates whos calling this function and determines what to return ()
    response_data={}
    count = 0 # for adding bikes


    if (typeindicator == 1):
        for i in (range(len(TypeOfBike.objects.all()))):
            response_data['result'+str(i+1)] = 0 # bikes[i]


        '''
        time1 = '2019-1-27 18:00:00'
        id1 = 2

        #test query for special test i've made
        query1 = Bike.objects.raw('SELECT bike_id, bike_type FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation, \
            station_on_reservation, stationroutes WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id AND sor_route_id = route_id AND \
            sor_reservation_id = reservation_id AND (res_type = 2 OR res_type = 3) AND endtime > \'2019-1-27 18:00:00\') AND bike_id IN \
            (SELECT bike_id FROM bike, reservation, bike_on_reservation, station_on_reservation, stationroutes WHERE bor_bike_id = bike_id AND \
            bor_reservation_id = reservation_id AND sor_route_id = route_id AND sor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)\
             AND end_station_id = 2 AND endtime < \'2019-1-27 18:00:00\') OR bike_id IN ( SELECT bike_id FROM bike WHERE bike_id NOT IN (SELECT bike_id\
              FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3))\
               AND bike_stationedat = 2)')



        #---- real query for running without values
        query2 = Bike.objects.raw('SELECT bike_id, bike_type FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation, \
            station_on_reservation, stationroutes WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id AND sor_route_id = route_id AND \
            sor_reservation_id = reservation_id AND (res_type = 2 OR res_type = 3) AND endtime > %s) AND bike_id IN \
            (SELECT bike_id FROM bike, reservation, bike_on_reservation, station_on_reservation, stationroutes WHERE bor_bike_id = bike_id AND \
            bor_reservation_id = reservation_id AND sor_route_id = route_id AND sor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)\
             AND end_station_id = %s AND endtime < %s) OR bike_id IN ( SELECT bike_id FROM bike WHERE bike_id NOT IN (SELECT bike_id\
              FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3))\
               AND bike_stationedat = %s)', [startdatetime, getstationid, startdatetime, getstationid])
        '''



    #bikes that are on current or future reservations that doesnt intersect with the timings that we want
    fut_ong_bikes = Bike.objects.raw('SELECT bike_id FROM bike, reservation, bike_on_reservation, station_on_reservation, stationroutes WHERE bor_bike_id = bike_id \
        AND bor_reservation_id = reservation_id AND sor_route_id = route_id AND sor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3) \
        AND NOT ((starttime < %s AND endtime >= %s) OR (starttime >= %s AND starttime <= %s)) GROUP BY bike_id', [startdatetime, startdatetime, startdatetime, enddatetime])


    #bikes with no current or future reservations that is stationed at the inputted start station
    no_fut_ong_bikes = Bike.objects.raw(' SELECT bike_id FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND \
        bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_stationedat = %s', [startstationid])


    if not fut_ong_bikes and not no_fut_ong_bikes:
        return response_data
    else:


        if no_fut_ong_bikes:
            for bikeobj2 in no_fut_ong_bikes:
                print('bike allowed: %s', [bikeobj2.bike_id])

                if (typeindicator == 1):
                    biketypenumber = bikeobj2.bike_type.bike_type_id
                    response_data['result'+str(biketypenumber)] += 1

                if (typeindicator == 2):
                    response_data[count] = bikeobj2
                    count += 1




        #if there are values inside the fut_ong_bikes query
        if fut_ong_bikes:
            for bikeobj1 in fut_ong_bikes:


                #get the bike_id value for bikeobj
                b_id = bikeobj1.bike_id
                #get the bike_type value for bikeobj
                b_type = bikeobj1.bike_type.bike_type_id

                #gets the earliest reservation which is closest to the inputed start time
                get_before_starttime_reserv = Reservation.objects.raw('SELECT reservation_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND \
                    bor_reservation_id = reservation_id AND bike_id = %s AND endtime < %s ORDER BY endtime DESC LIMIT 1;',[b_id, startdatetime])

                #gets the latest reservation which is closest to inputed end time
                get_after_endtime_reserv = Reservation.objects.raw('SELECT reservation_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND \
                    bor_reservation_id = reservation_id AND bike_id = %s AND starttime > %s ORDER BY starttime LIMIT 1;',[b_id, enddatetime])



                if get_before_starttime_reserv and get_after_endtime_reserv:
                    before_starttime_reserv_id = get_before_starttime_reserv[0].reservation_id
                    before_starttime_reserv_station = Stationroutes.objects.raw('SELECT route_id FROM stationroutes, station_on_reservation, reservation WHERE sor_route_id = route_id AND sor_reservation_id = reservation_id  AND reservation_id = %s', [before_starttime_reserv_id])
                    after_endtime_reserv_id = get_after_endtime_reserv[0].reservation_id
                    after_endtime_reserv_station = Stationroutes.objects.raw('SELECT route_id FROM stationroutes, station_on_reservation, reservation WHERE sor_route_id = route_id AND sor_reservation_id = reservation_id  AND reservation_id = %s', [after_endtime_reserv_id])
                    print('its goint to a')

                    if before_starttime_reserv_station[0].end_station_id == startstationid and after_endtime_reserv_station[0].start_station_id == endstationid:
                        print('bike allowed a: %s', [b_id])

                        if (typeindicator == 1):
                            response_data['result'+str(b_type)] += 1
                        if (typeindicator == 2):
                            response_data[count] = bikeobj1
                            count += 1
                elif get_before_starttime_reserv:
                    before_starttime_reserv_id = get_before_starttime_reserv[0].reservation_id
                    before_starttime_reserv_station = Stationroutes.objects.raw('SELECT route_id FROM stationroutes, station_on_reservation, reservation WHERE sor_route_id = route_id AND sor_reservation_id = reservation_id  AND reservation_id = %s', [before_starttime_reserv_id])
                    print('its goint to b')
                    if before_starttime_reserv_station[0].end_station_id == startstationid:
                        print('bike allowed b: %s', [b_id])
                        if (typeindicator == 1):
                            response_data['result'+str(b_type)] += 1
                        if (typeindicator == 2):
                            response_data[count] = bikeobj1
                            count += 1
                else:
                    after_endtime_reserv_id = get_after_endtime_reserv[0].reservation_id
                    after_endtime_reserv_station = Stationroutes.objects.raw('SELECT route_id FROM stationroutes, station_on_reservation, reservation WHERE sor_route_id = route_id AND sor_reservation_id = reservation_id  AND reservation_id = %s', [after_endtime_reserv_id])
                    print('its goint to c')
                    if after_endtime_reserv_station[0].start_station_id == endstationid and bikeobj1.bike_stationedat.station_id == startstationid:
                        print('bike allowed c: %s', [b_id])
                        if (typeindicator == 1):
                            response_data['result'+str(b_type)] += 1
                        if (typeindicator == 2):
                            response_data[count] = bikeobj1
                            count += 1
        return response_data


def logout(request):
    return render(request,"user/home.html")


def account(request):
    form1 = EditProfileForm(instance=request.user)
    form2 = PasswordChangeForm(user=request.user)
    args={'form1':form1,'form2':form2, 'user':request.user}
    return render(request,"user/account.html",args)


def changeaccount(request):
        if request.method == 'POST':
            form = EditProfileForm(request.POST,instance=request.user)
            if form.is_valid():
                form.save()
                messages.success(request, ('Your account details were successfully updated'))
                return redirect('/home/account/')
            else:
                messages.error(request, ('Your email format was invalid, try again'))
                return redirect('/home/account/')

def deleteaccount(request):
        user = request.user
        user.is_active = False
        user.save()
        messages.success(request, 'Profile successfully disabled. Thank you for everything, Have a great day!')
        return redirect('/home/login/')

#CHANGE PASSWORD VALIDATION NOT THERE----------
def changepassword(request):
    if request.method == 'POST':
        form = PasswordChangeForm(data=request.POST,user=request.user)
        if form.is_valid():
            form.save()
            update_session_auth_hash(request,form.user)
            messages.success(request, ('Your password was successfully updated!'))
            return redirect('/home/account/')
        else:
            messages.error(request, ('Your password was invalid'))
            return redirect('/home/account/')

def termsandconditions(request):
    return render(request,"user/termsandconditions.html")
