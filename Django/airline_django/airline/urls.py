from django.urls import path
from . import views

urlpatterns = [
    path("aircraft/", views.aircraft_list, name="aircraft_list"),
    path("aircraft/add/", views.aircraft_create, name="aircraft_create"),
    path("aircraft/<int:aircraftid>/edit/", views.aircraft_update, name="aircraft_update"),
    path("aircraft/<int:aircraftid>/delete/", views.aircraft_delete, name="aircraft_delete")
]