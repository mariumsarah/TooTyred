from django.shortcuts import render, redirect
from .models import Users,Station, TypeOfBike
from .forms import ExampleForm, RegistrationForm, EditProfileForm
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.decorators import login_required
from datetime import datetime, timedelta
from django.http import HttpResponse
# Create your views here.
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
        return HttpResponse(request.POST.get("inputendstation",""))
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
                return redirect('/home/account/')

def deleteaccount(request):
        user = request.user
        user.is_active = False
        user.save()
        messages.success(request, 'Profile successfully disabled.')
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
