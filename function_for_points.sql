DROP PROCEDURE IF EXISTS public.give_bonus_points();

CREATE PROCEDURE give_bonus_points() AS $$
declare all_trips cursor for select * from trips;
BEGIN
<<l>>
for i in all_trips loop
    update clients
    set bonus_points = bonus_points + i.trip_price * 0.005
    where i.client_id = clients.id;
end loop l;
END;
$$ LANGUAGE plpgsql;