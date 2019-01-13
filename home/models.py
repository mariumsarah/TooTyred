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

#This part of the code when once a user is created the extended user profile for that user is also created
def create_profile(sender,**kwargs):
    if kwargs['created']:
        user_profile=UserProfile.objects.create(user=kwargs['instance'])

post_save.connect(create_profile,sender=User)

class Stationstable(models.Model):
    lon = models.DecimalField(max_digits=30, decimal_places=16, blank=True, null=True)
    address = models.CharField(max_length=50, blank=True, null=True)
    capacity = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=30, blank=True, null=True)
    lat = models.DecimalField(max_digits=30, decimal_places=15, blank=True, null=True)
    num_bikes_available = models.IntegerField(blank=True, null=True)
    last_reported = models.IntegerField(blank=True, null=True)
    is_installed = models.TextField(blank=True, null=True)  # This field type is a guess.
    num_docks_available = models.IntegerField(blank=True, null=True)
    station_id = models.IntegerField(primary_key=True)
    is_renting = models.TextField(blank=True, null=True)  # This field type is a guess.
    is_returning = models.TextField(blank=True, null=True)  # This field type is a guess.
    image = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'stationstable'
