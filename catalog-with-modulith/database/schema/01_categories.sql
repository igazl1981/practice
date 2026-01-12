-- Categories Table with Hierarchical Structure
-- Uses materialized path pattern for efficient descendant queries

CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255) NULL,
    parent_id BIGINT NULL,
    path VARCHAR(1000) NOT NULL DEFAULT '/',
    level INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE CASCADE,
    INDEX idx_parent_id (parent_id),
    INDEX idx_path (path(255)),
    INDEX idx_level (level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Trigger to automatically update path after insert
-- Note: In production, you might want to handle this in application code for better control
DELIMITER $$

CREATE TRIGGER IF NOT EXISTS update_category_path_after_insert
AFTER INSERT ON categories
FOR EACH ROW
BEGIN
    DECLARE parent_path VARCHAR(1000);
    DECLARE parent_level INT;
    
    IF NEW.parent_id IS NULL THEN
        UPDATE categories SET 
            path = CONCAT('/', NEW.id),
            level = 0
        WHERE id = NEW.id;
    ELSE
        SELECT path, level INTO parent_path, parent_level
        FROM categories WHERE id = NEW.parent_id;
        
        UPDATE categories SET 
            path = CONCAT(parent_path, '/', NEW.id),
            level = parent_level + 1
        WHERE id = NEW.id;
    END IF;
END$$

DELIMITER ;

-- Function to get all descendant category IDs (including the category itself)
-- This can be used in queries to find all products under a category and its subcategories
DELIMITER $$

CREATE FUNCTION IF NOT EXISTS get_category_descendants(category_id BIGINT)
RETURNS TEXT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE category_path VARCHAR(1000);
    SELECT path INTO category_path FROM categories WHERE id = category_id;
    RETURN category_path;
END$$

DELIMITER ;

