-- Test Data for Products

-- Electronics - Computers - Laptops
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('MacBook Pro 16"', 'Apple MacBook Pro with M3 chip, 16GB RAM, 512GB SSD', 2499.99, 'ACTIVE', 26),
('Dell XPS 15', 'Dell XPS 15 laptop with Intel i7, 16GB RAM, 1TB SSD', 1899.99, 'ACTIVE', 26),
('Lenovo ThinkPad X1 Carbon', 'Business laptop with Intel i7, 16GB RAM, 512GB SSD', 1599.99, 'ACTIVE', 26),
('ASUS ROG Strix G15', 'Gaming laptop with AMD Ryzen 9, RTX 4070, 32GB RAM', 2199.99, 'ACTIVE', 27),
('Razer Blade 15', 'Premium gaming laptop with Intel i9, RTX 4080', 2999.99, 'ACTIVE', 27),
('MacBook Air M2', 'Ultrabook with Apple M2 chip, 8GB RAM, 256GB SSD', 1199.99, 'ACTIVE', 28),
('HP Spectre x360', 'Convertible ultrabook with Intel i7, 16GB RAM', 1399.99, 'ACTIVE', 28);

-- Electronics - Computers - Desktops
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('iMac 24"', 'Apple iMac with M3 chip, 16GB RAM, 512GB SSD', 1999.99, 'ACTIVE', 14),
('Dell OptiPlex 7090', 'Business desktop with Intel i7, 16GB RAM, 512GB SSD', 1299.99, 'ACTIVE', 14),
('Custom Gaming PC', 'High-performance gaming desktop with RTX 4090', 3499.99, 'ACTIVE', 15);

-- Electronics - Mobile Phones - Smartphones
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('iPhone 15 Pro', 'Apple iPhone 15 Pro with 256GB storage', 999.99, 'ACTIVE', 30),
('Samsung Galaxy S24 Ultra', 'Samsung flagship with 256GB storage, S Pen', 1199.99, 'ACTIVE', 30),
('Google Pixel 8 Pro', 'Google flagship with advanced AI features', 899.99, 'ACTIVE', 30),
('OnePlus 12', 'Flagship smartphone with Snapdragon 8 Gen 3', 799.99, 'ACTIVE', 30),
('Samsung Galaxy A54', 'Mid-range smartphone with great camera', 449.99, 'ACTIVE', 29),
('Xiaomi Redmi Note 13', 'Budget smartphone with excellent value', 299.99, 'ACTIVE', 29),
('Motorola Moto G84', 'Affordable smartphone with clean Android', 249.99, 'ACTIVE', 29);

-- Electronics - Mobile Phones - Phone Cases
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('iPhone 15 Pro Clear Case', 'Transparent protective case for iPhone 15 Pro', 29.99, 'ACTIVE', 18),
('Samsung Galaxy S24 Ultra Case', 'Rugged protective case with kickstand', 39.99, 'ACTIVE', 18),
('Universal Phone Case', 'Flexible silicone case for most smartphones', 19.99, 'ACTIVE', 18);

-- Electronics - Mobile Phones - Chargers
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('USB-C Fast Charger', '30W USB-C fast charger with cable', 24.99, 'ACTIVE', 19),
('Wireless Charging Pad', 'Qi-compatible wireless charging pad', 34.99, 'ACTIVE', 19),
('MagSafe Charger', 'Apple MagSafe wireless charger', 39.99, 'ACTIVE', 19);

-- Electronics - Audio
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Sony WH-1000XM5', 'Premium noise-cancelling headphones', 399.99, 'ACTIVE', 7),
('AirPods Pro 2', 'Apple wireless earbuds with noise cancellation', 249.99, 'ACTIVE', 7),
('JBL Flip 6', 'Portable Bluetooth speaker', 129.99, 'ACTIVE', 7),
('Audio-Technica ATH-M50x', 'Professional studio headphones', 149.99, 'ACTIVE', 7);

-- Electronics - Cameras
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Canon EOS R6 Mark II', 'Full-frame mirrorless camera', 2499.99, 'ACTIVE', 8),
('Sony Alpha 7 IV', 'Full-frame mirrorless camera with 33MP', 2499.99, 'ACTIVE', 8),
('GoPro Hero 12', 'Action camera with 5.3K video', 399.99, 'ACTIVE', 8);

-- Clothing - Men's Clothing
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Classic White Dress Shirt', '100% cotton formal dress shirt', 49.99, 'ACTIVE', 20),
('Oxford Button-Down Shirt', 'Casual oxford shirt in various colors', 39.99, 'ACTIVE', 20),
('Slim Fit Chinos', 'Comfortable chino pants in multiple colors', 59.99, 'ACTIVE', 21),
('Classic Fit Jeans', 'Denim jeans with classic fit', 79.99, 'ACTIVE', 21),
('Leather Jacket', 'Genuine leather biker jacket', 299.99, 'ACTIVE', 22),
('Winter Parka', 'Warm winter parka with hood', 199.99, 'ACTIVE', 22);

-- Clothing - Women's Clothing
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Floral Summer Dress', 'Lightweight floral print dress', 69.99, 'ACTIVE', 23),
('Little Black Dress', 'Classic LBD for any occasion', 89.99, 'ACTIVE', 23),
('Silk Blouse', 'Elegant silk blouse in various colors', 79.99, 'ACTIVE', 24),
('Cotton T-Shirt', 'Comfortable cotton t-shirt', 24.99, 'ACTIVE', 24),
('High-Waisted Jeans', 'Stylish high-waisted denim jeans', 89.99, 'ACTIVE', 25),
('Midi Skirt', 'Elegant midi skirt in various patterns', 59.99, 'ACTIVE', 25);

-- Clothing - Shoes
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Running Shoes', 'Comfortable running shoes with cushioning', 119.99, 'ACTIVE', 12),
('Leather Dress Shoes', 'Classic leather dress shoes', 149.99, 'ACTIVE', 12),
('Casual Sneakers', 'Versatile casual sneakers', 79.99, 'ACTIVE', 12),
('High Heels', 'Elegant high heels for formal occasions', 99.99, 'ACTIVE', 12);

-- Some inactive/discontinued products
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Old Model Laptop', 'Previous generation laptop model', 899.99, 'DISCONTINUED', 26),
('Legacy Smartphone', 'Older smartphone model', 199.99, 'INACTIVE', 29),
('Out of Season Jacket', 'Winter jacket out of season', 149.99, 'INACTIVE', 22);

