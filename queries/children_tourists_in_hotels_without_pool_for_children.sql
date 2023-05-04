select (select full_name as client_name from people 
		where people.id = (select person_id from clients where clients.id = client_id)), 
		(select email from people 
		where people.id = (select person_id from clients where clients.id = client_id)),
		(select full_name as tourist_name from people 
		where people.id = (select person_id from tourists where tourists.id = tourist_id)),
		(select (floor(extract(epoch FROM ( NOW() - people.birthday_date)/86400/365))) as tourist_age from people 
		where people.id = (select person_id from tourists where tourists.id = tourist_id))
		from trips
INNER JOIN hotels
ON trips.hotel_id = hotels.id
WHERE hotels.has_pool_for_children = 'false'
AND trips.tourist_id IN
	(select id from tourists where person_id IN 
	(select id from people where (floor(extract(epoch FROM ( NOW() - people.birthday_date)/86400/365))) < 10));
