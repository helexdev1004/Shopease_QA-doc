-- ShopEase SQL Validation Queries
-- Author: Afshan Rajabi
-- Purpose: QA database validation for e-commerce workflows

-- 1. Validate all users
SELECT * FROM users;

-- 2. Validate a specific user by email
SELECT * FROM users
WHERE email = 'user@test.com';

-- 3. Check duplicate email accounts
SELECT email, COUNT(*) AS duplicate_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

-- 4. Validate active users
SELECT * FROM users
WHERE status = 'Active';

-- 5. Validate products
SELECT * FROM products;

-- 6. Validate product by SKU
SELECT * FROM products
WHERE sku = 'WM-1001';

-- 7. Validate out-of-stock products
SELECT * FROM products
WHERE stock_quantity = 0;

-- 8. Validate cart items for a user
SELECT * FROM cart
WHERE user_id = 101;

-- 9. Validate cart item quantities
SELECT * FROM cart
WHERE quantity <= 0;

-- 10. Validate cart total calculation
SELECT user_id, SUM(quantity * unit_price) AS cart_total
FROM cart
GROUP BY user_id;

-- 11. Validate completed orders
SELECT * FROM orders
WHERE status = 'Completed';

-- 12. Validate pending orders
SELECT * FROM orders
WHERE status = 'Pending';

-- 13. Validate order details with user information
SELECT o.order_id, u.email, o.status, o.total_amount
FROM orders o
INNER JOIN users u
ON o.user_id = u.user_id;

-- 14. Validate order items with product information
SELECT oi.order_id, p.product_name, oi.quantity, oi.unit_price
FROM order_items oi
INNER JOIN products p
ON oi.product_id = p.product_id;

-- 15. Validate payment records
SELECT * FROM payments;

-- 16. Validate failed payments
SELECT * FROM payments
WHERE payment_status = 'Failed';

-- 17. Validate successful payments
SELECT * FROM payments
WHERE payment_status = 'Completed';

-- 18. Validate orders without payment
SELECT o.order_id, o.status
FROM orders o
LEFT JOIN payments p
ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

-- 19. Validate coupon usage
SELECT * FROM coupons
WHERE is_active = TRUE;

-- 20. Validate expired coupons
SELECT * FROM coupons
WHERE expiration_date < CURRENT_DATE;

-- 21. Count total orders per user
SELECT user_id, COUNT(*) AS total_orders
FROM orders
GROUP BY user_id;

-- 22. Calculate total revenue
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed';

-- 23. Find top selling products
SELECT product_id, SUM(quantity) AS total_sold
FROM order_items
GROUP BY product_id
ORDER BY total_sold DESC;

-- 24. Validate order total against order item total
SELECT o.order_id, o.total_amount, SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount;

-- 25. Validate recently created users
SELECT * FROM users
WHERE created_at >= CURRENT_DATE - INTERVAL '7 days';

-- 26. Validate recently placed orders
SELECT * FROM orders
WHERE created_at >= CURRENT_DATE - INTERVAL '7 days';

-- 27. Validate product price is not negative
SELECT * FROM products
WHERE price < 0;

-- 28. Validate cart quantity does not exceed stock
SELECT c.cart_id, c.product_id, c.quantity, p.stock_quantity
FROM cart c
INNER JOIN products p
ON c.product_id = p.product_id
WHERE c.quantity > p.stock_quantity;

-- 29. Validate deleted products are not visible
SELECT * FROM products
WHERE is_deleted = TRUE;

-- 30. Validate users with no orders
SELECT u.user_id, u.email
FROM users u
LEFT JOIN orders o
ON u.user_id = o.user_id
WHERE o.order_id IS NULL;
