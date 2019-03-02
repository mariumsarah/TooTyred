from django.shortcuts import render, redirect
from home.models import Station, TypeOfBike,Stationroutes, StationOnReservation,CustomerRating, Reservation, BikeOnReservation, ReservationType,Bike, StatusOfBike
from django.db.models import Count
from django.contrib.auth.models import User
from datetime import datetime, timedelta,timezone
import pytz
utc=pytz.UTC
import json

# Create your views here.
def manager(request):
    return render(request, 'manager/home.html')

def manUsagereports(request):
	#Retriving Stations with max usage
	 getStation=Station.objects.raw('SELECT station_id, name FROM station')
	 stationByStartTime=[]
	 for testobj in getStation:
	 	print('testobject %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes WHERE sor_route_id=route_id AND station_id=start_station_id  AND station_id=%s',[testobj.station_id])
	 	print('asdasdasd',looptest1[0].countnum,[testobj.station_id])
	 	stationByStartTime.append(looptest1[0].countnum)
	 	sbt = json.dumps(stationByStartTime)

    #Retriving Stations Name List
	 getStationname = Station.objects.raw('SELECT station_id,name FROM station')
	 Stationname=[]
	 for testobj in getStationname:
	 	print ('testobject %s', [testobj.name])
	 	Stationname.append([testobj.name])
	 	print(Stationname)
	 stname=json.dumps(Stationname)

	 #Retriving Max Bike usage
	 getBikelist = TypeOfBike.objects.raw('SELECT bike_type_id FROM type_of_bike')
	 bikesUsedCount = []
	 for testobj in getBikelist:
	 		print ('testobject %s', [testobj.bike_type_id])
	 		looptest1 =  TypeOfBike.objects.raw('SELECT bike_type_id, count(bike_type_id) AS typecount FROM type_of_bike, bike_on_reservation, bike WHERE bike.bike_type = bike_type_id AND bike_id = bor_bike_id AND bike_type_id = %s', [testobj.bike_type_id])
	 		print ('asdasdasd', looptest1[0].typecount, [testobj.bike_type_id])
	 		bikesUsedCount.append(looptest1[0].typecount)
	 		print('st count values', bikesUsedCount)
	 bikemax=json.dumps(bikesUsedCount)

	 #Retriving Max Bike Name List
	 getBikeNamelist = TypeOfBike.objects.raw('SELECT bike_type_id,bike_type FROM type_of_bike')
	 bikename=[]
	 for testobj in getBikeNamelist:
	 	print ('testobject %s', [testobj.bike_type])
	 	bikename.append([testobj.bike_type])
	 print(bikename)
	 bikenamelt=json.dumps(bikename)

	 #Total reservations in this year
	 totalreservpermonth=[]
	 no_of_month = 12
	 count = 0
	 while count < no_of_month:
	 	count += 1
	 	totalreservpermonthquery = Reservation.objects.raw('SELECT reservation_id, count(*) AS tmcount FROM reservation WHERE YEAR(res_date) = YEAR(NOW()) AND MONTH(res_date) = %s', [count])
	 	totalreservpermonth.append(totalreservpermonthquery[0].tmcount)
	 print(totalreservpermonth)
	 tresTD = json.dumps(totalreservpermonth)

##Total reservations in past year
	 totalreservpastyear = []
	 no_of_month = 12
	 count = 0
	 while count < no_of_month:
	 	count += 1
	 	totalreservpastyearquery = Reservation.objects.raw('SELECT reservation_id, count(*) AS tmcount FROM reservation    WHERE YEAR(res_date) = YEAR(NOW()- INTERVAL 1 YEAR) AND MONTH(res_date) = %s', [count])
	 	totalreservpastyear.append(totalreservpastyearquery[0].tmcount)
	 print(totalreservpastyear)
	 tresPY = json.dumps(totalreservpastyear)

	 #Retriving Stations with max usage Heatmap
	 getStationHMAP=Station.objects.raw('SELECT station_id, name FROM station')
	 stationlonlat=[]
	 for testobj in getStationHMAP:
	 	print('testobject2 %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id, lon, lat ,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes WHERE sor_route_id=route_id AND station_id=start_station_id  AND station_id=%s',[testobj.station_id])
	 	lat=looptest1[0].lat
	 	lon=looptest1[0].lon
	 	if lat is not None:
	 		lat = float(lat)
	 	if lon is not None:
	 		lon = float(lon)
	 		stationlonlat.append((lat,lon))
	 print(stationlonlat)

	 count=Bike.objects.all().count()
	 Bikes=Bike.objects.all()
	 feedbackcount=Reservation.objects.filter(feedback=" ").count()
	 feedback=Reservation.objects.all()
	 userscount = User.objects.all().count()
	 users = User.objects.all()

	 return render(request,'manager/usagereports.html',{"stationByStartTime":sbt,"Stationname":stname,"Bikemax":bikemax,"Bikenamelt":bikenamelt,"totalreservpermonth":tresTD,"totalreservpastyear":tresPY,"stationlonlat":stationlonlat,'count':count,'Bikes':Bikes ,'feedbackcount':feedbackcount,'feedback':feedback,'userscount':userscount,'users':users})

def manStatistics(request):
    return render(request, 'manager/statistics.html')

def manDailyreport(request):
#Retriving Stations with max usage
	 getStation=Station.objects.raw('SELECT station_id, name FROM station')
	 stationByStartTimeTD=[]
	 for testobj in getStation:
	 	print('testobject %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes, reservation WHERE sor_route_id = route_id AND station_id = start_station_id AND sor_reservation_id = reservation_id AND DATE(starttime) = CURDATE() AND station_id=%s',[testobj.station_id])
	 	print('asdasdasd',looptest1[0].countnum,[testobj.station_id])
	 	stationByStartTimeTD.append(looptest1[0].countnum)
	 	sbtTD = json.dumps(stationByStartTimeTD)
	#Retriving Stations Name List
	 getStationname=Station.objects.raw('SELECT station_id, name FROM station')
	 StationnameTD=[]
	 for testobj in getStationname:
		 print ('testobject %s', [testobj.name])
		 StationnameTD.append([testobj.name])
		 print(StationnameTD)
		 stnameTD=json.dumps(StationnameTD)

	 #Total Reservations in this week
	 totalreservperDOW = []
	 no_of_DOW = 7
	 count = 0
	 while count < no_of_DOW:
	 	count += 1
	 	totalreservperDOWquery = Reservation.objects.raw('SELECT reservation_id, count(*) AS twcount FROM reservation WHERE YEARWEEK(starttime) = YEARWEEK(NOW()) AND DAYOFWEEK(starttime) = %s', [count])
	 	totalreservperDOW.append(totalreservperDOWquery[0].twcount)
	 	print(totalreservperDOW)
	 	tresWTD = json.dumps(totalreservperDOW)

	 #Retriving Stations with max usage Heatmap
	 getStationHMAPTD=Station.objects.raw('SELECT station_id, name FROM station')
	 stationlonlatTD=[]
	 for testobj in getStationHMAPTD:
	 	print('testobject2 %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id, lon, lat,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes, reservation WHERE sor_route_id = route_id AND station_id = start_station_id AND sor_reservation_id = reservation_id AND DATE(starttime) = CURDATE() AND station_id=%s',[testobj.station_id])
	 	lat=looptest1[0].lat
	 	lon=looptest1[0].lon
	 	if lat is not None:
	 		lat = float(lat)
	 	if lon is not None:
	 		lon = float(lon)
	 		stationlonlatTD.append((lat,lon))
	 print(stationlonlatTD)

	 how_many_days = 1
	 reservations=Reservation.objects.filter(endtime__gte=datetime.now()-timedelta(days=how_many_days))
	 bike=Bike.objects.raw("select b.bike_id as bike_id, b.bike_type as bike_type,br.bor_reservation_id as bor_reservation_id from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id");
	 count=Reservation.objects.filter(endtime__gte=datetime.now()-timedelta(days=how_many_days)).count()

	 return render(request, 'manager/dailyreport.html',{"stationByStartTimeTD":sbtTD,"StationnameTD":stnameTD,"totalreservperDOW":tresWTD,"stationlonlatTD":stationlonlatTD,'reservations':reservations , 'bike':bike,'count':count})
