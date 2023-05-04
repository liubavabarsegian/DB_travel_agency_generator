select country_id, (select name from countries where id = country_id), count(*) from trips
group by country_id
order by count(*) DESC
LIMIT 10;