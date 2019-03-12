from django.conf.urls import url
from . import views
app_name="manApp"
urlpatterns = [
    url(r'^usagereports/$',views.manUsagereports,name="usagereports"),
    url(r'^statistics/$',views.manStatistics,name="statistics"),
    url(r'^dailyreports/$',views.manDailyreport,name="dailyreport"),
    ]
