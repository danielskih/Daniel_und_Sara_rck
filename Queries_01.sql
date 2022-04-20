use olist;
# Top 10 dealers.
select ROUND(sum(price)), seller_id from order_items GROUP BY seller_id ORDER BY sum(price) DESC LIMIT 10;
select sum(price), product_id from order_items GROUP BY product_id;