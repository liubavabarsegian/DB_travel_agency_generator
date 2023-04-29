DROP TABLE IF EXISTS "trips" CASCADE; 
DROP TABLE IF EXISTS "flights" CASCADE;
DROP TABLE IF EXISTS "people" CASCADE;
DROP TABLE IF EXISTS "aircompanies" CASCADE;
DROP TABLE IF EXISTS "airports" CASCADE;
DROP TABLE IF EXISTS "hotels" CASCADE;
DROP TABLE IF EXISTS "cities" CASCADE;
DROP TABLE IF EXISTS "countries" CASCADE;
DROP TABLE IF EXISTS "tourists" CASCADE;
DROP TABLE IF EXISTS "clients" CASCADE;
DROP TABLE IF EXISTS "workers" CASCADE;
DROP TABLE IF EXISTS "insurances" CASCADE;


CREATE TABLE "aircompanies" (
	id SERIAL PRIMARY KEY,
	aircompany_name varchar(255) default NULL,
    phone varchar(255) default NULL,
    office_address varchar(255) default NULL,
    discount_persent_for_children integer,
    luggage_price integer,
    meal_price integer
);

CREATE TABLE "countries" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL
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

CREATE TABLE "people" (
    id SERIAL PRIMARY KEY,
    full_name varchar(255),
    email varchar(255),
    birthday_date date default NULL,
    phone varchar(255)
);

CREATE TABLE "clients" (
	id SERIAL PRIMARY KEY,
	person_id integer NULL,
	FOREIGN KEY (person_id) REFERENCES people (id)  ON DELETE CASCADE,
    bonus_points integer,
    has_client_card boolean ---for 10% discount
);

CREATE TABLE "tourists" (
    id SERIAL PRIMARY KEY,
    person_id integer NULL,
	FOREIGN KEY (person_id) REFERENCES people (id)  ON DELETE CASCADE,
    passport varchar(255) UNIQUE,
    foreign_passport varchar(255) UNIQUE,
    has_visa boolean
);

CREATE TABLE "workers" (
	id SERIAL PRIMARY KEY,
	person_id integer NULL,
	FOREIGN KEY (person_id) REFERENCES people (id)  ON DELETE CASCADE,
    passport varchar(255) UNIQUE,
    salary integer default 0
);

CREATE TABLE "hotels" (
	id SERIAL PRIMARY KEY,
	hotel_name varchar(255),
    number_of_pools integer,
    has_pool_for_children boolean,
    number_of_stars integer,
    cleaning_included boolean default false,
    price_for_a_person integer,
    hotel_address varchar(255),
    phone varchar(255),
    web_site varchar(255),
    discount_percent_for_children integer,
    has_spa boolean,
    has_own_beach boolean,
    wifi_price_for_a_day integer default 0,
    has_aquapark boolean,
    coefficient_for_seasons real,
    number_of_bars integer,
    number_of_restaurants integer,
    city_id integer NULL,
    FOREIGN KEY (city_id) REFERENCES cities (id)  ON DELETE CASCADE
);

CREATE TABLE "flights" (
	id SERIAL PRIMARY KEY,
    flight_number varchar(255),
	departure_time timestamp,
    price integer,
    flight_duration integer,
    departure_airport_id integer NULL,
    FOREIGN KEY (departure_airport_id) REFERENCES airports (id)  ON DELETE CASCADE,
    arrival_airport_id integer NULL,
    FOREIGN KEY (arrival_airport_id) REFERENCES airports (id) ON DELETE CASCADE,
    aircompany_id integer NULL,
    FOREIGN KEY (aircompany_id) REFERENCES aircompanies (id)  ON DELETE CASCADE
);

CREATE TABLE "insurances" (
    id SERIAL PRIMARY KEY,
    insurance_type varchar(255),
    price_for_adult integer,
    price_for_children_and_old integer
);

CREATE TABLE "trips" (
	id SERIAL PRIMARY KEY,
    client_id integer NULL,
    FOREIGN KEY (client_id) REFERENCES clients (id)  ON DELETE CASCADE,
    worker_id integer NULL,
    FOREIGN KEY (worker_id) REFERENCES workers (id)  ON DELETE CASCADE,
    tourist_id integer NULL,
    FOREIGN KEY (tourist_id) REFERENCES tourists (id)  ON DELETE CASCADE,
    country_id integer NULL,
    FOREIGN KEY (country_id) REFERENCES countries (id)  ON DELETE CASCADE,
    number_of_nights integer,
    insurance_id integer NULL,
    FOREIGN KEY (insurance_id) REFERENCES insurances (id)  ON DELETE CASCADE,
    departure_date date,
    arrival_date date,
    trip_price integer,
    meal varchar(255),
    departure_flight_id integer NULL,
    FOREIGN KEY (departure_flight_id) REFERENCES flights (id)  ON DELETE CASCADE,
    arrival_flight_id integer NULL,
    FOREIGN KEY (arrival_flight_id) REFERENCES flights (id)  ON DELETE CASCADE,
    hotel_id integer NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels (id)  ON DELETE CASCADE,
    meal_for_flight boolean,
    has_luggage boolean
);
