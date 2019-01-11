from django.shortcuts import render, redirect
from .models import Users,Stationstable
from .forms import ExampleForm
from django.contrib.auth.forms import UserCreationForm
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
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            #----------------------REDIRECT AND DISPLAY A MESSAGE HOW DO YOU DO THAT------------------
            return redirect('/home/login/')
        #--------------------NO VALIDATION HOW TO PUT VALIDATION-------------
        else:
            return render(request,'user/reg_form.html',{'form':UserCreationForm()})
    else:
        form = UserCreationForm()
        return render(request,'user/reg_form.html',{'form': form})

def reserve(request):
    return render(request, 'user/reserve.html', {'stations':Stationstable.objects.all()})

def reservations(request):
    return render(request,"user/reservations.html")

def logout(request):
    return render(request,"user/home.html")

def account(request):
    return render(request,"user/account.html")
