from django.shortcuts import render, redirect
from .models import Station, TypeOfBike,Stationroutes, StationOnReservation, Reservation, BikeOnReservation, ReservationType,Bike, StatusOfBike
from .forms import ExampleForm, RegistrationForm, EditProfileForm
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from datetime import datetime, timedelta
from django.http import HttpResponse,JsonResponse
import json
from datetime import datetime
import time
from django.core.mail import EmailMessage
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
            response_data = {}
            #EDGAR --------------------------------------------------------------------------------------
            if request.POST.get('formtype','') == 'time':
                startdatetime = datetime.strptime(request.POST.get('startdate','')+' '+request.POST.get('starttime',''),'%d %b %Y %I:%M %p')
                enddatetime = datetime.strptime(request.POST.get('enddate','')+' '+request.POST.get('endtime',''),'%d %b %Y %I:%M %p')
                startstation = request.POST.get('startstation','')
                endstation = request.POST.get('endstation','')
                bikes={}
                #--------- the above are all the information you need
                # look at the else loop on how i made the reservations for reference
                #------In the bikes dict you need to put all the availabe for each of the bike types so for example
                #  biketype[0] will be available bikes of biktype 1
                #  biketype[1] will be available bikes of biktype 2
                for i in (range(len(TypeOfBike.objects.all()))):
                    response_data['result'+str(i+1)] = 2

                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            else:
                startstation = Station.objects.get(name=(request.POST.get("inputstartstation","")))
                endstation = Station.objects.get(name=(request.POST.get("inputendstation","")))
                route = Stationroutes.objects.get(start_station_id=startstation,end_station_id=endstation)
                startdatetime = datetime.strptime(request.POST.get("inputstartdate","")+' '+request.POST.get("inputstarttime",""),'%d %b %Y %I:%M %p')
                enddatetime = datetime.strptime(request.POST.get("inputenddate","")+' '+request.POST.get("inputendtime",""),'%d %b %Y %I:%M %p')
                totalcost = int(request.POST.get("inputtotal",""))
                currentDateTime=datetime.now()
                reservationType = ReservationType.objects.get(res_type_name='future')
                reservationTypePast = ReservationType.objects.get(res_type_name='past')
                reservationTypeOngoing = ReservationType.objects.get(res_type_name='ongoing')
                statusofbike = StatusOfBike.objects.get(bike_status_name='stationed')
                bikes = {}
                for i in range(len(TypeOfBike.objects.all())):
                    bikes[i] = int(request.POST.get("inputbike"+str(i+1)))
                #For each bike type
                biked = {}
                x=0
                # for each of the bike types
                for i in range(len(TypeOfBike.objects.all())):
                        # for each of the bikes selected of the bike types
                        for f in range(bikes[i]):
                            #for all bikes that exist and have that bike type
                            for bike in Bike.objects.filter(bike_type=i+1):
                                # if there are reservations for that bike
                                if BikeOnReservation.objects.filter(bor_bike=bike).exists():
                                    #store all the bikesReservation in bikesReservations
                                    bikesReservations = Reservation.objects.filter(bike_reservation=bike)

                                    # if it has future reservations
                                    if bikesReservations.filter(res_type=reservationType).exists():
                                        #store all the future reservations in futurereservations
                                        futurereservations = bikesReservations.filter(res_type=reservationType)

                                        allwithendstation = futurereservations.filter(route_reservation__in=Stationroutes.objects.filter(end_station=startstation))

                                        allwithstartstation = futurereservations.filter(route_reservation__in=Stationroutes.objects.filter(start_station=endstation))
                                        max_year = futurereservations.latest('endtime').endtime
                                        # if reservation is start and end station the same and there exists no reservation during the start and end reservation time allow it
                                        if startstation.station_id == endstation.station_id and allwithendstation.exists() and allwithstartstation.exists() and not allwithendstation.filter(endtime__gt=startdatetime-timedelta(minutes=15)).exists() and not allwithstartstation.filter(starttime__lt=enddatetime+timedelta(minutes=15)).exists() and not bike in biked.values:
                                            biked[x] = bike
                                            x=x+1
                                            break
                                        elif futurereservations.filter(endtime=max_year,route_reservation__in=Stationroutes.objects.filter(end_station=startstation)).exists() and max_year<=startdatetime-timedelta(minutes=15) and not bike in biked.values :
                                            biked[x] = bike
                                            x=x+1
                                            break
                                    # if no future reservations but ongoing one
                                    elif bikesReservations.get(res_type=reservationTypeOngoing).exists():
                                        #check if the ongoing is going to end station
                                        if bikesReservations.get(res_type=reservationTypeOngoing).route_reservation.endstation.station_id==startstation.station_id and bikesReservations.get(res_type=reservationTypeOngoing).endtime <= startdatetime-timedelta(minutes=15) and not bike in biked.values:
                                            biked[x] = bike
                                            x=x+1
                                            break
                                    # if no ongoing or future only past
                                    elif bikesReservations.filter(res_type=reservationTypePast).exists():
                                        if(bike.bike_status==statusofbike and bike.bike_stationedat.station_id==startstation.station_id and not bike in biked.values()):
                                            biked[x] = bike
                                            x=x+1
                                            break
                                elif (bike.bike_status==statusofbike and bike.bike_stationedat.station_id==startstation.station_id and not bike in biked.values()):
                                    biked[x] = bike
                                    x=x+1
                                    break
                user = User.objects.get(id=request.user.id)
                reservation = Reservation.objects.create(res_type=reservationType,res_cost=totalcost,res_date=currentDateTime,starttime=startdatetime,endtime=enddatetime,c=user)
                reservation.res_code='https://api.qrserver.com/v1/create-qr-code/?data='+str(reservation.reservation_id)+'&size=100x100'
                stationreservation = StationOnReservation.objects.create(sor_reservation=reservation,sor_route=route)
                for biken in range(len(biked)):
                    BikeOnReservation.objects.create(bor_bike=biked[biken],bor_reservation_id=reservation.reservation_id)
                reservation.save()
                messagew= 'Hi there '+request.user.first_name+' '+request.user.last_name+',      \nHere are the details of the reservation you just made on TooTyred.com! \n Your reservation starts on '+startdatetime.strftime('%d %b %Y %I:%M %p')+' at the station '+startstation.name+', '+startstation.address+'\n Your reservation ends on '+enddatetime.strftime('%d %b %Y %I:%M %p')+' at the station '+endstation.name+', '+endstation.address+'\n Your reservation ID is '+str(reservation.reservation_id)+ '\n Your reservation QR code is '+reservation.res_code+'\n The bikes you selected are \n'
                for i in range(len(biked)):
                    messagew+=str(i+1)+' '+biked[i].bike_type.bike_type+' \n'
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
        return render(request,"user/reservations.html")


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
