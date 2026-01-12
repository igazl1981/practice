-- Orders Table (PostgreSQL Version)

CREATE TABLE IF NOT EXISTS orders (
    id BIGSERIAL PRIMARY KEY,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    delivery_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_delivery_date ON orders(delivery_date);
CREATE INDEX IF NOT EXISTS idx_created_at ON orders(created_at);

-- Function to update updated_at timestamp
CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Order Items Table

CREATE TABLE IF NOT EXISTS order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    purchased_price DECIMAL(10, 2) NOT NULL CHECK (purchased_price >= 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_order_id ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_product_id ON order_items(product_id);

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

