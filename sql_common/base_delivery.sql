-- Base delivery table
-- Grain: 1 row per order_item_id
-- Scope: delivered orders only

SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,

    -- Financials
    oi.price,
    oi.freight_value,

    -- Delivery timestamps
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    -- Delivery metrics
    CAST(
        JULIANDAY(o.order_delivered_customer_date)
        - JULIANDAY(o.order_estimated_delivery_date)
        AS INTEGER
    ) AS delivery_delay_days,

    CASE
        WHEN o.order_delivered_customer_date
             > o.order_estimated_delivery_date
        THEN 1 ELSE 0
    END AS is_late_delivery

FROM olist_order_items oi
JOIN olist_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';