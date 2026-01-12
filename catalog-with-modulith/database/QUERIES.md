# Useful Database Queries

This document contains example queries for working with the hierarchical category structure and related data.

## Category Queries

### Get all subcategories (including nested) under a category
```sql
-- Get all subcategories under Electronics (id=1) regardless of depth
SELECT * FROM categories 
WHERE path LIKE '/1/%' OR id = 1
ORDER BY path;
```

### Get direct children only
```sql
-- Get direct children of Electronics
SELECT * FROM categories 
WHERE parent_id = 1;
```

### Get category with all ancestors
```sql
-- Get category and its parent chain
WITH RECURSIVE category_tree AS (
    SELECT id, name, parent_id, path, level, 0 as depth
    FROM categories WHERE id = 26  -- Business Laptops
    
    UNION ALL
    
    SELECT c.id, c.name, c.parent_id, c.path, c.level, ct.depth + 1
    FROM categories c
    INNER JOIN category_tree ct ON c.id = ct.parent_id
)
SELECT * FROM category_tree ORDER BY depth DESC;
```

### Get category depth
```sql
-- Count how many levels deep a category is
SELECT id, name, level, 
       (LENGTH(path) - LENGTH(REPLACE(path, '/', '')) - 1) as depth
FROM categories;
```

## Product Queries

### Get all products under a category and its subcategories
```sql
-- Get all products under Electronics (id=1) including all subcategories
SELECT p.*, c.name as category_name, c.path as category_path
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE c.path LIKE '/1/%' OR c.id = 1
ORDER BY c.path, p.name;
```

### Get products by category level
```sql
-- Get products in top-level categories only
SELECT p.*, c.name as category_name
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE c.level = 0;
```

### Get products with full category hierarchy
```sql
-- Get products with their full category path
SELECT 
    p.id,
    p.name,
    p.price,
    c.name as category_name,
    c.path as category_path,
    c.level as category_level
FROM products p
JOIN categories c ON p.category_id = c.id
ORDER BY c.path, p.name;
```

### Count products per category (including subcategories)
```sql
-- Count products in each category including products in subcategories
SELECT 
    c.id,
    c.name,
    c.path,
    COUNT(DISTINCT p.id) as product_count
FROM categories c
LEFT JOIN categories sub ON sub.path LIKE CONCAT(c.path, '%')
LEFT JOIN products p ON p.category_id = sub.id OR p.category_id = c.id
GROUP BY c.id, c.name, c.path
ORDER BY c.path;
```

## Order Queries

### Get order with all items and product details
```sql
-- Get complete order information
SELECT 
    o.id as order_id,
    o.total_amount,
    o.delivery_date,
    o.status,
    oi.quantity,
    oi.purchased_price,
    p.name as product_name,
    p.price as current_price,
    c.name as category_name
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id
WHERE o.id = 1
ORDER BY oi.id;
```

### Get orders by product category
```sql
-- Get all orders containing products from Electronics category
SELECT DISTINCT
    o.id as order_id,
    o.total_amount,
    o.delivery_date,
    o.status
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id
WHERE c.path LIKE '/1/%' OR c.id = 1;
```

### Calculate order statistics
```sql
-- Get order statistics by status
SELECT 
    status,
    COUNT(*) as order_count,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as average_order_value
FROM orders
GROUP BY status;
```

### Find products never ordered
```sql
-- Find products that have never been ordered
SELECT p.*
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
WHERE oi.id IS NULL;
```

### Get top selling products
```sql
-- Get top 10 best selling products
SELECT 
    p.id,
    p.name,
    p.price,
    SUM(oi.quantity) as total_quantity_sold,
    SUM(oi.purchased_price * oi.quantity) as total_revenue
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.name, p.price
ORDER BY total_quantity_sold DESC
LIMIT 10;
```

## Advanced Queries

### Get category tree structure
```sql
-- Display category hierarchy as a tree
SELECT 
    id,
    name,
    CONCAT(REPEAT('  ', level), name) as tree_display,
    path,
    level
FROM categories
ORDER BY path;
```

### Find categories with no products
```sql
-- Find categories (including subcategories) that have no products
SELECT c.*
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
WHERE p.id IS NULL
ORDER BY c.path;
```

### Get category statistics
```sql
-- Get statistics for each category including subcategories
SELECT 
    c.id,
    c.name,
    c.path,
    c.level,
    COUNT(DISTINCT sub.id) as subcategory_count,
    COUNT(DISTINCT p.id) as product_count
FROM categories c
LEFT JOIN categories sub ON sub.path LIKE CONCAT(c.path, '%') AND sub.id != c.id
LEFT JOIN products p ON p.category_id = sub.id OR p.category_id = c.id
GROUP BY c.id, c.name, c.path, c.level
ORDER BY c.path;
```

### Price change analysis
```sql
-- Compare purchased prices with current prices
SELECT 
    p.id,
    p.name,
    p.price as current_price,
    AVG(oi.purchased_price) as avg_purchased_price,
    (p.price - AVG(oi.purchased_price)) as price_difference,
    COUNT(oi.id) as times_ordered
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.name, p.price
HAVING price_difference != 0
ORDER BY ABS(price_difference) DESC;
```

