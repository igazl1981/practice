-- Test Data for Categories
-- Hierarchical category structure

-- Level 0: Root Categories
INSERT INTO categories (id, name, description, image, parent_id, path, level) VALUES
(1, 'Electronics', 'Electronic devices and accessories', 'category-electronics-1024x1024.png', NULL, '/1', 0),
(2, 'Clothing', 'Apparel and fashion items', 'category-clothes-1024x1024.png', NULL, '/2', 0),
(3, 'Home & Garden', 'Home improvement and garden supplies', 'category-home-and-garden-1024x1024.png', NULL, '/3', 0),
(4, 'Sports', 'Sports equipment and accessories', 'category-sport-1024x1024.png', NULL, '/4', 0);

-- Level 1: Subcategories under Electronics
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(5, 'Computers', 'Desktop and laptop computers', 1, '/1/5', 1),
(6, 'Mobile Phones', 'Smartphones and feature phones', 1, '/1/6', 1),
(7, 'Audio', 'Headphones, speakers, and audio equipment', 1, '/1/7', 1),
(8, 'Cameras', 'Digital cameras and accessories', 1, '/1/8', 1);

-- Level 1: Subcategories under Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(9, 'Mens Clothing', 'Clothing for men', 2, '/2/9', 1),
(10, 'Womens Clothing', 'Clothing for women', 2, '/2/10', 1),
(11, 'Kids Clothing', 'Clothing for children', 2, '/2/11', 1),
(12, 'Shoes', 'Footwear for all ages', 2, '/2/12', 1);

-- Level 2: Subcategories under Computers
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(13, 'Laptops', 'Portable computers', 5, '/1/5/13', 2),
(14, 'Desktops', 'Desktop computers', 5, '/1/5/14', 2),
(15, 'Gaming PCs', 'High-performance gaming computers', 5, '/1/5/15', 2),
(16, 'Accessories', 'Computer accessories and peripherals', 5, '/1/5/16', 2);

-- Level 2: Subcategories under Mobile Phones
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(17, 'Smartphones', 'Modern smartphones', 6, '/1/6/17', 2),
(18, 'Phone Cases', 'Protective cases and covers', 6, '/1/6/18', 2),
(19, 'Chargers', 'Phone chargers and cables', 6, '/1/6/19', 2);

-- Level 2: Subcategories under Men's Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(20, 'Shirts', 'Mens shirts and tops', 9, '/2/9/20', 2),
(21, 'Pants', 'Mens pants and trousers', 9, '/2/9/21', 2),
(22, 'Jackets', 'Mens jackets and outerwear', 9, '/2/9/22', 2);

-- Level 2: Subcategories under Women's Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(23, 'Dresses', 'Womens dresses', 10, '/2/10/23', 2),
(24, 'Tops', 'Womens tops and blouses', 10, '/2/10/24', 2),
(25, 'Bottoms', 'Womens pants and skirts', 10, '/2/10/25', 2);

-- Level 3: Subcategories under Laptops
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(26, 'Business Laptops', 'Laptops for business use', 13, '/1/5/13/26', 3),
(27, 'Gaming Laptops', 'Laptops optimized for gaming', 13, '/1/5/13/27', 3),
(28, 'Ultrabooks', 'Lightweight and thin laptops', 13, '/1/5/13/28', 3);

-- Level 3: Subcategories under Smartphones
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(29, 'Budget Smartphones', 'Affordable smartphone options', 17, '/1/6/17/29', 3),
(30, 'Flagship Smartphones', 'Premium flagship devices', 17, '/1/6/17/30', 3);

