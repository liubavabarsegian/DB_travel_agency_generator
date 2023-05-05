select client_id, sum(trip_price) from trips
inner join clients
on clients.id = trips.client_id
group by client_id
order by sum(trip_price) DESC
LIMIT 1;