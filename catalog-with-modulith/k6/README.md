# Load generation (k6)

Generate traffic against the catalog backend to observe logs for selling products and stock order handling.

**Prerequisites:** Install [k6](https://k6.io/docs/get-started/installation/).

**Run** (from this repo root, with backend running on port 8080):

```bash
k6 run -e BASE_URL=http://localhost:8080 load/cart-load.js
```

Or from the `catalog-with-modulith` directory:

```bash
k6 run -e BASE_URL=http://localhost:8080 load/cart-load.js
```

The script creates carts, adds 2–5 products per cart, then submits them. Override `BASE_URL` if your backend runs elsewhere.
