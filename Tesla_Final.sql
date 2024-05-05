--AUTOMATE EXCEL TO SQL--

--STEP 1 : CREATE TABLE 
IF OBJECT_ID('Tesla_Stock') IS NOT NULL DROP TABLE Tesla_Stock

CREATE TABLE Tesla_Stock
(	S_no NVARCHAR(50),
    Date1 DATE,
    Open1 NVARCHAR(50),
    High1 NVARCHAR(50),
    Low1 NVARCHAR(50),
    Close1 NVARCHAR(50),
    Volume NVARCHAR(50)
);

SELECT * FROM Tesla_Stock

--STEP 2: IMPORT DATA 
BULK INSERT Tesla_Stock
FROM 'C:\Users\monis\OneDrive\Desktop\Monisha\EXTRA Projects\Real Time Tesla Stock Analysis\Tesla_Stock.csv'
WITH (FORMAT = 'CSV');

SELECT * FROM Tesla_Stock

--STEP 3: CREATE A VIEW
--DROP VIEW Tesla_Stock_Summary
CREATE VIEW Tesla_Stock_Summary AS
SELECT
    MAX(CAST(Close1 AS DECIMAL(18, 9))) AS MaxPrice,
    MIN(CAST(Low1 AS DECIMAL(18, 9))) AS MinPrice,
    MAX(CAST(High1 AS DECIMAL(18, 9))) AS PeakPrice,
	MAX(CAST(Open1 AS DECIMAL(18, 9))) AS OpenPrice,
    SUM(CAST(Volume AS BIGINT)) AS TotalVolume,
    Date1 AS Date
FROM Tesla_Stock
WHERE YEAR(Date1) IN( 2015, 2016, 2017, 2018, 2019)
GROUP BY (Date1);



SELECT * FROM Tesla_Stock_Summary

--STEP 4: CREATE A STORED PROCEDURE
--DROP Procedure Tesla_Procedure
CREATE PROCEDURE Tesla_Procedure AS  
BEGIN
 SELECT *
 FROM dbo.Tesla_Stock_Summary
 --WHERE [Date1] BETWEEN @BegDate AND @EndDate;
END
GO

EXEC Tesla_Procedure --@BegDate = '1/1/2015', @EndDate = '12/31/2015'
