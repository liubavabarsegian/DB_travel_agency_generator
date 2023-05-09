select 	client_id, 
		(select full_name 
		from people 
		where id = (select person_id
				   from clients
				   where id = client_id)),
		count(*),
		sum(trip_price) 
from trips
inner join clients
	on clients.id = trips.client_id
where date_part('year', departure_date) = 2023
group by client_id
order by sum(trip_price) DESC
LIMIT 1;