from django.conf.urls import url
from . import views

app_name="home"
urlpatterns = [
    url(r'^$',views.home,name='home'),
    url(r'^login/$',views.login,name='login'),
    url(r'^register/$',views.register,name='register'),
    url(r'^logout/$',views.logout,name='logout'),
    url(r'^account/$',views.login,name='account'),
    url(r'^reserve/$',views.reserve,name='reserve'),
    url(r'^reservations/$',views.reservations,name='reservations')
]
