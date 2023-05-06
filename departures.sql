DROP PROCEDURE IF EXISTS public.departures();

CREATE PROCEDURE departures() AS $$
declare all_trips cursor for select * from trips;
BEGIN
<<l>>
for i in all_trips loop
	update trips tr 
		set departure_flight_id = (select f.id 
                                    from flights as f
                                    where i.country_id = f.country_where_to
                                    order by random () limit 1)
	where i.id = tr.id;
end loop l;

update  trips tr 
	set departure_date = (select departure_time 
                            from flights 
                            where flights.id = tr.departure_flight_id);

END;
$$ LANGUAGE plpgsql;

call departures();