create database telco_customer_churn;

use telco_customer_churn;

CREATE TABLE CustomerChurn (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen TINYINT,        -- 0 = No, 1 = Yes
    Partner VARCHAR(5),            -- Yes / No
    Dependents VARCHAR(5),         -- Yes / No
    tenure INT,                    -- Number of months customer has stayed
    PhoneService VARCHAR(5),       -- Yes / No
    MultipleLines VARCHAR(20),     -- Yes / No / No phone service
    InternetService VARCHAR(20),   -- DSL / Fiber optic / No
    OnlineSecurity VARCHAR(20),     -- Yes / No / No internet service
    OnlineBackup VARCHAR(20),       -- Yes / No / No internet service
    DeviceProtection VARCHAR(20),   -- Yes / No / No internet service
    TechSupport VARCHAR(20),        -- Yes / No / No internet service
    StreamingTV VARCHAR(20),        -- Yes / No / No internet service
    StreamingMovies VARCHAR(20),    -- Yes / No / No internet service
    Contract VARCHAR(20),          -- Month-to-month / One year / Two year
    PaperlessBilling VARCHAR(5),   -- Yes / No
    PaymentMethod VARCHAR(50),     -- Electronic check / Mailed check / Bank transfer / Credit card
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)               -- Yes / No
);

-- truncate table CustomerChurn;


-- total customer
Select count(*) from CustomerChurn;
-- 7032

-- total churn
select sum(case when churn = 'Yes' then 1 else 0 end) as total_churn
from CustomerChurn;
-- 1869

-- churn rate
select round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from CustomerChurn;
-- 26.58 %


-- Q Gender vs churn

select 
	Gender,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from CustomerChurn
group by 1;

-- insights 
-- there is not a major difference in churn and churn rate in gender segment male churn - 930 , churn rate - 26.20 | Female churn - 939, churn rate - 26.96
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- seniorcitizen vs churn

select
	Seniorcitizen,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
     round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;
    
-- insights
-- churn rate of a senior citizen (41.68 %) is very high as compare to  young,middle age person
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- Partner vs churn

select 
	Partner,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
     round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;

-- number of churn and churn rate of a non-partner (1200, 32.98 %) is approx double as compare to partner customer (669, 19.72 %)
-- -------------------------------------------------------------------------------------------------------------------------------------------

-- tenure vs churn

select 
	case when tenure > 0 and tenure <= 12 then 'New customer' 
		 when tenure >= 13 and tenure <= 24 then 'middle customer'
	else 'Loyal customer' end as tenure_segment,
	sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
	round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;

-- new customer churn is 1037 total customer is 2175 churn_rate is 47.68
-- middle_customer churn is 294 total customer is 1024 churn rate is 28.71
-- loyal customer churn is 539 total customer is 3833 churn rate is 14.04

-- which means new_customer churn rate is higher 41.68 % follwed by middle customer 28.71 %
-- loyal customer churn rate is good as compare to new and middle 14.04 %
-- company have to focus more on new customer because new customer leave the company more so they have to work on it to reduce churn
-- --------------------------------------------------------------------------------------------------------------------------------------------------------

-- internet service vs churn

select
	internetservice,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
	round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;

-- insights
-- according to the insight fibre optic churn rate is very high 41.89% , followed by DSL 19 %
-- No internetservices churn rate is good 7.43 %
-- company have to focus more on fibre optic internet services to reduce churn 
-- ------------------------------------------------------------------------------------------------------------------------

-- paymentmethod vs churn

select
	Paymentmethod,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
	round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1
order by 2 desc;

SELECT PaymentMethod, COUNT(*) AS churn_count
FROM customerchurn
WHERE churn='Yes'
GROUP BY PaymentMethod
order by 2 desc;


-- insights
-- every paymentmethod churn rate is same approx 16 % to 19 %
-- accept Electronic check , churn rate is 45.29 %
-- so company have to focus more on Electronic check to reduce thier churn
-- ------------------------------------------------------------------------------------------------------------------------------------

-- contract vs churn

select
	contract,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
	round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;
    
-- insights
-- month-to-month contract churn rate is very high approx 42.71 % 
-- one year churn rate is 11.28 % which is not bad
-- two year contract churn rate is very less and good just 2.85 %

-- which means month-to-month service is not good that's why customer leave more 
-- 2 year contract is very good for customer that's why people is loyal and not leave the company
-- ---------------------------------------------------------------------------------------------------------------------------------

-- techsupport vs churn

select
	techsupport,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
	round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;

-- insights
-- No tech support churn rate is very high approx 41.65 % 
-- tech support churn rate is good not to bad 15.20 %.

-- means company have to improve their tech support to reduce churn rate
-- -----------------------------------------------------------------------------------------------------------------------------------------------

-- onlinesecurity vs churn

select
	onlinesecurity,
    sum(case when churn = 'Yes' then 1 else 0 end) as churn,
    count(*) as total_customer,
	round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customerchurn
group by 1;

-- insights no onlinesecurity churn rate is very high approx 41.78 % 
-- onlinesecurity churn rate is 14.68 %

-- which means company online security is also a big reason for churn
-- --------------------------------------------------------------------------------------------------------

-- Average monthly charge churn

select 
	churn, 
	round(avg(monthlycharges),2) as avg_monthly_charge
from customerchurn
group by 1;

SELECT 
    FLOOR(MonthlyCharges/10)*10 AS ChargeRange, 
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS ChurnRate
FROM CustomerChurn
GROUP BY FLOOR(MonthlyCharges/10)*10
ORDER BY 2 desc;


-- insights
-- customer who leave the company monthly_charge is little high as compare to retain customers
-- churn customer avg_monthlycharge = 74.45
-- retain customer avg_monthlycharge = 61.31

-- ----------------------------------------------------------------------------------------------------------------

-- Your Overall Insights (Summary Storyline)

-- Demographics:
-- Gender doesn’t matter much.
-- Senior Citizens churn almost 42% (much higher than younger customers).

-- Customer Tenure:
-- New customers churn the most (47.7% in first 12 months).
-- Loyal customers (25+ months) churn just 14%.
-- 👉 The company is failing at onboarding & first-year experience.

-- Services:
-- Customers without Online Security or Tech Support churn ~42%.
-- Those with these services churn only ~15%.
-- 👉 Customers who feel “unsupported” leave fast.

-- Internet Service Type:
-- Fiber optic customers churn the most (42%) → maybe pricing or service quality issue.
-- DSL customers churn less (19%).

-- Payment Method:
-- Electronic Check users churn massively (45%).
-- Other payment methods churn around 16–19%.
-- 👉 Payment method is a hidden churn risk.

-- Contracts:
-- Month-to-month contracts churn 43%.
-- Two-year contracts churn just 2.9%.
-- 👉 Long-term contracts = loyalty.

-- Charges:
-- Average MonthlyCharges: Churned customers = ₹74.45, Retained customers = ₹61.31.
-- 👉 High prices are pushing people away.
-- -------------------------------------------------------------------------------------------------------------------------------------------------------

-- Final Business Recommendations

-- Fix first-year experience (reduce new customer churn):
--   Offer welcome discounts / loyalty rewards for first 12 months.
--   Improve onboarding (tutorials, support, special offers).

-- Upsell retention services (Tech Support & Online Security):
--   Bundle them with contracts (maybe free for first 6 months).
--   Promote them as “peace of mind” features.

-- Tackle Fiber Optic churn:
--   Investigate service quality complaints.
--   Price adjustments if customers feel overcharged.

-- Reduce risk of Electronic Check churn:
--   Educate customers about secure auto-pay methods.
--   Incentivize switching to credit card/autopay (discounts).

-- Encourage long-term contracts:
--    Offer bigger discounts for 1-year or 2-year plans.
--    Free add-ons (streaming, security) for long contracts.

-- Pricing strategy:
--   Churners pay higher bills → review high-charging segments.
--   Personalized discounts for high-bill customers.