<%@ page import="com.security.Secret"%>
<%@ page import="com.food.model.dao.pojo.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="com.security.*" %>
<%@ page import="com.food.model.dao.impl.UserDAOImpl" %>
<%@ page import="com.food.model.dao.model.User"  %>
<%@ page import="com.food.model.dao.model.Restaurant" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Collections" %>
<%
  /*  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
    if(request.getSession().getAttribute("uId") == null) response.sendRedirect("login.jsp");*/
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fab Food - Home</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f7f3e9;
            color: #333;
        }

        header {
            background-color: #ff5722;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header .logo {
            font-size: 24px;
            font-weight: bold;
        }

        header nav a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-size: 20px;
        }

        header nav a:hover {
            text-decoration: underline;
        }

        .search-bar-container {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .search-bar {
            width: 50%;
            padding: 10px;
            font-size: 1em;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .search-btn {
            background-color: #ff5722;
            color: white;
            padding: 10px 15px;
            border: none;
            font-size: 1em;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-left: 10px;
        }

        .search-btn:hover {
            background-color: #e64a19;
        }

        .restaurant-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 20px;
            margin: 0 auto;
            max-width: 1200px;
        }

        .restaurant-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .restaurant-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .restaurant-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .restaurant-info {
            padding: 15px;
            text-align: center;
        }

        .restaurant-info h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #2c3e50;
        }

        .restaurant-info p {
            color: #555;
            font-size: 14px;
        }

        .restaurant-info button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .restaurant-info button:hover {
            background-color: #e64a19;
        }

        footer {
            background-color: #333;
            color: white;
            padding: 20px;
            text-align: center;
        }

        footer a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
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
            <a href="#">Home</a>
            <a href="#">Order Food</a>
            <a href="#">Cart</a>
        </nav>
    </header>

    <div class="search-bar-container">
        <input type="text" class="search-bar" placeholder="Search for food or restaurants..." id="search-input">
        <button class="search-btn" onclick="searchFood()">Search</button>
    </div>

    <div class="restaurant-container">
        <% 
            List<Restaurant> restaurants = (List<Restaurant>) session.getAttribute("restaurants");
            if (restaurants != null && !restaurants.isEmpty()) {
                for (Restaurant restaurant : restaurants) { 
                    byte[] imageBytes = restaurant.getImage();
                    String base64Image = (imageBytes != null) 
                        ? Base64.getEncoder().encodeToString(imageBytes) 
                        : ""; 
        %>
        <div class="restaurant-card">
            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= restaurant.getName() %>">
            <div class="restaurant-info">
                <h3><%= restaurant.getName() %></h3>
                <p><%= restaurant.getCuisineType() %></p>
                <form action="DisplayMenu" method="post">
                    <input type="hidden" name="restaurantId" value="<%= restaurant.getrId() %>">
                    <button type="submit">View Menu</button>
                </form>
            </div>
        </div>
        <% 
                } 
            } else { 
        %>
        <p style="text-align: center; color: #e74c3e;">No restaurants available at the moment.</p>
        <% 
            } 
        %>
    </div>

    <footer>
        <p>&copy; 2025 FabFood. All rights reserved.</p>
        <p><a href="#">Terms & Conditions</a> | <a href="#">Privacy Policy</a> | <a href="#">Contact</a></p>
    </footer>

    <script>
        function searchFood() {
            const searchTerm = document.getElementById("search-input").value;
            alert("Searching for: " + searchTerm);
        }
    </script>
</body>
</html>
