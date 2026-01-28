Desription
===

The file contains specifications how the cart should be implemented on frontend and some modifications on the existing backend.


New cart page
---

The new cart page shows a message if cart is empty.
The message is in the middle of the page horizontally and vertically.

When the cart contains products list them like a table where columns are
1. name of the product
2. price of 1 product
3. quantity
4. the total price of the selected amount of products
5. a trash icon

The product list uses the full width of the page.

After the products show the total on the right of the page.

The page should use a Cart object based on the backend's cart data.

Quantity
---

The quantity is an input field and only accepts numbers.
Whenever the amount changes the backend is called to update the amount of the product and update the total as well.

Trash icon
--- 

The trash icon is here to remove a product from the cart.
It calls the backend and updates the page on backend response.

Navigation - Header icon
---

The new cart page can be reached with an icon in the top header.
The icon should be a cart icon and on the right side of the header.

The icon should show the amount of products in the cart, but no number should appear when the cart does not exist yet or empty. Use the items of the products to count them. Backend doesn't have dedicated field for the amount.

Navigation - Left menu
---

A "Cart" menu is added to the left menu and should leads to the new cart page.

Cart communication with backend
---

The cart and it's ID should be stored in a local storage.
If the storage doesn't have any ID when the 1st product is added the response should contain the ID and use that from that point on.

Note: the backend doesn't have session or user control so the active cart cannot be retrieved.

Backend changes
---

* Add total price to the cart in the database and the relevant models
* The cart items should store the price of the product so whenever the price is changed in the future the submitted carts are not affected
* Whenever the product is added/changed and before the cart is submitted the item prices are updated and the cart total also updated.
* If it's better create a getByIds method on the ProductApi so it returns multiple products with 1 query and the cart can use it.

Cart Cancellation
---

Cart Page contains a RED cancel button.
* it's under the table of the products
* left side in the same line with the total
* when clicked a confirmation pops up
* on confirm it calls the backend cancel endpoint 
* then the page is refreshed.

The backend should set the cart status to cancelled and the endpoint returns 204 because we don't need the cart anymore.

Use QDialog for notifications but don't forget to check if the plugin is enabled.

Cart submission
---

Cart Page has a submit button
* it's under the table of the products
* on the right side of the Total
* When clicked, it's calling the backend's submit endpoint
* the page is refreshed and the car is cleared

The backend saves the cart status to submitted and returns the finalized cart entity

Use QDialog for notification of the submission and don't forget to check if the plugin is enabled

Backend changes:
* On successful cart submission a Spring Modulith event is generated 
* The event contains basic information: product IDs and quantity
* The event is read in the product module
* The product stores the current stock instead of sold_amount
* The product module updates the products from the event and deducts the amount from the stock
* Update the product database structure if necessary
* Update the classes if necessary

* The product module generates and event when the stock goes under 0

