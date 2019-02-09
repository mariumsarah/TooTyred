from django.shortcuts import render
from django.urls import resolve
from django.http import HttpResponse
import json
from django.urls import resolve
from home.models import Station,Reservation,BikeOnReservation,Bike,StatusOfBike,ReservationType,Stationroutes,StationOnReservation
from django.contrib import messages
from datetime import datetime, timedelta,timezone

import pytz
utc=pytz.UTC
def stations(request):
    stationnumber = int(request.get_full_path().strip('/')[-1:])+1
    #If the reservation code is entered
    if(request.method == "POST"):
            if Reservation.objects.filter(res_code=request.POST.get("reservationcode","")).exists():
                now =  utc.localize(datetime.now())
                reservation = Reservation.objects.get(res_code=request.POST.get("reservationcode",""))
                reservationTypeCurrent = ReservationType.objects.get(res_type_name='ongoing')
                reservationTypePast = ReservationType.objects.get(res_type_name='past')
                stations = Stationroutes.objects.raw("select * from station_on_reservation as sr, reservation as r, stationroutes as s where r.reservation_id=sr.sor_reservation_id and sr.sor_route_id = s.route_id and r.reservation_id=%s",(reservation.reservation_id,))
                #UNLOCK BIKE
                if now<(reservation.starttime+timedelta(minutes=15)) and now>(reservation.starttime-timedelta(minutes=15)) and not Reservation.objects.filter(res_code=request.POST.get("reservationcode",""),res_type=reservationTypeCurrent).exists() and stations[0].start_station_id==stationnumber:
                    reservation.res_type=reservationTypeCurrent
                    status=StatusOfBike.objects.get(bike_status_name='active')
                    station=None
                    bikes=Bike.objects.raw("select * from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id and br.bor_reservation_id=%s",(reservation.reservation_id,))
                    displaymessage=""
                    for bike in bikes:
                        bike.bike_status=status
                        bike.bike_stationedat=station
                        bike.save()
                        displaymessage+=bike.bike_type.bike_type+' \n'
                    reservation.save()
                    messages.success(request,displaymessage+'is now  UNLOCKED! Have a great ride!')
                # LOCK BIKE
                elif now<(reservation.endtime+timedelta(minutes=15)) and now>(reservation.starttime-timedelta(minutes=15)) and Reservation.objects.filter(res_code=request.POST.get("reservationcode",""),res_type=reservationTypeCurrent).exists() and stations[0].end_station_id==stationnumber:
                    reservation.res_type=reservationTypePast
                    status=StatusOfBike.objects.get(bike_status_name='stationed')
                    station=Station.objects.get(station_id=stationnumber)
                    bikes=Bike.objects.raw("select * from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id and br.bor_reservation_id=%s",(reservation.reservation_id,))
                    displaymessage=""
                    for bike in bikes:
                        bike.bike_status=status
                        bike.bike_stationedat=station
                        bike.save()
                        displaymessage+=bike.bike_type.bike_type+' \n'
                    reservation.save()
                    messages.success(request,displaymessage+' is now LOCKED! Thank you for reserving with us! Do give us feedback about your reservation experience!')
                else:
                    messages.error(request,'Sorry, you entered the wrong passcode. Please try again!')
            else:
                messages.error(request,'Sorry, this passcode does not exist. Please try again!')
            return render(request, 'operator/station.html',{'url':stationnumber,'station':Station.objects.get(station_id=stationnumber)})
    else:
        stationnumber = int(request.get_full_path().strip('/')[-1:])+1
        return render(request, 'operator/station.html',{'stationnumber':stationnumber,'station':Station.objects.get(station_id=stationnumber)})

#The main operators page with all information about other pages
def log(request):
    return render(request, 'operator/home.html')

#The track bikes page where all the bikes can be tracked
def bikes(request):
    return render(request, 'operator/inspectbikes.html',{'status_of_bike':StatusOfBike.objects.all()})

#Customer service
def customerService(request):
    return render(request, 'operator/customerservice.html')
