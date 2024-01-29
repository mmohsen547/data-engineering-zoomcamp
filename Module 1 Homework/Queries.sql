-- Question 3. How many taxi trips were totally made on September 18th 2019?

select count(*) 
from green_tripdata
where tpep_pickup_datetime >= '2019-09-18 00:00:00' and tpep_dropoff_datetime <= '2019-09-18 23:59:59';
select tpep_pickup_datetime
from green_tripdata
order by trip_distance desc
limit 1;

-- Question 4. Which was the pick up day with the longest trip distance?

select tpep_pickup_datetime
from green_tripdata
order by trip_distance desc
limit 1;

-- Question 5. Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?

select z."Borough", sum(d."total_amount")
from zones as z 
join green_tripdata as d
on z."LocationID" = d."PULocationID"
WHERE d."tpep_pickup_datetime" >= '2019-09-18 00:00:00' AND d."tpep_pickup_datetime" <= '2019-09-18 23:59:59'
GROUP BY z."Borough"
having sum(d."total_amount") > 50000
ORDER BY sum(d."total_amount") desc 

-- Question 6. For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip

SELECT drop_off."Zone"
FROM green_tripdata as d
JOIN Zones as drop_off
on drop_off."LocationID" = d."DOLocationID"
JOIN Zones as pick_up
on pick_up."LocationID" = d."PULocationID"
WHERE d."tpep_pickup_datetime" >= '2019-09-01' AND d."tpep_pickup_datetime" < '2019-10-01'
AND pick_up."Zone" = 'Astoria'
order by d."tip_amount" desc
limit 1