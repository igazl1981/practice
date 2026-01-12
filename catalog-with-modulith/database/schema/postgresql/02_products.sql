-- Products Table (PostgreSQL Version)

CREATE TABLE IF NOT EXISTS products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    short_description VARCHAR(500),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE', 'DISCONTINUED')),
    category_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_category_id ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_status ON products(status);
CREATE INDEX IF NOT EXISTS idx_name ON products(name);

-- Function to update updated_at timestamp
CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- View to get products with category information including category path
CREATE OR REPLACE VIEW products_with_category AS
SELECT 
    p.id,
    p.name,
    p.short_description,
    p.price,
    p.status,
    p.category_id,
    c.name AS category_name,
    c.path AS category_path,
    c.level AS category_level,
    p.created_at,
    p.updated_at
FROM products p
JOIN categories c ON p.category_id = c.id;

