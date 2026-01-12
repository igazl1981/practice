-- Categories Table with Hierarchical Structure (PostgreSQL Version)
-- Uses materialized path pattern for efficient descendant queries

CREATE TABLE IF NOT EXISTS categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255) NULL,
    parent_id BIGINT NULL,
    path VARCHAR(1000) NOT NULL DEFAULT '/',
    level INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_parent_id ON categories(parent_id);
CREATE INDEX IF NOT EXISTS idx_path ON categories(path);
CREATE INDEX IF NOT EXISTS idx_level ON categories(level);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to automatically set path and level after insert
CREATE OR REPLACE FUNCTION set_category_path()
RETURNS TRIGGER AS $$
DECLARE
    parent_path VARCHAR(1000);
    parent_level INT;
BEGIN
    IF NEW.parent_id IS NULL THEN
        NEW.path := '/' || NEW.id::TEXT;
        NEW.level := 0;
    ELSE
        SELECT path, level INTO parent_path, parent_level
        FROM categories WHERE id = NEW.parent_id;
        
        NEW.path := parent_path || '/' || NEW.id::TEXT;
        NEW.level := parent_level + 1;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_category_path_trigger
BEFORE INSERT ON categories
FOR EACH ROW
EXECUTE FUNCTION set_category_path();

-- Function to get all descendant category IDs (including the category itself)
CREATE OR REPLACE FUNCTION get_category_descendants(category_id BIGINT)
RETURNS TEXT AS $$
DECLARE
    category_path VARCHAR(1000);
BEGIN
    SELECT path INTO category_path FROM categories WHERE id = category_id;
    RETURN category_path;
END;
$$ LANGUAGE plpgsql;

