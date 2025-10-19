#Total revenue per store per day

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `KaterinaShvetsova`@`%` 
    SQL SECURITY DEFINER
VIEW `v_Analysis_Daily_Store_Revenue` AS
    SELECT 
        `s`.`Store_ID` AS `Store Key`,
        `st`.`City` AS `City`,
        `s`.`Date` AS `Sale Date`,
        SUM(`si`.`TotalPrice`) AS `Daily_Revenue`
    FROM
        ((`Sale` `s`
        JOIN `Sale_Item` `si` ON ((`s`.`Sale_ID` = `si`.`Sale_ID`)))
        JOIN `Store` `st` ON ((`s`.`Store_ID` = `st`.`Store_ID`)))
    GROUP BY `s`.`Store_ID` , `st`.`City` , `s`.`Date`
    ORDER BY `s`.`Store_ID` , `s`.`Date`;
    
    #Sales per employee
    
    CREATE OR REPLACE VIEW v_Analysis_Employee_Sales AS
SELECT
    e.Employee_ID AS `Employee Key`,
    e.Name AS `Employee Name`,
    e.Role AS `Employee Role`,
    SUM(si.TotalPrice) AS Total_Sales
FROM Sale s
JOIN Sale_Item si ON s.Sale_ID = si.Sale_ID
JOIN Employee e ON s.Employee_ID = e.Employee_ID
GROUP BY e.Employee_ID, e.Name, e.Role;

#Stock per product in store
CREATE OR REPLACE VIEW v_Analysis_Inventory_Stock AS
SELECT
    i.Store_ID AS `Store Key`,
    i.Product_ID AS `Product Key`,
    SUM(i.Quantity) AS Total_Stock,
    MAX(i.LastUpdated) AS Last_Updated
FROM Inventory i
GROUP BY i.Store_ID, i.Product_ID;

#Total sales per product category

CREATE OR REPLACE VIEW v_Analysis_Sales_Per_Category AS
SELECT
    p.Category AS `Product Category`,
    SUM(si.Quantity) AS Total_Quantity_Sold,
    SUM(si.TotalPrice) AS Total_Revenue
FROM Sale_Item si
JOIN Product p ON si.Product_ID = p.Product_ID
GROUP BY p.Category;

#Total stock value per store

CREATE OR REPLACE VIEW v_Analysis_Stock_Value AS
SELECT
    i.Store_ID AS `Store Key`,
    st.City,
    SUM(i.Quantity * p.Price) AS Total_Stock_Value
FROM Inventory i
JOIN Product p ON i.Product_ID = p.Product_ID
JOIN Store st ON i.Store_ID = st.Store_ID
GROUP BY i.Store_ID, st.City;

#Sales per store

CREATE OR REPLACE VIEW v_Analysis_Store_Sales AS
SELECT
    st.Store_ID AS `Store Key`,
    st.City,
    SUM(si.TotalPrice) AS Store_Total_Sales
FROM Sale s
JOIN Sale_Item si ON s.Sale_ID = si.Sale_ID
JOIN Store st ON s.Store_ID = st.Store_ID
GROUP BY st.Store_ID, st.City;

#Sales growth per store (compared to previous day)

CREATE OR REPLACE VIEW v_Analysis_Store_Sales_Growth AS
SELECT
    st.Store_ID AS `Store Key`,
    st.City,
    CURRENT_DATE AS `Today`,
    COALESCE(SUM(CASE WHEN s.Date = CURRENT_DATE THEN si.TotalPrice END), 0) AS Today_Sales,
    COALESCE(SUM(CASE WHEN s.Date = CURRENT_DATE - INTERVAL 1 DAY THEN si.TotalPrice END), 0) AS Yesterday_Sales,
    CASE
        WHEN COALESCE(SUM(CASE WHEN s.Date = CURRENT_DATE - INTERVAL 1 DAY THEN si.TotalPrice END), 0) = 0 THEN NULL
        ELSE (SUM(CASE WHEN s.Date = CURRENT_DATE THEN si.TotalPrice END) 
             - SUM(CASE WHEN s.Date = CURRENT_DATE - INTERVAL 1 DAY THEN si.TotalPrice END))
             / SUM(CASE WHEN s.Date = CURRENT_DATE - INTERVAL 1 DAY THEN si.TotalPrice END) * 100
    END AS Sales_Growth_Percent
FROM Sale s
JOIN Sale_Item si ON s.Sale_ID = si.Sale_ID
JOIN Store st ON s.Store_ID = st.Store_ID
GROUP BY st.Store_ID, st.City;


#Supplier orders per product

CREATE OR REPLACE VIEW v_Analysis_Supply_Orders AS
SELECT
    so.Supplier_ID AS `Supplier Key`,
    so.Product_ID AS `Product Key`,
    SUM(so.Quantity) AS Total_Ordered,
    MAX(so.OrderDate) AS Last_Order_Date
FROM Supply_Order so
GROUP BY so.Supplier_ID, so.Product_ID;


#Top 3 employees by total sales

CREATE OR REPLACE VIEW v_Analysis_Top_Employees AS
SELECT *
FROM (
    SELECT
        e.Employee_ID AS `Employee Key`,
        e.Name AS `Employee Name`,
        e.Role AS `Employee Role`,
        SUM(si.TotalPrice) AS Total_Sales,
        RANK() OVER (ORDER BY SUM(si.TotalPrice) DESC) AS Rank_Sales
    FROM Sale s
    JOIN Sale_Item si ON s.Sale_ID = si.Sale_ID
    JOIN Employee e ON s.Employee_ID = e.Employee_ID
    GROUP BY e.Employee_ID, e.Name, e.Role
) ranked_employees
WHERE Rank_Sales <= 3;


#Total sales per product

CREATE OR REPLACE VIEW v_Analysis_Total_Sales_Per_Product AS
SELECT
    p.Product_ID AS `Product Key`,
    p.Name AS `Product Name`,
    p.Category AS `Product Category`,
    SUM(si.Quantity) AS Total_Quantity_Sold,
    SUM(si.TotalPrice) AS Total_Revenue
FROM Sale_Item si
JOIN Product p ON si.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Name, p.Category;





