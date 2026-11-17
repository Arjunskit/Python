
from sqlalchemy import create_engine
from sqlalchemy import text


engine = create_engine("mysql+pymysql://root:1234@localhost/airlineDB")

departure_time = "12:00"

query = text(
    '''
    select * from flights
        join aircraft 
            on aircraft.aircraftID = flights.aircraft_assigned
        join airports
            on airports.code = flights.arrival_airport
        join airport_staff
            on airports.code = airport_staff.airportID
        join crew_assignments
            on flights.flightID = crew_assignments.flightID
        join crew
            on crew.crewID = crew_assignments.crewID
        join bookings
            on bookings.flightID = flights.flightID
        join passengers
            on bookings.passengerID = passengers.passengerID
        join tickets
            on bookings.bookingID = tickets.bookingID
        join baggage
            on tickets.ticketID = baggage.ticketID
        where 
            flights.departure_time > :departure_time;
    '''
)

with engine.connect() as connection:
    result = connection.execute(query, {"departure_time": departure_time})

    for row in result:
        print(row)

    
