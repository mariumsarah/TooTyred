from django.db import models
from django.contrib.auth.models import User
#from . import fields
#when user created make a user profile too
from django.db.models.signals import post_save
from django.core.validators import RegexValidator
# Create your models here.

class Station(models.Model):
    station_id = models.AutoField(primary_key=True)
    address = models.CharField(max_length=100)
    info = models.TextField()
    name = models.CharField(max_length=50)
    lon = models.DecimalField(max_digits=30, decimal_places=16)
    lat = models.DecimalField(max_digits=30, decimal_places=15)
    is_active = models.IntegerField()
    image = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'station'

class TypeOfBike(models.Model):
    bike_type_id = models.AutoField(primary_key=True)
    bike_info = models.TextField()
    bike_model = models.CharField(max_length=20)
    bike_type = models.CharField(max_length=20)
    bike_cost = models.DecimalField(max_digits=11, decimal_places=2)
    bike_image = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'type_of_bike'


class StatusOfBike(models.Model):
    bike_status_id = models.AutoField(primary_key=True)
    bike_status_name = models.CharField(max_length=20)

    class Meta:
        db_table = 'status_of_bike'


class Bike(models.Model):
    bike_id = models.AutoField(primary_key=True)
    bike_type = models.ForeignKey('TypeOfBike',models.DO_NOTHING, db_column='bike_type')
    travel_count = models.DecimalField(max_digits=8, decimal_places=2)
    bike_status = models.ForeignKey('StatusOfBike', models.DO_NOTHING, db_column='bike_status')
    bike_stationedat = models.ForeignKey('Station', models.DO_NOTHING, db_column='bike_stationedat', blank=True, null=True)
    UID = models.CharField(max_length=255)
    class Meta:
        managed = False
        db_table = 'bike'

class ReservationType(models.Model):
    res_type_id = models.AutoField(primary_key=True)
    res_type_name = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'reservation_type'

class CustomerRating(models.Model):
    rating_id = models.AutoField(primary_key=True)
    rating_value = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'customer_rating'

class Stationroutes(models.Model):
    route_id = models.AutoField(primary_key=True)
    start_station = models.ForeignKey(Station, models.DO_NOTHING, related_name='start_station_id', blank=True, null=True)
    end_station = models.ForeignKey(Station, models.DO_NOTHING, related_name='end_station_id', blank=True, null=True)
    min_miles_travelled = models.DecimalField(max_digits=11, decimal_places=2)
    class Meta:
        managed = False
        db_table = 'stationroutes'

class Reservation(models.Model):
    reservation_id = models.AutoField(primary_key=True)
    res_type = models.ForeignKey('ReservationType', models.DO_NOTHING, db_column='res_type')
    res_cost = models.DecimalField(max_digits=11, decimal_places=2)
    res_date = models.DateTimeField()
    starttime = models.DateTimeField()
    endtime = models.DateTimeField()
    c_rating = models.ForeignKey(CustomerRating, models.DO_NOTHING, db_column='c_rating', blank=True, null=True)
    feedback= models.TextField(blank=True, null=True)
    c = models.ForeignKey(User, models.DO_NOTHING)
    bike_reservation = models.ManyToManyField(Bike, through='BikeOnReservation')
    route_reservation = models.ManyToManyField(Stationroutes, through='StationOnReservation')
    res_code = models.TextField()
    fine_cost = models.DecimalField(max_digits=11, decimal_places=2, blank=True, null=True)
    fine_desc = models.TextField(blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'reservation'

class BikeOnReservation(models.Model):
    bor_bike = models.ForeignKey('Bike', models.DO_NOTHING)
    bor_reservation = models.ForeignKey(Reservation, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'bike_on_reservation'
        unique_together = (('bor_bike', 'bor_reservation'),)

class StationOnReservation(models.Model):
    sor_route = models.ForeignKey('Stationroutes', models.DO_NOTHING)
    sor_reservation = models.ForeignKey(Reservation, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'station_on_reservation'
        unique_together = (('sor_route', 'sor_reservation'),)
#A table to keep track of station systems
# QR code for reservations

class contactUs(models.Model):
    mail_id = models.AutoField(primary_key=True,null=False)
    fn = models.CharField(max_length=30,null=False)
    ln = models.CharField(max_length=40,null=False)
    message=models.CharField(max_length=200,null=False)
    email=models.EmailField(null=False)
    class Meta:
        db_table = 'contactUs'
        managed = False
