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
        insert_into_flights(file)
        # insert_into_trips(file)
        # insert_into_insurances(file)
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
    file.puts("INSERT INTO flights (flight_number, departure_time, price, flight_duration, departure_airport_id, arrival_airport_id, aircompany_id) VALUES")
    (0...500).each do 
        flight_number = 
        departure_time = 
        price = 
        flight_duration = Faker::Number.between(from: 1, to: 20)
        file.puts("\t(\'#{price}\', \'#{meal_included}\', \'#{flight_duration}\', \'#{Faker::Time.forward(days: 30)}\', (SELECT id FROM aircompanies ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports ORDER BY random() LIMIT 1), 
            (SELECT id FROM airports ORDER BY random() LIMIT 1)),")
    end
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

insert_into_all_tables