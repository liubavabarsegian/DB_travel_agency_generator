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
    birthday_date timestamp default NULL,
    phone varchar(255)
);

CREATE TABLE "clients" (
	id SERIAL PRIMARY KEY,
	person_id integer NULL UNIQUE,
	FOREIGN KEY (person_id) REFERENCES people (id)  ON DELETE CASCADE,
    bonus_points integer,
    has_client_card boolean ---for 10% discount
);

CREATE TABLE "tourists" (
    id SERIAL PRIMARY KEY,
    person_id integer NULL UNIQUE,
	FOREIGN KEY (person_id) REFERENCES people (id)  ON DELETE CASCADE,
    passport varchar(255) UNIQUE,
    foreign_passport varchar(255) UNIQUE,
    has_visa boolean
);

CREATE TABLE "workers" (
	id SERIAL PRIMARY KEY,
	person_id integer NULL UNIQUE,
	FOREIGN KEY (person_id) REFERENCES people (id)  ON DELETE CASCADE,
    passport varchar(255) UNIQUE,
    salary integer default 0
);

CREATE TABLE "hotels" (
	id SERIAL PRIMARY KEY,
	hotel_name varchar(255),
    number_of_pools integer,
    meal_type varchar(255),
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
    country_from integer NULL,
    FOREIGN KEY (country_from) REFERENCES countries (id)  ON DELETE CASCADE,
    country_where_to integer NULL,
    FOREIGN KEY (country_where_to) REFERENCES countries (id)  ON DELETE CASCADE,
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
    departure_flight_id integer NULL,
    FOREIGN KEY (departure_flight_id) REFERENCES flights (id)  ON DELETE CASCADE,
    arrival_flight_id integer NULL,
    FOREIGN KEY (arrival_flight_id) REFERENCES flights (id)  ON DELETE CASCADE,
    hotel_id integer NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels (id)  ON DELETE CASCADE,
    meal_for_flight boolean,
    has_luggage boolean
);


insert into insurances(insurance_type, price_for_adult, price_for_children_and_old) values
    ('Базовая на 1 страну', 200, 400),
    ('Базовая на все страны мира', 1000, 2000),
    ('Расширенная на 1 страну', 500, 700),
    ('Расширенная на все страны мира', 2000, 3000),
    ('Расширенная для активного отдыха', 1500, 1700),
    ('Расширенная для лечения лихорадки', 1000, 1300),
    ('Индивидуальная', 2000, 2500);   

insert into countries(name) values
    ('Абхазия'),
    ('Азербайджан'),
    ('Армения'),
    ('Бахрейн'),
    ('Беларусь'),
    ('Болгария'),
    ('Венгрия'),
    ('Венесуэла'),
    ('Вьетнам'),
    ('Греция'),
    ('Грузия'),
    ('Доминикана'),
    ('Египет'),
    ('Израиль'),
    ('Индия'),
    ('Индонезия'),
    ('Иордания'),
    ('Испания'),
    ('Италия'),
    ('Казахстан'),
    ('Ката'),
    ('Кипр'),
    ('Киргизия'),
    ('Куба'),
    ('Маврикий'),
    ('Малайзия'),
    ('Мальдивы'),
    ('Марокко'),
    ('Мексика'),
    ('ОАЭ'),
    ('Оман'),
    ('Россия'),
    ('Саудовская аравия'),
    ('Сейшелы'),
    ('Сербия'),
    ('Таиланд'),
    ('Танзания'),
    ('Тунис'),
    ('Турция'),
    ('Узбекистан'),
    ('Черногория'),
    ('Шри-Ланка');

insert into cities(name, country_id) values
    ('Сухум', 1),
    ('Баку', 2),
    ('Ереван', 3),
    ('Манама', 4),
    ('Минск', 5),
    ('София', 6),
    ('Будапешт', 7),
    ('Каракас', 8),
    ('Ханой', 9),
    ('Афины', 10),
    ('Парга', 10),
    ('Тбилиси', 11),
    ('Санто-Доминго', 12),
    ('Каир', 13),
    ('Хургада', 13),
    ('Шарм-эм-Шейх', 13),
    ('Дахаб', 13),
    ('Иерусалим', 14),
    ('Тель-Авив', 14),
    ('Хайфа', 14),
    ('Эйлат', 14),
    ('Нью-Дели', 15),
    ('Джакарта', 16 ),
    ('Амман', 17),
    ('Мадрид', 18),
    ('Валенсия',18),
    ('Рим', 19),
    ('Венеция', 19),
    ('Неаполь', 19),
    ('Флоренция', 19),
    ('Милан', 19),
    ('Астана', 20),
    ('Доха', 21),
    ('Никосия', 22),
    ('Бишкек', 23),
    ('Гавана', 24),
    ('Порт-Луи', 25),
    ('Куала-Лумпур', 26),
    ('Мале', 27),
    ('Рабат', 28),
    ('Мехико', 29),
    ('Абу-Даби', 30),
    ('Маскат', 31),
    ('Москва', 32),
    ('Эр-Рияд', 33),
    ('Виктория', 34),
    ('Белград', 35),
    ('Бангкок', 36),
    ('Паттайа', 36),
    ('Пхукет', 36),
    ('Хуахуин', 36),
    ('Чиангмай', 36),
    ('Додома', 37),
    ('Тунис', 38),
    ('Анкара', 39),
    ('Аланья', 39),
    ('Анталья', 39),
    ('Стамбул', 39),
    ('Ташкент', 40),
    ('Подгорица', 41),
    ('Шри-Джаяварденепура-Котте', 42);
    
