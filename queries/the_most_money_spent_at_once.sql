select 	client_id, 
		(select full_name 
		from people 
		where id = (select person_id
				   from clients
				   where id = client_id)),
		trip_price, id as trip_id
from trips
order by trip_price DESC
LIMIT 1;