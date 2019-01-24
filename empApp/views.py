from django.shortcuts import render

# Create your views here.
# Create your views here.
#def station1(request):
#    if request.user.is_superuser:
#        return render(request, 'user/station1.html')
def emplogin(request):
    if request.method == 'POST':
        return render(request, 'employee/login.html')
    else:
        return render(request, 'employee/login.html')

def log(request):
    return render(request, 'employee/home.html')

def bikes(request):
    return render(request, 'employee/inspectbikes.html')

def empReservations(request):
    return render(request, 'employee/inspectreservations.html')

def empStations(request):
    return render(request, 'employee/inspectstations.html')

def empCustomerService(request):
    return render(request, 'employee/customerservice.html')

def empCheckups(request):
    return render(request, 'employee/checkups.html')
