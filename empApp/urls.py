from django.conf.urls import url
from django.contrib.auth.views import LoginView
app_name="empApp"
urlpatterns = [
    url(r'^$',LoginView.as_view(template_name='employee/login.html'),name="loginemp"),
    #url(r'^operator/$',views.operatorHome,name='operatorHome'),
    #url(r'^manager/$',views.managerHome,name='managerHome')
]
