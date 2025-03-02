-- 1)Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
    
    
-- 2)Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
    
-- 3)Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- 4)Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS total_orders
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY total_orders DESC
LIMIT 1;


-- 5)List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name AS pizza_name,
    SUM(order_details.quantity) as quantities
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_name
ORDER BY quantities DESC
LIMIT 5;


-- 6)Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category AS pizza_category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_category
ORDER BY quantity DESC;


-- 7)Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name AS pizza_name,
    SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 3;


-- 8)Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS orders_by_hour,
    COUNT(order_id) AS order_count
FROM
    orders
GROUP BY orders_by_hour;


-- 9)Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pizza_types.category AS category,
    COUNT(pizza_types.name) AS no_of_pizzas
FROM
    pizza_types
GROUP BY category;


-- 10)Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS avg_orders_per_day
FROM
    (SELECT 
        orders.order_date AS order_date,
            SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY order_date) AS order_quantity;