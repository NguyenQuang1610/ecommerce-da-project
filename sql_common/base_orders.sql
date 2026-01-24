-- Base orders table
-- Grain: 1 row per order_id

SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM olist_orders;
