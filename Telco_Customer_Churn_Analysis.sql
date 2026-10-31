CREATE DATABASE customer_churn_analysis;
USE customer_churn_analysis;
CREATE TABLE customer_churn (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)
);
SELECT COUNT(*) FROM customer_churn;
SHOW WARNINGS;
ALTER TABLE customer_churn
MODIFY TotalCharges VARCHAR(30);
SELECT COUNT(DISTINCT customerID) AS unique_customers
FROM customer_churn;
SELECT
    Churn,
    COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY Churn;

SELECT
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate_Percentage
FROM customer_churn;  

SELECT
    gender,
    Churn,
    COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY gender, Churn
ORDER BY gender, Churn;


SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_churn
GROUP BY Contract
ORDER BY Churned_Customers DESC;

SELECT
    SeniorCitizen,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_churn
GROUP BY SeniorCitizen;

SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_churn
GROUP BY InternetService;

SELECT
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY Churned_Customers DESC;

SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charges
FROM customer_churn
GROUP BY Churn;

SELECT
    Churn,
    ROUND(AVG(tenure), 2) AS Avg_Tenure_Months
FROM customer_churn
GROUP BY Churn;

SELECT
    Churn,
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue
FROM customer_churn
GROUP BY Churn;

SELECT COUNT(*) AS High_Risk_Customers
FROM customer_churn
WHERE Contract = 'Month-to-month'
AND Churn = 'Yes'
AND tenure <= 12;

SELECT
    customerID,
    tenure,
    MonthlyCharges,
    Contract,
    Churn
FROM customer_churn
ORDER BY MonthlyCharges DESC
LIMIT 10;

SELECT DATABASE();

USE customer_churn_analysis;

SELECT VERSION(), CURRENT_USER();

SHOW GRANTS FOR CURRENT_USER();
CREATE USER 'powerbi_user'@'localhost'
IDENTIFIED BY 'PowerBI@12345';

GRANT SELECT ON customer_churn_analysis.* 
TO 'powerbi_user'@'localhost';

GRANT SELECT ON customer_churn_analysis.* 
TO 'powerbi_user'@'localhost';

FLUSH PRIVILEGES;



USE customer_churn_analysis;



