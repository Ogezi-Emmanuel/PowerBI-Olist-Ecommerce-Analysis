SELECT
    c.customer_id,
    c.customer_unique_id, -- Important for identifying repeat customers
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state
FROM
    olist_customers_dataset AS c