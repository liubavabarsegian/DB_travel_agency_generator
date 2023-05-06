DROP PROCEDURE IF EXISTS public.hotels();

CREATE PROCEDURE hotels() AS $$
declare all_trips cursor for select * from trips;
BEGIN
<<l>>
for i in all_trips loop
	update trips tr set hotel_id =	    (select id
										from hotels as h
										where h.city_id IN (select id 
															from cities
														   	where country_id = i.country_id)
										order by random() limit 1)

	where i.id = tr.id;
end loop l;
END;
$$ LANGUAGE plpgsql;
