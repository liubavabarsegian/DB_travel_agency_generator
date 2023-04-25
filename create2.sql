DROP TABLE IF EXISTS "orders" CASCADE;
DROP TABLE IF EXISTS "route" CASCADE;
DROP TABLE IF EXISTS "trips" CASCADE;
DROP TABLE IF EXISTS "flights" CASCADE;
DROP TABLE IF EXISTS "aircompanies" CASCADE;
DROP TABLE IF EXISTS "airports" CASCADE;
DROP TABLE IF EXISTS "hotels" CASCADE;
DROP TABLE IF EXISTS "cities" CASCADE;
DROP TABLE IF EXISTS "countries" CASCADE;
DROP TABLE IF EXISTS "continents" CASCADE;
DROP TABLE IF EXISTS "tourists" CASCADE;
DROP TABLE IF EXISTS "clients" CASCADE;
DROP TABLE IF EXISTS "routes" CASCADE;
DROP TABLE IF EXISTS "workers" CASCADE;


CREATE TABLE "aircompanies" (
	id SERIAL PRIMARY KEY,
	aircompany_name varchar(255) default NULL,
    phone varchar(255) default NULL,
    office_address varchar(255) default NULL
);

CREATE TABLE "continents" (
    id SERIAL PRIMARY KEY,
    name varchar(50)
);

CREATE TABLE "countries" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    continent_id integer NULL,
    FOREIGN KEY (continent_id) REFERENCES continents (id) ON DELETE CASCADE
);

CREATE TABLE "cities" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    country_id integer NULL,
	FOREIGN KEY (country_id) REFERENCES countries (id) ON DELETE CASCADE
);

CREATE TABLE "airports" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    city_id integer NULL,
	FOREIGN KEY (city_id) REFERENCES cities (id)  ON DELETE CASCADE
);

CREATE TABLE "clients" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    phone varchar(255) default NULL,
    bonus_points integer,
    has_client_card boolean ---for 10% discount
);

CREATE TABLE "tourists" (
    id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    phone varchar(255) default NULL,
    birthday_date date default NULL,
    passport varchar(255) UNIQUE,
    foreign_passport varchar(255) UNIQUE,
    has_visa boolean
);

CREATE TABLE "workers" (
	id SERIAL PRIMARY KEY,
	full_name varchar(255) default NULL,
    phone varchar(255) default NULL,
    passport varchar(255) UNIQUE,
    birthday_date date default NULL,
    salary integer default 0,
    work_position varchar(255)
);

CREATE TABLE "hotels" (
	id SERIAL PRIMARY KEY,
	hotel_name varchar(255),
    has_pool boolean default false,
    number_of_stars integer,
    cleaning_included boolean default false,
    price_for_a_person integer,
    city_id integer NULL,
    hotel_address varchar(255),
    phone varchar(255),
    web_site varchar(255),
    discount_percent_for_children integer,
    has_spa boolean,
    has_own_beach boolean,
    wifi_price_for_a_day integer default 0,
    has_aquapark boolean,
    coefficient_for_seasons real,
    FOREIGN KEY (city_id) REFERENCES cities (id)  ON DELETE CASCADE
);

CREATE TABLE "flights" (
	id SERIAL PRIMARY KEY,
	departure_time timestamp,
    price integer,
    meal_included boolean default false,
    flight_duration integer,
    departure_airport_id integer NULL,
    FOREIGN KEY (departure_airport_id) REFERENCES airports (id)  ON DELETE CASCADE,
    arrival_airport_id integer NULL,
    FOREIGN KEY (arrival_airport_id) REFERENCES airports (id) ON DELETE CASCADE,
    aircompany_id integer NULL,
    FOREIGN KEY (aircompany_id) REFERENCES aircompanies (id)  ON DELETE CASCADE
);

CREATE TABLE "trips" (
	id SERIAL PRIMARY KEY,
    country_id integer NULL,
    FOREIGN KEY (country_id) REFERENCES countries (id)  ON DELETE CASCADE,
    trip_type varchar(255),
    number_of_nights integer,
    excursions_included boolean,
    trip_price integer,
    meal varchar(255),
    coefficient_for_seasons real,
    hotel_id integer NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels (id)  ON DELETE CASCADE
);

CREATE TABLE "routes" (
    where_from integer NULL,
    FOREIGN KEY (where_from) REFERENCES countries (id)  ON DELETE CASCADE,
    where_to integer NULL,
    FOREIGN KEY (where_to) REFERENCES countries (id)  ON DELETE CASCADE,
    departure_date date,
    arrival_date date,
    trip_id integer NULL,
    departure_flight_id integer NULL,
    FOREIGN KEY (departure_flight_id) REFERENCES flights (id)  ON DELETE CASCADE,
    arrival_flight_id integer NULL,
    FOREIGN KEY (arrival_flight_id) REFERENCES flights (id)  ON DELETE CASCADE
);

-- CREATE TABLE "orders" (
--     id SERIAL PRIMARY KEY,
--     number_of_people integer default 1,
--     order_time timestamp,
--     total_price integer,
--     client_id integer NULL,
--     FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE,
--     worker_id integer NULL,
--     FOREIGN KEY (worker_id) REFERENCES workers (id) ON DELETE CASCADE,
--     trip_id integer NULL,
--     FOREIGN KEY (trip_id) REFERENCES trips (id) ON DELETE CASCADE
-- )
