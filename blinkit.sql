use blinkitdb;
select * from blinkit_data
select count(*) from blinkit_data;
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;
select distinct(Item_Fat_Content) from blinkit_data;

SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_data;


SELECT CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales
FROM blinkit_data;

SELECT COUNT(*) AS No_of_Orders
FROM blinkit_data;

SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_data where Item_Fat_Content = 'Low Fat';

SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_data where Outlet_Establishment_Year = 2022;

SELECT CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales
FROM blinkit_data where Outlet_Establishment_Year = 2022;


SELECT COUNT(*) AS No_of_Orders
FROM blinkit_data where Outlet_Establishment_Year = 2022;

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data;

SELECT Item_Fat_Content, 
CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands
FROM blinkit_data
GROUP BY Item_Fat_Content order by Total_Sales_Thousands Desc;


SELECT Item_Fat_Content, 
CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands, CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content order by Total_Sales_Thousands Desc;

SELECT Item_Fat_Content, 
CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
 CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders, CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
where Outlet_Establishment_Year = 2022
GROUP BY Item_Fat_Content order by Total_Sales_Thousands Desc;

SELECT Item_Fat_Content, 
CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
 CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
where Outlet_Establishment_Year = 2020
GROUP BY Item_Fat_Content order by Total_Sales_Thousands Desc;

SELECT top 5 Item_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales, CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type order by Total_Sales Desc;


SELECT Item_Type, 
CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands, CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type order by Total_Sales_Thousands Desc;


SELECT top 5 Item_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales, CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type order by Total_Sales asc;


SELECT Outlet_Location_Type, Item_Fat_Content, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sale, CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content order by Total_Sale asc;

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

SELECT Outlet_Establishment_Year, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,  CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales desc;


SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


SELECT Outlet_Location_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sale,
 CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
 CAST(AVG(Total_Sales) AS decimal(10,1)) AS Avg_Sales,
 COUNT(*) AS No_of_Orders,  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type order by Total_Sale desc;


SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
 CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
