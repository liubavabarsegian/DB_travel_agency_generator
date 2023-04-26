require 'faker'

def insert_into_all_tables
    File.open('better_data.sql', 'w') do |file|
        insert_into_aircompanies(file)
        insert_into_airports(file)
        insert_into_hotels(file)
        insert_into_clients(file)
        insert_into_tourists(file)
        insert_into_workers(file)
        insert_into_trips(file)
        insert_into_flights(file)
        insert_into_routes(file)
        # insert_into_payments_and_orders(file)
    end
end

def insert_into_aircompanies(file)
    file.puts("INSERT INTO aircompanies (aircompany_name, phone, office_address) VALUES")
    (0...100).each do 
        name = Faker::Company.name
        phone = Faker::PhoneNumber.cell_phone_with_country_code
        office_address = Faker::Address.full_address
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}\', \'#{office_address.tr("'", "")}\' ),")
    end
    name = Faker::Company.name
    phone = Faker::PhoneNumber.cell_phone_with_country_code
    office_address = Faker::Address.full_address
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}\', \'#{office_address.tr("'", "")}\' );")
end

def insert_into_airports(file)
    file.puts("INSERT INTO airports (name, city_id) VALUES")
    (0...100).each do 
        name = Faker::Travel::Airport.name(size: "large", region: "united_states")
        file.puts("\t(\'#{name.tr("'", "")}\', (SELECT id FROM cities ORDER BY random() LIMIT 1)),")
    end
    name = Faker::Travel::Airport.name(size: "large", region: "united_states")
    file.puts("\t(\'#{name.tr("'", "")}\', (SELECT id FROM cities ORDER BY random() LIMIT 1));")
end

def insert_into_hotels(file)
    file.puts("INSERT INTO hotels (hotel_name, has_pool, number_of_stars, cleaning_included, price_for_a_person, city_id,
            hotel_address, phone, web_site, discount_percent_for_children, has_spa, has_own_beach, wifi_price_for_a_day, 
            has_aquapark, coefficient_for_seasons) VALUES")
    (0...100).each do 
        name = Faker::Name.name_with_middle
        has_pool = [true, false].sample
        number_of_stars = [1, 2, 3, 4, 5].sample
        cleaning_included = [true, false].sample
        price = Faker::Number.positive.round * number_of_stars / 100
        address = Faker::Address.street_address
        phone = Faker::PhoneNumber.cell_phone_with_country_code
        web_site = Faker::Internet.url 
        discount_for_children = Faker::Number.between(from: 10,to: 40)
        has_spa = [true, false].sample
        has_own_beach = [true, false].sample
        wifi = Faker::Number.between(from: 10,to: 100)
        aquapark = [true, false].sample
        coef = Faker::Number.between(from: 1.0, to: 3.0)
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{has_pool}\', #{number_of_stars}, \'#{cleaning_included}\', #{price}, 
        (SELECT id FROM cities ORDER BY random() LIMIT 1),
        \'#{address.tr("'", "")}\',\'#{phone}\', \'#{web_site}\', #{discount_for_children}, \'#{has_spa}\', \'#{has_own_beach}\',
        #{wifi}, \'#{aquapark}\', #{coef}),")
    end
    name = Faker::Name.name_with_middle
    has_pool = [true, false].sample
    number_of_stars = [1, 2, 3, 4, 5].sample
    cleaning_included = [true, false].sample
    price = Faker::Number.positive.round * number_of_stars / 100
    address = Faker::Address.street_address
    phone = Faker::PhoneNumber.cell_phone_with_country_code
    web_site = Faker::Internet.url 
    discount_for_children = Faker::Number.between(from: 10,to: 40)
    has_spa = [true, false].sample
    has_own_beach = [true, false].sample
    wifi = Faker::Number.between(from: 10,to: 100)
    aquapark = [true, false].sample
    coef = Faker::Number.between(from: 1.0, to: 3.0)
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{has_pool}\', #{number_of_stars}, \'#{cleaning_included}\', #{price}, 
    (SELECT id FROM cities ORDER BY random() LIMIT 1),
    \'#{address.tr("'", "")}\',\'#{phone}\', \'#{web_site}\', #{discount_for_children}, \'#{has_spa}\', \'#{has_own_beach}\',
    #{wifi}, \'#{aquapark}\', #{coef});")
end

def insert_into_clients(file)
    file.puts("INSERT INTO clients (name, phone, has_client_card, bonus_points ) VALUES")
    (0...100).each do 
        name = Faker::Name.first_name_neutral
        phone = Faker::PhoneNumber.phone_number_with_country_code
        has_member_card = [true, false].sample
        bonus_points = 100
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{has_member_card}\', #{bonus_points}),")
    end
    name = Faker::Name.first_name_neutral
    phone = Faker::PhoneNumber.phone_number_with_country_code
    has_member_card = [true, false].sample
    bonus_points = 100
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{has_member_card}\', #{bonus_points});")
end

def insert_into_tourists(file)
    file.puts("INSERT INTO tourists (name, phone, birthday_date, passport, foreign_passport, has_visa) VALUES")
    (0...100).each do 
        name = Faker::Name.first_name_neutral
        phone = Faker::PhoneNumber.phone_number_with_country_code
        bday = Faker::Date.birthday
        passport = Faker::IDNumber.danish_id_number
        f_passport = Faker::IDNumber.danish_id_number
        visa = [true, false].sample
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{bday}'\, \'#{passport}\',
        \'#{f_passport}\', \'#{visa}\'),")
    end
    name = Faker::Name.first_name_neutral
    phone = Faker::PhoneNumber.phone_number_with_country_code
    bday = Faker::Date.birthday
    passport = Faker::IDNumber.danish_id_number
    f_passport = Faker::IDNumber.danish_id_number
    visa = [true, false].sample
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{bday}'\, \'#{passport}\',
    \'#{f_passport}\', \'#{visa}\');")
end

def insert_into_workers(file)
    file.puts("INSERT INTO workers (full_name, phone, passport, birthday_date, salary) VALUES")
    (0...100).each do 
        name = Faker::Name.name_with_middle
        phone = Faker::PhoneNumber.phone_number_with_country_code
        passport = Faker::IDNumber.danish_id_number
        bday = Faker::Date.birthday
        salary = Faker::Number.positive.round
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{passport}\', \'#{bday}'\, #{salary}),")
    end
    name = Faker::Name.name_with_middle
    phone = Faker::PhoneNumber.phone_number_with_country_code
    passport = Faker::IDNumber.danish_id_number
    bday = Faker::Date.birthday
    salary = Faker::Number.positive.round
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{passport}\', \'#{bday}'\, #{salary});")
end


def insert_into_trips(file)
    file.puts("INSERT INTO trips (country_id, trip_type, number_of_nights, excursions_included, 
        coefficient_for_seasons, meal) VALUES")
    (0...100).each do 
        trip_type = ["Оздоровительный", "Культурный", "Индивидуальный", "Гастрономический", "Пляжный"].sample
        meal = ["Room Only", "Bed and Breakfast", "Half Board", "Half Board plus", "Full Board", "Full Board plus", "All inclusive", "Ultra All Inclusive"].sample
        number_of_nights = Faker::Number.between(from: 3,to: 14)
        excursions_included = [true, false].sample
        coef = Faker::Number.between(from: 1.0, to: 3.0)
        file.puts("\t((SELECT id FROM countries ORDER BY random() LIMIT 1), 
            \'#{trip_type}\', #{number_of_nights}, \'#{excursions_included}\', #{coef}, \'#{meal}'\ ),")
    end
    trip_type = ["Оздоровительный", "Культурный", "Индивидуальный", "Гастрономический", "Пляжный"].sample
        meal = ["Room Only", "Bed and Breakfast", "Half Board", "Half Board plus", "Full Board", "Full Board plus", "All inclusive", "Ultra All Inclusive"].sample
        number_of_nights = Faker::Number.between(from: 3,to: 14)
        excursions_included = [true, false].sample
        coef = Faker::Number.between(from: 1.0, to: 3.0)
        file.puts("\t((SELECT id FROM countries ORDER BY random() LIMIT 1), 
            \'#{trip_type}\', #{number_of_nights}, \'#{excursions_included}\', #{coef}, \'#{meal}'\ );")
    

    price = Faker::Number.between(from: 50, to: 300) #плата за тур без учета гостишки
    file.puts("UPDATE trips SET hotel_id = (SELECT id from hotels WHERE trips.country_id = (SELECT id FROM countries WHERE countries.id = country_id) ORDER BY RANDOM() LIMIT 1);")
    file.puts("UPDATE trips SET trip_price = 
            ((SELECT price_for_a_person from hotels where hotels.id = hotel_id) +
            #{price}) * number_of_nights * (SELECT number_of_stars from hotels where hotels.id = hotel_id);")
end

def insert_into_flights(file)
    file.puts("INSERT INTO flights (price, meal_included, flight_duration,  departure_time, aircompany_id,  departure_airport_id, arrival_airport_id) VALUES")
    (0...500).each do 
        price = Faker::Number.positive.round
        meal_included = [true, false].sample
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{price}\', \'#{meal_included}\', \'#{flight_duration}\', \'#{Faker::Time.forward(days: 30)}\', (SELECT id FROM aircompanies ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports ORDER BY random() LIMIT 1)),")
    end
    price = Faker::Number.positive.round
    meal_included = [true, false].sample
    flight_duration = Faker::Number.between(from: 1, to: 20)
    file.puts("\t(\'#{price}\', \'#{meal_included}\', \'#{flight_duration}\', \'#{Faker::Time.forward(days: 30)}\', (SELECT id FROM aircompanies ORDER BY random() LIMIT 1), 
        (SELECT id FROM airports ORDER BY random() LIMIT 1), 
        (SELECT id FROM airports ORDER BY random() LIMIT 1));")
    end

def insert_into_routes(file)
    trip_id = Faker::Number.between(from: 1, to: 500)
    file.puts("INSERT INTO routes (where_from, where_to trip_id) VALUES")
    (0...100).each do 
        file.puts("\t((SELECT id from cities where cities.country_id = 32 order by random() limit 1), 
        SELECT ),")
    end
    file.puts("\t((SELECT id from cities order by random() limit 1),
    (SELECT id FROM trips ORDER BY RANDOM() LIMIT 1));")

    file.puts("UPDATE routes SET where_to = (SELECT id from cities WHERE cities.id != routes.where_from ORDER BY RANDOM() LIMIT 1);")
    file.puts("UPDATE routes SET departure_flight_id = 
        (SELECT id FROM flights where flights.departure_time != (SELECT max(departure_time) from flights) ORDER BY random() LIMIT 1);")
    
        file.puts("UPDATE routes SET arrival_flight_id = 
            (select id from flights 
            where floor(extract(epoch FROM 
                (flights.departure_time - (select departure_date from trips where routes.trip_id = trips.id  ORDER BY RANDOM() LIMIT 1))/86400)) = 5 ORDER BY RANDOM() LIMIT 1)
		

        (SELECT id from flights where 
		(select floor(extract(epoch FROM (select ((select departure_time from flights where flights.id = routes.departure_flight_id) - flights.departure_time) from flights where flights.id = routes.departure_flight_id)/86400)))
        = (select number_of_nights from trips where trips.id = routes.trip_id));");
    file.puts ("UPDATE routes SET departure_date = (SELECT departure_time from flights where flights.id = routes.departure_flight_id);")
    file.puts ("UPDATE routes SET arrival_date = (SELECT departure_time from flights where flights.id = routes.arrival_flight_id );")
    file.puts("UPDATE routes SET price = 
        ((SELECT trip_price from trips where trips.id = routes.trip_id) +
        (SELECT price from flights where flights.id = departure_flight_id) +
        (SELECT price from flights where flights.id = arrival_flight_id));")
end


# def insert_into_payments_and_orders(file)
#     (0...100).each do 
#         file.puts("INSERT INTO payments (number_of_people, route_id, client_id, worker_id) VALUES")
#         number = rand(1...10)
#         file.puts("\t(#{number}, (SELECT id FROM routes ORDER BY random() LIMIT 1), (SELECT id FROM clients ORDER BY random() LIMIT 1), (SELECT id FROM workers ORDER BY random() LIMIT 1));")
#         (0...number).each do
#             file.puts("INSERT INTO orders (tourist_id, payment_id) VALUES")
#             file.puts("\t((SELECT id FROM tourists ORDER BY random() LIMIT 1), (SELECT id FROM payments ORDER BY random() LIMIT 1));")
#         end
#     end

#     file.puts("UPDATE payments SET total_price = number_of_people *
#         (select price from routes where routes.id = payments.route_id)")
# end

insert_into_all_tables