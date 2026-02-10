# Demo Security Boot 3

Spring Security 6 + Spring Boot 3 learning application (Kotlin, Maven).

## Run

```bash
mvn spring-boot:run
```

## Test

```bash
mvn test
```

## Default users (learning only)

In-memory users for form login:

| Username | Password | Role  |
|----------|----------|-------|
| user     | password | USER  |
| admin    | admin    | ADMIN |

- **Public:** `GET /public/hello` (no auth).
- **Authenticated:** `GET /` or `GET /home` (any logged-in user).
- **Admin:** `GET /admin/hello` (ADMIN only).

Login form: `GET /login` (default Spring Security form).
