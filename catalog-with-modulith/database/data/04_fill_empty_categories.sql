-- Fill Empty Categories with Subcategories and Products
-- This script adds subcategories up to 3 levels deep and fills them with products

-- ============================================
-- Home & Garden (id=3) - Level 0
-- ============================================

-- Level 1: Subcategories under Home & Garden
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(31, 'Furniture', 'Home furniture and decor', 3, '/3/31', 1),
(32, 'Kitchen & Dining', 'Kitchen appliances and dining items', 3, '/3/32', 1),
(33, 'Garden Tools', 'Outdoor gardening equipment', 3, '/3/33', 1),
(34, 'Home Decor', 'Decorative items for home', 3, '/3/34', 1);

-- Level 2: Subcategories under Furniture
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(35, 'Living Room Furniture', 'Sofas, chairs, and coffee tables', 31, '/3/31/35', 2),
(36, 'Bedroom Furniture', 'Beds, dressers, and nightstands', 31, '/3/31/36', 2),
(37, 'Office Furniture', 'Desks, chairs, and storage', 31, '/3/31/37', 2);

-- Level 2: Subcategories under Kitchen & Dining
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(38, 'Cookware', 'Pots, pans, and cooking utensils', 32, '/3/32/38', 2),
(39, 'Small Appliances', 'Coffee makers, blenders, and toasters', 32, '/3/32/39', 2),
(40, 'Dining Sets', 'Dinnerware and table settings', 32, '/3/32/40', 2);

-- Level 2: Subcategories under Garden Tools
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(41, 'Hand Tools', 'Shovels, rakes, and pruners', 33, '/3/33/41', 2),
(42, 'Power Tools', 'Electric lawn mowers and trimmers', 33, '/3/33/42', 2),
(43, 'Planters & Pots', 'Plant containers and garden accessories', 33, '/3/33/43', 2);

-- Level 2: Subcategories under Home Decor
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(44, 'Wall Art', 'Paintings, prints, and wall decorations', 34, '/3/34/44', 2),
(45, 'Lighting', 'Lamps and light fixtures', 34, '/3/34/45', 2),
(46, 'Rugs & Carpets', 'Floor coverings and area rugs', 34, '/3/34/46', 2);

-- Level 3: Subcategories under Living Room Furniture
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(47, 'Sofas & Couches', 'Comfortable seating for living room', 35, '/3/31/35/47', 3),
(48, 'Coffee Tables', 'Tables for living room center', 35, '/3/31/35/48', 3),
(49, 'TV Stands', 'Entertainment centers and TV furniture', 35, '/3/31/35/49', 3);

-- Level 3: Subcategories under Bedroom Furniture
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(50, 'Beds & Mattresses', 'Bed frames and mattresses', 36, '/3/31/36/50', 3),
(51, 'Wardrobes', 'Clothing storage solutions', 36, '/3/31/36/51', 3),
(52, 'Bedside Tables', 'Nightstands and bedside storage', 36, '/3/31/36/52', 3);

-- Level 3: Subcategories under Office Furniture
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(53, 'Desks', 'Office and home office desks', 37, '/3/31/37/53', 3),
(54, 'Office Chairs', 'Ergonomic office seating', 37, '/3/31/37/54', 3),
(55, 'Filing Cabinets', 'Document storage solutions', 37, '/3/31/37/55', 3);

-- Level 3: Subcategories under Cookware
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(56, 'Non-Stick Pans', 'Non-stick cookware sets', 38, '/3/32/38/56', 3),
(57, 'Stainless Steel Cookware', 'Durable stainless steel pots and pans', 38, '/3/32/38/57', 3),
(58, 'Baking Supplies', 'Baking sheets, pans, and tools', 38, '/3/32/38/58', 3);

-- Level 3: Subcategories under Small Appliances
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(59, 'Coffee Makers', 'Automatic and manual coffee machines', 39, '/3/32/39/59', 3),
(60, 'Blenders & Mixers', 'Food processors and blenders', 39, '/3/32/39/60', 3),
(61, 'Toasters & Ovens', 'Countertop ovens and toasters', 39, '/3/32/39/61', 3);

-- Level 3: Subcategories under Dining Sets
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(62, 'Dinnerware Sets', 'Complete dinnerware collections', 40, '/3/32/40/62', 3),
(63, 'Cutlery Sets', 'Knife, fork, and spoon sets', 40, '/3/32/40/63', 3),
(64, 'Glassware', 'Drinking glasses and stemware', 40, '/3/32/40/64', 3);

-- Level 3: Subcategories under Hand Tools
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(65, 'Shovels & Spades', 'Digging and soil tools', 41, '/3/33/41/65', 3),
(66, 'Pruners & Shears', 'Cutting and trimming tools', 41, '/3/33/41/66', 3),
(67, 'Rakes & Hoes', 'Soil preparation tools', 41, '/3/33/41/67', 3);

-- Level 3: Subcategories under Power Tools
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(68, 'Lawn Mowers', 'Electric and gas lawn mowers', 42, '/3/33/42/68', 3),
(69, 'Trimmers & Edgers', 'Grass trimming equipment', 42, '/3/33/42/69', 3),
(70, 'Leaf Blowers', 'Electric and gas leaf blowers', 42, '/3/33/42/70', 3);

-- Level 3: Subcategories under Planters & Pots
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(71, 'Indoor Planters', 'Decorative indoor plant containers', 43, '/3/33/43/71', 3),
(72, 'Outdoor Planters', 'Weather-resistant outdoor pots', 43, '/3/33/43/72', 3),
(73, 'Hanging Baskets', 'Suspended plant containers', 43, '/3/33/43/73', 3);

-- Level 3: Subcategories under Wall Art
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(74, 'Canvas Prints', 'Printed canvas artwork', 44, '/3/34/44/74', 3),
(75, 'Framed Art', 'Framed paintings and prints', 44, '/3/34/44/75', 3),
(76, 'Wall Mirrors', 'Decorative mirrors for walls', 44, '/3/34/44/76', 3);

-- Level 3: Subcategories under Lighting
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(77, 'Table Lamps', 'Desk and bedside lamps', 45, '/3/34/45/77', 3),
(78, 'Floor Lamps', 'Standing floor lighting', 45, '/3/34/45/78', 3),
(79, 'Ceiling Lights', 'Overhead lighting fixtures', 45, '/3/34/45/79', 3);

-- Level 3: Subcategories under Rugs & Carpets
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(80, 'Area Rugs', 'Decorative area rugs', 46, '/3/34/46/80', 3),
(81, 'Runner Rugs', 'Hallway and entryway rugs', 46, '/3/34/46/81', 3),
(82, 'Outdoor Rugs', 'Weather-resistant outdoor rugs', 46, '/3/34/46/82', 3);

-- ============================================
-- Sports (id=4) - Level 0
-- ============================================

-- Level 1: Subcategories under Sports
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(83, 'Fitness Equipment', 'Exercise and workout equipment', 4, '/4/83', 1),
(84, 'Outdoor Sports', 'Outdoor recreational activities', 4, '/4/84', 1),
(85, 'Team Sports', 'Team-based sports equipment', 4, '/4/85', 1),
(86, 'Water Sports', 'Aquatic sports and activities', 4, '/4/86', 1);

-- Level 2: Subcategories under Fitness Equipment
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(87, 'Cardio Equipment', 'Treadmills, bikes, and ellipticals', 83, '/4/83/87', 2),
(88, 'Strength Training', 'Weights, benches, and racks', 83, '/4/83/88', 2),
(89, 'Yoga & Pilates', 'Mats, blocks, and accessories', 83, '/4/83/89', 2);

-- Level 2: Subcategories under Outdoor Sports
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(90, 'Cycling', 'Bicycles and cycling accessories', 84, '/4/84/90', 2),
(91, 'Camping & Hiking', 'Outdoor adventure gear', 84, '/4/84/91', 2),
(92, 'Winter Sports', 'Skiing, snowboarding equipment', 84, '/4/84/92', 2);

-- Level 2: Subcategories under Team Sports
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(93, 'Basketball', 'Basketballs, hoops, and gear', 85, '/4/85/93', 2),
(94, 'Soccer', 'Soccer balls and equipment', 85, '/4/85/94', 2),
(95, 'Tennis', 'Rackets, balls, and accessories', 85, '/4/85/95', 2);

-- Level 2: Subcategories under Water Sports
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(96, 'Swimming', 'Swimwear and pool equipment', 86, '/4/86/96', 2),
(97, 'Surfing', 'Surfboards and surfing gear', 86, '/4/86/97', 2),
(98, 'Kayaking', 'Kayaks and paddling equipment', 86, '/4/86/98', 2);

-- Level 3: Subcategories under Cardio Equipment
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(99, 'Treadmills', 'Running and walking machines', 87, '/4/83/87/99', 3),
(100, 'Exercise Bikes', 'Stationary and spin bikes', 87, '/4/83/87/100', 3),
(101, 'Ellipticals', 'Elliptical trainers', 87, '/4/83/87/101', 3);

-- Level 3: Subcategories under Strength Training
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(102, 'Dumbbells', 'Free weights and dumbbell sets', 88, '/4/83/88/102', 3),
(103, 'Barbells', 'Barbell sets and weight plates', 88, '/4/83/88/103', 3),
(104, 'Resistance Bands', 'Elastic resistance training bands', 88, '/4/83/88/104', 3);

-- Level 3: Subcategories under Yoga & Pilates
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(105, 'Yoga Mats', 'Exercise and yoga mats', 89, '/4/83/89/105', 3),
(106, 'Yoga Blocks', 'Support blocks for yoga practice', 89, '/4/83/89/106', 3),
(107, 'Pilates Equipment', 'Pilates rings and accessories', 89, '/4/83/89/107', 3);

-- Level 3: Subcategories under Cycling
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(108, 'Road Bikes', 'Road cycling bicycles', 90, '/4/84/90/108', 3),
(109, 'Mountain Bikes', 'Off-road mountain bicycles', 90, '/4/84/90/109', 3),
(110, 'Bike Accessories', 'Helmets, locks, and bike gear', 90, '/4/84/90/110', 3);

-- Level 3: Subcategories under Camping & Hiking
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(111, 'Tents', 'Camping tents and shelters', 91, '/4/84/91/111', 3),
(112, 'Sleeping Bags', 'Outdoor sleeping bags', 91, '/4/84/91/112', 3),
(113, 'Backpacks', 'Hiking and camping backpacks', 91, '/4/84/91/113', 3);

-- Level 3: Subcategories under Winter Sports
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(114, 'Skis', 'Alpine and cross-country skis', 92, '/4/84/92/114', 3),
(115, 'Snowboards', 'Snowboarding equipment', 92, '/4/84/92/115', 3),
(116, 'Winter Apparel', 'Ski jackets and winter gear', 92, '/4/84/92/116', 3);

-- Level 3: Subcategories under Basketball
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(117, 'Basketballs', 'Official and practice basketballs', 93, '/4/85/93/117', 3),
(118, 'Basketball Hoops', 'Portable and mounted hoops', 93, '/4/85/93/118', 3),
(119, 'Basketball Shoes', 'Performance basketball footwear', 93, '/4/85/93/119', 3);

-- Level 3: Subcategories under Soccer
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(120, 'Soccer Balls', 'Official and training soccer balls', 94, '/4/85/94/120', 3),
(121, 'Soccer Cleats', 'Football boots and cleats', 94, '/4/85/94/121', 3),
(122, 'Soccer Goals', 'Portable and permanent goals', 94, '/4/85/94/122', 3);

-- Level 3: Subcategories under Tennis
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(123, 'Tennis Rackets', 'Tennis rackets and strings', 95, '/4/85/95/123', 3),
(124, 'Tennis Balls', 'Official tennis balls', 95, '/4/85/95/124', 3),
(125, 'Tennis Apparel', 'Tennis clothing and accessories', 95, '/4/85/95/125', 3);

-- Level 3: Subcategories under Swimming
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(126, 'Swimwear', 'Swimsuits and swim trunks', 96, '/4/86/96/126', 3),
(127, 'Swim Accessories', 'Goggles, caps, and pool toys', 96, '/4/86/96/127', 3),
(128, 'Pool Equipment', 'Pool maintenance and cleaning', 96, '/4/86/96/128', 3);

-- Level 3: Subcategories under Surfing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(129, 'Surfboards', 'Shortboards, longboards, and foam boards', 97, '/4/86/97/129', 3),
(130, 'Surf Accessories', 'Leashes, wax, and board bags', 97, '/4/86/97/130', 3),
(131, 'Wetsuits', 'Surfing wetsuits and rash guards', 97, '/4/86/97/131', 3);

-- Level 3: Subcategories under Kayaking
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(132, 'Kayaks', 'Recreational and touring kayaks', 98, '/4/86/98/132', 3),
(133, 'Paddles', 'Kayak paddles and oars', 98, '/4/86/98/133', 3),
(134, 'Kayak Accessories', 'Life vests, dry bags, and gear', 98, '/4/86/98/134', 3);

-- ============================================
-- Kids Clothing (id=11) - Level 1
-- ============================================

-- Level 2: Subcategories under Kids Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(135, 'Boys Clothing', 'Clothing for boys', 11, '/2/11/135', 2),
(136, 'Girls Clothing', 'Clothing for girls', 11, '/2/11/136', 2),
(137, 'Baby Clothing', 'Infant and baby apparel', 11, '/2/11/137', 2),
(138, 'Unisex Kids', 'Unisex children clothing', 11, '/2/11/138', 2);

-- Level 3: Subcategories under Boys Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(139, 'Boys T-Shirts', 'T-shirts and casual tops for boys', 135, '/2/11/135/139', 3),
(140, 'Boys Pants', 'Jeans, shorts, and pants for boys', 135, '/2/11/135/140', 3),
(141, 'Boys Outerwear', 'Jackets and coats for boys', 135, '/2/11/135/141', 3);

-- Level 3: Subcategories under Girls Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(142, 'Girls Dresses', 'Dresses and skirts for girls', 136, '/2/11/136/142', 3),
(143, 'Girls Tops', 'Tops and blouses for girls', 136, '/2/11/136/143', 3),
(144, 'Girls Bottoms', 'Pants and leggings for girls', 136, '/2/11/136/144', 3);

-- Level 3: Subcategories under Baby Clothing
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(145, 'Onesies', 'Baby bodysuits and onesies', 137, '/2/11/137/145', 3),
(146, 'Baby Sleepwear', 'Pajamas and sleepwear for babies', 137, '/2/11/137/146', 3),
(147, 'Baby Accessories', 'Hats, bibs, and baby accessories', 137, '/2/11/137/147', 3);

-- Level 3: Subcategories under Unisex Kids
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(148, 'Kids Activewear', 'Athletic wear for children', 138, '/2/11/138/148', 3),
(149, 'Kids Pajamas', 'Sleepwear for children', 138, '/2/11/138/149', 3),
(150, 'Kids Underwear', 'Underwear and socks for kids', 138, '/2/11/138/150', 3);

-- ============================================
-- Accessories (id=16) - Level 2 (under Computers)
-- ============================================

-- Level 3: Subcategories under Accessories
INSERT INTO categories (id, name, description, parent_id, path, level) VALUES
(151, 'Keyboards & Mice', 'Computer keyboards and mice', 16, '/1/5/16/151', 3),
(152, 'Monitors', 'Computer monitors and displays', 16, '/1/5/16/152', 3),
(153, 'Storage Devices', 'External hard drives and SSDs', 16, '/1/5/16/153', 3),
(154, 'Cables & Adapters', 'Computer cables and adapters', 16, '/1/5/16/154', 3),
(155, 'Webcams', 'Computer webcams and cameras', 16, '/1/5/16/155', 3),
(156, 'Docking Stations', 'Laptop docking stations', 16, '/1/5/16/156', 3);

-- ============================================
-- Products for all Level 3 categories
-- ============================================

-- Products for Home & Garden - Furniture - Living Room - Sofas & Couches (47)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Modern 3-Seater Sofa', 'Contemporary fabric sofa with cushions', 899.99, 'ACTIVE', 47),
('Leather Reclining Sofa', 'Genuine leather sofa with reclining seats', 1299.99, 'ACTIVE', 47),
('Sectional Sofa Set', 'Large L-shaped sectional with chaise', 1599.99, 'ACTIVE', 47),
('Compact Loveseat', 'Small 2-seater sofa for apartments', 599.99, 'ACTIVE', 47);

-- Products for Home & Garden - Furniture - Living Room - Coffee Tables (48)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Glass Top Coffee Table', 'Modern glass and metal coffee table', 299.99, 'ACTIVE', 48),
('Wooden Coffee Table', 'Solid wood coffee table with storage', 449.99, 'ACTIVE', 48),
('Nesting Coffee Tables', 'Set of 3 nesting tables', 199.99, 'ACTIVE', 48);

-- Products for Home & Garden - Furniture - Living Room - TV Stands (49)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Modern TV Stand', 'Sleek TV stand with cable management', 349.99, 'ACTIVE', 49),
('Entertainment Center', 'Large entertainment center with shelves', 599.99, 'ACTIVE', 49),
('Floating TV Mount', 'Wall-mounted TV bracket', 149.99, 'ACTIVE', 49);

-- Products for Home & Garden - Furniture - Bedroom - Beds & Mattresses (50)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Queen Size Platform Bed', 'Modern platform bed frame', 699.99, 'ACTIVE', 50),
('Memory Foam Mattress', '12-inch memory foam mattress', 899.99, 'ACTIVE', 50),
('Hybrid Mattress', 'Coil and foam hybrid mattress', 1199.99, 'ACTIVE', 50);

-- Products for Home & Garden - Furniture - Bedroom - Wardrobes (51)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Sliding Door Wardrobe', 'Modern wardrobe with sliding doors', 799.99, 'ACTIVE', 51),
('Freestanding Wardrobe', 'Tall freestanding wardrobe', 649.99, 'ACTIVE', 51),
('Walk-in Closet System', 'Modular closet organization system', 1299.99, 'ACTIVE', 51);

-- Products for Home & Garden - Furniture - Bedroom - Bedside Tables (52)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Modern Nightstand', 'Bedside table with drawer', 149.99, 'ACTIVE', 52),
('Floating Nightstand', 'Wall-mounted bedside table', 99.99, 'ACTIVE', 52),
('Set of 2 Nightstands', 'Matching pair of bedside tables', 249.99, 'ACTIVE', 52);

-- Products for Home & Garden - Furniture - Office - Desks (53)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Standing Desk', 'Adjustable height standing desk', 599.99, 'ACTIVE', 53),
('L-Shaped Desk', 'Corner desk with storage', 449.99, 'ACTIVE', 53),
('Writing Desk', 'Classic wooden writing desk', 299.99, 'ACTIVE', 53);

-- Products for Home & Garden - Furniture - Office - Office Chairs (54)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Ergonomic Office Chair', 'Comfortable ergonomic desk chair', 349.99, 'ACTIVE', 54),
('Gaming Chair', 'High-back gaming chair with lumbar support', 399.99, 'ACTIVE', 54),
('Executive Leather Chair', 'Premium leather executive chair', 599.99, 'ACTIVE', 54);

-- Products for Home & Garden - Furniture - Office - Filing Cabinets (55)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('2-Drawer Filing Cabinet', 'Metal filing cabinet with lock', 199.99, 'ACTIVE', 55),
('4-Drawer Filing Cabinet', 'Large filing cabinet for office', 349.99, 'ACTIVE', 55),
('Mobile File Cart', 'Rolling file storage cart', 129.99, 'ACTIVE', 55);

-- Products for Home & Garden - Kitchen - Cookware - Non-Stick Pans (56)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Non-Stick Frying Pan Set', 'Set of 3 non-stick pans', 79.99, 'ACTIVE', 56),
('Ceramic Coated Pan', 'Eco-friendly ceramic non-stick pan', 49.99, 'ACTIVE', 56),
('Professional Non-Stick Wok', 'Large non-stick wok pan', 59.99, 'ACTIVE', 56);

-- Products for Home & Garden - Kitchen - Cookware - Stainless Steel Cookware (57)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Stainless Steel Pot Set', '10-piece stainless steel cookware set', 199.99, 'ACTIVE', 57),
('Stainless Steel Saucepan', '3-quart stainless steel saucepan', 69.99, 'ACTIVE', 57),
('Dutch Oven', 'Enameled cast iron Dutch oven', 149.99, 'ACTIVE', 57);

-- Products for Home & Garden - Kitchen - Cookware - Baking Supplies (58)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Baking Sheet Set', 'Set of 3 non-stick baking sheets', 29.99, 'ACTIVE', 58),
('Muffin Pan', '12-cup non-stick muffin pan', 19.99, 'ACTIVE', 58),
('Silicone Baking Mats', 'Set of 2 reusable baking mats', 24.99, 'ACTIVE', 58);

-- Products for Home & Garden - Kitchen - Small Appliances - Coffee Makers (59)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Drip Coffee Maker', '12-cup programmable coffee maker', 89.99, 'ACTIVE', 59),
('Espresso Machine', 'Semi-automatic espresso machine', 299.99, 'ACTIVE', 59),
('French Press', '8-cup glass French press', 29.99, 'ACTIVE', 59);

-- Products for Home & Garden - Kitchen - Small Appliances - Blenders & Mixers (60)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('High-Speed Blender', 'Professional-grade blender', 199.99, 'ACTIVE', 60),
('Stand Mixer', '5-quart stand mixer with attachments', 399.99, 'ACTIVE', 60),
('Immersion Blender', 'Handheld stick blender', 49.99, 'ACTIVE', 60);

-- Products for Home & Garden - Kitchen - Small Appliances - Toasters & Ovens (61)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('4-Slice Toaster', 'Stainless steel toaster', 59.99, 'ACTIVE', 61),
('Toaster Oven', 'Countertop toaster oven with convection', 149.99, 'ACTIVE', 61),
('Air Fryer', '5-quart digital air fryer', 129.99, 'ACTIVE', 61);

-- Products for Home & Garden - Kitchen - Dining Sets - Dinnerware Sets (62)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Porcelain Dinnerware Set', '16-piece dinnerware set for 4', 79.99, 'ACTIVE', 62),
('Stoneware Dinner Set', '20-piece stoneware set', 99.99, 'ACTIVE', 62),
('Melamine Dinnerware', 'Unbreakable melamine set', 49.99, 'ACTIVE', 62);

-- Products for Home & Garden - Kitchen - Dining Sets - Cutlery Sets (63)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Stainless Steel Cutlery Set', '24-piece cutlery set', 39.99, 'ACTIVE', 63),
('Premium Silverware Set', '32-piece premium cutlery set', 89.99, 'ACTIVE', 63),
('Bamboo Cutlery Set', 'Eco-friendly bamboo cutlery', 29.99, 'ACTIVE', 63);

-- Products for Home & Garden - Kitchen - Dining Sets - Glassware (64)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Wine Glass Set', 'Set of 6 crystal wine glasses', 49.99, 'ACTIVE', 64),
('Tumbler Set', 'Set of 8 drinking glasses', 24.99, 'ACTIVE', 64),
('Beer Glass Set', 'Set of 4 pint glasses', 19.99, 'ACTIVE', 64);

-- Products for Home & Garden - Garden Tools - Hand Tools - Shovels & Spades (65)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Round Point Shovel', 'Heavy-duty steel shovel', 34.99, 'ACTIVE', 65),
('Garden Spade', 'Professional garden spade', 29.99, 'ACTIVE', 65),
('Trenching Shovel', 'Narrow blade trenching shovel', 39.99, 'ACTIVE', 65);

-- Products for Home & Garden - Garden Tools - Hand Tools - Pruners & Shears (66)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Bypass Pruners', 'Professional bypass pruning shears', 24.99, 'ACTIVE', 66),
('Hedge Shears', 'Long-handled hedge trimming shears', 39.99, 'ACTIVE', 66),
('Anvil Pruners', 'Heavy-duty anvil pruners', 29.99, 'ACTIVE', 66);

-- Products for Home & Garden - Garden Tools - Hand Tools - Rakes & Hoes (67)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Leaf Rake', '24-inch steel leaf rake', 19.99, 'ACTIVE', 67),
('Garden Hoe', 'Traditional garden hoe', 24.99, 'ACTIVE', 67),
('Bow Rake', 'Steel bow rake for soil', 29.99, 'ACTIVE', 67);

-- Products for Home & Garden - Garden Tools - Power Tools - Lawn Mowers (68)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Electric Lawn Mower', 'Corded electric lawn mower', 199.99, 'ACTIVE', 68),
('Battery Lawn Mower', 'Cordless battery-powered mower', 349.99, 'ACTIVE', 68),
('Self-Propelled Mower', 'Gas-powered self-propelled mower', 449.99, 'ACTIVE', 68);

-- Products for Home & Garden - Garden Tools - Power Tools - Trimmers & Edgers (69)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('String Trimmer', 'Electric string trimmer', 79.99, 'ACTIVE', 69),
('Lawn Edger', 'Gas-powered lawn edger', 149.99, 'ACTIVE', 69),
('Cordless Trimmer', 'Battery-powered trimmer', 129.99, 'ACTIVE', 69);

-- Products for Home & Garden - Garden Tools - Power Tools - Leaf Blowers (70)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Electric Leaf Blower', 'Corded electric leaf blower', 59.99, 'ACTIVE', 70),
('Gas Leaf Blower', 'Backpack gas leaf blower', 199.99, 'ACTIVE', 70),
('Cordless Leaf Blower', 'Battery-powered leaf blower', 99.99, 'ACTIVE', 70);

-- Products for Home & Garden - Garden Tools - Planters & Pots - Indoor Planters (71)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Ceramic Planter Set', 'Set of 3 decorative ceramic planters', 39.99, 'ACTIVE', 71),
('Self-Watering Planter', 'Indoor planter with water reservoir', 24.99, 'ACTIVE', 71),
('Macrame Plant Hanger', 'Decorative hanging planter', 19.99, 'ACTIVE', 71);

-- Products for Home & Garden - Garden Tools - Planters & Pots - Outdoor Planters (72)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Large Outdoor Planter', 'Weather-resistant outdoor planter', 79.99, 'ACTIVE', 72),
('Window Box Planter', 'Decorative window box', 34.99, 'ACTIVE', 72),
('Terra Cotta Pot Set', 'Set of 5 terra cotta pots', 29.99, 'ACTIVE', 72);

-- Products for Home & Garden - Garden Tools - Planters & Pots - Hanging Baskets (73)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Cocoa Liner Hanging Basket', '12-inch hanging basket with liner', 14.99, 'ACTIVE', 73),
('Decorative Hanging Planter', 'Ornamental hanging planter', 19.99, 'ACTIVE', 73),
('Wire Hanging Basket', 'Metal wire hanging basket', 12.99, 'ACTIVE', 73);

-- Products for Home & Garden - Home Decor - Wall Art - Canvas Prints (74)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Abstract Canvas Print', 'Modern abstract art canvas', 49.99, 'ACTIVE', 74),
('Nature Landscape Canvas', 'Scenic landscape canvas print', 59.99, 'ACTIVE', 74),
('Cityscape Canvas Art', 'Urban cityscape canvas', 54.99, 'ACTIVE', 74);

-- Products for Home & Garden - Home Decor - Wall Art - Framed Art (75)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Framed Botanical Print', 'Vintage botanical illustration', 79.99, 'ACTIVE', 75),
('Modern Abstract Framed Art', 'Contemporary framed artwork', 89.99, 'ACTIVE', 75),
('Gallery Wall Set', 'Set of 6 framed prints', 149.99, 'ACTIVE', 75);

-- Products for Home & Garden - Home Decor - Wall Art - Wall Mirrors (76)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Round Wall Mirror', 'Decorative round wall mirror', 69.99, 'ACTIVE', 76),
('Full Length Mirror', 'Tall standing wall mirror', 99.99, 'ACTIVE', 76),
('Sunburst Mirror', 'Decorative sunburst wall mirror', 89.99, 'ACTIVE', 76);

-- Products for Home & Garden - Home Decor - Lighting - Table Lamps (77)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Modern Table Lamp', 'Sleek LED table lamp', 49.99, 'ACTIVE', 77),
('Vintage Desk Lamp', 'Classic vintage-style desk lamp', 59.99, 'ACTIVE', 77),
('Touch Control Lamp', 'Touch-sensitive table lamp', 39.99, 'ACTIVE', 77);

-- Products for Home & Garden - Home Decor - Lighting - Floor Lamps (78)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Arc Floor Lamp', 'Modern arc floor lamp', 129.99, 'ACTIVE', 78),
('Torchiere Floor Lamp', 'Tall torchiere floor lamp', 79.99, 'ACTIVE', 78),
('Reading Floor Lamp', 'Adjustable reading floor lamp', 99.99, 'ACTIVE', 78);

-- Products for Home & Garden - Home Decor - Lighting - Ceiling Lights (79)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Pendant Light Fixture', 'Modern pendant ceiling light', 89.99, 'ACTIVE', 79),
('Chandelier', 'Crystal chandelier light fixture', 299.99, 'ACTIVE', 79),
('Flush Mount Ceiling Light', 'LED flush mount ceiling light', 69.99, 'ACTIVE', 79);

-- Products for Home & Garden - Home Decor - Rugs & Carpets - Area Rugs (80)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Persian Style Area Rug', 'Traditional Persian design rug', 299.99, 'ACTIVE', 80),
('Modern Geometric Rug', 'Contemporary geometric pattern rug', 199.99, 'ACTIVE', 80),
('Shag Area Rug', 'Soft shaggy area rug', 149.99, 'ACTIVE', 80);

-- Products for Home & Garden - Home Decor - Rugs & Carpets - Runner Rugs (81)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Hallway Runner Rug', 'Long hallway runner rug', 89.99, 'ACTIVE', 81),
('Stair Runner', 'Non-slip stair runner carpet', 129.99, 'ACTIVE', 81),
('Entryway Runner', 'Decorative entryway runner', 79.99, 'ACTIVE', 81);

-- Products for Home & Garden - Home Decor - Rugs & Carpets - Outdoor Rugs (82)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Outdoor Patio Rug', 'Weather-resistant patio rug', 119.99, 'ACTIVE', 82),
('Outdoor Deck Rug', 'UV-resistant deck rug', 99.99, 'ACTIVE', 82),
('Outdoor Mat', 'Heavy-duty outdoor doormat', 29.99, 'ACTIVE', 82);

-- Products for Sports - Fitness - Cardio - Treadmills (99)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Folding Treadmill', 'Compact folding treadmill', 599.99, 'ACTIVE', 99),
('Commercial Treadmill', 'Heavy-duty commercial treadmill', 1999.99, 'ACTIVE', 99),
('Under Desk Treadmill', 'Walking pad for under desk', 399.99, 'ACTIVE', 99);

-- Products for Sports - Fitness - Cardio - Exercise Bikes (100)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Upright Exercise Bike', 'Standard upright exercise bike', 299.99, 'ACTIVE', 100),
('Recumbent Exercise Bike', 'Comfortable recumbent bike', 449.99, 'ACTIVE', 100),
('Spin Bike', 'Indoor cycling spin bike', 599.99, 'ACTIVE', 100);

-- Products for Sports - Fitness - Cardio - Ellipticals (101)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Front Drive Elliptical', 'Front-drive elliptical trainer', 699.99, 'ACTIVE', 101),
('Rear Drive Elliptical', 'Rear-drive elliptical machine', 799.99, 'ACTIVE', 101),
('Compact Elliptical', 'Space-saving compact elliptical', 499.99, 'ACTIVE', 101);

-- Products for Sports - Fitness - Strength Training - Dumbbells (102)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Adjustable Dumbbell Set', 'Adjustable weight dumbbells', 299.99, 'ACTIVE', 102),
('Rubber Coated Dumbbells', 'Set of 2 rubber dumbbells', 89.99, 'ACTIVE', 102),
('Hex Dumbbell Set', 'Set of 6 hex dumbbells', 199.99, 'ACTIVE', 102);

-- Products for Sports - Fitness - Strength Training - Barbells (103)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Olympic Barbell Set', '7-foot Olympic barbell with weights', 399.99, 'ACTIVE', 103),
('Standard Barbell', 'Standard 5-foot barbell', 149.99, 'ACTIVE', 103),
('EZ Curl Bar', 'Curved barbell for bicep curls', 79.99, 'ACTIVE', 103);

-- Products for Sports - Fitness - Strength Training - Resistance Bands (104)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Resistance Band Set', 'Set of 5 resistance bands', 24.99, 'ACTIVE', 104),
('Loop Resistance Bands', 'Set of 3 loop bands', 19.99, 'ACTIVE', 104),
('Pull-Up Resistance Bands', 'Assistance bands for pull-ups', 29.99, 'ACTIVE', 104);

-- Products for Sports - Fitness - Yoga & Pilates - Yoga Mats (105)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Premium Yoga Mat', 'Extra thick non-slip yoga mat', 39.99, 'ACTIVE', 105),
('Eco-Friendly Yoga Mat', 'Sustainable cork yoga mat', 49.99, 'ACTIVE', 105),
('Travel Yoga Mat', 'Lightweight travel yoga mat', 24.99, 'ACTIVE', 105);

-- Products for Sports - Fitness - Yoga & Pilates - Yoga Blocks (106)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Cork Yoga Block Set', 'Set of 2 cork yoga blocks', 19.99, 'ACTIVE', 106),
('Foam Yoga Block', 'Lightweight foam yoga block', 9.99, 'ACTIVE', 106),
('Yoga Block and Strap Set', 'Yoga block with strap', 24.99, 'ACTIVE', 106);

-- Products for Sports - Fitness - Yoga & Pilates - Pilates Equipment (107)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Pilates Ring', 'Resistance ring for Pilates', 29.99, 'ACTIVE', 107),
('Pilates Ball', 'Exercise ball for Pilates', 19.99, 'ACTIVE', 107),
('Pilates Reformer', 'Home Pilates reformer machine', 899.99, 'ACTIVE', 107);

-- Products for Sports - Outdoor - Cycling - Road Bikes (108)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Carbon Road Bike', 'Lightweight carbon fiber road bike', 1999.99, 'ACTIVE', 108),
('Aluminum Road Bike', 'Entry-level aluminum road bike', 699.99, 'ACTIVE', 108),
('Hybrid Road Bike', 'Versatile hybrid road bike', 599.99, 'ACTIVE', 108);

-- Products for Sports - Outdoor - Cycling - Mountain Bikes (109)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Full Suspension Mountain Bike', 'Trail-ready full suspension bike', 2499.99, 'ACTIVE', 109),
('Hardtail Mountain Bike', 'Hardtail mountain bike', 899.99, 'ACTIVE', 109),
('Electric Mountain Bike', 'E-bike for mountain trails', 2999.99, 'ACTIVE', 109);

-- Products for Sports - Outdoor - Cycling - Bike Accessories (110)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Bike Helmet', 'Safety-certified bike helmet', 49.99, 'ACTIVE', 110),
('Bike Lock', 'Heavy-duty U-lock', 39.99, 'ACTIVE', 110),
('Bike Water Bottle', 'Insulated bike water bottle', 19.99, 'ACTIVE', 110);

-- Products for Sports - Outdoor - Camping & Hiking - Tents (111)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('4-Person Camping Tent', 'Weather-resistant 4-person tent', 199.99, 'ACTIVE', 111),
('Backpacking Tent', 'Lightweight 2-person backpacking tent', 299.99, 'ACTIVE', 111),
('Family Camping Tent', 'Large 8-person family tent', 399.99, 'ACTIVE', 111);

-- Products for Sports - Outdoor - Camping & Hiking - Sleeping Bags (112)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Mummy Sleeping Bag', 'Cold-weather mummy sleeping bag', 129.99, 'ACTIVE', 112),
('Rectangular Sleeping Bag', 'Comfortable rectangular bag', 79.99, 'ACTIVE', 112),
('Double Sleeping Bag', '2-person sleeping bag', 149.99, 'ACTIVE', 112);

-- Products for Sports - Outdoor - Camping & Hiking - Backpacks (113)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Hiking Backpack', '50L hiking backpack with frame', 149.99, 'ACTIVE', 113),
('Daypack', 'Lightweight day hiking pack', 59.99, 'ACTIVE', 113),
('Ultralight Backpack', 'Minimalist ultralight pack', 199.99, 'ACTIVE', 113);

-- Products for Sports - Outdoor - Winter Sports - Skis (114)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Alpine Skis', 'All-mountain alpine skis', 599.99, 'ACTIVE', 114),
('Cross-Country Skis', 'Classic cross-country skis', 399.99, 'ACTIVE', 114),
('Ski Boots', 'Performance ski boots', 449.99, 'ACTIVE', 114);

-- Products for Sports - Outdoor - Winter Sports - Snowboards (115)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('All-Mountain Snowboard', 'Versatile all-mountain board', 499.99, 'ACTIVE', 115),
('Freestyle Snowboard', 'Park and freestyle snowboard', 449.99, 'ACTIVE', 115),
('Snowboard Boots', 'Comfortable snowboard boots', 299.99, 'ACTIVE', 115);

-- Products for Sports - Outdoor - Winter Sports - Winter Apparel (116)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Ski Jacket', 'Waterproof insulated ski jacket', 199.99, 'ACTIVE', 116),
('Ski Pants', 'Waterproof ski pants', 149.99, 'ACTIVE', 116),
('Winter Gloves', 'Insulated winter gloves', 49.99, 'ACTIVE', 116);

-- Products for Sports - Team Sports - Basketball - Basketballs (117)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Official Basketball', 'NBA-style official basketball', 39.99, 'ACTIVE', 117),
('Indoor Basketball', 'Indoor court basketball', 29.99, 'ACTIVE', 117),
('Outdoor Basketball', 'Durable outdoor basketball', 24.99, 'ACTIVE', 117);

-- Products for Sports - Team Sports - Basketball - Basketball Hoops (118)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Portable Basketball Hoop', 'Adjustable portable hoop', 199.99, 'ACTIVE', 118),
('Wall-Mounted Hoop', 'Wall-mounted basketball hoop', 149.99, 'ACTIVE', 118),
('In-Ground Hoop', 'Permanent in-ground basketball system', 599.99, 'ACTIVE', 118);

-- Products for Sports - Team Sports - Basketball - Basketball Shoes (119)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('High-Top Basketball Shoes', 'Performance high-top sneakers', 129.99, 'ACTIVE', 119),
('Low-Top Basketball Shoes', 'Lightweight low-top basketball shoes', 99.99, 'ACTIVE', 119),
('Basketball Shoe Socks', 'Cushioned basketball socks', 14.99, 'ACTIVE', 119);

-- Products for Sports - Team Sports - Soccer - Soccer Balls (120)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Official Soccer Ball', 'FIFA-approved soccer ball', 49.99, 'ACTIVE', 120),
('Training Soccer Ball', 'Durable training soccer ball', 24.99, 'ACTIVE', 120),
('Youth Soccer Ball', 'Size 4 youth soccer ball', 19.99, 'ACTIVE', 120);

-- Products for Sports - Team Sports - Soccer - Soccer Cleats (121)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Firm Ground Cleats', 'Firm ground soccer cleats', 89.99, 'ACTIVE', 121),
('Soft Ground Cleats', 'Soft ground soccer cleats', 99.99, 'ACTIVE', 121),
('Turf Soccer Shoes', 'Artificial turf soccer shoes', 79.99, 'ACTIVE', 121);

-- Products for Sports - Team Sports - Soccer - Soccer Goals (122)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Portable Soccer Goal', 'Pop-up portable soccer goal', 79.99, 'ACTIVE', 122),
('Full-Size Soccer Goal', 'Regulation-size soccer goal', 299.99, 'ACTIVE', 122),
('Practice Goal Set', 'Set of 2 practice goals', 149.99, 'ACTIVE', 122);

-- Products for Sports - Team Sports - Tennis - Tennis Rackets (123)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Professional Tennis Racket', 'Graphite tennis racket', 199.99, 'ACTIVE', 123),
('Beginner Tennis Racket', 'Aluminum tennis racket', 49.99, 'ACTIVE', 123),
('Tennis Racket String', 'Professional tennis string', 19.99, 'ACTIVE', 123);

-- Products for Sports - Team Sports - Tennis - Tennis Balls (124)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Professional Tennis Balls', 'Can of 3 professional balls', 9.99, 'ACTIVE', 124),
('Practice Tennis Balls', 'Bulk practice tennis balls', 24.99, 'ACTIVE', 124),
('Pressureless Tennis Balls', 'Long-lasting pressureless balls', 19.99, 'ACTIVE', 124);

-- Products for Sports - Team Sports - Tennis - Tennis Apparel (125)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Tennis Skirt', 'Women tennis skirt with shorts', 39.99, 'ACTIVE', 125),
('Tennis Polo Shirt', 'Moisture-wicking tennis polo', 34.99, 'ACTIVE', 125),
('Tennis Headband', 'Sweat-wicking tennis headband', 9.99, 'ACTIVE', 125);

-- Products for Sports - Water Sports - Swimming - Swimwear (126)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Swimsuit', 'One-piece women swimsuit', 49.99, 'ACTIVE', 126),
('Swim Trunks', 'Men quick-dry swim trunks', 34.99, 'ACTIVE', 126),
('Bikini Set', 'Two-piece bikini set', 39.99, 'ACTIVE', 126);

-- Products for Sports - Water Sports - Swimming - Swim Accessories (127)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Swimming Goggles', 'Anti-fog swimming goggles', 24.99, 'ACTIVE', 127),
('Swim Cap', 'Silicone swim cap', 12.99, 'ACTIVE', 127),
('Pool Noodle', 'Floatable pool noodle', 9.99, 'ACTIVE', 127);

-- Products for Sports - Water Sports - Swimming - Pool Equipment (128)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Pool Skimmer', 'Pool cleaning skimmer net', 19.99, 'ACTIVE', 128),
('Pool Vacuum', 'Automatic pool vacuum cleaner', 199.99, 'ACTIVE', 128),
('Pool Test Kit', 'Water testing kit for pools', 29.99, 'ACTIVE', 128);

-- Products for Sports - Water Sports - Surfing - Surfboards (129)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Longboard Surfboard', '9-foot longboard surfboard', 599.99, 'ACTIVE', 129),
('Shortboard Surfboard', '6-foot shortboard', 499.99, 'ACTIVE', 129),
('Foam Beginner Board', 'Soft-top beginner surfboard', 299.99, 'ACTIVE', 129);

-- Products for Sports - Water Sports - Surfing - Surf Accessories (130)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Surfboard Leash', 'Surfboard ankle leash', 24.99, 'ACTIVE', 130),
('Surf Wax', 'Base and top coat surf wax', 9.99, 'ACTIVE', 130),
('Surfboard Bag', 'Protective surfboard travel bag', 79.99, 'ACTIVE', 130);

-- Products for Sports - Water Sports - Surfing - Wetsuits (131)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Full Wetsuit', '3mm full-body wetsuit', 199.99, 'ACTIVE', 131),
('Spring Suit', 'Shorty wetsuit for warm water', 149.99, 'ACTIVE', 131),
('Rash Guard', 'UV-protection rash guard', 39.99, 'ACTIVE', 131);

-- Products for Sports - Water Sports - Kayaking - Kayaks (132)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Recreational Kayak', '10-foot recreational kayak', 499.99, 'ACTIVE', 132),
('Touring Kayak', '14-foot touring kayak', 799.99, 'ACTIVE', 132),
('Inflatable Kayak', 'Portable inflatable kayak', 299.99, 'ACTIVE', 132);

-- Products for Sports - Water Sports - Kayaking - Paddles (133)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Kayak Paddle', 'Adjustable kayak paddle', 89.99, 'ACTIVE', 133),
('Lightweight Paddle', 'Carbon fiber kayak paddle', 149.99, 'ACTIVE', 133),
('Youth Paddle', 'Shorter paddle for kids', 49.99, 'ACTIVE', 133);

-- Products for Sports - Water Sports - Kayaking - Kayak Accessories (134)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Life Vest', 'USCG-approved life vest', 59.99, 'ACTIVE', 134),
('Dry Bag', 'Waterproof dry storage bag', 34.99, 'ACTIVE', 134),
('Kayak Cart', 'Portable kayak transport cart', 79.99, 'ACTIVE', 134);

-- Products for Clothing - Kids - Boys - Boys T-Shirts (139)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Boys Graphic Tee', 'Cool graphic print t-shirt', 19.99, 'ACTIVE', 139),
('Boys Polo Shirt', 'Classic polo shirt for boys', 24.99, 'ACTIVE', 139),
('Boys Long Sleeve Tee', 'Comfortable long sleeve shirt', 22.99, 'ACTIVE', 139);

-- Products for Clothing - Kids - Boys - Boys Pants (140)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Boys Jeans', 'Durable denim jeans for boys', 34.99, 'ACTIVE', 140),
('Boys Cargo Pants', 'Functional cargo pants', 29.99, 'ACTIVE', 140),
('Boys Athletic Shorts', 'Comfortable athletic shorts', 19.99, 'ACTIVE', 140);

-- Products for Clothing - Kids - Boys - Boys Outerwear (141)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Boys Winter Jacket', 'Warm winter jacket', 59.99, 'ACTIVE', 141),
('Boys Hoodie', 'Cozy pullover hoodie', 34.99, 'ACTIVE', 141),
('Boys Rain Jacket', 'Waterproof rain jacket', 44.99, 'ACTIVE', 141);

-- Products for Clothing - Kids - Girls - Girls Dresses (142)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Girls Party Dress', 'Elegant party dress', 39.99, 'ACTIVE', 142),
('Girls Summer Dress', 'Lightweight summer dress', 29.99, 'ACTIVE', 142),
('Girls Casual Dress', 'Everyday casual dress', 24.99, 'ACTIVE', 142);

-- Products for Clothing - Kids - Girls - Girls Tops (143)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Girls Blouse', 'Pretty blouse for girls', 27.99, 'ACTIVE', 143),
('Girls T-Shirt', 'Colorful t-shirt for girls', 19.99, 'ACTIVE', 143),
('Girls Tank Top', 'Comfortable tank top', 16.99, 'ACTIVE', 143);

-- Products for Clothing - Kids - Girls - Girls Bottoms (144)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Girls Leggings', 'Stretchy leggings for girls', 22.99, 'ACTIVE', 144),
('Girls Jeans', 'Denim jeans for girls', 32.99, 'ACTIVE', 144),
('Girls Skirt', 'Cute skirt for girls', 24.99, 'ACTIVE', 144);

-- Products for Clothing - Kids - Baby - Onesies (145)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Baby Bodysuit Set', 'Set of 5 baby onesies', 29.99, 'ACTIVE', 145),
('Organic Cotton Onesie', 'Soft organic cotton onesie', 14.99, 'ACTIVE', 145),
('Long Sleeve Onesie', 'Warm long sleeve bodysuit', 16.99, 'ACTIVE', 145);

-- Products for Clothing - Kids - Baby - Baby Sleepwear (146)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Baby Pajama Set', 'Cozy 2-piece pajama set', 19.99, 'ACTIVE', 146),
('Sleep Sack', 'Wearable blanket sleep sack', 24.99, 'ACTIVE', 146),
('Footed Pajamas', 'One-piece footed pajamas', 22.99, 'ACTIVE', 146);

-- Products for Clothing - Kids - Baby - Baby Accessories (147)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Baby Sun Hat', 'UV-protection sun hat', 12.99, 'ACTIVE', 147),
('Baby Bib Set', 'Set of 5 feeding bibs', 14.99, 'ACTIVE', 147),
('Baby Socks', 'Soft baby socks pack', 9.99, 'ACTIVE', 147);

-- Products for Clothing - Kids - Unisex - Kids Activewear (148)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Kids Athletic Shorts', 'Unisex athletic shorts', 18.99, 'ACTIVE', 148),
('Kids Sports Tee', 'Moisture-wicking sports shirt', 19.99, 'ACTIVE', 148),
('Kids Track Pants', 'Comfortable track pants', 24.99, 'ACTIVE', 148);

-- Products for Clothing - Kids - Unisex - Kids Pajamas (149)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Kids Pajama Set', 'Cozy unisex pajama set', 22.99, 'ACTIVE', 149),
('Kids Nightgown', 'Comfortable nightgown', 19.99, 'ACTIVE', 149),
('Kids Robe', 'Soft kids bath robe', 29.99, 'ACTIVE', 149);

-- Products for Clothing - Kids - Unisex - Kids Underwear (150)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Kids Underwear Pack', 'Pack of 6 underwear', 16.99, 'ACTIVE', 150),
('Kids Socks Pack', 'Pack of 8 socks', 12.99, 'ACTIVE', 150),
('Kids Undershirt Pack', 'Pack of 3 undershirts', 14.99, 'ACTIVE', 150);

-- Products for Electronics - Computers - Accessories - Keyboards & Mice (151)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('Mechanical Keyboard', 'RGB mechanical gaming keyboard', 129.99, 'ACTIVE', 151),
('Wireless Mouse', 'Ergonomic wireless mouse', 49.99, 'ACTIVE', 151),
('Keyboard and Mouse Combo', 'Wireless keyboard and mouse set', 79.99, 'ACTIVE', 151);

-- Products for Electronics - Computers - Accessories - Monitors (152)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('27-inch 4K Monitor', 'Ultra HD 4K computer monitor', 399.99, 'ACTIVE', 152),
('Gaming Monitor', '144Hz gaming monitor', 299.99, 'ACTIVE', 152),
('Ultrawide Monitor', '34-inch ultrawide curved monitor', 599.99, 'ACTIVE', 152);

-- Products for Electronics - Computers - Accessories - Storage Devices (153)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('1TB External SSD', 'Portable external solid state drive', 129.99, 'ACTIVE', 153),
('2TB External HDD', 'Portable external hard drive', 79.99, 'ACTIVE', 153),
('USB Flash Drive', '64GB USB 3.0 flash drive', 19.99, 'ACTIVE', 153);

-- Products for Electronics - Computers - Accessories - Cables & Adapters (154)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('USB-C Cable', '6-foot USB-C charging cable', 14.99, 'ACTIVE', 154),
('HDMI Cable', 'High-speed HDMI 2.1 cable', 19.99, 'ACTIVE', 154),
('USB Hub', '4-port USB 3.0 hub', 24.99, 'ACTIVE', 154);

-- Products for Electronics - Computers - Accessories - Webcams (155)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('4K Webcam', 'Ultra HD 4K webcam', 149.99, 'ACTIVE', 155),
('1080p Webcam', 'Full HD webcam with microphone', 79.99, 'ACTIVE', 155),
('Streaming Webcam', 'Professional streaming webcam', 199.99, 'ACTIVE', 155);

-- Products for Electronics - Computers - Accessories - Docking Stations (156)
INSERT INTO products (name, short_description, price, status, category_id) VALUES
('USB-C Docking Station', 'Multi-port USB-C dock', 149.99, 'ACTIVE', 156),
('Thunderbolt Dock', 'Thunderbolt 3 docking station', 249.99, 'ACTIVE', 156),
('Laptop Docking Station', 'Universal laptop dock', 199.99, 'ACTIVE', 156);
