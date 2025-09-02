-- Use a CTE to create a clean, aggregated payments table first
WITH AggregatedPayments AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value,
        -- This line combines multiple payment types into a single text string
        STRING_AGG(payment_type, ', ') AS payment_methods,
        MAX(payment_installments) AS max_installments
    FROM
        olist_order_payments_dataset
    GROUP BY
        order_id
)

SELECT
    -- Item-level details
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,

    -- Order-level details
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    -- Correctly joined payment details
    p.total_payment_value,
    p.payment_methods,
    p.max_installments,

    -- Review details
    r.review_score

FROM
    olist_order_items_dataset AS oi
LEFT JOIN
    olist_orders_dataset AS o ON oi.order_id = o.order_id
LEFT JOIN
    -- Join the aggregated CTE, not the raw payments table
    AggregatedPayments AS p ON oi.order_id = p.order_id
LEFT JOIN
    olist_order_reviews_dataset AS r ON oi.order_id = r.order_id;