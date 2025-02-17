<%@page import="com.food.model.dao.pojo.CartItem"%>
<%@page import="java.util.TreeMap"%>
<%@page import="com.food.model.dao.model.Menu"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Menu</title>
    <link rel="icon" type="image/webp" href="fabfood.webp">
    <style>
        /* General Page Styles */
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f7f3e9;
            color: #333;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ff5722;
            color: white;
            padding: 15px 20px;
            font-size: 1.8em;
        }

        header a {
            text-decoration: none;
            color: white;
            font-size: 1em;
            font-weight: bold;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            position: relative;
        }

        header a:hover {
            background-color: #e64a19;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 20px;
            height: 20px;
            background-color: red;
            color: white;
            font-size: 12px;
            font-weight: bold;
            text-align: center;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .menu-container {
            display: grid;
            grid-template-columns: repeat(3, minmax(250px, 1fr));
            gap: 40px;
            padding: 20px;
            margin: 0 auto;
            max-width: 80%;
        }

        .menu-card {
            background-color: #f7f3e9;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .menu-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
        }

        .menu-card img {
            display: block;
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }

        .menu-info {
            padding: 15px;
            text-align: center;
        }

        .menu-info h3 {
            margin: 10px 0;
            font-size: 1.2em;
            color: #2c3e50;
        }

        .menu-info p {
            margin: 5px 0;
            color: #555;
            font-size: 0.9em;
        }

        .menu-info .price {
            color: #4caf50;
            font-weight: bold;
        }

        .menu-info .rating {
            color: #ff9800;
            font-weight: bold;
        }

        .quantity-controls {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin: 10px 0;
        }

        .quantity-controls button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 0.9em;
            border-radius: 5px;
            cursor: pointer;
        }

        .quantity-controls button:hover {
            background-color: #e64a19;
        }

        .menu-info button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 0.9em;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
        }

        .menu-info button:hover {
            background-color: #e64a19;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #2c3e50;
            color: white;
            font-size: 0.85em;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div>
            <a href="javascript:history.back();" style="text-decoration: none; color: white; font-size: 1em; font-weight: bold; padding: 10px 15px; border-radius: 5px; transition: background-color 0.3s ease;"> Back</a>
        </div>
        <div style="display: flex; align-items: center;">
            <!-- Cart Section with Notification -->
            <a href="cart.jsp" style="margin-right: 15px; text-decoration: none; color: white; font-size: 1em; font-weight: bold;">
                🛒 Cart
                <!-- Notification Badge -->
                <%
                	@SuppressWarnings("unchecked")
                	TreeMap<CartItem,Integer> cartMap = (TreeMap<CartItem,Integer>)(session.getAttribute("cartItems"));
                %>
                <span class="notification-badge"><%= cartMap == null ? 0 : cartMap.size() %></span> <!-- Example of a notification count -->
            </a>
        </div>
    </header>

    <!-- Menus Section -->
    <div class="menu-container">
        <% 
            Object obj = session.getAttribute("menus"); 
            
            @SuppressWarnings("unchecked")
            List<Menu> menus = (List<Menu>) obj;
            
            if (menus != null && !menus.isEmpty()) {
                for (Menu menu : menus) {
                    String name = menu.getName();
                    String description = menu.getDescription();
                    float price = menu.getPrice();
                    float rating = menu.getRating();
                    byte[] imageBytes = menu.getImage();
                    
                    String base64Image = "";
                    if (imageBytes != null) {
                        base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    }
        %>
        <!-- Card Template -->
        <div class="menu-card">
            <img src="<%= imageBytes != null ? "data:image/jpeg;base64," + base64Image : "default-menu.jpg" %>" alt="<%= name %>" class="menu-image">
            <div class="menu-info">
                <h3><%= name %></h3>
                <p><%= description %></p>
                <p class="price">Price: ₹<%= price %></p>
                <p class="rating">Rating: <%= rating %> ⭐</p>
                <div class="quantity-controls">
                    <button type="button" onclick="updateQuantity('quantity-<%= menu.getMenuId() %>', -1)">-</button>
                    <% 
                     String quantity = "quantity-"+menu.getMenuId();
                    %>
                    <input type="text" id="<%= quantity %>" value="1" readonly style="width: 40px; text-align: center;">
                    <button type="button" onclick="updateQuantity('<%= quantity %>', 1)">+</button>
                </div>
                <form id="addToCartForm" action="AddToCart" method="post" style="display: inline;">
                    <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
                    <% 
                     String addToCartQuantity = "addToCartQuantity-"+menu.getMenuId();
                    %>
                    <input type="number" name="<%= addToCartQuantity %>" id="<%= addToCartQuantity %>" value="1" style="display:none">
                    <button type="submit">Add to Cart</button>
                </form>
                <form action="AddAndPay" method="post" style="display: inline;">
                    <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
                    <% 
                     String orderNowQuantity = "orderNowQuantity-"+menu.getMenuId();
                    %>
                    <input type="number" name="<%= orderNowQuantity %>" id="<%= orderNowQuantity %>" value="1" style="display:none">
                    <button type="submit">Order Now</button>
                </form>
            </div>
        </div>
        <% 
                }
            } else { 
        %>
        <p style="text-align: center; color: #e74c3c;">No menu items available at the moment.</p>
        <% 
            } 
        %>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2024 Foodies. All Rights Reserved.
    </footer>
</body>
<script>
		
		let form = document.getElementById('addToCartForm');
		form.addEventListener("submit",event => {
			event.preventDefault();
			let formData = new FormData(form);
			fetch("AddToCart",{
				method : "POST",
				body : new URLSearchParams(formData)
			}).then(res => res.json()).then(data => {
				alert("Added to cart")
				let cartSize = document.getElementsByClassName('notification-badge')[0];
				cartSize.textContent = data.cartSize;
			});
		})
		
		
        function updateQuantity(inputId, increment) {
            const quantityInput = document.getElementById(inputId);
            let value = parseInt(quantityInput.value) || 1;
            value += increment;
            if (value < 1) value = 1; // Ensure quantity is at least 1
            quantityInput.value = value;

            // Update the hidden fields with the real-time quantity
            const menuId = inputId.split('-')[1];
            document.getElementById('addToCartQuantity-' + menuId).value = value;
            document.getElementById('orderNowQuantity-' + menuId).value = value;
        }
    </script>
</html>