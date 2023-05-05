select To_Char(departure_date, 'Day') as dow from trips
group by dow
order by count(*);