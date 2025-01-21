<%@ page language="java" contentType="text/html; charset=UTF-16"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="com.food.model.dao.model.Menu" %>
<%@ page import="com.food.model.dao.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fab Food - Home</title>
    <link rel="icon" type="image/webp" href="fabfood.webp">
    <style>
        /* General Page Styles */
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f7f3e9;
            background: url('https://static.vecteezy.com/system/resources/previews/006/400/482/non_2x/food-delivery-application-online-on-mobile-3d-illustration-photo.jpg') no-repeat center center/cover;
            color: #333;
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ff5722;
            color: white;
            padding: 15px 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-size: 2em;
            font-weight: bold;
        }

        nav {
            display: flex;
            gap: 15px;
        }

        nav a {
            font-weight: bold;
            color: white;
            text-decoration: none;
            font-size: 1.5em;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        /* Search Bar */
        .search-bar-container {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .search-bar {
            width: 50%;
            padding: 12px;
            font-size: 1em;
            border-radius: 5px;
            border: 1px solid #ddd;
            transition: all 0.3s ease;
        }

        .search-bar:focus {
            outline: none;
            border-color: #ff5722;
            box-shadow: 0 0 8px rgba(255, 87, 34, 0.3);
        }

        .search-btn {
            background-color: #ff5722;
            color: white;
            padding: 12px 20px;
            border: none;
            font-size: 1em;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
            margin-left: 10px;
        }

        .search-btn:hover {
            background-color: #e64a19;
        }

        /* Menu and Restaurant Cards Grid */
        .menu-container, .restaurant-container {
            display: grid;
            grid-template-columns: repeat(3, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px;
            margin: 0 auto;
            max-width: 1200px;
        }

        /* Card Styles */
        .card, .menu-card, .restaurant-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover, .menu-card:hover, .restaurant-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .card img, .menu-card img, .restaurant-card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .card-info, .menu-info, .restaurant-info {
            padding: 15px;
            text-align: center;
        }

        .card-info h3, .menu-info h3, .restaurant-info h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #2c3e50;
        }

        .card-info p, .menu-info p, .restaurant-info p {
            color: #555;
            font-size: 14px;
        }

        .price {
            font-size: 16px;
            font-weight: bold;
            color: #e74c3e;
        }

        .rating {
            font-size: 14px;
            color: #f39c12;
            font-weight: bold;
        }

        .menu-info button, .restaurant-info button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .menu-info button:hover, .restaurant-info button:hover {
            background-color: #e64a19;
        }

        /* Quantity Control */
        .quantity-controls {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 10px;
        }

        .quantity-controls button {
            background-color: #e64a19;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 1.5em;
            cursor: pointer;
            border-radius: 5px;
        }

        .quantity-controls input {
            width: 40px;
            text-align: center;
            font-size: 1em;
            margin: 0 10px;
        }

        /* Section Titles */
        .section-title {
            font-size: 2em;
            font-weight: bold;
            color: #ff5722;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Footer */
        footer {
            background-color: #333;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 14px;
            margin-top: 20px;
        }

        footer a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            transition: all 0.3s ease;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">FabFood</div>
        <nav>
            <a href="login.jsp">Home</a>
            <a href="login.jsp">Order Food</a>
            <a href="login.jsp">Cart</a>
        </nav>
    </header>

    <div class="search-bar-container">
        <input type="text" class="search-bar" placeholder="Search for food or restaurants..." id="search-input">
        <button class="search-btn" onclick="searchFood()">Search</button>
    </div>

    <!-- Menu Items Section -->
    <div class="section">
        <h2 class="section-title">Popular Menu Items</h2>
        <div class="menu-container">
            <% 
            	@SuppressWarnings("unchecked")
                List<Menu> menus = (List<Menu>) session.getAttribute("menus");
                byte val = 0;
                if (menus != null && !menus.isEmpty()) {
                    for (Menu item : menus) { 
                    	if(val >= 3) break;
                        String base64Image = Base64.getEncoder().encodeToString(item.getImage());
            %>
            <div class="menu-card">
                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= item.getName() %>">
                <div class="menu-info">
                    <h3><%= item.getName() %></h3>
                    <p><%= item.getDescription() %></p>
                    <p class="price">₹<%= item.getPrice() %></p>
                    <p class="rating">Rating: <%= item.getRating() %> ⭐</p>
                    <form action="AddToCart" method="post" style="display: inline;">
                        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                        <input type="number" name="addToCartQuantity-<%= item.getMenuId() %>" value="1" style="display:none">
                        <button type="submit">Add to Cart</button>
                    </form>
                    <form action="AddAndPay" method="post" style="display: inline;">
                        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                        <input type="number" name="orderNowQuantity-<%= item.getMenuId() %>" value="1" style="display:none">
                        <button type="submit">Order Now</button>
                    </form>
                </div>
            </div>
            <% val++;} } else { %>
            <p style="text-align:center; color:#888;">No menu items available.</p>
            <% } %>
        </div>
    </div>

    <!-- Restaurant Section -->
    <div class="section">
        <h2 class="section-title">Restaurants</h2>
        <div class="restaurant-container">
            <% 
                val = 0;
                List<Restaurant> restaurants = (List<Restaurant>) session.getAttribute("restaurants");
                if (restaurants != null && !restaurants.isEmpty()) {
                    for (Restaurant restaurant : restaurants) { 
                    	if(val >= 3) break;
                        String base64Image = Base64.getEncoder().encodeToString(restaurant.getImage());
            %>
            <div class="restaurant-card">
                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= restaurant.getName() %>">
                <div class="restaurant-info">
                    <h3><%= restaurant.getName() %></h3>
                    <p><%= restaurant.getCuisineType() %></p> <!-- Corrected the closing parenthesis here -->
                    <button>View Menu</button>
                </div>
            </div>
            <% val++;} } else { %>
            <p style="text-align:center; color:#888;">No restaurants available.</p>
            <% } %>
        </div>
    </div>

    <footer>&copy; 2025 FabFood. All rights reserved.</footer>

    <script>
        function searchFood() {
            const searchTerm = document.getElementById("search-input").value;
            alert("Searching for: " + searchTerm);
        }
    </script>
</body>
</html>