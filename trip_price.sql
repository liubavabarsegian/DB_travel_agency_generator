DROP PROCEDURE IF EXISTS public.price();

CREATE PROCEDURE price() AS $$
declare all_trips cursor for select * from trips;
BEGIN
<<l>>
for i in all_trips loop
	update trips tr set trip_price = (number_of_nights * ((select price_for_adult 
														  	from insurances
														  	where insurances.id = insurance_id)
														 +(select price_for_a_person
														   	from hotels 
														   	where hotels.id = hotel_id))
														 +(select price 
														   from flights 
														   where flights.id = departure_flight_id)
         												+ (select price 
														   from flights 
														   where flights.id  = arrival_flight_id) 
     									)
    WHERE i.tourist_id IN (select id 
						 from tourists 
						 where tourists.person_id IN  (select id 
													   from people 
													   where (floor(extract(epoch FROM ( NOW() - people.birthday_date)/86400/365))) < 12))
    
	AND i.id = tr.id;
end loop l;

<<n>>
for i in all_trips loop
	update trips tr set trip_price = (number_of_nights * ((select price_for_children_and_old 
														  	from insurances
														  	where insurances.id = insurance_id)
														 +(select price_for_a_person * hotels.discount_percent_for_children / 100 
														   	from hotels 
														   	where hotels.id = hotel_id))
														 +(select price 
														   from flights 
														   where flights.id = departure_flight_id) * (select discount_persent_for_children 
																									  from aircompanies 
																									  where id = (select aircompany_id 
																												  from flights 
																												  where id = departure_flight_id))/100
         												+ (select price 
														   from flights 
														   where flights.id  = arrival_flight_id) * (select discount_persent_for_children 
																									 from aircompanies 
																									 where id = (select aircompany_id 
																												 from flights 
																												 where id = arrival_flight_id))/100
     									)
    WHERE i.tourist_id IN (select id 
						 from tourists 
						 where tourists.person_id IN  (select id 
													   from people 
													   where (floor(extract(epoch FROM ( NOW() - people.birthday_date)/86400/365))) >= 12))
    
	AND i.id = tr.id;
end loop n;


<<luggage>>
for i in all_trips loop
	update trips tr set trip_price = (trip_price + (SELECT luggage_price 
													from aircompanies where id = (select aircompany_id 
																				  from flights 
																				  where flights.id = departure_flight_id))
         											+ (SELECT luggage_price 
													   from aircompanies where id = (select aircompany_id 
																					 from flights 
																					 where flights.id = arrival_flight_id))
         							)
    WHERE i.has_luggage = 'true'    
	AND i.id = tr.id;
end loop luggage;

<<meal>>
for i in all_trips loop
	update trips tr set trip_price = (trip_price + (SELECT meal_price 
													from aircompanies 
													where id = (select aircompany_id 
																from flights 
																where flights.id = departure_flight_id))
									 			+ (SELECT meal_price 
												   from aircompanies 
												   where id = (select aircompany_id 
															   from flights 
															   where flights.id = arrival_flight_id))
    							     )
    WHERE i.meal_for_flight = 'true'    
	AND i.id = tr.id;
end loop meal;

END;
$$ LANGUAGE plpgsql;
