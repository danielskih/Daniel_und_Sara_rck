use olist_sql;
#Get top 12 grossing products.
SELECT  COUNT(items.product_id), product_category_name_english  FROM olist_order_items_dataset AS items
INNER JOIN olist_products_dataset AS products USING(product_id)
INNER JOIN product_category_name_translation ON product_category_name = ï»¿product_category_name
GROUP BY product_category_name_english
ORDER BY COUNT(items.product_id)  DESC;

# Get bottom 19 grossing products.
SELECT ROUND(SUM(price)) AS gross_revenue, product_category_name FROM olist_order_items_dataset AS items 
INNER JOIN olist_products_dataset AS products USING(product_id) 
GROUP BY product_category_name ORDER BY gross_revenue LIMIT 19;

;
;