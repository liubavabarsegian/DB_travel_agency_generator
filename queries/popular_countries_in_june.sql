select country_id, (select name from countries where id = country_id), count(*) from trips
where date_part('month', departure_date) = 6
group by country_id
order by count(*) DESC
LIMIT 10;