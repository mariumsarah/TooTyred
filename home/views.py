from django.shortcuts import render, redirect
from .models import Users,Station, TypeOfBike
from .forms import ExampleForm, RegistrationForm, EditProfileForm
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from datetime import datetime, timedelta
from django.http import HttpResponse,JsonResponse
import json

def home(request):
    if request.method == 'POST':
        form = ExampleForm(request.POST)
        if form.is_valid():
            field1 = form.cleaned_data['field']
            book=Users(id=field1)
            book.save()
            return render(request, 'user/home.html', {'form': form,'user':Users.objects.all(),'is_false': True,'field1':field1})
    else:
        form = ExampleForm()
        return render(request, 'user/home.html', {'form': form,'user':Users.objects.all(),'is_false': False})

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request,'You are now registered!')
        else:
            messages.error(request,'The form is invalid.')

        return render(request,'user/reg_form.html',{'form': form})
    else:
        form = RegistrationForm()
        return render(request,'user/reg_form.html',{'form': form})


def reserve(request):
    if request.method == 'POST':
            response_data = {}

            if request.POST.get('formtype','') == 'bike':
                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            #----------------------EDGAR ----------------------------------
            elif request.POST.get('formtype','') == 'time':
                #-----------The following are the variables containing the dates and times
                #request.POST.get('starttime','')# in text 4:15 AM
                #request.POST.get('endtime','')# in text 3:50 AM
                #request.POST.get('startdate','')# in text 24 Jan 2019
                #request.POST.get('enddate','')#in text 25 Jan 2019


                #--------- the following are all the bike_types and how many are available forEach
                # the digit after result is the bike_type_id
                # also look at the success part of timepost() funciton in the reserve.html file
                # if you want to see how this is rendered on the page
                #--------- make sure this is in a for each bike_type loop
                # this is so the bike types are dynamic and more can be added later
                response_data['result1'] = 2
                response_data['result2'] = 0
                response_data['result3'] = 0
                response_data['result4'] = 0
                return HttpResponse(
                    json.dumps(response_data),
                    content_type="application/json"
                    )
            else:
                return render(request, 'user/reserve.html', {'station':Station.objects.all(),'bike_type':TypeOfBike.objects.all(),'startdates':startdates,'reservationdays':reservationdays,'costperhour':cost,'maxbikes':maxbikes})
    else:
        startdates = []
        i=0
        for i in range(15):
            startdates.append((datetime.now()+timedelta(days=i)).date())
            i=i+1
        cost=20;
        reservationdays = 14;
        maxbikes=3;
        return render(request, 'user/reserve.html', {'station':Station.objects.all(),'bike_type':TypeOfBike.objects.all(),'startdates':startdates,'reservationdays':reservationdays,'costperhour':cost,'maxbikes':maxbikes})

def reservations(request):
        return render(request,"user/reservations.html")


def logout(request):
    return render(request,"user/home.html")


def account(request):
    form1 = EditProfileForm(instance=request.user)
    form2 = PasswordChangeForm(user=request.user)
    args={'form1':form1,'form2':form2, 'user':request.user}
    return render(request,"user/account.html",args)


def changeaccount(request):
        if request.method == 'POST':
            form = EditProfileForm(request.POST,instance=request.user)
            if form.is_valid():
                form.save()
                messages.success(request, ('Your account details were successfully updated'))
                return redirect('/home/account/')
            else:
                messages.error(request, ('Your email format was invalid, try again'))
                return redirect('/home/account/')

def deleteaccount(request):
        user = request.user
        user.is_active = False
        user.save()
        messages.success(request, 'Profile successfully disabled. Thank you for everything, Have a great day!')
        return redirect('/home/login/')

#CHANGE PASSWORD VALIDATION NOT THERE----------
def changepassword(request):
    if request.method == 'POST':
        form = PasswordChangeForm(data=request.POST,user=request.user)
        if form.is_valid():
            form.save()
            update_session_auth_hash(request,form.user)
            messages.success(request, ('Your password was successfully updated!'))
            return redirect('/home/account/')
        else:
            messages.error(request, ('Your password was invalid'))
            return redirect('/home/account/')

def termsandconditions(request):
    return render(request,"user/termsandconditions.html")
