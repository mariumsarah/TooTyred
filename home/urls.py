from django.conf.urls import url
from . import views
from django.contrib.auth.views import LoginView,LogoutView
app_name="home"
urlpatterns = [
    url(r'^$',views.home,name='home'),
    url(r'^login/$',LoginView.as_view(template_name='user/login.html'),name="login"),
    url(r'^logout/$',LogoutView.as_view(template_name='user/logout.html'),name="logout"),
    url(r'^register/$',views.register,name='register'),
    url(r'^logout/$',views.logout,name='logout'),
    url(r'^account/$',views.account,name='account'),
    url(r'^reserve/$',views.reserve,name='reserve'),
    url(r'^reservations/$',views.reservations,name='reservations')
]
