-- What's the most expensive listing? What else can you tell me about the listing?
SELECT id, name, 
	neighbourhood, room_type, 
	availability_365, minimum_nights, 
	calculated_host_listings_count,
	MAX(price) most_expensive
FROM listings
GROUP BY 1, 2, 3, 4, 5, 6, 7
ORDER BY most_expensive DESC
LIMIT 3;

-- the most expensive listing is $10k, it's an entire home on the Near North side, 
-- and it's available for almost a quarter of the year.

-- What neighborhoods seem to be the most popular?
SELECT neighbourhood, COUNT(neighbourhood) neighbourhood_counts
FROM listings
GROUP BY 1
ORDER BY neighbourhood_counts DESC;

-- The most popular neighborhood is West Town then Lake View closely followed by Near North Side

-- What time of year is the cheapest time to go to your city? What about the busiest?
SELECT 
	EXTRACT(month from calendar_date) as listing_month, 
	COUNT(listing_id) as number_of_listings, AVG(price::numeric)
FROM calendar
WHERE price IS NOT NULL
GROUP BY 1
ORDER BY number_of_listings DESC;

-- the cheapest time of year is winter (Dec, Jan, Feb)
-- the busiest time of year is Fall into Winter (Nov, Dec, Jan)