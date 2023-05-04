DROP TRIGGER IF EXISTS trigger_points ON public.trips;
DROP FUNCTION IF EXISTS public.give_bonus_points();

CREATE FUNCTION give_bonus_points() RETURNS TRIGGER AS $$
BEGIN
UPDATE clients AS t1
SET bonus_points = bonus_points + t3.trip_price * 0.005
FROM (SELECT
t2.trip_price,
t2.client_id
FROM trips AS t2
WHERE NEW.id = t2.id) AS t3
WHERE t1.id = t3.client_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_points
AFTER UPDATE OF trip_price
ON public.trips
FOR EACH ROW
EXECUTE FUNCTION public.give_bonus_points();
