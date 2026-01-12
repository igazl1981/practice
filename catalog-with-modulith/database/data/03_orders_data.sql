-- Test Data for Orders and Order Items

-- Order 1: Electronics order with multiple items
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(1, 2999.98, '2024-02-15', 'CONFIRMED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(1, 1, 2499.99, 1),  -- MacBook Pro 16"
(1, 21, 24.99, 1),   -- USB-C Fast Charger
(1, 22, 34.99, 1),   -- Wireless Charging Pad
(1, 23, 39.99, 1);   -- MagSafe Charger

-- Order 2: Smartphone order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(2, 1039.98, '2024-02-10', 'SHIPPED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(2, 11, 999.99, 1),  -- iPhone 15 Pro
(2, 18, 29.99, 1),   -- iPhone 15 Pro Clear Case
(2, 22, 34.99, 1);   -- Wireless Charging Pad

-- Order 3: Clothing order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(3, 189.97, '2024-02-20', 'PENDING');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(3, 31, 49.99, 1),   -- Classic White Dress Shirt
(3, 33, 59.99, 1),   -- Slim Fit Chinos
(3, 44, 79.99, 1);   -- Leather Dress Shoes

-- Order 4: Gaming setup order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(4, 2599.98, '2024-02-25', 'CONFIRMED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(4, 4, 2199.99, 1),  -- ASUS ROG Strix G15
(4, 24, 399.99, 1);  -- Sony WH-1000XM5 Headphones

-- Order 5: Women's clothing order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(5, 229.97, '2024-02-18', 'DELIVERED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(5, 37, 69.99, 1),   -- Floral Summer Dress
(5, 41, 89.99, 1),   -- High-Waisted Jeans
(5, 46, 69.99, 1);   -- High Heels

-- Order 6: Camera and accessories
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(6, 2899.98, '2024-03-01', 'CONFIRMED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(6, 28, 2499.99, 1), -- Canon EOS R6 Mark II
(6, 30, 399.99, 1);  -- GoPro Hero 12

-- Order 7: Budget smartphone order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(7, 274.98, '2024-02-12', 'SHIPPED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(7, 17, 249.99, 1),  -- Motorola Moto G84
(7, 20, 19.99, 1),   -- Universal Phone Case
(7, 21, 24.99, 1);   -- USB-C Fast Charger

-- Order 8: Audio equipment order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(8, 649.97, '2024-02-22', 'PENDING');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(8, 24, 399.99, 1),  -- Sony WH-1000XM5
(8, 25, 249.99, 1);  -- AirPods Pro 2

-- Order 9: Mixed electronics order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(9, 1399.98, '2024-02-28', 'CONFIRMED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(9, 6, 1199.99, 1),  -- MacBook Air M2
(9, 26, 129.99, 1),  -- JBL Flip 6
(9, 22, 34.99, 1),   -- Wireless Charging Pad
(9, 21, 24.99, 1);   -- USB-C Fast Charger

-- Order 10: Cancelled order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(10, 199.99, '2024-02-14', 'CANCELLED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(10, 36, 199.99, 1); -- Winter Parka

-- Order 11: Large order with multiple categories
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(11, 3849.94, '2024-03-05', 'CONFIRMED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(11, 2, 1899.99, 1),  -- Dell XPS 15
(11, 12, 1199.99, 1), -- Samsung Galaxy S24 Ultra
(11, 24, 399.99, 1),  -- Sony WH-1000XM5
(11, 32, 39.99, 2),   -- Oxford Button-Down Shirt (quantity 2)
(11, 34, 79.99, 1),   -- Classic Fit Jeans
(11, 44, 79.99, 1),   -- Leather Dress Shoes
(11, 22, 34.99, 1),   -- Wireless Charging Pad
(11, 19, 29.99, 1),   -- Samsung Galaxy S24 Ultra Case
(11, 21, 24.99, 1);   -- USB-C Fast Charger

-- Order 12: Simple single item order
INSERT INTO orders (id, total_amount, delivery_date, status) VALUES
(12, 89.99, '2024-02-16', 'DELIVERED');

INSERT INTO order_items (order_id, product_id, purchased_price, quantity) VALUES
(12, 38, 89.99, 1);   -- Little Black Dress

