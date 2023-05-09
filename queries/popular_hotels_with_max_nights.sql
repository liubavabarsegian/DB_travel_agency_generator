select trips.hotel_id, trips.number_of_nights, (select hotel_name from hotels where id = hotel_id), count(*) from trips
where number_of_nights = (select max(number_of_nights) from trips)
group by hotel_id, number_of_nights
order by count(*) DESC
LIMIT 10;
