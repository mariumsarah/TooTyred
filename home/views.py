from django.shortcuts import render
from .models import Users
from .forms import ExampleForm
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

def login(request):
    return render(request,"user/login.html")

def register(request):
    return render(request,"user/reg_form.html")
