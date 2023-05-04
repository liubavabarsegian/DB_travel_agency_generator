select (select aircompany_name from aircompanies where id = flights.aircompany_id), count(*) from trips
inner join flights
on flights.id = trips.departure_flight_id OR flights.id = trips.arrival_flight_id
where trips.has_luggage = 'true' OR trips.meal_for_flight = 'true'
group by flights.aircompany_id
order by count(*) DESC
LIMIT 10;