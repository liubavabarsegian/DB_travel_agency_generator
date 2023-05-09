select (select name from countries where id = country_id), count(country_id), round(avg(workers.salary)) from trips
INNER JOIN clients
ON trips.client_id = clients.id
INNER JOIN workers
ON workers.person_id = clients.person_id
group by country_id
order by count(*) DESC
LIMIT 10;