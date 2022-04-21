use olist;
# Top 10 dealers.
select ROUND(sum(price)), seller_id from order_items GROUP BY seller_id ORDER BY sum(price) DESC;
# Total revenue per item.
select ROUND(sum(price)) AS total_revenue_item, product_id from order_items GROUP BY product_id ORDER BY total_revenue_item DESC;
# Total customer over time.
SELECT COUNT(distinct customer_id) AS customers, 
YEAR(order_purchase_timestamp) as "years", 
MONTH(order_purchase_timestamp) AS monat
FROM orders 
#WHERE order_status = 'delivered' 
GROUP BY monat, years
ORDER BY years;
# Vendors over time.
SELECT COUNT(distinct(seller_id)) AS vendors,
YEAR(order_purchase_timestamp) as "years", 
MONTH(order_purchase_timestamp) AS monat 
FROM order_items 
INNER JOIN orders using (order_id)
GROUP BY monat, years
ORDER BY years;

#Total revenue over time.
USE olist_sql;
SELECT ROUND(SUM(payment_value)) AS revenue,
MONTH(order_purchase_timestamp) AS monat,
YEAR(order_purchase_timestamp) AS jahr
FROM olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset using(order_id)
INNER JOIN olist_orders_dataset USING(order_id)
GROUP BY monat, jahr
ORDER BY jahr, monat;
#Salers marketing leads origin.
SELECT count(mql_id), origin FROM olist_marketing_qualified_leads_dataset WHERE origin IS NOT NULL group by origin;
#Orders status
USE olist_sql;
SELECT COUNT(order_id), order_status FROM olist_sql.olist_orders_dataset GROUP BY order_status;
# Revenue per marketing channel
USE olist_sql;
select ROUND(SUM(payment_value)) AS revenue,origin   FROM olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
INNER JOIN olist_closed_deals_dataset USING(seller_id)
LEFT JOIN olist_marketing_qualified_leads_dataset USING(mql_id)
GROUP BY origin ORDER BY revenue DESC;



