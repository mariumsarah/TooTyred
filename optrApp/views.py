from django.shortcuts import render
from django.urls import resolve
from django.http import HttpResponse
import json
from django.urls import resolve
from home.models import User,Station,Reservation,BikeOnReservation,Bike,StatusOfBike,ReservationType,Stationroutes,StationOnReservation
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
                bikestatustracked = StatusOfBike.objects.get(bike_status_id=5)
                bikestatustored = StatusOfBike.objects.get(bike_status_id=4)
                bikestatustationed = StatusOfBike.objects.get(bike_status_id=1)
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
                #CHANGED
                elif Reservation.objects.filter(res_code=request.POST.get("reservationcode",""),res_type=reservationTypeCurrent).exists() and stations[0].end_station_id==stationnumber:
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
                #IF THE RESERVATION HAS BIKES THAT ARE TRACKED AND ITS A PAST RESERVATION THEN MAKE THOSE BIKES AS STORED INSTEAD OF TRACKED
                elif Reservation.objects.filter(res_code=request.POST.get("reservationcode",""),res_type=reservationTypePast).exists() and stations[0].end_station_id==stationnumber :
                    reservati=Reservation.objects.get(res_code=request.POST.get("reservationcode",""),res_type=reservationTypePast)
                    bbikes=Bike.objects.raw("select * from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id and br.bor_reservation_id=%s and b.bike_status=5",(reservati.reservation_id,))
                    s=False
                    print(bbikes)
                    for each in bbikes:
                            each.bike_status=bikestatustationed
                            s=True
                            each.save()
                    if s:
                        messages.success(request,'Thank you for reserving with us! You locked your bikes late, please pay your fines in your account!')
                    else:
                        messages.error(request,'Sorry, you entered the wrong passcode. Please try again!')
                else:
                    messages.error(request,'Sorry, you entered the wrong passcode. Please try again!')
            else:
                messages.error(request,'Sorry, this passcode does not exist. Please try again!')
            return render(request, 'operator/station.html',{'url':stationnumber,'station':Station.objects.get(station_id=stationnumber)})
    else:
        stationnumber = int(request.get_full_path().strip('/')[-1:])+1
        return render(request, 'operator/station.html',{'stationnumber':stationnumber,'station':Station.objects.get(station_id=stationnumber)})

#The main operators page with all information about other pages
#def log(request):
#    return render(request, 'operator/home.html')

#The track bikes page where all the bikes can be tracked
def bikes(request):
    if(request.method == "POST"):
        if request.POST.get('formtype','') == 'bikeselected':
            response_date={}
            response_date[0]={}
            response_date[0]['bike_id']=request.POST.get('bikeid','')
            #IF ITS AN ONGOING RESERVATION
            if Bike.objects.get(bike_id=request.POST.get('bikeid','')).bike_stationedat==None:
                ongoingreservations = Reservation.objects.raw("select r.fine_desc as fine_desc, r.fine_cost as fine_cost,br.bor_bike_id as bor_bike_id,br.bor_reservation_id as bor_reservation_id, r.res_type as res_type,r.feedback as feedback,r.c_id as c_id,r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname,sd.name as endname,ss.lon as startlon,ss.lat as startlat,sd.lon as endlon,sd.lat as endlat,r.starttime as starttime,r.endtime as endtime from bike_on_reservation as br,reservation as r,stationroutes as sr,station_on_reservation as sor,station as ss,station as sd where br.bor_bike_id=%s and br.bor_reservation_id=r.reservation_id and sor.sor_reservation_id=r.reservation_id and sor.sor_route_id=sr.route_id and sr.start_station_id=ss.station_id and sr.end_station_id=sd.station_id and r.res_type=2",(int(request.POST.get('bikeid','')),))
                for each in ongoingreservations:
                    if(each.endtime>utc.localize(datetime.now())):
                        response_date[0]['shouldlock']=str(0)
                    else:
                        response_date[0]['shouldlock']=str(1)
                    response_date[0]['duration']=str((each.endtime-each.starttime).total_seconds()*1000)
                    response_date[0]['startlon']=str(each.startlon)
                    response_date[0]['type']=0
                    response_date[0]['startlon']=str(each.startlon)
                    response_date[0]['startlat']=str(each.startlat)
                    response_date[0]['startname']=str(each.startname)
                    response_date[0]['endlon']=str(each.endlon)
                    response_date[0]['endlat']=str(each.endlat)
                    response_date[0]['endname']=str(each.endname)
            #IF ITS STATIONED OR OUTOFSERVICE
            else:
                bikeinfo = Bike.objects.raw("select s.name as name,b.bike_id as bike_id,s.station_id as station_id,s.lat as lat,s.lon as lon,b.bike_status as bike_status from bike as b, station as s where b.bike_stationedat=s.station_id and b.bike_id=%s",(int(request.POST.get('bikeid','')),))
                #response_date[0][1]=bikeinfo.lat
                for each in bikeinfo:
                    response_date[0]['type']=1
                    response_date[0]['lon']=str(each.lon)
                    response_date[0]['lat']=str(each.lat)
                    response_date[0]['stationname']=each.name
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
                response_date[i]['c_id']=str(each.c_id)+' '+str(User.objects.get(id=each.c_id).is_active)
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
        elif request.POST.get('formtype','') == 'viewreservations':
            response_date={}
            response_date[0]=0
            reservations = Reservation.objects.raw("select r.fine_desc as fine_desc, r.fine_cost as fine_cost, r.res_type as res_type,r.feedback as feedback,r.c_id as c_id,r.reservation_id as reservation_id,r.res_code as res_code,r.res_cost as res_cost,r.res_date as res_date,r.starttime as starttime,r.endtime as endtime,r.c_rating as c_rating,ss.name as startname,sd.name as endname from reservation as r,stationroutes as sr,station_on_reservation as sor,station as ss,station as sd where sor.sor_reservation_id=r.reservation_id and sor.sor_route_id=sr.route_id and sr.start_station_id=ss.station_id and sr.end_station_id=sd.station_id")
            i=1
            for each in reservations:
                    response_date[i]={}
                    response_date[i]['bike_id']=each.reservation_id
                    response_date[i]['reservation_id']=each.reservation_id
                    response_date[i]['res_code']=each.res_code
                    response_date[i]['res_cost']=str(each.res_cost)
                    response_date[i]['res_type']=each.res_type.res_type_name
                    response_date[i]['res_date']=each.res_date.strftime('%d %b %Y %I:%M %p')
                    response_date[i]['starttime']=each.starttime.strftime('%d %b %Y %I:%M %p')
                    response_date[i]['endtime']=each.endtime.strftime('%d %b %Y %I:%M %p')
                    if(each.c_rating!=None):
                        response_date[i]['c_rating']=each.c_rating.rating_value
                        response_date[i]['feedback']=each.feedback
                    response_date[i]['c_id']=str(each.c_id)+' '+str(User.objects.get(id=each.c_id).is_active)
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
        elif request.POST.get('formtype','') == 'viewbikes':
            response_date={}
            response_date[0]=0
            reservations = Bike.objects.all()
            i=1
            for each in reservations:
                    response_date[i]={}
                    response_date[i]['bike_id']=each.bike_id
                    response_date[i]['bike_status']=each.bike_status.bike_status_name
                    response_date[i]['bike_image']=each.bike_type.bike_image
                    response_date[i]['bike_type']=each.bike_type.bike_type
                    if(each.bike_stationedat!=None):
                        response_date[i]['bike_stationedat_name']=each.bike_stationedat.name
                    i=i+1
            return HttpResponse(json.dumps(response_date),
                content_type="application/json")
        elif request.POST.get('formtype','') == 'blockBike':
            response_date={}
            #stores value whether the blocking was successfull or not
            bikes = Bike.objects.raw('SELECT * FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_id=%s AND (bike_status=1)',(request.POST.get('bikeid',''),))
            if not bikes:
                response_date[0]=0
                return HttpResponse(json.dumps(response_date),
                    content_type="application/json")
            for bike in bikes:
                    response_date[0]=1
                    #if the bike is stored
                    bike.bike_status=StatusOfBike.objects.get(bike_status_id=2)
                    bike.save()
                    return HttpResponse(json.dumps(response_date),
                        content_type="application/json")
        elif request.POST.get('formtype','') == 'unblockBike':
            response_date={}
            #stores value whether the blocking was successfull or not
            bikes = Bike.objects.raw('SELECT * FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_id=%s AND (bike_status=2)',(request.POST.get('bikeid',''),))
            if not bikes:
                response_date[0]=0
                return HttpResponse(json.dumps(response_date),
                    content_type="application/json")
            for bike in bikes:
                    response_date[0]=1
                    #if the bike is stored
                    bike.bike_status=StatusOfBike.objects.get(bike_status_id=1)
                    bike.save()
                    return HttpResponse(json.dumps(response_date),
                        content_type="application/json")
        elif request.POST.get('formtype','') == 'transferBike':
            response_date={}
            #stores value whether the blocking was successfull or not
            bikes = Bike.objects.raw('SELECT * FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_id=%s AND (bike_status=1 OR bike_status=4 OR bike_status=2)',(request.POST.get('bikeid',''),))
            if not bikes:
                response_date[0]=0
                return HttpResponse(json.dumps(response_date),
                    content_type="application/json")
            for bike in bikes:
                    response_date[0]=1
                    #if the bike is stored
                    if bike.bike_status.bike_status_id==StatusOfBike.objects.get(bike_status_id=4).bike_status_id:
                        bike.bike_status=StatusOfBike.objects.get(bike_status_id=1)
                    if request.POST.get('station','')==str(0):
                        bike.bike_stationedat=None
                        response_date[1]='Storage'
                        bike.bike_status=StatusOfBike.objects.get(bike_status_id=4)
                    else:
                        bike.bike_stationedat=Station.objects.get(station_id=request.POST.get('station',''))
                        response_date[1]=bike.bike_stationedat.name
                    bike.save()
                    return HttpResponse(json.dumps(response_date),
                        content_type="application/json")
        elif request.POST.get('formtype','') == 'replaceBike':
            response_date={}
            #stores value whether the blocking was successfull or not
            bikes = Bike.objects.raw('SELECT * FROM bike WHERE bike_id=%s AND (bike_status=1 OR bike_status=3 OR bike_status=4 OR bike_status=2)',(request.POST.get('bikeid',''),))
            if not bikes:
                response_date[0]=0
                return HttpResponse(json.dumps(response_date),
                    content_type="application/json")
            for bike in bikes:
                    response_date[0]=1
                    #if the bike is stored
                    bike.travel_count=0
                    bike.save()
                    return HttpResponse(json.dumps(response_date),
                        content_type="application/json")
            response_date[1]=request.POST.get('bikeid','')
            return HttpResponse(json.dumps(response_date),
                content_type="application/json")
    else:
        return render(request, 'operator/inspectbikes.html',{'allbikes':Bike.objects.all(),'station':Station.objects.all()})

#Customer service
#def customerService(request):
#    return render(request, 'operator/customerservice.html')
