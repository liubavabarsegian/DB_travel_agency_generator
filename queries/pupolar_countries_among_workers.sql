select (select name from countries where id = country_id), count(*) from trips
where client_id IN (select clients.id from clients
	INNER JOIN workers
	ON clients.person_id = workers.person_id)
group by country_id
order by count(*) DESC
LIMIT 10;