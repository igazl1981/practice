# Learn Modulith

Multi-module project with Spring Boot (Kotlin) backend and Vue.js + Quasar frontend.

## Project Structure

```
learn-modulith/
├── backend/          # Spring Boot Kotlin backend
└── frontend/         # Vue.js + Quasar frontend
```

## Backend

Spring Boot application with Kotlin.

### Running the Backend

```bash
cd backend
mvn spring-boot:run
```

The backend will be available at `http://localhost:8080`

### API Endpoints

- `GET /api/hello` - Returns "Hello World"

## Frontend

Vue.js 3 application with Quasar Framework.

### Setup

```bash
cd frontend
npm install
```

### Running the Frontend

```bash
npm run dev
```

The frontend will be available at `http://localhost:3000`

## Building All Modules

From the root directory:

```bash
# Build backend
cd backend && mvn clean install && cd ..

# Build frontend
cd frontend && npm run build && cd ..
```

