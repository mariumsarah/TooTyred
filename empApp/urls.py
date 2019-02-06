from django.conf.urls import url
from django.contrib.auth.views import LoginView
from . import views
app_name="empApp"
urlpatterns = [
    url(r'^$',LoginView.as_view(template_name='employee/login.html',redirect_field_name= '/employee/log/'),name="emplogin"),
    url(r'^log/$',views.log,name="log"),
    url(r'^bikes/$',views.bikes,name="bikes"),
    url(r'^customerservice/$',views.empCustomerService,name="customerservice"),
    url(r'^station[0-9]/$',views.stations,name="stations"),
    ]
