from django.db import models
from django.contrib.auth.models import User
#from . import fields
#when user created make a user profile too
from django.db.models.signals import post_save
from django.core.validators import RegexValidator
# Create your models here.

#store more infor about usr than provided
class UserProfile(models.Model):
    user=models.OneToOneField(User,on_delete=models.CASCADE)
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$', message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    phone_number = models.CharField(validators=[phone_regex], max_length=17, blank=True) # validators should be a list
    #-------------------------------WE NEED CREDIT CARD NUMBER-----------------------------
    #creditcardnumber=models.CharField(placeholder='0000 0000 0000 0000', min_length=12, max_length=19)
    creditcardexpirationdate=models.DateField(null=True,blank=True)
    CREDITCARD_TYPE = (
        ('V' ,'Visa'),
        ('M' ,'Mastercard'),
        ('A','American Express'),
    )
    creditcardtype=models.CharField(max_length=1,choices=CREDITCARD_TYPE,null=True,blank=True)
    def __str__(self):
        return self.user.username
#This part of the code when once a user is created the extended user profile for that user is also created
def create_profile(sender,**kwargs):
    if kwargs['created']:
        user_profile=UserProfile.objects.create(user=kwargs['instance'])

post_save.connect(create_profile,sender=User)

class Station(models.Model):
    station_id = models.AutoField(primary_key=True)
    address = models.CharField(max_length=100)
    rack_capacity = models.IntegerField()
    num_racks_available = models.IntegerField()
    info = models.TextField()
    name = models.CharField(max_length=50)
    lon = models.DecimalField(max_digits=30, decimal_places=16)
    lat = models.DecimalField(max_digits=30, decimal_places=15)
    is_active = models.IntegerField()
    image = models.CharField(max_length=30)
    fine_cost = models.DecimalField(max_digits=11, decimal_places=2, blank=True, null=True)
    fine_desc = models.TextField(blank=True, null=True)

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

    class Meta:
        managed = False
        db_table = 'bike'

class Creditcardinfo(models.Model):
    card_id = models.AutoField(primary_key=True)
    card_info = models.IntegerField()
    card_exp_date = models.DateField()

    class Meta:
        managed = False
        db_table = 'creditcardinfo'

class Complaints(models.Model):
    complaint_id = models.AutoField(primary_key=True)
    complaint_type = models.CharField(max_length=20)
    complaint_desc = models.TextField()

    class Meta:
        managed = False
        db_table = 'complaints'

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

class Checkuplog(models.Model):
    clog_id = models.AutoField(primary_key=True)
    clog_count = models.IntegerField()
    checkup_date = models.DateField()
    checkup_desc = models.TextField()
    checkuplog_station = models.ForeignKey('Station', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'checkuplog'

class Stationfootage(models.Model):
    footage_id = models.AutoField(primary_key=True)
    footage_date = models.CharField(max_length=20)
    footage_link = models.CharField(max_length=20)
    footage_station = models.ForeignKey(Station, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'stationfootage'

class Maintenancelog(models.Model):
    mlog_id = models.AutoField(primary_key=True)
    mlog_count = models.IntegerField()
    maintenance_date = models.DateField()
    maintenance_desc = models.TextField()
    mechanic_name = models.CharField(max_length=50)
    maintenance_bike = models.ForeignKey(Bike, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'maintenancelog'

class Stationroutes(models.Model):
    route_id = models.AutoField(primary_key=True)
    start_station = models.ForeignKey(Station, models.DO_NOTHING, related_name='start_station_id', blank=True, null=True)
    end_station = models.ForeignKey(Station, models.DO_NOTHING, related_name='end_station_id', blank=True, null=True)

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
    c = models.ForeignKey(User, models.DO_NOTHING)
    bike_reservation = models.ManyToManyField(Bike, through='BikeOnReservation')
    route_reservation = models.ManyToManyField(Stationroutes, through='StationOnReservation')

    class Meta:
        managed = False
        db_table = 'reservation'





class BikeOnReservation(models.Model):
    bor_bike = models.ForeignKey(Bike, models.DO_NOTHING)
    bor_reservation = models.ForeignKey('Reservation', models.DO_NOTHING)

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
