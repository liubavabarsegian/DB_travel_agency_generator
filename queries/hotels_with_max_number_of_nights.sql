select * from hotels
where hotels.id IN 
    (select hotel_id from trips 
        where number_of_nights = (select max(number_of_nights) from trips));
