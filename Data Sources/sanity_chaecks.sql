# check the consistency of the sellers data
use olist_sql;
SELECT COUNT(seller_id) FROM olist_sellers_dataset WHERE seller_id IN
(
SELECT seller_id FROM olist_closed_deals_dataset WHERE seller_id IN
(
SELECT seller_id FROM olist_order_items_dataset
)
);

SELECT COUNT(DISTINCT(seller_id)) FROM olist_sellers_dataset WHERE seller_id IN
(SELECT seller_id FROM olist_order_items_dataset);
SELECT COUNT(DISTINCT(seller_id)) FROM olist_sellers_dataset WHERE seller_id IN
(SELECT seller_id FROM olist_closed_deals_dataset);
SELECT COUNT(DISTINCT(seller_id )) FROM olist_closed_deals_dataset;

# check the payment data for consistency
SELECT SUM(payment_value) FROM olist_order_payments_dataset; 
SELECT SUM(price * order_item_id + freight_value) AS sum_price FROM olist_order_items_dataset;

SELECT 
    payment_value,
    price * order_item_id + freight_value AS calc_price
FROM
    olist_order_payments_dataset
        INNER JOIN
    olist_order_items_dataset USING (order_id);

SELECT 
    SUM(payment_value) AS sum_payment,
    SUM(price * order_item_id + freight_value) AS sum_calc_price
FROM
    olist_order_payments_dataset
        INNER JOIN
    olist_order_items_dataset USING (order_id);
