from django.shortcuts import render, redirect
from .models import Station, TypeOfBike,Stationroutes, StationOnReservation,CustomerRating, Reservation, BikeOnReservation, ReservationType,Bike, StatusOfBike
from .forms import RegistrationForm, EditProfileForm, enquiryForm
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from datetime import datetime, timedelta,timezone
from django.http import HttpResponse,JsonResponse
from django.db import connection
import json
import time
from django.core.mail import EmailMessage
from django.utils.crypto import get_random_string
import pytz
utc=pytz.UTC
import time
def home(request):
    bikeDescription =  TypeOfBike.objects.all();
    if request.method == 'POST':
        form =  enquiryForm(request.POST)
        if form.is_valid():
            form.save()
            form=enquiryForm()
            return render(request, 'user/home.html',{'bikeDesc': bikeDescription,'form': form,'station':Station.objects.all(),'sent':True})
        else:
            return render(request, 'user/home.html',{'bikeDesc': bikeDescription,'form': form,'station':Station.objects.all(),'sent':False})
    else:
        form = enquiryForm()
        return render(request, 'user/home.html',{'bikeDesc': bikeDescription,'form': form,'station':Station.objects.all(),'sent':False})

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request,'You are now registered!')
            return redirect('/home/login/')
        else:
            messages.error(request,'The form is invalid.')
            return render(request,'user/reg_form.html',{'form': form})
    else:
        form = RegistrationForm()
        return render(request,'user/reg_form.html',{'form': form})


def reserve(request):
    if request.method == 'POST':
            #The form submitted time now get the bikes using time
            if request.POST.get('formtype','') == 'time':
                startdatetime = utc.localize(datetime.strptime(request.POST.get('startdate','')+' '+request.POST.get('starttime',''),'%d %b %Y %I:%M %p'))
                enddatetime = utc.localize(datetime.strptime(request.POST.get('enddate','')+' '+request.POST.get('endtime',''),'%d %b %Y %I:%M %p'))
                startstationid = Station.objects.get(name = request.POST.get('startstation','')).station_id
                endstationid = Station.objects.get(name = request.POST.get('endstation','')).station_id
                return HttpResponse(
                    json.dumps(getBikes(startdatetime,enddatetime,startstationid,endstationid,1)),
                    content_type="application/json")
            #The form submitted is when reservation is complete and now insertion of reservation in database
            else:
                startstation = Station.objects.get(name=(request.POST.get("inputstartstation","")))
                endstation = Station.objects.get(name=(request.POST.get("inputendstation","")))
                startdatetime = utc.localize(datetime.strptime(request.POST.get("inputstartdate","")+' '+request.POST.get("inputstarttime",""),'%d %b %Y %I:%M %p'))
                enddatetime = utc.localize(datetime.strptime(request.POST.get("inputenddate","")+' '+request.POST.get("inputendtime",""),'%d %b %Y %I:%M %p'))
                totalcost = float(request.POST.get("inputtotal",""))
                currentDateTime=utc.localize(datetime.now())
                bikes = {}
                inputbikelen = 0
                for i in range(len(TypeOfBike.objects.all())):
                    bikes[i] = int(request.POST.get("inputbike"+str(i+1)))
                    #print(bikes[i])
                    inputbikelen += bikes[i]   #gets the total number of bikes that user wanted on the bike select page
                #For each bike type
                biked = {}  #these are the bikes that are allowed to be reserved by the user
                finalbikes = set() #these are the bikes that WILL be reserved to the user
                print('types of bikes and shit', bikes)

                # for each of the bike types
                biked = getBikes(startdatetime, enddatetime, startstation.station_id, endstation.station_id, 2)
                print (biked[0].bike_type.bike_type_id)
                bikelen=0
                for i in range(len(biked)):
                    bikelen += biked[i].bike_type.bike_type_id
                if inputbikelen > len(biked): #Check if the total number of bikes selected is greater than the no of bikes that can be reserved, then do an error as we cannot reserve the amount the user wanted
                       #do error here
                    print('error123')
                else:
                    #this whole part checks the biked tuple and selects the bikes of certain types on what the user wanted, the bikes gets stored in the finalbikes tuple
                    x = 0
                    for b in range(len(biked)):
                        #print('asdasdasd $s', biked[b])
                        #print('123', bikes[biked[b].bike_type.bike_type_id-1])
                        if inputbikelen <= 0:
                            break
                        else:
                            if bikes[biked[b].bike_type.bike_type_id-1] > 0:
                                bikes[biked[b].bike_type.bike_type_id-1] -= 1
                                finalbikes.add(biked[b])
                                inputbikelen -= 1
                                x += 1


                    print(finalbikes)
                    user = User.objects.get(id=request.user.id)
                    random = get_random_string(length=6, allowed_chars='1234567890')
                    while(Reservation.objects.filter(res_code=random).exists()):
                        random = get_random_string(length=6, allowed_chars='1234567890')
                    reservation = Reservation.objects.create(res_type=ReservationType.objects.get(res_type_name='future'),res_cost=totalcost,res_date=currentDateTime,starttime=startdatetime,endtime=enddatetime,c=user,res_code=random)
                    stationreservation = StationOnReservation.objects.create(sor_reservation=reservation,sor_route=Stationroutes.objects.get(start_station_id=startstation.station_id,end_station_id=endstation.station_id))
                    for biken in finalbikes:
                        bikereservation = BikeOnReservation.objects.create(bor_bike=biken,bor_reservation_id=reservation.reservation_id)

                    # this is the part that takes time when reserving
                    messagew= 'Hi there '+request.user.first_name+' '+request.user.last_name+',      \nHere are the details of the reservation you just made on TooTyred.com! \n Your reservation starts on '+startdatetime.strftime('%d %b %Y %I:%M %p')+' at the station '+startstation.name+', '+startstation.address+'\n Your reservation ends on '+enddatetime.strftime('%d %b %Y %I:%M %p')+' at the station '+endstation.name+', '+endstation.address+'\n Your reservation ID is '+str(reservation.reservation_id)+ '\n Your reservation QR code is '+reservation.res_code+'\n The bikes you selected are \n'
                    count = 1;
                    for i in finalbikes:
                        messagew+=str(count)+' '+i.bike_type.bike_type+' \n'
                        count += 1;
                    messagew+='\n Your total cost that you paid for this reservation is €'+str(totalcost)+'\n Thank you for reserving a bike on our website! Hope you have a great ride!'
                    email = EmailMessage('Your TooTyred Reservation', messagew, to=[request.user.email])
                    email.send()
                    return redirect('/home/reservations/')
    else:
        cost=20
        reservationdays = 14
        checkMessages(request)
        if not Reservation.objects.filter(c=request.user.id).exists():
            messages.success(request,'Double click markers to select start and end station! Click once to learn more about the station!')
        return render(request, 'user/reserve.html', {'station':Station.objects.all(),'bike_type':TypeOfBike.objects.all(),'reservationdays':reservationdays,'costperhour':cost})

def reservations(request):
    if request.method == 'POST':
            if request.POST.get('formtype','') == 'feedback':
                reservationnumber = request.POST.get('reservationcode','')
                reservation = Reservation.objects.get(res_code=reservationnumber)
                response_data={}
                response_data[0]=request.POST.get('reservationcode','')
                #if the reservation is ongoing
                if(reservation.res_type==ReservationType.objects.get(res_type_id=2)):
                    print('its an issue ')

                    #set the travel count to 0 showing that the bikes were replaced
                    # and then transfer the bikes to their location as needed for future reservations
                    oldbikes = {}
                    for i in range(len(TypeOfBike.objects.all())):
                        getoldbiketypecount = Bike.objects.raw('SELECT bike_id, count(*) AS count1 FROM bike_on_reservation, bike WHERE bike_id = bor_bike_id AND bike_type = %s AND bor_reservation_id = %s',[i+1, reservationnumber])
                        oldbikes[i] = getoldbiketypecount[0].count1
                        print('getoldbiketypecount: ', getoldbiketypecount[0].count1)

                    bikestodelete = set()
                    for i in range(len(TypeOfBike.objects.all())):
                        getoldbikespertype = Bike.objects.raw('SELECT bike_id FROM bike_on_reservation, bike WHERE bike_id = bor_bike_id AND bike_type = %s AND bor_reservation_id = %s',[i+1, reservationnumber])
                        for oldbike in getoldbikespertype:
                            bike_check_resquery = Reservation.objects.raw('SELECT reservation_id FROM bike_on_reservation, reservation WHERE bor_reservation_id = reservation_id AND res_type = 3 AND starttime > %s AND bor_bike_id = %s ORDER BY starttime LIMIT 1', [reservation.starttime, oldbike.bike_id])
                            if bike_check_resquery:
                                newstationedatquery = Stationroutes.objects.raw('SELECT route_id, start_station_id AS s_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = %s', [bike_check_resquery[0].reservation_id])
                                bikestodelete.add(oldbike.bike_id)
                                #bike is replaced
                                oldbike.travel_count=0
                                oldbike.bike_stationedat = Station.objects.get(station_id = newstationedatquery[0].s_id)
                                oldbike.bike_status=StatusOfBike.objects.get(bike_status_id=1)
                                oldbike.save()
                            else:
                                oldbike.bike_stationedat = None
                                oldbike.bike_status= StatusOfBike.objects.get(bike_status_id=4)
                                oldbike.travel_count=0
                                bikestodelete.add(oldbike.bike_id)
                                oldbike.save()
                    reservation.res_type=ReservationType.objects.get(res_type_id=1)
                    reservation.res_cost=0
                    reservation.fine_cost=None
                    reservation.fine_desc=None
                    reservation.fined_at=None
                    reservation.c_rating=None
                    reservation.feedback="REPORT: "+request.POST.get('feedback','')
                else:
                    print(reservation.c_rating)
                    reservation.c_rating=CustomerRating.objects.get(rating_id=request.POST.get('rating',''))
                    reservation.feedback=request.POST.get('feedback','')
                reservation.save()
                #reservation.feedback=request.POST.get('feedback','')
                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            # --------------------------------------------------------------------------------------
            elif request.POST.get('formtype','') == 'fine':
                reservationnumber = request.POST.get('reservationcode','')
                reservation = Reservation.objects.get(reservation_id=reservationnumber)
                reservation.fine_desc=None
                reservation.save()
                response_data={}
                response_data[0]=request.POST.get('reservationcode','')
                messagew= 'Hi there '+request.user.first_name+' '+request.user.last_name+',      \nYour fine for reservation of code '+reservation.res_code+' has been succesfully paid! \n'
                messagew+='\n The total fine you paid is €'+str(reservation.fine_cost)+'\n Hope you had a great experience on our website! And keep reserving!'
                email = EmailMessage('Your TooTyred Reservation', messagew, to=[request.user.email])
                email.send()
                #reservation.feedback=request.POST.get('feedback','')
                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            # --------------------------------------------------------------------------------------
            elif request.POST.get('formtype','') == 'cancel':
                reservationnumber = request.POST.get('reservationcode','')
                reservation = Reservation.objects.get(reservation_id=reservationnumber)
                cost = reservation.res_cost
                #send an email saying refund needs to be processed
                messagew= 'Hi there '+request.user.first_name+' '+request.user.last_name+',      \nYour reservation of code '+reservation.res_code+' is cancelled successfully! \n'
                messagew+='\n Your total cost that will be refunded is €'+str(reservation.res_cost)+'\n Send us an email specifying your account number and account name and further updates will be made. \nHope you had a great experience on our website! And keep reserving!'
                email = EmailMessage('Your TooTyred Reservation', messagew, to=[request.user.email])
                email.send()
                #remove all bikes on that reservation
                bikes = BikeOnReservation.objects.filter(bor_reservation_id=reservation.reservation_id)
                #
                #
                #
                oldbikes = {}
                for i in range(len(TypeOfBike.objects.all())):
                    getoldbiketypecount = Bike.objects.raw('SELECT bike_id, count(*) AS count1 FROM bike_on_reservation, bike WHERE bike_id = bor_bike_id AND bike_type = %s AND bor_reservation_id = %s',[i+1, reservationnumber])
                    oldbikes[i] = getoldbiketypecount[0].count1
                    print('getoldbiketypecount: ', getoldbiketypecount[0].count1)

                bikestodelete = set()
                for i in range(len(TypeOfBike.objects.all())):
                    getoldbikespertype = Bike.objects.raw('SELECT bike_id FROM bike_on_reservation, bike WHERE bike_id = bor_bike_id AND bike_type = %s AND bor_reservation_id = %s',[i+1, reservationnumber])
                    for oldbike in getoldbikespertype:
                        bike_check_resquery = Reservation.objects.raw('SELECT reservation_id FROM bike_on_reservation, reservation WHERE bor_reservation_id = reservation_id AND res_type = 3 AND starttime > %s AND bor_bike_id = %s ORDER BY starttime LIMIT 1', [reservation.starttime, oldbike.bike_id])
                        if bike_check_resquery:
                            newstationedatquery = Stationroutes.objects.raw('SELECT route_id, start_station_id AS s_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = %s', [bike_check_resquery[0].reservation_id])
                            bikestodelete.add(oldbike.bike_id)
                            oldbike.bike_stationedat = Station.objects.get(station_id = newstationedatquery[0].s_id)
                            oldbike.save()
                        else:
                            bikestodelete.add(oldbike.bike_id)
                #
                #
                #
                bikes.delete()
                #remove all station on that reservation
                StationOnReservation.objects.filter(sor_reservation_id=reservation.reservation_id).delete()
                #remove the reservations
                reservation.delete()
                response_data={}
                response_data[0]=str(cost)
                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            # --------------------------------------------------------------------------------------
            else:
                startstation1 = Station.objects.get(name=(request.POST.get("inputstartstation","")))
                endstation1 = Station.objects.get(name=(request.POST.get("inputendstation","")))
                reservationnumber = request.POST.get("reservation","")
                startdatetime = utc.localize(datetime.strptime(request.POST.get("inputstartdate","")+' '+request.POST.get("inputstarttime",""),'%d %b %Y %I:%M %p'))
                enddatetime = utc.localize(datetime.strptime(request.POST.get("inputenddate","")+' '+request.POST.get("inputendtime",""),'%d %b %Y %I:%M %p'))
                totalcost = float(request.POST.get("inputtotal",""))
                currentDateTime=utc.localize(datetime.now())
                bikes = {}
                inputbikelen = 0
                for i in range(len(TypeOfBike.objects.all())):
                    bikes[i] = int(request.POST.get("inputbike"+str(i+1)))
                    print(bikes[i])
                    inputbikelen += bikes[i]   #gets the total number of bikes that user wanted on the bike select page

                print('this is bikes, old bikes needs to be the same as this', bikes)

                finalbikes = set() #these are the bikes that WILL be reserved to the user


                #oldbikes =

                #for each bike type, check:
                #for loop on each bike type:
                #if new bike type number > old bike type number, add bike from biked
                #if new bike type number < old bike type number, remove bike (if that bike has future reservation, transfer it directly)
                #if new bike type number = old bike type number, do nothing for that bike type



                reservation = Reservation.objects.get(reservation_id=reservationnumber)

                oldstartdatetime = reservation.starttime
                oldenddatetime = reservation.endtime



                if(startdatetime != oldstartdatetime or enddatetime != oldenddatetime):
                    initialbikes = set()
                    countno = 0;
                    initbikequery = Bike.objects.raw('SELECT bike_id FROM bike, bike_on_reservation WHERE bike_id = bor_bike_id AND bor_reservation_id = %s', [reservationnumber])
                    for bike in initbikequery:
                        print("aeiou", bike)
                        initialbikes.add(bike)
                    for bike in initialbikes:

                        bike_check_resquery = Reservation.objects.raw('SELECT reservation_id FROM bike_on_reservation, reservation WHERE bor_reservation_id = reservation_id AND res_type = 3 AND starttime > %s AND bor_bike_id = %s ORDER BY starttime LIMIT 1', [oldstartdatetime, bike.bike_id])
                        if bike_check_resquery:
                            newstationedatquery = Stationroutes.objects.raw('SELECT route_id, start_station_id AS s_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = %s', [bike_check_resquery[0].reservation_id])
                            newbikequery = Bike.objects.raw('SELECT bike_id FROM bike WHERE bike_status = 4 AND bike_type = %s', [bike.bike_type.bike_type_id])

                            print('this is the bike type', bike.bike_type.bike_type_id)

                            with connection.cursor() as c:
                                c.execute('UPDATE tootyred.bike_on_reservation SET bor_bike_id = %s WHERE bor_bike_id = %s AND bor_reservation_id = %s', [newbikequery[countno].bike_id, bike.bike_id, reservationnumber])
                            newbike = Bike.objects.get(bike_id = newbikequery[countno].bike_id)
                            countno += 1

                            newbike.bike_status = StatusOfBike.objects.get(bike_status_id = 1)
                            newbike.bike_stationedat = startstation1
                            bike.bike_stationedat = Station.objects.get(station_id = newstationedatquery[0].s_id)

                            newbike.save()
                            bike.save()
                        else:
                            newbikequery = Bike.objects.raw('SELECT bike_id FROM bike WHERE bike_status = 4 AND bike_type = %s', [bike.bike_type.bike_type_id])

                            print('this is the bike type', bike.bike_type.bike_type_id)

                            with connection.cursor() as c:
                                c.execute('UPDATE tootyred.bike_on_reservation SET bor_bike_id = %s WHERE bor_bike_id = %s AND bor_reservation_id = %s', [newbikequery[countno].bike_id, bike.bike_id, reservationnumber])
                            newbike = Bike.objects.get(bike_id = newbikequery[countno].bike_id)
                            countno += 1

                            newbike.bike_status = StatusOfBike.objects.get(bike_status_id = 1)
                            newbike.bike_stationedat = startstation1
                            bike.bike_stationedat = None
                            bike.bike_status = StatusOfBike.objects.get(bike_status_id = 4)

                            newbike.save()
                            bike.save()


                oldbikes = {}
                oldinputbikelen = 0
                for i in range(len(TypeOfBike.objects.all())):
                    getoldbiketypecount = Bike.objects.raw('SELECT bike_id, count(*) AS count1 FROM bike_on_reservation, bike WHERE bike_id = bor_bike_id AND bike_type = %s AND bor_reservation_id = %s',[i+1, reservationnumber])
                    oldbikes[i] = getoldbiketypecount[0].count1
                    print('getoldbiketypecount: ', getoldbiketypecount[0].count1)
                    oldinputbikelen += oldbikes[i]


                bikestodelete = set()
                for i in range(len(TypeOfBike.objects.all())):
                    getoldbikespertype = Bike.objects.raw('SELECT bike_id FROM bike_on_reservation, bike WHERE bike_id = bor_bike_id AND bike_type = %s AND bor_reservation_id = %s',[i+1, reservationnumber])
                    if bikes[i] >= oldbikes[i]:
                        bikes[i] = bikes[i] - oldbikes[i]
                    else:
                        removebikecount = oldbikes[i] - bikes[i]
                        for oldbike in getoldbikespertype:
                            if removebikecount > 0:
                                bike_check_resquery = Reservation.objects.raw('SELECT reservation_id FROM bike_on_reservation, reservation WHERE bor_reservation_id = reservation_id AND res_type = 3 AND starttime > %s AND bor_bike_id = %s ORDER BY starttime LIMIT 1', [oldstartdatetime, oldbike.bike_id])
                                if bike_check_resquery:
                                    newstationedatquery = Stationroutes.objects.raw('SELECT route_id, start_station_id AS s_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = %s', [bike_check_resquery[0].reservation_id])

                                    bikestodelete.add(oldbike.bike_id)
                                    oldbike.bike_stationedat = Station.objects.get(station_id = newstationedatquery[0].s_id)
                                    oldbike.save()
                                    removebikecount -= 1
                                    #do same as one bellow
                                    #for cursor, use delete instead of update
                                else:
                                    bikestodelete.add(oldbike.bike_id)
                                    removebikecount -= 1


                inputbikelen = inputbikelen - oldinputbikelen
                print('this is the new length boi ', inputbikelen)

                #For each bike type
                biked = {}  #these are the bikes that are allowed to be reserved by the user
                print(inputbikelen)

                # for each of the bike types
                biked = getBikes(startdatetime, enddatetime, startstation1.station_id, endstation1.station_id, 2)

                bikelen=0

                for i in range(len(biked)):
                    print('bikes that can be put on the database thingy :::', biked[i].bike_id)
                #this whole part checks the biked tuple and selects the bikes of certain types on what the user wanted, the bikes gets stored in the finalbikes tuple

                x = 0
                for b in range(len(biked)):
                    #print('asdasdasd $s', biked[b])
                    #print('123', bikes[biked[b].bike_type.bike_type_id-1])

                    if bikes[biked[b].bike_type.bike_type_id-1] > 0:
                        bikes[biked[b].bike_type.bike_type_id-1] -= 1
                        finalbikes.add(biked[b])
                        inputbikelen -= 1
                        x += 1


                print('this is the final bike list :::: ',finalbikes)
                reservation.res_cost = totalcost
                reservation.res_date = currentDateTime
                reservation.starttime = startdatetime
                reservation.endtime = enddatetime
                for reservationBike in finalbikes:
                    bikereservation = BikeOnReservation.objects.create(bor_bike= reservationBike,bor_reservation_id=reservation.reservation_id)
                reservation.save()

                for oldbike in bikestodelete:
                    with connection.cursor() as c:
                        c.execute('DELETE FROM tootyred.bike_on_reservation  WHERE bor_bike_id = %s AND bor_reservation_id = %s', [oldbike, reservationnumber])

                return redirect('/home/reservations/')
    else:
        checkMessages(request)
        ongoing = Reservation.objects.raw("select r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname, sse.name as endname  from stationroutes sr,station_on_reservation s, reservation r,station ss,station sse where s.sor_route_id=sr.route_id and r.reservation_id = s.sor_reservation_id and sr.start_station_id = ss.station_id and sr.end_station_id = sse.station_id and r.c_id=%s and r.res_type=2",(request.user.id,))
        futurereservations = Reservation.objects.raw("select r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname, sse.name as endname  from stationroutes sr,station_on_reservation s, reservation r,station ss,station sse where s.sor_route_id=sr.route_id and r.reservation_id = s.sor_reservation_id and sr.start_station_id = ss.station_id and sr.end_station_id = sse.station_id and r.c_id=%s and r.res_type=3",(request.user.id,))
        pastreservations = Reservation.objects.raw("select r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname, sse.name as endname  from stationroutes sr,station_on_reservation s, reservation r,station ss,station sse where s.sor_route_id=sr.route_id and r.reservation_id = s.sor_reservation_id and sr.start_station_id = ss.station_id and sr.end_station_id = sse.station_id and r.c_id=%s and r.res_type=1",(request.user.id,))
        for each in futurereservations:
            each.starttime=each.starttime.strftime('%b. %d, %Y, %I:%M %p')
            each.endtime=each.endtime.strftime('%b. %d, %Y, %I:%M %p')
            each.res_date=each.res_date.strftime('%b. %d, %Y, %I:%M %p')
        for each in pastreservations:
            each.starttime=each.starttime.strftime('%b. %d, %Y, %I:%M %p')
            each.endtime=each.endtime.strftime('%b. %d, %Y, %I:%M %p')
            each.res_date=each.res_date.strftime('%b. %d, %Y, %I:%M %p')
        for each in ongoing:
            each.starttime=each.starttime.strftime('%b. %d, %Y, %I:%M %p')
            each.endtime=each.endtime.strftime('%b. %d, %Y, %I:%M %p')
            each.res_date=each.res_date.strftime('%b. %d, %Y, %I:%M %p')
        bikesonreservations =  Bike.objects.raw("select b.bike_id as bike_id, b.bike_type as bike_type,br.bor_reservation_id as bor_reservation_id from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id");
        countbiketypereservation = Bike.objects.raw("select b.bike_id as bike_id, b.bike_type as bike_type,br.bor_reservation_id as bor_reservation_id, count(*) as count from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id group by bike_type, bor_reservation_id;");

        cost=20
        reservationdays = 14
        nows =  utc.localize(datetime.now()) + timedelta(days=1)
        return render(request,"user/reservations.html",{'countbiketypereservation': countbiketypereservation,'now': nows,'pastreservations':pastreservations,'station':Station.objects.all(),'futurereservations': futurereservations,'ongoing': ongoing,'bikesonreservations':bikesonreservations,'bike_type':TypeOfBike.objects.all(),'reservationdays':reservationdays,'costperhour':cost})

#This function is used in reserve() and reservations() to get all the avaialable bike ids using the start time end time start station and end station
def getBikes(startdatetime,enddatetime,startstationid,endstationid,typeindicator): #typeindicator indicates whos calling this function and determines what to return ()
    result={}
    count = 0 # for adding bikes

    if (typeindicator == 1):
        for i in (range(len(TypeOfBike.objects.all()))):
            result['result'+str(i+1)] = 0 # bikes[i]

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


    #reservation1 = Reservation.objects.get(reservation_id=9)
    #print('gayshit 123 %d', [reservation1.starttime])

    initialbikes = set()
    initialbikes2 = set()
    initbikequery = Bike.objects.raw('SELECT bike_id FROM bike, bike_on_reservation WHERE bike_id = bor_bike_id AND bor_reservation_id = 8')
    for bike in initbikequery:
        print("aeiou", bike.bike_id)
        initialbikes.add(bike)
        initialbikes2.add(bike)

    booleancheck = initialbikes == initialbikes2

    print("booleancheck ", booleancheck)

    #bikes that are on current or future reservations that doesnt intersect with the timings that we want
    fut_ong_bikes = Bike.objects.raw('SELECT bike_id FROM bike, reservation, bike_on_reservation, station_on_reservation, stationroutes WHERE bor_bike_id = bike_id \
        AND bor_reservation_id = reservation_id AND sor_route_id = route_id AND sor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3) \
        AND NOT ((starttime < %s AND endtime >= %s) OR (starttime >= %s AND starttime <= %s)) GROUP BY bike_id', [startdatetime, startdatetime, startdatetime, enddatetime])

    #bikes with no current or future reservations that is stationed at the inputted start station AND IS NOT OUTOFSERVICE
    no_fut_ong_bikes = Bike.objects.raw('SELECT bike_id FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND \
        bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_stationedat = %s AND bike_status=1', [startstationid])

    if not fut_ong_bikes and not no_fut_ong_bikes:
        return result
    else:
        if no_fut_ong_bikes:
            for bikeobj2 in no_fut_ong_bikes:
                print('bike allowed: %s', [bikeobj2.bike_id])
                if (typeindicator == 1):
                    biketypenumber = bikeobj2.bike_type.bike_type_id
                    result['result'+str(biketypenumber)] += 1
                if (typeindicator == 2):
                    result[count] = bikeobj2
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
                            result['result'+str(b_type)] += 1
                        if (typeindicator == 2):
                            result[count] = bikeobj1
                            count += 1
                elif get_before_starttime_reserv:
                    before_starttime_reserv_id = get_before_starttime_reserv[0].reservation_id
                    before_starttime_reserv_station = Stationroutes.objects.raw('SELECT route_id FROM stationroutes, station_on_reservation, reservation WHERE sor_route_id = route_id AND sor_reservation_id = reservation_id  AND reservation_id = %s', [before_starttime_reserv_id])
                    print('its goint to b')
                    if before_starttime_reserv_station[0].end_station_id == startstationid:
                        print('bike allowed b: %s', [b_id])
                        if (typeindicator == 1):
                            result['result'+str(b_type)] += 1
                        if (typeindicator == 2):
                            result[count] = bikeobj1
                            count += 1
                else:
                    after_endtime_reserv_id = get_after_endtime_reserv[0].reservation_id
                    after_endtime_reserv_station = Stationroutes.objects.raw('SELECT route_id FROM stationroutes, station_on_reservation, reservation WHERE sor_route_id = route_id AND sor_reservation_id = reservation_id  AND reservation_id = %s', [after_endtime_reserv_id])
                    print('its goint to c')
                    if after_endtime_reserv_station[0].start_station_id == endstationid and bikeobj1.bike_stationedat.station_id == startstationid:
                        print('bike allowed c: %s', [b_id])
                        if (typeindicator == 1):
                            result['result'+str(b_type)] += 1
                        if (typeindicator == 2):
                            result[count] = bikeobj1
                            count += 1
        return result

def logout(request):
    return render(request,"user/home.html")

def account(request):
    checkMessages(request)
    editProfile = EditProfileForm(instance=request.user)
    changePassword = PasswordChangeForm(user=request.user)
    return render(request,"user/account.html",{'form1':editProfile,'form2':changePassword, 'user':request.user})

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

def checkMessages(request):
    for each in Reservation.objects.filter(c=request.user.id):
        if each.fine_desc!=None:
            messages.error(request,'Please pay your fines in the past reservations page or your fines will increase!')
            break
