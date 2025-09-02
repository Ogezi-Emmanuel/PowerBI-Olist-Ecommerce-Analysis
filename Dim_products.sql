SELECT
    p.product_id,
    COALESCE(pt.product_category_name_english, p.product_category_name) AS product_category,
    p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM
    olist_products_dataset AS p
LEFT JOIN
    product_category_name_translation AS pt ON p.product_category_name = pt.product_category_name