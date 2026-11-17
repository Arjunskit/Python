# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Aircraft(models.Model):
    aircraftid = models.IntegerField(db_column='aircraftID', primary_key=True)  # Field name made lowercase.
    model = models.CharField(max_length=50, blank=True, null=True)
    manufacturer = models.CharField(max_length=50, blank=True, null=True)
    seating_capacity = models.IntegerField(blank=True, null=True)
    registration_no = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'aircraft'


class AirportStaff(models.Model):
    staffid = models.IntegerField(db_column='staffID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=50, blank=True, null=True)
    gender = models.CharField(max_length=50, blank=True, null=True)
    dob = models.DateField(db_column='DOB', blank=True, null=True)  # Field name made lowercase.
    phone = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    job_title = models.CharField(max_length=50, blank=True, null=True)
    airportid = models.ForeignKey('Airports', models.DO_NOTHING, db_column='airportID', blank=True, null=True)  # Field name made lowercase.
    shift = models.CharField(max_length=50, blank=True, null=True)
    salary = models.FloatField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'airport_staff'


class Airports(models.Model):
    code = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=50, blank=True, null=True)
    city = models.CharField(max_length=50, blank=True, null=True)
    state = models.CharField(max_length=50, blank=True, null=True)
    country = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'airports'

class Baggage(models.Model):
    baggageid = models.IntegerField(db_column='baggageID', primary_key=True)  # Field name made lowercase.
    ticketid = models.ForeignKey('Tickets', models.DO_NOTHING, db_column='ticketID', blank=True, null=True)  # Field name made lowercase.
    weight_kg = models.FloatField(blank=True, null=True)
    type = models.CharField(max_length=50, blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'baggage'


class Bookings(models.Model):
    bookingid = models.IntegerField(db_column='bookingID', primary_key=True)  # Field name made lowercase.
    passengerid = models.ForeignKey('Passengers', models.DO_NOTHING, db_column='passengerID', blank=True, null=True)  # Field name made lowercase.
    booking_date = models.DateTimeField(blank=True, null=True)
    flightid = models.ForeignKey('Flights', models.DO_NOTHING, db_column='flightID', blank=True, null=True)  # Field name made lowercase.
    status = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'bookings'


class Crew(models.Model):
    crewid = models.IntegerField(db_column='crewID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=50, blank=True, null=True)
    designation = models.CharField(max_length=50, blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(unique=True, max_length=50, blank=True, null=True)
    experience = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'crew'


class CrewAssignments(models.Model):
    assignmentid = models.IntegerField(db_column='assignmentID', primary_key=True)  # Field name made lowercase.
    flightid = models.ForeignKey('Flights', models.DO_NOTHING, db_column='flightID', blank=True, null=True)  # Field name made lowercase.
    crewid = models.ForeignKey(Crew, models.DO_NOTHING, db_column='crewID', blank=True, null=True)  # Field name made lowercase.
    status = models.CharField(max_length=50, blank=True, null=True)
    updated_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'crew_assignments'



class FlightSchedule(models.Model):
    scheduleid = models.IntegerField(db_column='scheduleID', primary_key=True)  # Field name made lowercase.
    flightid = models.ForeignKey('Flights', models.DO_NOTHING, db_column='flightID', blank=True, null=True)  # Field name made lowercase.
    schedule_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'flight_schedule'


class FlightStatus(models.Model):
    statusid = models.IntegerField(db_column='statusID', primary_key=True)  # Field name made lowercase.
    flightid = models.ForeignKey('Flights', models.DO_NOTHING, db_column='flightID', blank=True, null=True)  # Field name made lowercase.
    status = models.CharField(max_length=50, blank=True, null=True)
    updated_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'flight_status'


class Flights(models.Model):
    flightid = models.IntegerField(db_column='flightID', primary_key=True)  # Field name made lowercase.
    airline_name = models.CharField(max_length=50, blank=True, null=True)
    departure_airport = models.ForeignKey(Airports, models.DO_NOTHING, db_column='departure_airport', blank=True, null=True)
    arrival_airport = models.ForeignKey(Airports, models.DO_NOTHING, db_column='arrival_airport', related_name='flights_arrival_airport_set', blank=True, null=True)
    aircraft_assigned = models.ForeignKey(Aircraft, models.DO_NOTHING, db_column='aircraft_assigned', blank=True, null=True)
    departure_time = models.TimeField(blank=True, null=True)
    arrival_time = models.TimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'flights'


class Passengers(models.Model):
    passengerid = models.IntegerField(db_column='passengerID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=50, blank=True, null=True)
    gender = models.CharField(max_length=50, blank=True, null=True)
    dob = models.DateField(db_column='DOB', blank=True, null=True)  # Field name made lowercase.
    phone = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(unique=True, max_length=50, blank=True, null=True)
    passport_no = models.CharField(unique=True, max_length=50, blank=True, null=True)
    nationality = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'passengers'


class Payments(models.Model):
    paymentid = models.IntegerField(db_column='paymentID', primary_key=True)  # Field name made lowercase.
    bookingid = models.ForeignKey(Bookings, models.DO_NOTHING, db_column='bookingID', blank=True, null=True)  # Field name made lowercase.
    amount = models.FloatField(blank=True, null=True)
    method = models.CharField(max_length=50, blank=True, null=True)
    payment_date = models.DateTimeField(blank=True, null=True)
    payment_status = models.CharField(max_length=50, blank=True, null=True)
    transactionid = models.IntegerField(db_column='transactionID', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'payments'


class Tickets(models.Model):
    ticketid = models.IntegerField(db_column='ticketID', primary_key=True)  # Field name made lowercase.
    bookingid = models.ForeignKey(Bookings, models.DO_NOTHING, db_column='bookingID', blank=True, null=True)  # Field name made lowercase.
    passengerid = models.ForeignKey(Passengers, models.DO_NOTHING, db_column='passengerID', blank=True, null=True)  # Field name made lowercase.
    seat_number = models.CharField(max_length=50, blank=True, null=True)
    fare_class = models.CharField(max_length=50, blank=True, null=True)
    issue_date = models.DateTimeField(blank=True, null=True)
    ticket_status = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tickets'
