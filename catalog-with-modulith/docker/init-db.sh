#!/bin/bash
set -e

echo "=========================================="
echo "Initializing Learn Modulith Database"
echo "=========================================="

# Wait for PostgreSQL to be ready
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 1
done

echo "PostgreSQL is ready. Setting up database..."

# Execute schema files in order
echo ""
echo "Creating schema..."
echo "  - Creating categories table..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/schema/postgresql/01_categories.sql

echo "  - Creating products table..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/schema/postgresql/02_products.sql

echo "  - Creating orders and order_items tables..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/schema/postgresql/03_orders.sql

# Execute data files in order
echo ""
echo "Loading test data..."
echo "  - Loading categories data..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/data/01_categories_data.sql

echo "  - Loading products data..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/data/02_products_data.sql

echo "  - Loading orders data..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/data/03_orders_data.sql

echo "  - Filling empty categories with subcategories and products..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < /database/data/04_fill_empty_categories.sql

# Reset sequences
echo ""
echo "Resetting sequences..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    SELECT setval('categories_id_seq', (SELECT MAX(id) FROM categories));
    SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));
    SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));
    SELECT setval('order_items_id_seq', (SELECT MAX(id) FROM order_items));
EOSQL

echo ""
echo "=========================================="
echo "Database initialization completed!"
echo "=========================================="
echo ""
echo "Database: $POSTGRES_DB"
echo "User: $POSTGRES_USER"
echo ""
echo "You can now connect to the database."

