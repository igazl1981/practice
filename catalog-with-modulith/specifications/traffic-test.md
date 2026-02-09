# Load generation

I want to generate some load on the service so I can see the logs selling products and handling the stock orders.

- use k6 for generating some traffic
- the script should handle a complete cart

## Handling cart

The script has to keep track of the carts were created and use that cart to add multiple products (random 2-5 products in 1 cart).

When the desired amount of different products are added submit the cart and forget about that cart.

## Traffic

Generate a fairly normal traffic for local testing.
