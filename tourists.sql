DROP PROCEDURE IF EXISTS public.tourists();

CREATE PROCEDURE tourists() AS $$
declare all_trips cursor for select * from trips;
BEGIN
<<l>>
for i in all_trips loop
    update trips
    	set tourist_id = (select id
						from tourists
						where not exists (select tourist_id 
                                            from trips
                                            where ((i.departure_date >= trips.departure_date and i.departure_date =< trips.arrival_date)
                                            OR (i.arrival_date >= trips.departure_date and i.arrival_date =< trips.arrival_date))
                                            AND trips.tourist_id = tourists.id
										)
						order by random() limit 1)
    where i.id = trips.id;
end loop l;
END;
$$ LANGUAGE plpgsql;