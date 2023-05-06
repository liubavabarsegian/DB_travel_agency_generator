DROP PROCEDURE IF EXISTS public.arrivals();

CREATE PROCEDURE arrivals() AS $$
declare all_trips cursor for select * from trips;
BEGIN
<<l>>
for i in all_trips loop
	update trips tr set arrival_flight_id = 	(select f.id 
												  from flights as f
												  where (floor(extract(epoch 
																	   FROM (f.departure_time - (select departure_time 
																									   from flights 
																									   where flights.id = i.departure_flight_id))/86400))) >= 3 
                            					  AND (floor(extract(epoch 
																	 FROM (f.departure_time - (select departure_time
																									 from flights 
																									 where flights.id = i.departure_flight_id))/86400))) <= 30
                             					  AND i.country_id = f.country_from
												 order by random() limit 1)

	where i.id = tr.id;
end loop l;

update  trips tr 
	set arrival_date = (select departure_time 
						  from flights 
						  where flights.id = tr.arrival_flight_id);

UPDATE trips set number_of_nights = (trips.arrival_date - trips.departure_date);

END;
$$ LANGUAGE plpgsql;

call arrivals();