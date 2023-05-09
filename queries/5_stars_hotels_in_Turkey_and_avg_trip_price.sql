select 
		hotels.id, 
		hotel_name,
		(select name 
		from cities
		where cities.id = hotels.city_id),
		(select round(avg(trip_price))
		from trips
		where trips.hotel_id = hotels.id
		group by hotel_id)
from hotels 
INNER JOIN cities
ON cities.id = hotels.city_id
INNER JOIN countries
ON countries.id = cities.country_id
WHERE countries.name = 'Турция'
AND hotels.number_of_stars = 5