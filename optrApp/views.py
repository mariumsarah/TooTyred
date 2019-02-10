from django.shortcuts import render
from django.urls import resolve
from django.http import HttpResponse
import json
from django.urls import resolve
from home.models import Station,Reservation,BikeOnReservation,Bike,StatusOfBike,ReservationType,Stationroutes,StationOnReservation
from django.contrib import messages
from datetime import datetime, timedelta,timezone
from django.http import HttpResponse
import json
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
    if(request.method == "POST"):
        if request.POST.get('formtype','') == 'bikeselected':
            response_date={}
            response_date[0]=(request.POST.get('bikeid',''));
            reservations = Reservation.objects.raw("select r.fine_desc as fine_desc, r.fine_cost as fine_cost,br.bor_bike_id as bor_bike_id,br.bor_reservation_id as bor_reservation_id, r.res_type as res_type,r.feedback as feedback,r.c_id as c_id,r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname,sd.name as endname from bike_on_reservation as br,reservation as r,stationroutes as sr,station_on_reservation as sor,station as ss,station as sd where br.bor_bike_id=%s and br.bor_reservation_id=r.reservation_id and sor.sor_reservation_id=r.reservation_id and sor.sor_route_id=sr.route_id and sr.start_station_id=ss.station_id and sr.end_station_id=sd.station_id",(int(request.POST.get('bikeid','')),))
            i=1
            for each in reservations:
                response_date[i]={}
                response_date[i]['bike_id']=each.bor_bike_id
                response_date[i]['reservation_id']=each.bor_reservation_id
                response_date[i]['res_code']=each.res_code
                response_date[i]['res_cost']=str(each.res_cost)
                response_date[i]['res_type']=each.res_type.res_type_name
                response_date[i]['res_date']=each.res_date.strftime('%d %b %Y %I:%M %p')
                response_date[i]['starttime']=each.starttime.strftime('%d %b %Y %I:%M %p')
                response_date[i]['endtime']=each.endtime.strftime('%d %b %Y %I:%M %p')
                if(each.c_rating!=None):
                    response_date[i]['c_rating']=each.c_rating.rating_value
                    response_date[i]['feedback']=each.feedback
                response_date[i]['c_id']=each.c_id
                if(each.fine_cost!=None):
                    response_date[i]['fine_desc']=each.fine_desc
                    response_date[i]['fine_cost']=str(each.fine_cost)
                response_date[i]['startname']=each.startname
                response_date[i]['endname']=each.endname
                response_date[i]['bikes_on_reservation']={}
                bikes = Bike.objects.raw('select * from bike as b, bike_on_reservation as br where br.bor_reservation_id=%s and b.bike_id=br.bor_bike_id',(each.reservation_id,))
                x=0
                for n in bikes:
                    response_date[i]['bikes_on_reservation'][x]={}
                    response_date[i]['bikes_on_reservation'][x]['bike_id']=n.bike_id
                    response_date[i]['bikes_on_reservation'][x]['bike_type']=n.bike_type.bike_type
                    response_date[i]['bikes_on_reservation'][x]['bike_image']=n.bike_type.bike_image
                    x=x+1
                i=i+1
            return HttpResponse(json.dumps(response_date),
                content_type="application/json")
    else:
        return render(request, 'operator/inspectbikes.html',{'allbikes':Bike.objects.all()})

#Customer service
def customerService(request):
    return render(request, 'operator/customerservice.html')
