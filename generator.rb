require 'faker'

def insert_into_all_tables
    File.open('generator_100.sql', 'w') do |file|
        insert_into_aircompanies(file)
        insert_into_countries(file)
        insert_into_cities(file)
        insert_into_airports(file)
        insert_into_hotels(file)
        insert_into_clients(file)
        insert_into_flights(file)
        insert_into_trips(file)
        insert_into_workers(file)
    end
    File.open('generator_10mln.sql', 'w') do |file|
        insert_into_orders(file)
    end
end

def insert_into_aircompanies(file)
    file.puts("INSERT INTO aircompanies (name) VALUES")
    (0...100).each do 
        name = Faker::Company.name
        file.puts("\t(\'#{name.tr("'", "")}\'),")
    end
    name = Faker::Company.name
    file.puts("\t(\'#{name.tr("'", "")}\');")
end

def insert_into_countries(file)
    file.puts("INSERT INTO countries (name) VALUES")
    (0...100).each do 
        name = Faker::Address.country
        file.puts("\t(\'#{name.tr("'", "")}\'),")
    end
    name = Faker::Company.name
    file.puts("\t(\'#{name.tr("'", "")}\');")
end

def insert_into_cities(file)
    file.puts("INSERT INTO cities (name, country_id) VALUES")
    (0...100).each do 
        name = Faker::Address.city
        file.puts("\t(\'#{name.tr("'", "")}\', (SELECT id FROM countries ORDER BY random() LIMIT 1)),")
    end
    name = Faker::Company.name
    file.puts("\t(\'#{name.tr("'", "")}\', (SELECT id FROM countries ORDER BY random() LIMIT 1));")
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
    file.puts("INSERT INTO hotels (name, has_pool, number_of_stars, cleaning_included, price_for_a_person, city_id) VALUES")
    (0...100).each do 
        name = Faker::Name.name_with_middle
        has_pool = [true, false].sample
        number_of_stars = [1, 2, 3, 4, 5].sample
        cleaning_included = [true, false].sample
        price = Faker::Number.positive.round * number_of_stars / 100
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{has_pool}\', #{number_of_stars}, \'#{cleaning_included}\', #{price}, (SELECT id FROM cities ORDER BY random() LIMIT 1)),")
    end
    name = Faker::Name.name_with_middle
    has_pool = [true, false].sample
    number_of_stars = [1, 2, 3, 4, 5].sample
    cleaning_included = [true, false].sample
    price = Faker::Number.positive.round * number_of_stars / 100
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{has_pool}\', #{number_of_stars}, \'#{cleaning_included}\', #{price}, (SELECT id FROM cities ORDER BY random() LIMIT 1));")
end

def insert_into_clients(file)
    file.puts("INSERT INTO clients (full_name, phone, birthday_date, has_member_card) VALUES")
    (0...100).each do 
        name = Faker::Name.name_with_middle
        phone = Faker::PhoneNumber.phone_number_with_country_code
        bday = Faker::Date.birthday
        has_member_card = [true, false].sample
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{bday}'\, \'#{has_member_card}'\),")
    end
    name = Faker::Name.name_with_middle
    phone = Faker::PhoneNumber.phone_number_with_country_code
    bday = Faker::Date.birthday
    has_member_card = [true, false].sample
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{bday}'\, \'#{has_member_card}'\);")
end

def insert_into_flights(file)
    file.puts("INSERT INTO flights (price, meal_included, flight_duration,  departure_time, aircompany_id,  departure_airport_id, arrival_airport_id) VALUES")
    (0...100).each do 
        price = Faker::Number.positive.round
        meal_included = [true, false].sample
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{price}\', \'#{meal_included}\', \'#{flight_duration}\', \'#{Faker::Time.forward(days: 7)}\', (SELECT id FROM aircompanies ORDER BY random() LIMIT 1), (SELECT id FROM airports ORDER BY random() LIMIT 1), (SELECT id FROM airports ORDER BY random() LIMIT 1)),")
    end
    price = Faker::Number.positive.round
    meal_included = [true, false].sample
    flight_duration = Faker::Number.between(from: 1, to: 20)
    file.puts("\t(\'#{price}\', \'#{meal_included}\', \'#{flight_duration}\', \'#{Faker::Time.forward(days: 7)}\', (SELECT id FROM aircompanies ORDER BY random() LIMIT 1), (SELECT id FROM airports ORDER BY random() LIMIT 1), (SELECT id FROM airports ORDER BY random() LIMIT 1));")
end

def insert_into_trips(file)
    file.puts("INSERT INTO trips (departure_flight_id, hotel_id, meal) VALUES")
    (0...100).each do 
        meal = ["Room Only", "Bed and Breakfast", "Half Board", "Half Board plus", "Full Board", "Full Board plus", "All inclusive", "Ultra All Inclusive"].sample
        file.puts("\t((SELECT id from flights where flights.departure_time != (SELECT max(departure_time) from flights) ORDER BY random() LIMIT 1), (SELECT id FROM hotels ORDER BY random() LIMIT 1),  \'#{meal}'\ ),")
    end
    meal = ["Room Only", "Bed and Breakfast", "Half Board", "Half Board plus", "Full Board", "Full Board plus", "All inclusive", "Ultra All Inclusive"].sample
    file.puts("\t((SELECT id from flights where flights.departure_time != (SELECT max(departure_time) from flights) ORDER BY random() LIMIT 1), (SELECT id FROM hotels ORDER BY random() LIMIT 1),  \'#{meal}'\ );")
    file.puts("UPDATE trips SET arrival_flight_id = (SELECT id from flights where flights.departure_time > (SELECT departure_time FROM flights where flights.id = trips.departure_flight_id) ORDER BY random() LIMIT 1),
        departure_date = (SELECT departure_time from flights where flights.id = trips.departure_flight_id );")
    file.puts("UPDATE trips SET arrival_date = (SELECT departure_time from flights where flights.id = trips.arrival_flight_id );")
end

def insert_into_workers(file)
    file.puts("INSERT INTO workers (full_name, phone, birthday_date, salary) VALUES")
    (0...100).each do 
        name = Faker::Name.name_with_middle
        phone = Faker::PhoneNumber.phone_number_with_country_code
        bday = Faker::Date.birthday
        salary = Faker::Number.positive.round
        file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{bday}'\, #{salary}),")
    end
    name = Faker::Name.name_with_middle
    phone = Faker::PhoneNumber.phone_number_with_country_code
    bday = Faker::Date.birthday
    salary = Faker::Number.positive.round
    file.puts("\t(\'#{name.tr("'", "")}\', \'#{phone}'\, \'#{bday}'\, #{salary});")
end

def insert_into_orders(file)
    file.puts("INSERT INTO orders (number_of_people, trip_id, client_id, worker_id) VALUES")
    (0...5000).each do 
        number = rand(1...10)
        file.puts("\t(#{number}, (SELECT id FROM trips ORDER BY random() LIMIT 1), (SELECT id FROM clients ORDER BY random() LIMIT 1), (SELECT id FROM workers ORDER BY random() LIMIT 1)),")
    end
    number = rand(1...10)
    file.puts("\t(#{number}, (SELECT id FROM trips ORDER BY random() LIMIT 1), (SELECT id FROM clients ORDER BY random() LIMIT 1), (SELECT id FROM workers ORDER BY random() LIMIT 1));")

    file.puts("UPDATE orders SET order_time = (SELECT departure_date FROM trips WHERE id = orders.trip_id),
    total_price = orders.number_of_people * 
    ((SELECT price FROM flights WHERE flights.id = 
        (SELECT departure_flight_id from trips where trips.id = orders.trip_id) LIMIT 1) 
    +
    (SELECT price FROM flights WHERE flights.id = 
        (SELECT arrival_flight_id from trips where trips.id = orders.trip_id)) 
    +
    ((SELECT price_for_a_person FROM hotels WHERE hotels.id = 
        (SELECT hotel_id from trips where trips.id = orders.trip_id)) * (
            SELECT (arrival_date - departure_date) FROM trips WHERE trips.id = orders.trip_id LIMIT 1
        ))
    )")
end

insert_into_all_tables