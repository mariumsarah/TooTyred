from django.shortcuts import render
from django.urls import resolve
from django.http import HttpResponse
import json
from django.urls import resolve
from home.models import Station,Reservation
from django.contrib import messages
# Create your views here.
# Create your views here.

def stations(request):
    current_url = int(request.get_full_path().strip('/')[-1:])+1
    if(request.method == "POST"):
        if Reservation.objects.filter(res_code=request.POST.get("reservationcode","")).exists():
            messages.success(request,'Your'+' Tandem bike '+' is now '+' UNLOCKED! Have a great ride!'+'LOCKED! Thank you for reserving with us!')
        else:
            messages.error(request,'Sorry, you entered the wrong code. Please try again!')
        return render(request, 'employee/station.html',{'url':current_url,'station':Station.objects.get(station_id=current_url)})
    else:
        current_url = int(request.get_full_path().strip('/')[-1:])+1
        return render(request, 'employee/station.html',{'url':current_url,'station':Station.objects.get(station_id=current_url)})

def log(request):
    return render(request, 'employee/home.html')

def bikes(request):
    return render(request, 'employee/inspectbikes.html')

def empCustomerService(request):
    return render(request, 'employee/customerservice.html')

def empCheckups(request):
    return render(request, 'employee/checkups.html')

def empCheckups(request):
    return render(request, 'employee/checkups.html')
