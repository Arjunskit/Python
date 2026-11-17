

# Create your views here.


from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.db import IntegrityError
from .models import Aircraft


def aircraft_list(request):
    aircraft = Aircraft.objects.all()

    return render(request, "aircraft/aircraft_list.html", {
        "aircraft": aircraft
    })

def aircraft_create(request):

    if request.method == "POST":

        Aircraft.objects.create(
            aircraftid=request.POST.get("aircraftid"),
            model=request.POST.get("model"),
            manufacturer=request.POST.get("manufacturer"),
            seating_capacity=request.POST.get("seating_capacity"),
            registration_no=request.POST.get("registration_no")
        )

        return redirect("aircraft_list")
    
    return render(request, "aircraft/aircraft_create.html")


def aircraft_update(request, aircraftid):

    aircraft = get_object_or_404(Aircraft, aircraftid=aircraftid)

    if request.method == "POST":

        aircraft.model = request.POST.get("model")
        aircraft.manufacturer=request.POST.get("manufacturer")
        aircraft.seating_capacity=request.POST.get("seating_capacity")
        aircraft.registration_no=request.POST.get("registration_no")

        aircraft.save()

        return redirect("aircraft_list")

    return render(
        request,
        "aircraft/aircraft_update.html",
        {"aircraft": aircraft}
    )


def aircraft_delete(request, aircraftid):

    aircraft = get_object_or_404(Aircraft, aircraftid=aircraftid)

    if request.method == "POST":
        try:
            aircraft.delete()

            messages.success(
                request,
                "Aircraft deleted successfully."
            )

        except IntegrityError:
            messages.error(
                request,
                "Cannot delete this aircraft because it is assigned to existing flights or other records."
            )

        return redirect("aircraft_list")

    return render(
        request,
        "aircraft/aircraft_delete.html",
        {"aircraft": aircraft}
    )


    