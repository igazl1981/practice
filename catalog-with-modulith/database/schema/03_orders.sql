-- Orders Table

CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    delivery_date DATE NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_delivery_date (delivery_date),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Order Items Table

CREATE TABLE IF NOT EXISTS order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    purchased_price DECIMAL(10, 2) NOT NULL CHECK (purchased_price >= 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- View to get orders with item details
CREATE OR REPLACE VIEW orders_with_items AS
SELECT 
    o.id AS order_id,
    o.total_amount,
    o.delivery_date,
    o.status AS order_status,
    o.created_at AS order_created_at,
    oi.id AS item_id,
    oi.product_id,
    p.name AS product_name,
    oi.purchased_price,
    oi.quantity,
    (oi.purchased_price * oi.quantity) AS item_total,
    oi.created_at AS item_created_at
FROM orders o
LEFT JOIN order_items oi ON o.id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.id;

-- Trigger to validate order total matches sum of order items
-- Note: This is a simplified validation. In production, you might want to handle this in application code
DELIMITER $$

CREATE TRIGGER IF NOT EXISTS validate_order_total
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    -- This trigger would need to be enhanced to check against order_items
    -- For now, it's a placeholder for application-level validation
END$$

DELIMITER ;

