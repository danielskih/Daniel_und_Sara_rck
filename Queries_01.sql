use olist_sql;
#Average revenue per user
select avg(revenue) from 
(select sum(payment_value) as revenue from olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
GROUP BY seller_id ORDER BY revenue DESC) as revenue;
# Top 10 dealers.
select ROUND(sum(payment_value)) as revenue, seller_id from olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
GROUP BY seller_id ORDER BY revenue DESC;
# Total revenue per category.
select ROUND(sum(payment_value)) AS total_revenue_item, product_category_name_english AS product  from olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
INNER JOIN olist_products_dataset USING(product_id)
INNER JOIN product_category_name_translation 
ON ï»¿product_category_name=product_category_name
GROUP BY product ORDER BY total_revenue_item DESC;
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
select ROUND(SUM(payment_value)) AS revenue, origin   FROM olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
INNER JOIN olist_closed_deals_dataset USING(seller_id)
LEFT JOIN olist_marketing_qualified_leads_dataset USING(mql_id)
GROUP BY origin ORDER BY revenue DESC;
# Average ratings 
SELECT round(AVG(review_score)), YEAR(review_creation_date) AS jahr, QUARTER(review_creation_date) AS Q FROM olist_order_reviews_dataset GROUP BY jahr, monat Order by jahr, monat;

SELECT COUNT(review_score) as "count", review_score AS score, YEAR(review_creation_date) AS jahr, QUARTER(review_creation_date)
AS Q FROM olist_order_reviews_dataset GROUP BY 'COUNT', score, jahr, Q ORDER BY jahr, Q, score;

# Sellers
SELECT COUNT(seller_id) FROM olist_sql.olist_sellers_dataset;
# Average sellers performance per aquisition channel
USE olist_sql;
SELECT ROUND(AVG(temp.revenue)) AS "Average sellers performance", temp.origin FROM
(select ROUND(SUM(payment_value)) AS revenue, origin  FROM olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
INNER JOIN olist_closed_deals_dataset USING(seller_id)
LEFT JOIN olist_marketing_qualified_leads_dataset USING(mql_id)
GROUP BY seller_id, origin ORDER BY revenue DESC) AS temp
GROUP BY temp.origin;

select ROUND(SUM(payment_value)) AS revenue, origin, SELLER_ID   FROM olist_order_items_dataset 
INNER JOIN olist_order_payments_dataset USING(order_id)
INNER JOIN olist_closed_deals_dataset USING(seller_id)
LEFT JOIN olist_marketing_qualified_leads_dataset USING(mql_id)
GROUP BY seller_id, origin ORDER BY revenue DESC;
# Total revenue
SELECT ROUND(SUM(payment_value)) FROM olist_order_payments_dataset;
