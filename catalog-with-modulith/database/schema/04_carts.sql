-- Carts Table

CREATE TABLE IF NOT EXISTS carts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    status ENUM('ACTIVE', 'SUBMITTED', 'CANCELLED') NOT NULL DEFAULT 'ACTIVE',
    total_price DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (total_price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cart Items Table

CREATE TABLE IF NOT EXISTS cart_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_item_cart FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_item_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    UNIQUE KEY uk_cart_product (cart_id, product_id),
    INDEX idx_cart_id (cart_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- View to get carts with item details
CREATE OR REPLACE VIEW carts_with_items AS
SELECT 
    c.id AS cart_id,
    c.status AS cart_status,
    c.total_price AS cart_total_price,
    c.created_at AS cart_created_at,
    c.updated_at AS cart_updated_at,
    ci.id AS item_id,
    ci.product_id,
    p.name AS product_name,
    ci.price AS item_price,
    ci.quantity,
    (ci.price * ci.quantity) AS item_total,
    ci.created_at AS item_created_at,
    ci.updated_at AS item_updated_at
FROM carts c
LEFT JOIN cart_items ci ON c.id = ci.cart_id
LEFT JOIN products p ON ci.product_id = p.id;
