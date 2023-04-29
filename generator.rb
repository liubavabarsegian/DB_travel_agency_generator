require 'faker'

def insert_into_all_tables
    Faker::Config.locale = :ru
    File.open('better_data.sql', 'w') do |file|
        # insert_into_people(file)
        # insert_into_clients(file)
        # insert_into_tourists(file)
        # insert_into_workers(file)
        # insert_into_aircompanies(file)
        # insert_into_airports(file)
        # insert_into_hotels(file)
        # insert_into_flights(file)
        insert_into_trips(file)
    end
end

def insert_into_people(file)
    file.puts("INSERT INTO people (full_name, email, birthday_date, phone) VALUES")
    (0...200).each do 
        name = Faker::Name.name_with_middle
        phone = Faker::PhoneNumber.phone_number_with_country_code
        bday = Faker::Date.birthday(min_age: 3, max_age: 60)
        email = Faker::Internet.email
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{email}\', \'#{bday}\', \'#{phone}\'),")
    end 
    name = Faker::Name.name_with_middle
    phone = Faker::PhoneNumber.phone_number_with_country_code
    bday = Faker::Date.birthday(min_age: 3, max_age: 60)
    email = Faker::Internet.email
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{email}\', \'#{bday}\', \'#{phone}\');")
end

def insert_into_clients(file)
    (0...150).each do 
        file.puts("INSERT INTO clients (person_id, has_client_card, bonus_points) VALUES")
        has_member_card = [true, false].sample
        bonus_points = 100
        file.puts("\t((select id from people 
                    WHERE date_part('year',age(birthday_date)) >= 18
                    AND id NOT IN (select id from clients)
                    ORDER BY RANDOM() limit 1), \'#{has_member_card}\', #{bonus_points});")
    end
end

def insert_into_tourists(file)
    (0...200).each do 
        file.puts("INSERT INTO tourists (person_id, passport, foreign_passport, has_visa) VALUES")
        passport = Faker::IDNumber.danish_id_number
        f_passport = Faker::IDNumber.danish_id_number
        has_visa = [true, false].sample
        file.puts("\t((select id from people 
            WHERE date_part('year',age(birthday_date)) >= 18
            AND id NOT IN (select id from tourists)
            ORDER BY RANDOM() limit 1), \'#{passport}\', \'#{f_passport}\', #{has_visa});")
    end
end

def insert_into_workers(file)
    (0...150).each do 
        file.puts("INSERT INTO workers (person_id, passport, salary) VALUES")
        passport = Faker::IDNumber.danish_id_number
        salary = Faker::Number.between(from: 10000, to:300000)
        file.puts("\t((select id from people 
            WHERE date_part('year',age(birthday_date)) >= 18
            AND id NOT IN (select id from workers)
            ORDER BY RANDOM() limit 1),  \'#{passport}\', #{salary});")
    end
end

def insert_into_aircompanies(file)
    file.puts("INSERT INTO aircompanies (aircompany_name, phone, office_address, discount_persent_for_children, luggage_price, meal_price) VALUES")
    (0...100).each do 
        name = Faker::Company.name
        phone = Faker::PhoneNumber.cell_phone_with_country_code
        office_address = Faker::Address.full_address
        discount_for_children = Faker::Number.between(from: 5, to: 25)
        luggage = Faker::Number.between(from: 1000, to: 5000)
        meal = Faker::Number.between(from: 1000, to: 5000)
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}\', \'#{office_address.tr("'", "")}\', #{discount_for_children}, #{luggage}, #{meal} ),")
    end
    name = Faker::Company.name
    phone = Faker::PhoneNumber.cell_phone_with_country_code
    office_address = Faker::Address.full_address
    discount_for_children = Faker::Number.between(from: 5, to: 25)
    luggage = Faker::Number.between(from: 1000, to: 5000)
    meal = Faker::Number.between(from: 1000, to: 5000)
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}\', \'#{office_address.tr("'", "")}\', #{discount_for_children}, #{luggage}, #{meal}  );")
end


def insert_into_airports(file)
    file.puts("INSERT INTO airports (name, city_id) VALUES")
    (0...150).each do 
        name = Faker::Travel::Airport.name(size: "large", region: "united_states")
        file.puts("\t(\'#{name.tr("'", "")}\', (SELECT id FROM cities ORDER BY random() LIMIT 1)),")
    end
    name = Faker::Travel::Airport.name(size: "large", region: "united_states")
    file.puts("\t(\'#{name.tr("'", "")}\', (SELECT id FROM cities ORDER BY random() LIMIT 1));")
end

def insert_into_hotels(file)
    Faker::Config.locale = :en
    file.puts("INSERT INTO hotels (hotel_name, number_of_pools,has_pool_for_children, number_of_stars, cleaning_included, price_for_a_person, city_id,
            hotel_address, phone, web_site, discount_percent_for_children, has_spa, has_own_beach, wifi_price_for_a_day, 
            has_aquapark, coefficient_for_seasons, number_of_bars, number_of_restaurants) VALUES")
    (0...500).each do 
        name = Faker::Name.name
        n_of_pools = Faker::Number.between(from: 0,to: 10)
        has_pool = [true, false].sample
        has_pool = false if (n_of_pools == 0)
        number_of_stars = [1, 2, 3, 4, 5].sample
        cleaning_included = [true, false].sample
        price = Faker::Number.positive.round * number_of_stars / 100
        address = Faker::Address.street_address
        phone = Faker::PhoneNumber.cell_phone
        web_site = Faker::Internet.url 
        discount_for_children = Faker::Number.between(from: 10,to: 40)
        has_spa = [true, false].sample
        has_own_beach = [true, false].sample
        wifi = Faker::Number.between(from: 10,to: 100)
        aquapark = [true, false].sample
        coef = Faker::Number.between(from: 1.0, to: 3.0)
        bars = Faker::Number.between(from: 0,to: 10)
        restaurants = Faker::Number.between(from: 0,to: 10)
        file.puts("\t(\'#{name.tr("'", "")}\', #{n_of_pools}, \'#{has_pool}\', #{number_of_stars}, \'#{cleaning_included}\', #{price}, 
        (SELECT id FROM cities ORDER BY random() LIMIT 1),
        \'#{address.tr("'", "")}\',\'#{phone}\', \'#{web_site}\', #{discount_for_children}, \'#{has_spa}\', \'#{has_own_beach}\',
        #{wifi}, \'#{aquapark}\', #{coef}, #{bars}, #{restaurants}),")
    end
    name = Faker::Name.name
    n_of_pools = Faker::Number.between(from: 0,to: 10)
    has_pool = [true, false].sample
    has_pool = false if (n_of_pools == 0)
    number_of_stars = [1, 2, 3, 4, 5].sample
    cleaning_included = [true, false].sample
    price = Faker::Number.between(from: 2000, to: 30000) * number_of_stars / 2
    address = Faker::Address.street_address
    phone = Faker::PhoneNumber.cell_phone
    web_site = Faker::Internet.url 
    discount_for_children = Faker::Number.between(from: 10,to: 40)
    has_spa = [true, false].sample
    has_own_beach = [true, false].sample
    wifi = Faker::Number.between(from: 100,to: 500)
    aquapark = [true, false].sample
    coef = Faker::Number.between(from: 1.0, to: 3.0)
    bars = Faker::Number.between(from: 0,to: 10)
    restaurants = Faker::Number.between(from: 0,to: 10)
    file.puts("\t(\'#{name.tr("'", "")}\', #{n_of_pools}, \'#{has_pool}\', #{number_of_stars}, \'#{cleaning_included}\', #{price}, 
    (SELECT id FROM cities ORDER BY random() LIMIT 1),
    \'#{address.tr("'", "")}\',\'#{phone}\', \'#{web_site}\', #{discount_for_children}, \'#{has_spa}\', \'#{has_own_beach}\',
    #{wifi}, \'#{aquapark}\', #{coef}, #{bars}, #{restaurants});")
end

def insert_into_flights(file)
    #fligths from Russia to other countires (any)
    (0...100).each do 
        file.puts("INSERT INTO flights 
            (flight_number, departure_time, price, 
            flight_duration, departure_airport_id, arrival_airport_id, aircompany_id) VALUES")
        flight_number = Faker::Alphanumeric.alphanumeric(number:4, min_numeric:3, min_alpha: 1)
        departure_time = Faker::Time.forward(days: 30)
        price = Faker::Number.between(from: 10000, to:80000)
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{flight_number}\', \'#{departure_time}\', \'#{price}\', \'#{flight_duration}\', 
            (SELECT id FROM airports WHERE city_id IN (select id from cities where country_id = 32) ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports WHERE city_id NOT IN (select id from cities where country_id = 32) ORDER BY random() LIMIT 1),
            (SELECT id FROM aircompanies ORDER BY random() LIMIT 1));")
    end

    #from Moscow to popular countries
    # Турция 39, Тунис 38, Таиланд 36 , ОАЭ 30 Мальдивы 27 
    #Куба 24 Кипр 22 Испания 18, Египет 13, Грузия 11,Абхазия 1
    (0...500).each do 
        file.puts("INSERT INTO flights 
            (flight_number, departure_time, price, 
            flight_duration, departure_airport_id, arrival_airport_id, aircompany_id) VALUES")
        flight_number = Faker::Alphanumeric.alphanumeric(number:4, min_numeric:3, min_alpha: 1)
        departure_time = Faker::Time.forward(days: 30)
        price = Faker::Number.between(from: 10000, to:80000)
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{flight_number}\', \'#{departure_time}\', \'#{price}\', \'#{flight_duration}\', 
            (SELECT id FROM airports WHERE city_id IN (select id from cities where country_id = 32) ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports WHERE city_id NOT IN (select id from cities where country_id = 32)
                AND city_id IN 
                (select id from cities where country_id IN (39, 38, 36, 30, 27, 24, 22, 18, 13, 11, 1)) ORDER BY random() LIMIT 1), 
            (SELECT id FROM aircompanies ORDER BY random() LIMIT 1));")
    end

    #fligths to Russia from other countires (any)
    (0...100).each do 
        file.puts("INSERT INTO flights 
            (flight_number, departure_time, price, 
            flight_duration, departure_airport_id, arrival_airport_id, aircompany_id) VALUES")
        flight_number = Faker::Alphanumeric.alphanumeric(number:4, min_numeric:3, min_alpha: 1)
        departure_time = Faker::Time.forward(days: 70)
        price = Faker::Number.between(from: 10000, to:80000)
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{flight_number}\', \'#{departure_time}\', \'#{price}\', \'#{flight_duration}\', 
            (SELECT id FROM airports WHERE city_id NOT IN (select id from cities where country_id = 32) ORDER BY random() LIMIT 1),
            (SELECT id FROM airports WHERE city_id IN (select id from cities where country_id = 32) ORDER BY random() LIMIT 1), 
            (SELECT id FROM aircompanies ORDER BY random() LIMIT 1));")
    end

    #to Russia from popular countries
    # Турция 39, Тунис 38, Таиланд 36 , ОАЭ 30 Мальдивы 27 
    #Куба 24 Кипр 22 Испания 18, Египет 13, Грузия 11,Абхазия 1
    (0...500).each do 
        file.puts("INSERT INTO flights 
            (flight_number, departure_time, price, 
            flight_duration, departure_airport_id, arrival_airport_id, aircompany_id) VALUES")
        flight_number = Faker::Alphanumeric.alphanumeric(number:4, min_numeric:3, min_alpha: 1)
        departure_time = Faker::Time.backward(days: 70)
        price = Faker::Number.between(from: 10000, to:80000)
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{flight_number}\', \'#{departure_time}\', \'#{price}\', \'#{flight_duration}\', 
            (SELECT id FROM airports WHERE city_id NOT IN (select id from cities where country_id = 32) 
                AND city_id IN 
                (select id from cities where country_id IN (39, 38, 36, 30, 27, 24, 22, 18, 13, 11, 1) ORDER BY random() LIMIT 1) ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports WHERE city_id IN (select id from cities where country_id = 32 ORDER BY random() limit 1) ORDER BY random() LIMIT 1), 
            (SELECT id FROM aircompanies ORDER BY random() LIMIT 1));")
    end
    file.puts("UPDATE flights SET
        country_from = (select id from countries where countries.id = (select country_id from cities where cities.id = (select city_id from airports where airports.id = departure_airport_id))),
        country_where_to = (select id from countries where countries.id = (select country_id from cities where cities.id = (select city_id from airports where airports.id = arrival_airport_id)));")
end


def insert_into_trips(file)
    (0...100).each do
        file.puts("INSERT INTO trips (client_id, worker_id, tourist_id, 
            country_id, meal_for_flight, has_luggage) VALUES")
        file.puts("\t((SELECT id FROM clients ORDER BY random() LIMIT 1), 
        (SELECT id FROM workers ORDER BY random() LIMIT 1),
        (SELECT id FROM tourists ORDER BY random() LIMIT 1),
        (SELECT id FROM countries where id != 32 ORDER BY random() LIMIT 1),
        \'#{[true, false].sample}\', \'#{[true, false].sample}\');")
    end

    file.puts("UPDATE trips SET hotel_id = 
        (SELECT id from hotels where hotels.city_id IN  (select id from cities 
            WHERE cities.country_id = trips.country_id) order by random() limit 1),
        departure_flight_id = 
        (select id from flights where arrival_airport_id IN 
            (select id from airports where city_id IN 
                (select city_id from countries where countries.id = trips.country_id)) order by random() limit 1);")
    file.puts("UPDATE trips SET 
        departure_date = 
            (select departure_time from flights where flights.id = trips.departure_flight_id),
        arrival_flight_id = ((select id from flights where 
                (floor(extract(epoch FROM (flights.departure_time - (select departure_time from flights where flights.id = departure_flight_id))))) > 3 
            AND departure_airport_id IN 
            (select id from airports where city_id IN 
                (select city_id from countries where countries.id = trips.country_id))) order by random() limit 1);")
    file.puts("UPDATE trips SET 
        arrival_date = 
            (select departure_time from flights where flights.id = trips.arrival_flight_id"),
    file.puts("UPDATE trips set number_of_nights = (trips.arrival_date - trips.departure_date);")

    #insurance id
    #trip price
    
end

insert_into_all_tables