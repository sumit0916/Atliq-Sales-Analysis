SELECT * FROM customers;
select * from markets;
select * from products;
select * from date;
select * from transactions;
select * from transactions where currency = 'USD';

-- select transactions from the year 2020
select * from transactions t join date d on t.order_date = d.date where d.year = 2020;

-- calculate the total revenue in the year 2020
select sum(t.sales_amount) from transactions t join date d on t.order_date = d.date where d.year = 2020;

-- calculate the total revenue in the year 2020
select sum(t.sales_amount) from transactions t join date d on t.order_date = d.date where d.year = 2019;

-- calculate the total revenue generated in Delhi NCR Market in the year 2020
select sum(t.sales_amount) from transactions t join date d on t.order_date = d.date 
where d.year = 2019 and t.market_code = 'Mark004';

-- select the distinct products sold in Delhi NCR
select distinct product_code FROM transactions where market_code = 'Mark004';

-- Customers having maximum number of orders and their order amount in the year 2020
select c.custmer_name, c.customer_code, sum(t.sales_qty) as Total_quantity ,sum(t.sales_amount) AS Total_order_amount, 
year(t.order_date) as Year from transactions t 
join customers c on t.customer_code = c.customer_code
where year(t.order_date) = 2020
group by c.custmer_name, c.customer_code
order by Total_order_amount DESC;

-- Customers having maximum number of orders and their order amount in the year 2019
select c.custmer_name, c.customer_code, sum(t.sales_qty) as Total_quantity ,sum(t.sales_amount) AS Total_order_amount, 
year(t.order_date) as Year from transactions t 
join customers c on t.customer_code = c.customer_code
where year(t.order_date) = 2019
group by c.custmer_name, c.customer_code
order by Total_order_amount DESC;

-- select the top regions/cities which provide max revenue in 2020
select markets_name, markets_code, sum(sales_amount) as Total_revenue
from transactions t join markets m on m.markets_code = t.market_code
where year(t.order_date) = 2020 group by markets_name, markets_code
order by Total_revenue desc;

-- select the top regions/cities which provide max revenue in 2020
select markets_name, markets_code, sum(sales_amount) as Total_revenue
from transactions t join markets m on m.markets_code = t.market_code
where year(t.order_date) = 2019 group by markets_name, markets_code
order by Total_revenue desc;

-- select the names of top city wise customers in 2020 and their revenue
select distinct m.markets_name, c.custmer_name, sum(t.sales_amount) as total_revenue, year(order_date) as Year
from transactions t join markets m on m.markets_code = t.market_code join customers c on c.customer_code = t.customer_code
where year(order_date) = 2020 group by m.markets_name, c.custmer_name, Year(t.order_date) order by total_revenue desc;

-- select the top 10 selling products from the year 2020 and their respective revenues
select p.product_code, sum(t.sales_amount) as total_revenue, year(t.order_date) as Year 
from transactions t join products p on p.product_code = t.product_code
where year(t.order_date) = 2020
group by p.product_code, year(t.order_date) order by total_revenue desc limit 10;