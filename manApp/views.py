from django.shortcuts import render, redirect
from home.models import Station, TypeOfBike,Stationroutes, StationOnReservation,CustomerRating, Reservation, BikeOnReservation, ReservationType,Bike, StatusOfBike
from django.db.models import Count, Avg, Max, Min, Sum
from django.contrib.auth.models import User
from datetime import datetime, timedelta,timezone
import pytz
utc=pytz.UTC
import json
from django.utils import timezone

def manUsagereports(request):

	#Retriving Stations with max usage
	 getStation=Station.objects.raw('SELECT station_id, name FROM station')
	 stationByStartTime=[]
	 for testobj in getStation:
	 	#print('testobject %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes WHERE sor_route_id=route_id AND station_id=start_station_id  AND station_id=%s',[testobj.station_id])
	 	#print('asdasdasd',looptest1[0].countnum,[testobj.station_id])
	 	stationByStartTime.append(looptest1[0].countnum)
	 	sbt = json.dumps(stationByStartTime)

    #Retriving Stations Name List
	 getStationname = Station.objects.raw('SELECT station_id,name FROM station')
	 Stationname=[]
	 for testobj in getStationname:
	 	#print ('testobject %s', [testobj.name])
	 	Stationname.append([testobj.name])
	 	#print(Stationname)
	 stname=json.dumps(Stationname)

	 #Retriving Max Bike usage
	 getBikelist = TypeOfBike.objects.raw('SELECT bike_type_id FROM type_of_bike')
	 bikesUsedCount = []
	 for testobj in getBikelist:
	 		#print ('testobject %s', [testobj.bike_type_id])
	 		looptest1 =  TypeOfBike.objects.raw('SELECT bike_type_id, count(bike_type_id) AS typecount FROM type_of_bike, bike_on_reservation, bike WHERE bike.bike_type = bike_type_id AND bike_id = bor_bike_id AND bike_type_id = %s', [testobj.bike_type_id])
	 		#print ('asdasdasd', looptest1[0].typecount, [testobj.bike_type_id])
	 		bikesUsedCount.append(looptest1[0].typecount)
	 		#print('st count values', bikesUsedCount)
	 bikemax=json.dumps(bikesUsedCount)

	 #Retriving Max Bike Name List
	 getBikeNamelist = TypeOfBike.objects.raw('SELECT bike_type_id,bike_type FROM type_of_bike')
	 bikename=[]
	 for testobj in getBikeNamelist:
	 	#print ('testobject %s', [testobj.bike_type])
	 	bikename.append([testobj.bike_type])
	 #print(bikename)
	 bikenamelt=json.dumps(bikename)

	 #Total reservations in this year
	 totalreservpermonth=[]
	 no_of_month = 12
	 count = 0
	 while count < no_of_month:
	 	count += 1
	 	totalreservpermonthquery = Reservation.objects.raw('SELECT reservation_id, count(*) AS tmcount FROM reservation WHERE YEAR(res_date) = YEAR(NOW()) AND MONTH(res_date) = %s', [count])
	 	totalreservpermonth.append(totalreservpermonthquery[0].tmcount)
	 #print(totalreservpermonth)
	 tresTD = json.dumps(totalreservpermonth)

##Total reservations in past year
	 totalreservpastyear = []
	 no_of_month = 12
	 count = 0
	 while count < no_of_month:
	 	count += 1
	 	totalreservpastyearquery = Reservation.objects.raw('SELECT reservation_id, count(*) AS tmcount FROM reservation    WHERE YEAR(res_date) = YEAR(NOW()- INTERVAL 1 YEAR) AND MONTH(res_date) = %s', [count])
	 	totalreservpastyear.append(totalreservpastyearquery[0].tmcount)
	 #print(totalreservpastyear)
	 tresPY = json.dumps(totalreservpastyear)

	 #Retriving Stations with max usage Heatmap
	 getStationHMAP=Reservation.objects.raw('SELECT reservation_id FROM reservation')
	 stationlonlat=[]
	 for testobj in getStationHMAP:
	 	#print('testobject2 %s',[testobj.station_id])
	 	looptest1=Reservation.objects.raw('SELECT reservation_id,lon,lat FROM station, station_on_reservation, stationroutes,reservation WHERE  reservation_id = sor_reservation_id AND sor_route_id = route_id AND start_station_id = station_id AND reservation_id= %s',[testobj.reservation_id])
	 	lat=looptest1[0].lat
	 	lon=looptest1[0].lon
	 	if lat is not None:
	 		lat = float(lat)
	 	if lon is not None:
	 		lon = float(lon)
	 		stationlonlat.append((lat,lon))
	# print(stationlonlat)

	 count=Bike.objects.all().count()
	 Bikes=Bike.objects.all()
	 feedbackcount=Reservation.objects.filter(feedback=" ").count()
	 feedback=Reservation.objects.all()
	 userscount = User.objects.all().count()
	 users = User.objects.all()

	 return render(request,'manager/usagereports.html',{"stationByStartTime":sbt,"Stationname":stname,"Bikemax":bikemax,"Bikenamelt":bikenamelt,"totalreservpermonth":tresTD,"totalreservpastyear":tresPY,"stationlonlat":stationlonlat,'count':count,'Bikes':Bikes ,'feedbackcount':feedbackcount,'feedback':feedback,'userscount':userscount,'users':users})

def manStatistics(request):
	 #Retriving Stations with max usage
	 getStation=Station.objects.raw('SELECT station_id, name FROM station')
	 stationByStartTime=[]
	 for testobj in getStation:
	 	#print('testobject %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes WHERE sor_route_id=route_id AND station_id=start_station_id  AND station_id=%s',[testobj.station_id])
	 	#print('asdasdasd',looptest1[0].countnum,[testobj.station_id])
	 	stationByStartTime.append(looptest1[0].countnum)
	 	sbt = json.dumps(stationByStartTime)

    #Retriving Stations Name List
	 getStationname = Station.objects.raw('SELECT station_id,name FROM station')
	 Stationname=[]
	 for testobj in getStationname:
	 	#print ('testobject %s', [testobj.name])
	 	Stationname.append([testobj.name])
	 	#print(Stationname)
	 stname=json.dumps(Stationname)

	 #Retriving Max Bike usage
	 getBikelist = TypeOfBike.objects.raw('SELECT bike_type_id FROM type_of_bike')
	 bikesUsedCount = []
	 for testobj in getBikelist:
	 		#print ('testobject %s', [testobj.bike_type_id])
	 		looptest1 =  TypeOfBike.objects.raw('SELECT bike_type_id, count(bike_type_id) AS typecount FROM type_of_bike,  bike WHERE bike.bike_type = bike_type_id AND  bike_type_id = %s', [testobj.bike_type_id])
	 		#print ('asdasdasd', looptest1[0].typecount, [testobj.bike_type_id])
	 		bikesUsedCount.append(looptest1[0].typecount)
	 		#print('st count values', bikesUsedCount)
	 bikemax=json.dumps(bikesUsedCount)


	 #Retriving Max Bike Name List
	 getBikeNamelist = TypeOfBike.objects.raw('SELECT bike_type_id,bike_type FROM type_of_bike')
	 bikename=[]
	 for testobj in getBikeNamelist:
	 	#print ('testobject %s', [testobj.bike_type])
	 	bikename.append([testobj.bike_type])
	 #print(bikename)
	 bikenamelt=json.dumps(bikename)

	 #Retriving Max Bike usage
	 getBikelist = TypeOfBike.objects.raw('SELECT bike_type_id FROM type_of_bike')
	 bikesUsedCount = []
	 for testobj in getBikelist:
	 		#print ('testobject %s', [testobj.bike_type_id])
	 		looptest1 =  TypeOfBike.objects.raw('SELECT  bike_type_id, count(bike_type_id) AS replacecount FROM type_of_bike, bike WHERE bike.bike_type = bike_type_id AND travel_count=0  AND  bike_type_id = %s', [testobj.bike_type_id])
	 		#print ('asdasdasd', looptest1[0].replacecount, [testobj.bike_type_id])
	 		bikesUsedCount.append(looptest1[0].replacecount)
	 		#print('st count values', bikesUsedCount)
	 biketr=json.dumps(bikesUsedCount)


	 #Retriving Max Bike Name List
	 getBikeNamelist = TypeOfBike.objects.raw('SELECT bike_type_id,bike_type FROM type_of_bike')
	 bikename=[]
	 for testobj in getBikeNamelist:
	 	#print ('testobject %s', [testobj.bike_type])
	 	bikename.append([testobj.bike_type])
	 #print(bikename)
	 bikenamett=json.dumps(bikename)




	 count=Bike.objects.all().count()
	 Bikes=Bike.objects.all()
	 feedbackcount=Reservation.objects.filter(feedback=" ").count()
	 feedback=Reservation.objects.all()
	 userscount = User.objects.all().count()
	 users = User.objects.all()


    #Total PROFIT in this year
	 totalPROFITreservpermonth=[]
	 no_of_month = 12
	 count = 0
	 while count < no_of_month:
	 	count += 1
	 	totalPROFITreservpermonthquery = Reservation.objects.raw('SELECT reservation_id, SUM(res_cost) AS tmcount FROM reservation WHERE YEAR(res_date) = YEAR(NOW()) AND MONTH(res_date) = %s', [count])
	 	TProfit=totalPROFITreservpermonthquery[0].tmcount
	 	if TProfit is not None:
	 		TProfit = float(TProfit)
	 	totalPROFITreservpermonth.append(TProfit)
	 #print(totalPROFITreservpermonth)
	 totalPROFITreservpermonth = json.dumps(totalPROFITreservpermonth)

    #Total profit on each day
	 totalPROFITreservperDAY=[]
	 no_of_days = 31
	 count = 0
	 while count < no_of_days:
	 	count += 1
	 	totalreservprofitperDAYquery = Reservation.objects.raw('SELECT reservation_id, SUM(res_cost) AS tmcount FROM reservation WHERE MONTH(res_date) = MONTH(NOW()) AND DAY(res_date) = %s', [count])
	 	TProfitDAY=totalreservprofitperDAYquery[0].tmcount
	 	if TProfitDAY is not None:
	 		TProfitDAY = float(TProfitDAY)
	 	totalPROFITreservperDAY.append(TProfitDAY)
	 #print(totalPROFITreservperDAY)
	 totalPROFITreservperDAY = json.dumps(totalPROFITreservperDAY)

	 #Total profit on each day
	 totalPROFITreservperLASTMONTH=[]
	 no_of_days = 31
	 count = 0
	 while count < no_of_days:
	 	count += 1
	 	totalreservprofitperLASTMONTHquery = Reservation.objects.raw('SELECT reservation_id, SUM(res_cost) AS tmcount FROM reservation WHERE MONTH(res_date) = MONTH(NOW()- INTERVAL 1 MONTH) AND DAY(res_date) = %s', [count])
	 	TProfitLASTMONTH=totalreservprofitperLASTMONTHquery[0].tmcount
	 	if TProfitLASTMONTH is not None:
	 		TProfitLASTMONTH = float(TProfitLASTMONTH)
	 	totalPROFITreservperLASTMONTH.append(TProfitLASTMONTH)
	 #print(totalPROFITreservperLASTMONTH)
	 totalPROFITreservperLASTMONTH = json.dumps(totalPROFITreservperLASTMONTH)

    #Total profit in past year
	 Ptotalreservpastyear = []
	 no_of_month = 12
	 count = 0
	 while count < no_of_month:
	 	count += 1
	 	Ptotalreservpastyearquery = Reservation.objects.raw('SELECT reservation_id, SUM(res_cost) AS tmcount FROM reservation    WHERE YEAR(res_date) = YEAR(NOW()- INTERVAL 1 YEAR) AND MONTH(res_date) = %s', [count])
	 	TProfitYEAR=Ptotalreservpastyearquery[0].tmcount
	 	if TProfitYEAR is not None:
	 		TProfitYEAR = float(TProfitYEAR)
	 		Ptotalreservpastyear.append(TProfitYEAR)
	 #print(Ptotalreservpastyear)
	 Ptotalreservpastyear = json.dumps(Ptotalreservpastyear)

	  #Total Profit in this week
	 TPtotalreservperDOW = []
	 no_of_DOW = 7
	 count = 0
	 while count < no_of_DOW:
	 	count += 1
	 	TPtotalreservperDOWquery = Reservation.objects.raw('SELECT reservation_id, SUM(res_cost) AS twcount FROM reservation WHERE YEARWEEK(starttime) = YEARWEEK(NOW()) AND DAYOFWEEK(starttime) = %s', [count])
	 	TProfitWEEK=TPtotalreservperDOWquery[0].twcount
	 	if TProfitWEEK is not None:
	 		TProfitWEEK = float(TProfitWEEK)
	 	TPtotalreservperDOW.append(TProfitWEEK)
	 #print(TPtotalreservperDOW)
	 TPtotalreservperDOW = json.dumps(TPtotalreservperDOW)


	 return render(request, 'manager/statistics.html',{"Biketr":biketr,"Bikenamett":bikenamett,"stationByStartTime":sbt,"Stationname":stname,"Bikemax":bikemax,"Bikenamelt":bikenamelt,'count':count,'Bikes':Bikes ,'feedbackcount':feedbackcount,'feedback':feedback,'userscount':userscount,'users':users,"totalPROFITreservpermonth":totalPROFITreservpermonth,"TPtotalreservperDOW":TPtotalreservperDOW,"totalPROFITreservperDAY":totalPROFITreservperDAY,"totalPROFITreservperLASTMONTH":totalPROFITreservperLASTMONTH,"Ptotalreservpastyear":Ptotalreservpastyear})

def manDailyreport(request):
#Retriving Stations with max usage
	 getStation=Station.objects.raw('SELECT station_id, name FROM station')
	 stationByStartTimeTD=[]
	 for testobj in getStation:
	 	#print('testobject %s',[testobj.station_id])
	 	looptest1=Station.objects.raw('SELECT station_id,count(start_station_id)AS countnum FROM station, station_on_reservation, stationroutes, reservation WHERE sor_route_id = route_id AND station_id = start_station_id AND sor_reservation_id = reservation_id AND DATE(starttime) = CURDATE() AND station_id=%s',[testobj.station_id])
	 	#print('asdasdasd',looptest1[0].countnum,[testobj.station_id])
	 	stationByStartTimeTD.append(looptest1[0].countnum)
	 	sbtTD = json.dumps(stationByStartTimeTD)
	#Retriving Stations Name List
	 getStationname=Station.objects.raw('SELECT station_id, name FROM station')
	 StationnameTD=[]
	 for testobj in getStationname:
		 #print ('testobject %s', [testobj.name])
		 StationnameTD.append([testobj.name])
		 #print(StationnameTD)
		 stnameTD=json.dumps(StationnameTD)

	 #Total Reservations in this week
	 totalreservperDOW = []
	 no_of_DOW = 7
	 count = 0
	 while count < no_of_DOW:
	 	count += 1
	 	totalreservperDOWquery = Reservation.objects.raw('SELECT reservation_id, count(*) AS twcount FROM reservation WHERE YEARWEEK(starttime) = YEARWEEK(NOW()) AND DAYOFWEEK(starttime) = %s', [count])
	 	totalreservperDOW.append(totalreservperDOWquery[0].twcount)
	 	#print(totalreservperDOW)
	 	tresWTD = json.dumps(totalreservperDOW)

	 #Retriving Stations with max usage Heatmap
	 getStationHMAPTD=Reservation.objects.raw('SELECT reservation_id,DATE(starttime) FROM reservation')
	 stationlonlatTD=[]
	 for testobj in getStationHMAPTD:
	 	#print('testobject2 %s',[testobj.station_id])
	 	looptest1=Reservation.objects.raw('SELECT reservation_id,DATE(starttime),lon,lat FROM station, station_on_reservation, stationroutes,reservation WHERE  reservation_id = sor_reservation_id AND sor_route_id = route_id AND start_station_id = station_id AND DATE(starttime) = CURRENT_DATE() AND reservation_id= %s',[testobj.reservation_id])
	 	for loop in looptest1:
		 	lon=looptest1[0].lon
		 	lat=looptest1[0].lat
		 	if lat is not None:
		 		lat = float(lat)
		 	if lon is not None:
		 		lon = float(lon)
		 		stationlonlatTD.append((lat,lon))
	 #print(stationlonlatTD)

	 how_many_days = 1
	 reservations=Reservation.objects.filter(starttime__gte=datetime.now())
	 bike=Bike.objects.raw("select b.bike_id as bike_id, b.bike_type as bike_type,br.bor_reservation_id as bor_reservation_id from bike as b, bike_on_reservation as br where b.bike_id = br.bor_bike_id");
	 counter=Reservation.objects.filter(starttime__gte=datetime.now()).count()

     #Ratings Max
	 getRatings=Reservation.objects.raw('SELECT reservation_id,c_rating FROM reservation');
	 Ratings=[]
	 Rate= 5
	 count = 0
	 while count < Rate:
	 	count += 1
	 	getRatingsQuery = Reservation.objects.raw('SELECT reservation_id, count(c_rating) AS twcount FROM reservation WHERE DATE(starttime) = CURRENT_DATE() AND c_rating=%s', [count])
	 	getRatings=getRatingsQuery[0].twcount
	 	Ratings.append(getRatings)
	 	Rating= json.dumps(Ratings)



	 return render(request, 'manager/dailyreport.html',{"stationByStartTimeTD":sbtTD,"StationnameTD":stnameTD,"totalreservperDOW":tresWTD,"stationlonlatTD":stationlonlatTD,'reservations':reservations , 'bike':bike,'counter':counter,'Rating':Rating})
