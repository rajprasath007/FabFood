<%@page import="com.food.model.dao.pojo.CartItem"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Base64"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (request.getSession().getAttribute("uId") == null) {
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title style="align">Shopping Cart</title>
    <link rel="icon" type="image/webp" href="fabfood.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f7f3e9;
            color: #333;
        }

        header {
        display: flex;
        justify-content: space-between;  /* Positioning the "Back" button to the left and centering "Shopping Cart" */
        align-items: center;
        background-color: #ff5722;
        color: white;
        padding: 15px 20px;
        font-size: 1.8em;
        position: relative;
    }

    header a {
        text-decoration: none;
        color: white;
        font-size: 1em;
        font-weight: bold;
        padding: 10px 15px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    header a:hover {
        background-color: #e64a19;
    }

    header .cart-title {
        flex-grow: 1;
        text-align: center;
        font-size: 1.3em;
    }

        .cart-container {
            max-width: 800px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .cart-details {
            flex: 1;
            margin-left: 20px;
        }

        .cart-details h3 {
            margin: 0;
            font-size: 1.2em;
            color: #2c3e50;
        }

        .cart-details p {
            margin: 5px 0;
            color: #555;
        }

        .cart-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cart-actions input {
            width: 50px;
            text-align: center;
        }

        .cart-actions button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .cart-actions button:hover {
            background-color: #e64a19;
        }

        .cart-footer {
            text-align: center;
            margin-top: 20px;
        }

        .cart-footer button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
        }

        .cart-footer button:hover {
            background-color: #e64a19;
        }

        .total-row {
            text-align: right;
            font-size: 1.2em;
            margin: 10px 0;
        }

        .proceed-button {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
        }

        .proceed-button:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
    	<a href="javascript:history.back();">Back</a> <!-- The "Back" button stays left -->
    	<div class="cart-title">Shopping Cart</div> <!-- This will be centered -->
	</header>


    <!-- Cart Container -->
    <div class="cart-container">
        <% 
            Object cartObj = session.getAttribute("cartItems"); 
            
            @SuppressWarnings("unchecked")
            Map<CartItem,Integer> cartItems = (Map<CartItem,Integer>) cartObj;

            float ultimateTotal = 0;

            if (cartItems != null && !cartItems.isEmpty()) {
                for (CartItem item : cartItems.keySet()) {
                    String name = item.getItemName();
                    String restaurantName = item.getRestaurantName(); // Retrieve the restaurant name
                    float price = item.getPrice();
                    int quantity = cartItems.get(item);
                    byte[] imageBytes = item.getImage();

                    String base64Image = "";
                    if (imageBytes != null) {
                        base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    }

                    float itemTotal = price * quantity;
                    ultimateTotal += itemTotal;
        %>
        <!-- Cart Item -->
        <div class="cart-item">
            <img src="<%= imageBytes != null ? "data:image/jpeg;base64," + base64Image : "default-item.jpg" %>" alt="<%= name %>">
            <div class="cart-details">
                <h3><%= name %></h3>
                <p>Restaurant: <%= restaurantName %></p>
                <p>Price: ₹<span id="price-<%= item.getMenuID() %>"><%= price %></span></p>
                <p>Item Total: ₹<span id="total-<%= item.getMenuID() %>"><%= itemTotal %></span></p>
            </div>
            <div class="cart-actions">
                <button onclick="updateQuantity('<%= item.getMenuID() %>', -1)">-</button>
                <input type="text" id="quantity-<%= item.getMenuID() %>" value="<%= quantity %>" readonly>
                <button onclick="updateQuantity('<%= item.getMenuID() %>', 1)">+</button>
                <form action="DeleteCartItem" method="post" style="display: inline;">
                    <input type="hidden" name="cartItemId" value="<%= item.getMenuID() %>">
                    <button type="submit" style="background-color: #e74c3c;">Delete</button>
                </form>
            </div>
        </div>
        <% 
                }
            } else { 
        %>
        <p style="text-align: center; color: #e74c3c;">Your cart is empty.</p>
        <% 
            } 
        %>

        <!-- Ultimate Total -->
        <div class="total-row">
            Total: ₹<span id="ultimate-total"><%= ultimateTotal %></span>
        </div>

        <!-- Cart Footer -->
        <div class="cart-footer">
            <form action="ClearCart" method="post" onsubmit="return confirmClearCart();">
                <button type="submit" style="background-color: #e74c3c;">Clear Cart</button>
            </form>
            <form action="payments.jsp" method="post">
                <button type="submit" class="proceed-button">Proceed to Pay</button>
            </form>
        </div>
    </div>
</body>
  <script>
        function updateQuantity(cartItemId, increment) {
            const quantityInput = document.getElementById('quantity-' + cartItemId);
            const priceElement = document.getElementById('price-' + cartItemId);
            const totalElement = document.getElementById('total-' + cartItemId);
            
            let params = new URLSearchParams();
            params.append("menuId",cartItemId);
            params.append("updateQuantity",increment);
            
            console.log(params.toString());
            
            fetch("UpdateCart", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: params
            }).then(response => response.text())
              .then(data => {
                  console.log(data);
              });

            let quantity = parseInt(quantityInput.value) || 1;
            quantity += increment;
            if (quantity < 1) quantity = 1; // Minimum quantity is 1
            quantityInput.value = quantity;

            // Update item total
            const price = parseFloat(priceElement.textContent);
            const itemTotal = price * quantity;
            totalElement.textContent = itemTotal.toFixed(2);

            // Update ultimate total
            updateUltimateTotal();
        }

        function updateUltimateTotal() {
            let ultimateTotal = 0;
            const itemTotals = document.querySelectorAll('[id^="total-"]');
            itemTotals.forEach(item => {
                ultimateTotal += parseFloat(item.textContent);
            });

            document.getElementById('ultimate-total').textContent = ultimateTotal.toFixed(2);
        }

        function confirmClearCart() {
            return confirm('Are you sure you want to clear the cart? This action cannot be undone.');
        }
    </script>
</html>
