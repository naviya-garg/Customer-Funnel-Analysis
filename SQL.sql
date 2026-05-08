create database Funnel_Analysis;
use Funnel_Analysis;

# Funnel Analysis Project
select * from ca;  
select * from cb;
select * from o;  
select * from cs;
select * from sp;


  # Objective: Analyze user journey from Browse → Checkout

-- 1. DATA EXPLORATION

-- Total number of records
SELECT COUNT(*) AS total_rows
FROM ca;

-- Unique customers in dataset
SELECT COUNT(DISTINCT Cust_ID) AS total_customers
FROM ca;

-- Distinct funnel stages available
SELECT DISTINCT Activity
FROM ca;

-- Check date range of dataset
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM ca;


-- 2. FUNNEL STAGE COUNT (CORE METRIC)

-- Count unique users at each stage
SELECT 
    Activity,
    COUNT(DISTINCT Cust_ID) AS users
FROM ca
GROUP BY Activity
ORDER BY users DESC;


-- 3. FIRST OCCURRENCE OF EACH STAGE PER CUSTOMER

-- Get earliest time each user reached each stage
SELECT 
    Cust_ID,
    Activity,
    MIN(Date) AS first_time
FROM ca
GROUP BY Cust_ID, Activity
ORDER BY Cust_ID;


-- 4. CREATE STAGE-WISE TABLE (PIVOT STYLE)

-- Convert rows into columns for easier transition analysis
SELECT Cust_ID,
    MIN(CASE WHEN Activity = 'Browse' THEN Date END) AS Browse,
    MIN(CASE WHEN Activity = 'Sign_Up' THEN Date END) AS Sign_Up,
    MIN(CASE WHEN Activity = 'Add_to_Cart' THEN Date END) AS Add_to_Cart,
    MIN(CASE WHEN Activity = 'Checkout' THEN Date END) AS Checkout
FROM ca
GROUP BY Cust_ID
ORDER BY Cust_ID;


-- 5. TRANSITION TIME BETWEEN STAGES

-- Calculate days taken between each stage
SELECT Cust_ID,
    DATEDIFF(Browse, Sign_Up) AS Browse_to_SignUp,
    DATEDIFF(Add_to_Cart, Sign_Up) AS SignUp_to_AddCart,
    DATEDIFF(Checkout, Add_to_Cart) AS AddCart_to_Checkout
FROM (SELECT Cust_ID,
        MIN(CASE WHEN Activity = 'Browse' THEN Date END) AS Browse,
        MIN(CASE WHEN Activity = 'Sign_Up' THEN Date END) AS Sign_Up,
        MIN(CASE WHEN Activity = 'Add_to_Cart' THEN Date END) AS Add_to_Cart,
        MIN(CASE WHEN Activity = 'Checkout' THEN Date END) AS Checkout
FROM ca
GROUP BY Cust_ID
) AS funnel_data;


-- 6. AVERAGE TRANSITION TIME (BUSINESS METRIC)

-- Calculate average days taken between stages
SELECT 
    AVG(DATEDIFF(Sign_Up, Browse)) AS avg_Browse_to_SignUp,
    AVG(DATEDIFF(Add_to_Cart, Sign_Up)) AS avg_SignUp_to_AddCart,
    AVG(DATEDIFF(Checkout, Add_to_Cart)) AS avg_AddCart_to_Checkout
FROM (
    SELECT 
        Cust_ID,

        MIN(CASE WHEN Activity = 'Browse' THEN Date END) AS Browse,
        MIN(CASE WHEN Activity = 'Sign_Up' THEN Date END) AS Sign_Up,
        MIN(CASE WHEN Activity = 'Add_to_Cart' THEN Date END) AS Add_to_Cart,
        MIN(CASE WHEN Activity = 'Checkout' THEN Date END) AS Checkout

    FROM ca
    GROUP BY Cust_ID
) AS funnel_data
WHERE Browse IS NOT NULL 
  AND Sign_Up IS NOT NULL;


-- 7. CITY-WISE FUNNEL ANALYSIS (JOIN + SEGMENTATION)

-- Join activity with customer data
SELECT cb.City, ca.Activity, COUNT(DISTINCT ca.Cust_ID) AS users
FROM ca ca
JOIN cb cb
    ON ca.Cust_ID = cb.Cust_ID
GROUP BY cb.City, ca.Activity
ORDER BY cb.City, users DESC;


-- 8. CONVERSION RATE (ADVANCED INSIGHT)

-- Calculate conversion rate from Browse stage
SELECT Activity, COUNT(DISTINCT Cust_ID) * 100.0 /
    (SELECT COUNT(DISTINCT Cust_ID) 
     FROM ca
     WHERE Activity = 'Browse') AS conversion_rate
FROM ca
GROUP BY Activity;


-- 9. IDENTIFY DROP-OFF (FUNNEL WEAK POINTS)

-- Compare stage-to-stage user drop
WITH stage_counts AS (
    SELECT 
        Activity,
        COUNT(DISTINCT Cust_ID) AS users
    FROM ca
    GROUP BY Activity
)
SELECT Activity, users, 
LAG(users) OVER (ORDER BY users DESC) AS previous_stage_users,
(users * 100.0 / LAG(users) OVER (ORDER BY users DESC)) AS retention_rate
FROM stage_counts;


-- END OF ANALYSIS











