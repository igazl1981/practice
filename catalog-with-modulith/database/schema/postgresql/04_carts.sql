-- Carts Table (PostgreSQL Version)

CREATE TABLE IF NOT EXISTS carts (
    id BIGSERIAL PRIMARY KEY,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'SUBMITTED', 'CANCELLED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_status ON carts(status);
CREATE INDEX IF NOT EXISTS idx_created_at ON carts(created_at);

-- Function to update updated_at timestamp
CREATE TRIGGER update_carts_updated_at BEFORE UPDATE ON carts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Cart Items Table

CREATE TABLE IF NOT EXISTS cart_items (
    id BIGSERIAL PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_item_cart FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_item_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    UNIQUE (cart_id, product_id)
);

CREATE INDEX IF NOT EXISTS idx_cart_id ON cart_items(cart_id);
CREATE INDEX IF NOT EXISTS idx_product_id ON cart_items(product_id);

-- Function to update updated_at timestamp
CREATE TRIGGER update_cart_items_updated_at BEFORE UPDATE ON cart_items
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- View to get carts with item details
CREATE OR REPLACE VIEW carts_with_items AS
SELECT 
    c.id AS cart_id,
    c.status AS cart_status,
    c.created_at AS cart_created_at,
    c.updated_at AS cart_updated_at,
    ci.id AS item_id,
    ci.product_id,
    p.name AS product_name,
    p.price AS product_price,
    ci.quantity,
    (p.price * ci.quantity) AS item_total,
    ci.created_at AS item_created_at,
    ci.updated_at AS item_updated_at
FROM carts c
LEFT JOIN cart_items ci ON c.id = ci.cart_id
LEFT JOIN products p ON ci.product_id = p.id;
