CREATE TABLE Bank_Management_Dataset (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Account_Type VARCHAR(20),
    Open_Date DATE,
    Balance NUMERIC(12,2), 
    Deposit_Amount NUMERIC(12,2),
    Withdrawal_Amount NUMERIC(12,2),
    Loan_Amount NUMERIC(12,2),
    Credit_Score INT
);

SELECT * FROM Bank_Management_Dataset;


 --1) Find the total number of customer in the bank.
SELECT COUNT(*) AS Total_Customers
FROM Bank_Management_Dataset;


--2) Find the total number of customer in bank balance.
SELECT SUM(Balance) AS Total_Balance
FROM Bank_Management_Dataset;

 
--3) Find the total number of customer in avg balance.
SELECT AVG(Balance) AS Average_Balance
FROM Bank_Management_Dataset;


--4) Find the total number of customer in max balance. 
SELECT MAX(Balance) AS Highest_Balance
FROM Bank_Management_Dataset;


--5) Find the total number of customer in min balance. 
SELECT MIN(Balance) AS Lowest_Balance
FROM Bank_Management_Dataset;

	
--6) Find the total deposit amount.
SELECT SUM(Deposit_Amount) AS Total_Deposit
FROM Bank_Management_Dataset;

	
--7) Find the total withdrawal amount. 
SELECT SUM(Withdrawal_Amount) AS Total_Withdrawal
FROM Bank_Management_Dataset;

	
--8) Find the total loan amount.
SELECT SUM(Loan_Amount) AS Total_Loan
FROM Bank_Management_Dataset;

   
--9) Number of Customers in Each City.
SELECT City,
COUNT(*) AS Customers
FROM Bank_Management_Dataset
GROUP BY City
ORDER BY Customers DESC;

   
--10) Average Balance by City.
SELECT City,
AVG(Balance) AS Avg_Balance
FROM Bank_Management_Dataset
GROUP BY City;


--11) Total Balance by Account Type.
SELECT Account_Type,
SUM(Balance) AS Total_Balance
FROM Bank_Management_Dataset
GROUP BY Account_Type;


--12) Average Credit Score.
SELECT AVG(Credit_Score) AS Avg_Credit_Score
FROM Bank_Management_Dataset;


--13) Customers with Balance Greater than 100000.
SELECT * FROM Bank_Management_Dataset
WHERE Balance > 100000;


--14) Customers with Loan.
SELECT * FROM Bank_Management_Dataset
WHERE Loan_Amount > 0;


--15) Customers with No Loan.
SELECT * FROM Bank_Management_Dataset
WHERE Loan_Amount = 0;


--16) Top 10 Customers by Balance.
SELECT Customer_Name, Balance
FROM Bank_Management_Dataset
ORDER BY Balance DESC
LIMIT 10;


--17) Lowest 10 Coustomer by Balances.
SELECT Customer_Name, Balance
FROM Bank_Management_Dataset
ORDER BY Balance
LIMIT 10;


--18) Customers with Credit Score Above 750.
SELECT * FROM Bank_Management_Dataset
WHERE Credit_Score > 750;


--19) Customers with Low Credit Score.
SELECT * FROM Bank_Management_Dataset
WHERE Credit_Score < 650;


--20) Average Deposit by Account Type.
SELECT Account_Type,
AVG(Deposit_Amount) AS Avg_Deposit
FROM Bank_Management_Dataset
GROUP BY Account_Type;


--21) Average Withdrawal by City.
SELECT City, 
AVG(Withdrawal_Amount) AS Avg_Withdrawal
FROM Bank_Management_Dataset
GROUP BY City;


-- 22) Find Highest Deposit.
SELECT Customer_Name,Deposit_Amount
FROM Bank_Management_Dataset
ORDER BY Deposit_Amount DESC
LIMIT 1;


-- 23) Find Highest Withdrawal.
SELECT Customer_Name, Withdrawal_Amount
FROM Bank_Management_Dataset
ORDER BY Withdrawal_Amount DESC
 LIMIT 1;

	
-- 24) Customers Above Average Balance. (Subquery)
SELECT Customer_Name,Balance
FROM Bank_Management_Dataset
WHERE Balance >
( SELECT AVG(Balance)
 FROM Bank_Management_Dataset );


-- 25) Rank Customers by Balance (Window Function).  
SELECT Customer_Name, Balance,
RANK() OVER(ORDER BY Balance DESC) AS Balance_Rank
FROM Bank_Management_Dataset; 


-- 26)  Running Total of Deposits.
SELECT Customer_ID,Deposit_Amount,
SUM(Deposit_Amount)
OVER(ORDER BY Customer_ID) AS Running_Total
FROM Bank_Management_Dataset;


-- 27) Dense Rank by Credit Score.
SELECT Customer_Name,Credit_Score,
DENSE_RANK()
OVER(ORDER BY Credit_Score DESC) AS Credit_Rank
FROM Bank_Management_Dataset;


-- 28) Customers with Balance Between 100000 and 300000. 
SELECT * FROM Bank_Management_Dataset
WHERE Balance BETWEEN 100000 AND 300000;


-- 29) Top 3 Customers in Each Account Type. (Window Function)
WITH RankedCustomers AS
 (
SELECT *,
ROW_NUMBER() OVER
(PARTITION BY Account_Type ORDER BY Balance DESC) AS rn
FROM Bank_Management_Dataset
  )
SELECT * FROM RankedCustomers
WHERE rn<=3;


-- 30) Rank customers based on account balance.
SELECT Customer_Name,Balance,
RANK() OVER (ORDER BY Balance DESC) AS Balance_Rank
FROM Bank_Management_Dataset;


-- 31) Find cities having more than 80 customers. (HAVING)
SELECT City,
COUNT(*) AS Total_Customers
FROM Bank_Management_Dataset
GROUP BY City
HAVING COUNT(*) > 80
ORDER BY Total_Customers DESC;


-- 32) Categorize customers based on their Credit Score. (CASE WHEN)
SELECT Customer_Name,Credit_Score,
CASE WHEN Credit_Score >= 750 THEN 'Excellent'
WHEN Credit_Score >= 650 THEN 'Good'
ELSE 'Poor'
END AS Credit_Category
FROM Bank_Management_Dataset;


 -- 33) Find customers whose name starts with 'Customer_1'. (LIKE)
SELECT Customer_ID,Customer_Name
FROM Bank_Management_Dataset
WHERE Customer_Name LIKE 'Customer_1%';


 -- 34) Find customers whose city name contains the letter 'a'.
SELECT Customer_Name,City
FROM Bank_Management_Dataset
WHERE City LIKE '%a%';


-- 35) The bank wants to identify High Value Customers who have both a high balance and an excellent credit score.
SELECT Customer_Name,Balance,Credit_Score
FROM Bank_Management_Dataset
WHERE Balance > 300000 AND Credit_Score >= 750
ORDER BY Balance DESC;

Business Insight: ye customer premium bankink service ke liye suitable hai


-- 36) The bank wants to know which account type holds more money.           
SELECT Account_Type,
COUNT(*) AS Total_Customers,
SUM(Balance) AS Total_Balance,
AVG(Balance) AS Average_Balance
FROM Bank_Management_Dataset
GROUP BY Account_Type
ORDER BY Total_Balance DESC;

Note: bank dekh sakta hai kis account se jyada deposite or revenue aa raha hai.








