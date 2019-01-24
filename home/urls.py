from django.conf.urls import url
from . import views
from django.contrib.auth.views import LoginView,LogoutView,PasswordResetView, PasswordResetConfirmView, PasswordResetDoneView,PasswordResetCompleteView
app_name="home"
urlpatterns = [
    url(r'^$',views.home,name='home'),
    url(r'^login/$',LoginView.as_view(template_name='user/login.html'),name="login"),
    url(r'^logout/$',LogoutView.as_view(template_name='user/logout.html'),name="logout"),
    url(r'^register/$',views.register,name='register'),
    url(r'^termsandconditions/$',views.termsandconditions,name='termsandconditions'),
    url(r'^logout/$',views.logout,name='logout'),
    url(r'^account/$',views.account,name='account'),
    url(r'^reserve/$',views.reserve,name='reserve'),
    url(r'^reservations/$',views.reservations,name='reservations'),
    url(r'^changeaccount/$', views.changeaccount, name='changeaccount'),
    url(r'^deleteaccount/$', views.deleteaccount, name='deleteaccount'),
    url(r'^changepassword/$', views.changepassword, name='changepassword'),
    url(r'^reset-password/$',PasswordResetView.as_view(template_name='user/reset_password.html',email_template_name='user/reset_password_email.html',success_url= 'done'),name='reset_password'),
    url(r'^reset-password/done/$',PasswordResetDoneView.as_view(template_name='user/reset_password_done.html'),name='password_reset_done'),
    url(r'^reset-password/confirm/(?P<uidb64>[0-9A-Za-z]+)/(?P<token>.+)/$',PasswordResetConfirmView.as_view(template_name='user/reset_password_confirm.html',success_url= '/home/reset-password/complete/'),name='password_reset_confirm'),
    url(r'^reset-password/complete/$',PasswordResetCompleteView.as_view(template_name='user/reset_password_complete.html'),name='password_reset_complete')
]
