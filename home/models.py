from django.db import models
from django.contrib.auth.models import User
#from . import fields
#when user created make a user profile too
from django.db.models.signals import post_save
from django.core.validators import RegexValidator
# Create your models here.

#home.html playing with users folder
class Users(models.Model):
    id = models.IntegerField(primary_key=True)
    class Meta:
        managed = False
        db_table = 'users'

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
        db_table = 'station'

class TypeOfBike(models.Model):
    bike_type_id = models.AutoField(primary_key=True)
    bike_info = models.TextField()
    bike_model = models.CharField(max_length=20)
    bike_type = models.CharField(max_length=20)
    bike_cost = models.DecimalField(max_digits=11, decimal_places=2)
    bike_image = models.CharField(max_length=30)

    class Meta:
        db_table = 'type_of_bike'


class StatusOfBike(models.Model):
    bike_status_id = models.AutoField(primary_key=True)
    bike_status_name = models.CharField(max_length=20)

    class Meta:
        db_table = 'status_of_bike'


class Bike(models.Model):
    bike_id = models.AutoField(primary_key=True)
    bike_type = models.ForeignKey('TypeOfBike', TypeOfBike, db_column='bike_type')
    travel_count = models.DecimalField(max_digits=8, decimal_places=2)
    bike_status = models.ForeignKey('StatusOfBike', StatusOfBike, db_column='bike_status')
    bike_stationedat = models.ForeignKey('Station', Station, db_column='bike_stationedat', blank=True, null=True)

    class Meta:
        db_table = 'bike'
