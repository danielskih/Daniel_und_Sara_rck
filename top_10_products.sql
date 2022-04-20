use olist_sql;
#Get top 12 grossing products.
SELECT  COUNT(items.product_id), products.product_category_name  FROM olist_order_items_dataset AS items
INNER JOIN olist_products_dataset AS products USING(product_id)
GROUP BY products.product_category_name
ORDER BY COUNT(items.product_id)  DESC LIMIT 12;

# Get bottom 19 grossing products.
SELECT ROUND(SUM(price)) AS gross_revenue, product_category_name FROM olist_order_items_dataset AS items 
INNER JOIN olist_products_dataset AS products USING(product_id) 
GROUP BY product_category_name ORDER BY gross_revenue LIMIT 19;

;
;