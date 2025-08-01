-- Total Rentals Per Vehicle
SELECT 
  v.vehicle_id,
  v.model,
  COUNT(r.rental_id) AS total_rentals
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id
GROUP BY v.vehicle_id, v.model;

-- Vehicles Rented More Than 10 Times (HAVING)
SELECT 
  v.vehicle_id,
  v.model,
  COUNT(r.rental_id) AS rental_count
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id
GROUP BY v.vehicle_id, v.model
HAVING rental_count > 10;

-- Average Rental Cost Per Car Type
SELECT 
  v.car_type,
  AVG(p.amount) AS avg_rental_cost
FROM vehicles v
JOIN rentals r ON v.vehicle_id = r.vehicle_id
JOIN payments p ON r.payment_id = p.payment_id
GROUP BY v.car_type;

-- INNER JOIN - Rentals ↔ Vehicles
SELECT 
  r.rental_id,
  r.customer_id,
  v.vehicle_id,
  v.model,
  r.rental_date
FROM rentals r
INNER JOIN vehicles v ON r.vehicle_id = v.vehicle_id;

-- LEFT JOIN - Vehicles ↔ Payments (via Rentals)
SELECT 
  v.vehicle_id,
  v.model,
  p.payment_id,
  p.amount
FROM vehicles v
LEFT JOIN rentals r ON v.vehicle_id = r.vehicle_id
LEFT JOIN payments p ON r.payment_id = p.payment_id;

--  SELF JOIN - Cars of the Same Model and Type
SELECT 
  v1.vehicle_id AS vehicle1_id,
  v2.vehicle_id AS vehicle2_id,
  v1.model,
  v1.car_type
FROM vehicles v1
JOIN vehicles v2 
  ON v1.vehicle_id <> v2.vehicle_id 
  AND v1.model = v2.model 
  AND v1.car_type = v2.car_type;
