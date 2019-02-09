from django.conf.urls import url
from . import views

app_name="optrApp"
urlpatterns = [
    url(r'^log/$',views.log,name="log"),
    url(r'^bikes/$',views.bikes,name="bikes"),
    url(r'^customerservice/$',views.customerService,name="customerservice"),
    url(r'^station[0-9]/$',views.stations,name="stations"),
    ]
