-- Create tables
CREATE TABLE Accidents (
    ACCIDENT_NO VARCHAR(255) PRIMARY KEY NOT NULL,
    ACCIDENT_DATE DATE NOT NULL,
    ACCIDENT_TIME TIME NOT NULL,
    ACCIDENT_TYPE INT NOT NULL,
    ACCIDENT_TYPE_DESC VARCHAR(255) NOT NULL,
    NODE_ID VARCHAR(255) NOT NULL,
    ROAD_GEOMETRY_DESC VARCHAR(255) NOT NULL
);

CREATE TABLE Accident_Details (
    ACCIDENT_NO VARCHAR(255) NOT NULL,
    ACCIDENT_LOCATION VARCHAR(225) NOT NULL,
    DCA_CODE VARCHAR(255) NOT NULL,
    DCA_DESC VARCHAR(255) NOT NULL,
    LIGHT_CONDITION VARCHAR(255) NOT NULL,
    SEVERITY INT NOT NULL,
    SPEED_ZONE INT NOT NULL,
    RMA VARCHAR(255) NOT NULL,
    PRIMARY KEY (ACCIDENT_NO, DCA_CODE),
    FOREIGN KEY (ACCIDENT_NO) REFERENCES Accidents(ACCIDENT_NO)
);

-- Load data from Excel sheet to PostgreSQL from engine
-- Ensure that data is loaded

SELECT * FROM Accidents;
SELECT * FROM Accident_Details;

-- Add the time of the day column
SELECT ACCIDENT_TIME,
       CASE
           WHEN ACCIDENT_TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
           WHEN ACCIDENT_TIME BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
           ELSE 'Evening'
       END AS Time_of_day
FROM Accidents;

ALTER TABLE Accidents ADD COLUMN Time_of_day VARCHAR(30);
UPDATE Accidents SET
    Time_of_day = CASE
        WHEN ACCIDENT_TIME BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN ACCIDENT_TIME BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END;

-- Add DAY_name column
SELECT ACCIDENT_DATE,
       TO_CHAR(ACCIDENT_DATE, 'DY') AS Day_name
FROM Accidents;

ALTER TABLE Accidents ADD COLUMN Day_name VARCHAR(20);
UPDATE Accidents SET 
    Day_name = TO_CHAR(ACCIDENT_DATE, 'DY');  

-- Add MONTH_name column
SELECT ACCIDENT_DATE,
       TO_CHAR(ACCIDENT_DATE, 'MONTH') AS Month_name
FROM Accidents;

ALTER TABLE Accidents ADD COLUMN Month_name VARCHAR(20);
UPDATE Accidents SET 
    Month_name = TO_CHAR(ACCIDENT_DATE, 'MONTH');  

-- Add Light_condition_desc column
SELECT LIGHT_CONDITION,
       CASE
           WHEN LIGHT_CONDITION = '1' THEN 'Daylight'
           WHEN LIGHT_CONDITION = '2' THEN 'Dawn'
           WHEN LIGHT_CONDITION = '3' THEN 'Dusk'
           WHEN LIGHT_CONDITION = '4' THEN 'Dark (street lights on)'
           WHEN LIGHT_CONDITION = '5' THEN 'Dark (street lights off)'
           WHEN LIGHT_CONDITION = '6' THEN 'Dark (no street lights)'
           WHEN LIGHT_CONDITION = '7' THEN 'Foggy'
           WHEN LIGHT_CONDITION = '8' THEN 'Rainy (daylight)'
           WHEN LIGHT_CONDITION = '9' THEN 'Rainy (dark)'
       END AS Light_condition_desc
FROM Accident_Details;

ALTER TABLE Accident_Details ADD COLUMN Light_condition_desc VARCHAR(50);
UPDATE Accident_Details SET
    Light_condition_desc = CASE
        WHEN LIGHT_CONDITION = '1' THEN 'Daylight'
        WHEN LIGHT_CONDITION = '2' THEN 'Dawn'
        WHEN LIGHT_CONDITION = '3' THEN 'Dusk'
        WHEN LIGHT_CONDITION = '4' THEN 'Dark (street lights on)'
        WHEN LIGHT_CONDITION = '5' THEN 'Dark (street lights off)'
        WHEN LIGHT_CONDITION = '6' THEN 'Dark (no street lights)'
        WHEN LIGHT_CONDITION = '7' THEN 'Foggy'
        WHEN LIGHT_CONDITION = '8' THEN 'Rainy (daylight)'
        WHEN LIGHT_CONDITION = '9' THEN 'Rainy (dark)'
    END;

-- Add severity_desc column
SELECT SEVERITY,
       CASE
           WHEN SEVERITY = '1' THEN 'damage only (no injuries)'
           WHEN SEVERITY = '2' THEN 'Minor injury'
           WHEN SEVERITY = '3' THEN 'Serious injury'
           WHEN SEVERITY = '4' THEN 'Fatal (resulting in death)'
       END AS severity_desc
FROM Accident_Details;

ALTER TABLE Accident_Details ADD COLUMN severity_desc VARCHAR(100);
UPDATE Accident_Details SET
    severity_desc = CASE
        WHEN SEVERITY = '1' THEN 'damage only (no injuries)'
        WHEN SEVERITY = '2' THEN 'Minor injury'
        WHEN SEVERITY = '3' THEN 'Serious injury'
        WHEN SEVERITY = '4' THEN 'Fatal (resulting in death)'
    END;

-- Add Speed_DESC column
SELECT SPEED_ZONE,
       CASE
           WHEN SPEED_ZONE BETWEEN '20' AND '40' THEN 'LOW SPEED'
           WHEN SPEED_ZONE BETWEEN '50' AND '70' THEN 'moderate SPEED'
           ELSE 'HIGH SPEED'
       END AS Speed_DESC
FROM Accident_Details;

ALTER TABLE Accident_Details ADD COLUMN Speed_DESC VARCHAR(100);
UPDATE Accident_Details SET
    Speed_DESC = CASE
        WHEN SPEED_ZONE BETWEEN '20' AND '40' THEN 'LOW SPEED'
        WHEN SPEED_ZONE BETWEEN '50' AND '70' THEN 'moderate SPEED'
        ELSE 'HIGH SPEED'
    END;

/* --------------------------------------------------------------------
-------------------------------- Generic ------------------------------
---------------------------------------------------------------------*/

-- 1: How many unique Locations does the data have?
SELECT COUNT(DISTINCT ACCIDENT_LOCATION) AS Dist_Loc_num FROM Accident_Details;

-- 2: Which locations have the highest number of accidents?
SELECT COUNT(ACCIDENT_NO) AS ACCIDENT_NUM, ACCIDENT_LOCATION AS Dist_Loc_num
FROM Accident_Details
GROUP BY ACCIDENT_LOCATION
ORDER BY ACCIDENT_NUM DESC
LIMIT 10;

-- 3: What is the range of date in the data?
SELECT EXTRACT(YEAR FROM MIN(ACCIDENT_DATE)) AS FROM, EXTRACT(YEAR FROM MAX(ACCIDENT_DATE)) AS TO 
FROM Accidents;

-- 4: What is the total number of accidents recorded?
SELECT COUNT(ACCIDENT_NO) AS NUM_of_accidents FROM Accidents;

-- 5: What is the average number of accidents per day?
SELECT COUNT(*) AS Avg_num_of_accidents, Day_name AS Day
FROM Accidents
GROUP BY Day_name;

-- 6: What is the distribution of accidents by time of day?
SELECT COUNT(*) AS Avg_num_of_accidents, Time_of_day AS Time
FROM Accidents
GROUP BY Time_of_day;

-- 7: How does the number of accidents vary by month?
SELECT COUNT(*) AS Avg_num_of_accidents, Month_name AS Month
FROM Accidents
GROUP BY Month_name;

-- 8: How does the number of accidents vary by speed zone category (Low, Moderate, High)?
SELECT COUNT(*) AS Avg_num_of_accidents, Speed_DESC AS Speed
FROM Accident_Details
GROUP BY Speed_DESC;

-- 9: What is the most common day of the week for accidents to occur?
SELECT COUNT(*) AS num_of_accidents, Day_name AS Day
FROM Accidents
GROUP BY Day_name
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 10: What is the trend in the number of accidents over the years (e.g., increasing, decreasing, stable)?
SELECT COUNT(*) AS num_of_accidents, EXTRACT(YEAR FROM ACCIDENT_DATE) AS year
FROM Accidents
GROUP BY year
ORDER BY year ASC;

-- 11: What are the most frequent road geometry descriptions associated with accidents?
SELECT COUNT(*) AS num_of_accidents, ROAD_GEOMETRY_DESC AS RGD
FROM Accidents
GROUP BY ROAD_GEOMETRY_DESC
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 12: How does the accident frequency vary between different road management authorities (RMA)?
SELECT COUNT(*) AS num_of_accidents, RMA AS R_M_A
FROM Accident_Details
GROUP BY RMA
ORDER BY num_of_accidents DESC;

/*--------------------------------------------------------------------
------------------------------ Accident -------------------------------
---------------------------------------------------------------------*/

-- 13: How many unique accident types are recorded in the data?
SELECT COUNT(DISTINCT ACCIDENT_TYPE_DESC) AS unique_accidents_num FROM Accidents;

-- 14: What is the most common accident type?
SELECT COUNT(*) AS num_of_accidents, ACCIDENT_TYPE_DESC AS Acc_type
FROM Accidents
GROUP BY ACCIDENT_TYPE_DESC
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 15: What is the total number of accidents by month?
SELECT COUNT(*) AS num_of_accidents, Month_name AS Month
FROM Accidents
GROUP BY Month_name
ORDER BY num_of_accidents DESC;

-- 16: Which month had the largest number of severe accidents?
SELECT COUNT(*) AS num_of_accidents, Month_name AS Month, Severity_DESC AS severity
FROM Accidents
INNER JOIN Accident_Details USING (ACCIDENT_NO)
GROUP BY Month_name, Severity_DESC
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 17: Which location had the largest number of accidents?
SELECT COUNT(*) AS num_of_accidents, ACCIDENT_LOCATION AS location
FROM Accident_Details
GROUP BY ACCIDENT_LOCATION
ORDER BY num_of_accidents DESC
LIMIT 1;

/*--------------------------------------------------------------------
------------------------------ Severity -------------------------------
---------------------------------------------------------------------*/

-- 18: Which accident type resulted in the highest severity?
SELECT COUNT(*) AS num_of_accidents, ACCIDENT_TYPE_DESC AS accident_type, Severity_DESC AS severity
FROM Accidents
INNER JOIN Accident_Details USING (ACCIDENT_NO)
GROUP BY ACCIDENT_TYPE_DESC, Severity_DESC
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 19: What speed zone has the highest average severity?
SELECT COUNT(*) AS num_of_accidents, SPEED_ZONE AS ZONE, Speed_DESC AS Speed, Severity_DESC AS severity
FROM Accident_Details
GROUP BY Speed_DESC, Severity_DESC, SPEED_ZONE
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 20: Which light condition is associated with the highest severity?
SELECT DISTINCT Light_condition_desc AS light_condition
FROM Accident_Details
WHERE SEVERITY = '4';

/*--------------------------------------------------------------------
------------------------------ Environmental -------------------------
--------------------------------------------------------------------*/

-- 21: How many unique light conditions are recorded in the data?
SELECT DISTINCT LIGHT_CONDITION AS LIGHT_COND, LIGHT_CONDITION_DESC AS LIGHT_COND_DESC
FROM Accident_Details;

-- 22: What is the most common light condition during accidents?
SELECT COUNT(*) AS num_of_accidents, Light_condition_desc AS LIGHT_COND_DESC
FROM Accident_Details
GROUP BY Light_condition_desc
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 23: What road geometry description is associated with the highest number of accidents?
SELECT COUNT(*) AS num_of_accidents, ROAD_GEOMETRY_DESC AS road_geometry_description
FROM Accidents
GROUP BY ROAD_GEOMETRY_DESC
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 24: Which light condition has the highest severity on average?
SELECT DISTINCT LIGHT_CONDITION_DESC AS LIGHT_COND, SEVERITY_DESC AS severity
FROM Accident_Details
GROUP BY SEVERITY_DESC, LIGHT_CONDITION_DESC
ORDER BY LIGHT_CONDITION_DESC DESC
LIMIT 1;

-- 25: Which time, day, and month has the most accidents?
SELECT COUNT(*) AS num_of_accidents, ACCIDENT_TIME AS time, Day_name AS day, Month_name AS month
FROM Accidents
GROUP BY ACCIDENT_TIME, Day_name, Month_name
ORDER BY num_of_accidents DESC
LIMIT 1;

-- 26: How do accidents vary by speed zone?
SELECT COUNT(*) AS num_of_accidents, SPEED_ZONE AS Speed, Speed_DESC AS desc_Speed
FROM Accident_Details
GROUP BY SPEED_ZONE, Speed_DESC
ORDER BY num_of_accidents ASC;

/*--------------------------------------------------------------------
------------------------------ Additional Analysis Queries ------------
--------------------------------------------------------------------*/

-- 27: What is the detailed information of accidents, including accident type, cause description, light condition, severity, and speed zone?
SELECT ACCIDENT_TYPE AS accident_type, ACCIDENT_TYPE_DESC AS Description,
       LIGHT_CONDITION_DESC AS light_cond, SEVERITY_DESC AS severity, SPEED_ZONE AS speed 
FROM Accidents 
JOIN Accident_Details USING (ACCIDENT_NO);

-- 28: How many accidents occurred on each day of the week, and what were their types and severity?
SELECT COUNT(*) AS num_of_accidents, Day_name AS DAY, ACCIDENT_TYPE_DESC AS TYPE, SEVERITY_DESC AS severity
FROM Accidents 
JOIN Accident_Details USING (ACCIDENT_NO)
GROUP BY Day_name, ACCIDENT_TYPE_DESC, SEVERITY_DESC
ORDER BY num_of_accidents DESC;

-- 29: What is the total number of accidents that occurred each month?
SELECT COUNT(*) AS num_of_accidents, EXTRACT(MONTH FROM ACCIDENT_DATE) AS MON
FROM Accidents
GROUP BY MON
ORDER BY MON, num_of_accidents;

-- 30: What is the severity of accidents for different light conditions?
SELECT COUNT(SEVERITY) AS num_of_sev, LIGHT_CONDITION_DESC AS light_cond
FROM Accident_Details
GROUP BY LIGHT_CONDITION_DESC
ORDER BY num_of_sev;
