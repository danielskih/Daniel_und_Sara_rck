use olist;
# Top 10 dealers.
select ROUND(sum(price)), seller_id from order_items GROUP BY seller_id ORDER BY sum(price) DESC LIMIT 10;
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
SELECT ROUND(SUM(payment_value)),
MONTH(order_purchase_timestamp) AS monat,
YEAR(order_purchase_timestamp) AS jahr
FROM olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset using(order_id)
INNER JOIN olist_orders_dataset USING(order_id)
GROUP BY monat, jahr
ORDER BY jahr, monat;