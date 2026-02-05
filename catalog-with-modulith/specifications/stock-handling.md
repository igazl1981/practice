# Stock handling 

When a customer submits and order the product stock is updated and an event is generated for every product where the stock went under 0.

I want to handle these products and update a stock or stock-orders table.

# New module

Lets create a new module in the backend: stock.

This module is responsible for creating stock-orders and save all the products and quantities, so we can order it later and fill up the stock.

## Database

The stock-orders are stored in a table which has this structure:

- ID - could be autoincrement
- created at as a timestamp
- status - OPEN, PENDING, CLOSED
- products - which is a JSON field where the product ID and the amount we are under 0

## Handling low stock events

Whenever a new ProductStockLowEvent occures:
- finds the latest still open stock-order
- if none exists or all closed it creates a new one
- updates the stock-order with the product id and the quantity
- if the product is already there just update the missing quantity


## Scheduled JOB for ordering

The scheduled job runs every 5 minutes and checks for open/new stock-orders

If an order is open it generates a file in the root that contains
- Order ID
- Current Date and Time (until minutes)
- List of products with name and quantity to order
- It orders some more then the missing amount
- the extra amount is configurable from settings (use ConfigurationProperties)

How to calculate extra amount:

- use the missing amount 
- check how many times it can be devided by 3
- use the result (whole number) as the extra amount

The job updates the quantity in the stock-order for the products and adds the extra amount.

The job sets the status to PENDING when the file is created and rolls back if the file creation failed.

## Scheduled JOB for stock reload

This job is responsible for restocking the missing products.

It runs every 5 minutes and checks for PENDING stock-orders that are older than 10 minutes.

For every order:
- Update the product stock and add the amount stored in stock-order
- Update the stock-order status to CLOSED

