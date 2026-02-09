# Docker Setup

This directory contains Docker Compose configuration for running PostgreSQL locally with automatic database initialization.

## Prerequisites

- Docker Desktop (or Docker Engine + Docker Compose)
- Docker Compose v2 (or docker-compose v1.29+)

## Quick Start

1. **Create environment file** (optional, uses defaults if not present):
   ```bash
   # Create .env file with custom values, or use defaults
   cat > .env << EOF
   POSTGRES_DB=learn_modulith
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=postgres
   POSTGRES_PORT=5432
   EOF
   ```

2. **Start the database**:
   ```bash
   docker-compose up -d
   ```

3. **Check logs**:
   ```bash
   docker-compose logs -f postgres
   ```

4. **Connect to the database**:
   ```bash
   docker-compose exec postgres psql -U postgres -d learn_modulith
   ```

## Configuration

Edit `.env` file to customize:
- `POSTGRES_DB` - Database name (default: `learn_modulith`)
- `POSTGRES_USER` - Database user (default: `postgres`)
- `POSTGRES_PASSWORD` - Database password (default: `postgres`)
- `POSTGRES_PORT` - Host port mapping (default: `5432`)
- `PROMETHEUS_PORT` - Prometheus UI port (default: `9090`)
- `GRAFANA_PORT` - Grafana UI port (default: `3000`)
- `GRAFANA_ADMIN_USER` / `GRAFANA_ADMIN_PASSWORD` - Grafana login (default: `admin` / `admin`)

## Prometheus & Grafana (metrics)

The stack includes Prometheus and Grafana for metrics when the backend runs **on the host** (e.g. `./mvnw spring-boot:run` from `backend/`).

1. Start the backend locally (from `backend/`): `./mvnw spring-boot:run`
2. Start Docker services: `docker-compose up -d`
3. **Prometheus** scrapes the backend at `http://host.docker.internal:8080/actuator/prometheus` (scrape config in `prometheus.yml`)
4. Open **Grafana**: http://localhost:3000 (login: `admin` / `admin`)
5. In Grafana: **Connections → Data sources → Add data source → Prometheus**. Set URL to `http://prometheus:9090`, Save & test.
6. Create dashboards or import existing ones (e.g. JVM or Spring Boot dashboards from Grafana.com).

Prometheus UI: http://localhost:9090

## How It Works

1. **PostgreSQL Container**: Starts PostgreSQL 16 Alpine image
2. **Automatic Initialization**: The `init-db.sh` script is executed automatically on first startup:
   - Executes schema files from `../database/schema/postgresql/` in order
   - Loads test data from `../database/data/` in order
   - Resets sequences to continue auto-increment from the highest ID
3. **Data Persistence**: Database data is stored in a Docker volume `postgres_data`
4. **Volume Mounts**: The entire `../database/` directory is mounted read-only for initialization scripts

## Commands

### Start services
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### Stop and remove volumes (⚠️ deletes all data)
```bash
docker-compose down -v
```

### View logs
```bash
docker-compose logs -f postgres
```

### Execute SQL commands
```bash
docker-compose exec postgres psql -U postgres -d learn_modulith -c "SELECT COUNT(*) FROM categories;"
```

### Access PostgreSQL shell
```bash
docker-compose exec postgres psql -U postgres -d learn_modulith
```

### Backup database
```bash
docker-compose exec postgres pg_dump -U postgres learn_modulith > backup.sql
```

### Restore database
```bash
docker-compose exec -T postgres psql -U postgres learn_modulith < backup.sql
```

## Connection String

For Spring Boot application (`application.yml`):
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/learn_modulith
    username: postgres
    password: postgres
    driver-class-name: org.postgresql.Driver
```

## Troubleshooting

### Port already in use
If port 5432 is already in use, change `POSTGRES_PORT` in `.env` file:
```bash
POSTGRES_PORT=5433
```

### Reset database
To completely reset the database:
```bash
docker-compose down -v
docker-compose up -d
```

### Check if database is ready
```bash
docker-compose exec postgres pg_isready -U postgres
```

### View database size
```bash
docker-compose exec postgres psql -U postgres -d learn_modulith -c "SELECT pg_size_pretty(pg_database_size('learn_modulith'));"
```

## File Structure

```
docker/
├── docker-compose.yml    # Docker Compose configuration (postgres, prometheus, grafana)
├── prometheus.yml        # Prometheus scrape config for catalog backend
├── init-db.sh            # Database initialization script (executable)
├── reset-sequences.sql   # SQL script to reset sequences (used by init-db.sh)
├── .gitignore            # Git ignore file (excludes .env)
└── README.md             # This file
```

The initialization script mounts the `../database/` directory and executes:
- Schema files: `database/schema/postgresql/*.sql`
- Data files: `database/data/*.sql`

## Notes

- The database initialization happens only on first startup (when the data volume is empty)
- To reinitialize, you need to remove the volume: `docker-compose down -v`
- Schema files are executed in alphabetical order
- Data files are executed after schema files
- The PostgreSQL container includes health checks for better orchestration

