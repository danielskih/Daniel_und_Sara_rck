use olist;
select sum(price), seller_id from order_items GROUP BY seller_id ORDER BY sum(price) LIMIT 10;
SELECT count(customer_city),customer_city FROM olist.customers group by customer_city order by count(customer_city) desc;
select sum(price), order_items.product_id, products.product_category_name from order_items INNER JOIN products using(product_id) GROUP BY order_items.product_id ORDER BY product_id desc LIMIT 10;
SELECT ROUND(sum(price)) AS gross_revenue_from, product_category_name FROM order_items INNER JOIN products USING(product_id) GROUP BY product_category_name ORDER BY gross_revenue_from DESC;