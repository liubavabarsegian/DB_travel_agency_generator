DROP PROCEDURE IF EXISTS public.give_bonus_points();

CREATE PROCEDURE give_bonus_points() AS $$
declare all_trips cursor for select * from trips;
BEGIN
update clients set bonus_points = 100;
<<l>>
for i in all_trips loop
    update clients
        set bonus_points = (select bonus_points 
							from clients 
							where i.client_id = clients.id) + i.trip_price * 0.01;
end loop l;
END;
$$ LANGUAGE plpgsql;
