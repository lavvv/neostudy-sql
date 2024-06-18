-- 1
SELECT airport_name, city
FROM bookings.airports;

-- 2
SELECT DISTINCT timezone
FROM bookings.airports;

-- 3
SELECT city
FROM bookings.airports
WHERE timezone='Europe/Moscow';

-- 4 Использовать как AND так и OR в одном условии
SELECT airport_name, city, longitude, latitude, timezone
FROM bookings.airports
WHERE
	(longitude < 40	OR latitude > 60)
	AND timezone='Europe/Moscow';

-- 5
SELECT airport_name
FROM bookings.airports
WHERE city IN ('Москва', 'Саратов');

-- 6
SELECT airport_code, airport_name
FROM bookings.airports
WHERE longitude BETWEEN 10 AND 50;

-- 7
SELECT city
FROM bookings.airports
WHERE timezone LIKE 'A%';

-- 8 Использовать одновременно ASC и DESC для разных столбцов
SELECT city, latitude, timezone
FROM bookings.airports
WHERE latitude > 60
ORDER BY timezone ASC, latitude DESC;

-- 9
SELECT SUM(amount)
FROM bookings.ticket_flights
WHERE fare_conditions!='Economy'
GROUP BY fare_conditions;

-- 10
SELECT COUNT(fare_conditions)
FROM bookings.ticket_flights
WHERE amount > 100000;

-- 11
SELECT SUM(amount)
FROM bookings.ticket_flights
WHERE amount > 20000
GROUP BY fare_conditions
HAVING COUNT(amount) > 35000;

--

-- создание таблицы, не менее 4х колонок разного типа, 1 колонка первичный ключ, одна необнуляймая
CREATE TABLE bookings.pilots (
	id INT NOT NULL,
	last_name TEXT NOT NULL,
	first_name TEXT,
	middle_name TEXT,
	PRIMARY KEY (id)
);

-- удаление таблицы
DROP TABLE bookings.pilots;

-- создание индекса
CREATE UNIQUE INDEX idx_last_name
ON bookings.pilots (last_name);

-- удаление индекса (PostgreSQL)
DROP INDEX bookings.idx_last_name;

-- получение описания структуры таблицы (PostgreSQL)
SELECT
	column_name,
	data_type,
	character_maximum_length,
	is_nullable,
	column_default
FROM information_schema.columns
WHERE table_name = 'pilots';

-- очистка таблицы
TRUNCATE TABLE bookings.pilots;

-- выбрать одно из вариантов: добавление/удаление/модификация колонок
ALTER TABLE bookings.pilots ADD age INT;

-- переименование таблицы
ALTER TABLE bookings.pilots RENAME TO former_pilots;

-- вставка значений
INSERT INTO bookings.pilots (id, last_name, first_name, middle_name)
VALUES (1, 'Ivanov', 'Ivan', 'Ivanovich')

-- обновление записей
UPDATE bookings.pilots
SET last_name='Petrov', first_name='Pyotr', middle_name='Petrovich'
WHERE id=1;

-- удаление записей
DELETE FROM bookings.pilots
WHERE id=1;
