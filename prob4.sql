-- 1) What was the hottest day in our data set? Where was that?
SELECT zip, date, maxtemperaturef as max_temp   
FROM weather 
ORDER BY max_temp DESC;

-- Noveber 17th, 2015 in Redwood city, CA (64063)


-- 2)How many trips started at each station?
SELECT COUNT(start_station) as station_counts, 
			start_station as station_name
FROM trips 
GROUP BY start_station;
-- output is station counts for each station name.


-- 3)What's the shortest trip that happened?
SELECT MIN(duration) 
FROM trips;

-- SELECT trip_id, duration
-- FROM trips
-- ORDER BY duration;

-- The shortest trip is 60 mins and numerous trips have that duration


-- 4)What is the average trip duration, by end station?
SELECT end_station, AVG(duration)
FROM trips
GROUP BY end_station;
-- output is end stations and their average durations