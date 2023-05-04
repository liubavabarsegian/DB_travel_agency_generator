select trips.country_id, (select name from countries where id = country_id), count(*) from trips
where country_id IN 
	(select country_id from trips where number_of_nights = (select max(number_of_nights) from trips))
group by country_id
order by count(*) DESC
LIMIT 10;
