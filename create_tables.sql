DROP TABLE IF EXISTS "orders" CASCADE;
DROP TABLE IF EXISTS "trips" CASCADE;
DROP TABLE IF EXISTS "flights" CASCADE;
DROP TABLE IF EXISTS "aircompanies" CASCADE;
DROP TABLE IF EXISTS "airports" CASCADE;
DROP TABLE IF EXISTS "hotels" CASCADE;
DROP TABLE IF EXISTS "cities" CASCADE;
DROP TABLE IF EXISTS "countries" CASCADE;
DROP TABLE IF EXISTS "clients" CASCADE;
DROP TABLE IF EXISTS "workers" CASCADE;


CREATE TABLE "aircompanies" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL
);

CREATE TABLE "countries" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL
);

CREATE TABLE "cities" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    country_id integer NULL,
	FOREIGN KEY (country_id) REFERENCES countries (id)
);

CREATE TABLE "airports" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    city_id integer NULL,
	FOREIGN KEY (city_id) REFERENCES cities (id)
);

CREATE TABLE "clients" (
	id SERIAL PRIMARY KEY,
	full_name varchar(255) default NULL,
    phone varchar(255) default NULL,
    birthday_date date default NULL,
    has_member_card boolean default false
);

CREATE TABLE "workers" (
	id SERIAL PRIMARY KEY,
	full_name varchar(255) default NULL,
    phone varchar(255) default NULL,
    birthday_date date default NULL,
    salary integer default 0
);

CREATE TABLE "hotels" (
	id SERIAL PRIMARY KEY,
	name varchar(255) default NULL,
    has_pool boolean default false,
    number_of_stars integer,
    cleaning_included boolean default false,
    price_for_a_person integer,
    city_id integer NULL,
    FOREIGN KEY (city_id) REFERENCES cities (id)
);

CREATE TABLE "flights" (
	id SERIAL PRIMARY KEY,
	departure_time timestamp,
    price integer,
    meal_included boolean default false,
    flight_duration integer,
    departure_airport_id integer NULL,
    FOREIGN KEY (departure_airport_id) REFERENCES airports (id),
    arrival_airport_id integer NULL,
    FOREIGN KEY (arrival_airport_id) REFERENCES airports (id),
    aircompany_id integer NULL,
    FOREIGN KEY (aircompany_id) REFERENCES aircompanies (id)
);

CREATE TABLE "trips" (
	id SERIAL PRIMARY KEY,
	departure_date date,
    arrival_date date,
    meal varchar(255),
    departure_flight_id integer NULL,
    FOREIGN KEY (departure_flight_id) REFERENCES flights (id),
    arrival_flight_id integer NULL,
    FOREIGN KEY (arrival_flight_id) REFERENCES flights (id),
    hotel_id integer NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels (id)
);

CREATE TABLE "orders" (
    id SERIAL PRIMARY KEY,
    number_of_people integer default 1,
    order_time timestamp,
    total_price integer,
    client_id integer NULL,
    FOREIGN KEY (client_id) REFERENCES clients (id),
    worker_id integer NULL,
    FOREIGN KEY (worker_id) REFERENCES clients (id),
    trip_id integer NULL,
    FOREIGN KEY (trip_id) REFERENCES clients (id)
)