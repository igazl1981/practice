-- Stock Orders Table (PostgreSQL Version)
-- products: JSONB map of product ID (key) to quantity (value)

CREATE TABLE IF NOT EXISTS stock_orders (
    id BIGSERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'PENDING', 'CLOSED')),
    products JSONB NOT NULL DEFAULT '{}'
);

CREATE INDEX IF NOT EXISTS idx_status ON stock_orders(status);
CREATE INDEX IF NOT EXISTS idx_created_at ON stock_orders(created_at);
