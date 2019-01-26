from django.shortcuts import render

# Create your views here.
def manager(request):
    return render(request, 'manager/home.html')

def manUsagereports(request):
    return render(request, 'manager/usagereports.html')
    
def manStatistics(request):
    return render(request, 'manager/statistics.html')

def manDailyreport(request):
    return render(request, 'manager/dailyreport.html')
