from django.shortcuts import render
from django.urls import resolve
from django.http import HttpResponse
import json
from django.urls import resolve
from home.models import Station,Reservation,BikeOnReservation,Bike,StatusOfBike,ReservationType,Stationroutes,StationOnReservation, UserProfile
from django.contrib import messages
from datetime import datetime, timedelta,timezone
# Create your views here.
# Create your views here
import pytz

utc=pytz.UTC
def stations(request):
    current_url = int(request.get_full_path().strip('/')[-1:])+1
    if(request.method == "POST"):
            if Reservation.objects.filter(res_code=request.POST.get("reservationcode","")).exists():
                now =  utc.localize(datetime.now())
                reservation = Reservation.objects.get(res_code=request.POST.get("reservationcode",""))
                reservationTypeCurrent = ReservationType.objects.get(res_type_name='ongoing')
                reservationTypePast = ReservationType.objects.get(res_type_name='past')
                print(now)
                print(reservation.starttime+timedelta(minutes=15))
                print(reservation.starttime-timedelta(minutes=15))
                print(now)
                print(reservation.endtime+timedelta(minutes=15))
                print(reservation.endtime-timedelta(minutes=15))
                #if the time is 15 min before start of reservation or 15 min after start of reservation
                # and if the reservation is not already unlocked
                # and start station is start station
                stations = Stationroutes.objects.raw("select * from station_on_reservation as sr, reservation as r, stationroutes as s where r.reservation_id=sr.sor_reservation_id and sr.sor_route_id = s.route_id and r.reservation_id=%s",(reservation.reservation_id,))
                if now<(reservation.starttime+timedelta(minutes=15)) and now>(reservation.starttime-timedelta(minutes=15)) and not Reservation.objects.filter(res_code=request.POST.get("reservationcode",""),res_type=reservationTypeCurrent).exists() and stations[0].start_station_id==current_url:
                    reservation.res_type=reservationTypeCurrent
                    status=StatusOfBike.objects.get(bike_status_name='active')
                    station=None
                    bikes=Bike.objects.raw("select * from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id and br.bor_reservation_id=%s",(reservation.reservation_id,))
                    s="The following bikes \n"
                    for x in bikes:
                        x.bike_status=status
                        x.bike_stationedat=station
                        x.save()
                        s+=x.bike_type.bike_type+' \n'
                    reservation.save()
                    messages.success(request,s+'is now  UNLOCKED! Have a great ride!')
                # if the time is 15 min before end of reservation and 15 min after end of reservations
                # and if the reservation was unlocked
                # and the end station is end statin
                elif now<(reservation.endtime+timedelta(minutes=15)) and now>(reservation.endtime-timedelta(minutes=15)) and Reservation.objects.filter(res_code=request.POST.get("reservationcode",""),res_type=reservationTypeCurrent).exists() and stations[0].end_station_id==current_url:
                    reservation.res_type=reservationTypePast
                    status=StatusOfBike.objects.get(bike_status_name='stationed')
                    station=Station.objects.get(station_id=current_url)
                    bikes=Bike.objects.raw("select * from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id and br.bor_reservation_id=%s",(reservation.reservation_id,))
                    s=""
                    for x in bikes:
                        x.bike_status=status
                        x.bike_stationedat=station
                        x.save()
                        s+=x.bike_type.bike_type+' \n'
                    reservation.save()
                    messages.success(request,s+' is now LOCKED! Thank you for reserving with us! Do give us feedback about your reservation experience!')
                else:
                    messages.error(request,'Sorry, you entered the wrong passcode. Please try again!')
            else:
                messages.error(request,'Sorry, this passcode does not exist. Please try again!')
            return render(request, 'employee/station.html',{'url':current_url,'station':Station.objects.get(station_id=current_url)})
    else:
        current_url = int(request.get_full_path().strip('/')[-1:])+1
        return render(request, 'employee/station.html',{'url':current_url,'station':Station.objects.get(station_id=current_url)})

def log(request):
    return render(request, 'employee/home.html')

def bikes(request):
    return render(request, 'employee/inspectbikes.html',{'status_of_bike':StatusOfBike.objects.all()})

def empCustomerService(request):
    return render(request, 'employee/customerservice.html',{'home_userprofile':UserProfile.objects.all()})
