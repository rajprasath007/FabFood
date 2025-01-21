<%@ page language="java" contentType="text/html; charset=UTF-16"
    pageEncoding="UTF-8"%>
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
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
    if(request.getSession().getAttribute("uId") == null) response.sendRedirect("index.jsp");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fab Food Home</title>
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

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ff5722;
            color: white;
            padding: 15px 20px;
            font-size: 2em;
        }

        header span {
            font-weight: bold;
        }

        /* Cart Link Container */
        .cart-link {
            position: relative;
            text-decoration: none;
            color: white;
            font-size: 1em;
            display: flex;
            align-items: center;
            margin-left: 20px;
            padding: 5px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .cart-link:hover {
            background-color: rgba(255, 255, 255, 0.2); /* Slightly transparent white on hover */
            transform: scale(1.02); /* Subtle scaling effect */
        }

        .cart-link img {
            width: 30px;
            height: 30px;
            margin-right: 8px;
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

        /* Profile Section Styles */
        .profile-section {
            display: flex;
            align-items: center;  /* Ensures vertical alignment of elements */
            background-color: transparent;
            transition: background-color 0.3s ease, transform 0.3s ease;
            padding: 5px;
            border-radius: 8px;
            cursor: pointer;
            flex-shrink: 0;
        }
        
        .profile-link{
        	text-decoration: none;
        }

        .profile-pic {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 2px solid white;
            margin-left: 10px;
            margin-top: 5px;
            object-fit: cover;
            transition: transform 0.3s ease, border-color 0.3s ease;
        }

        .profile-name {
            color: white;
            margin-left: 10px;
            font-size: 1em;
            transition: color 0.3s ease;
            display: inline-flex;  /* Make name an inline-flex element to ensure proper vertical alignment */
            align-items: center;   /* Align the text with the profile picture */
            line-height: 40px;     /* Align the profile name with the image */
        }

        .profile-section:hover .profile-pic {
            transform: scale(1.1); /* Slightly enlarge the profile picture */
            border-color: #ff5722; /* Change border color on hover */
        }

        .profile-section:hover .profile-name {
            color: #e64a19; /* Change text color on hover */
        }
        
        #hov{
        	display: none; 
        	position: absolute; 
        	background-color: #333; 
        	color: white; 
        	margin: 5px;
        	padding: 2px; 
        	border-radius: 5px; 
        	font-size: 0.5em;
        }

        .logout-btn {
            background-color: #fff;
            color: #ff5722;
            border: none;
            padding: 8px 15px;
            font-size: 0.9em;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #e64a19;
            color: white;
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
        
        .welcome{
        	text-align: center;
        }

        .restaurant-container {
            display: grid;
            grid-template-columns: repeat(3, minmax(250px, 1fr));
            gap: 40px;
            padding: 20px;
            margin: 0 auto;
            max-width: 80%;
        }

        .restaurant-card {
            background-color: #f7f3e9;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .restaurant-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
        }

        .restaurant-card img {
            display: block;
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }

        .restaurant-info {
            padding: 15px;
            text-align: center;
        }

        .restaurant-info h3 {
            margin: 10px 0;
            font-size: 1.2em;
            color: #2c3e50;
        }

        .restaurant-info p {
            margin: 5px 0;
            color: #555;
            font-size: 0.9em;
        }

        .restaurant-info button {
            background-color: #ff5722;
            color: #fff;
            border: none;
            padding: 10px 15px;
            font-size: 0.9em;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        .restaurant-info button:hover {
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
    	<%
    		UserDAOImpl daoImpl = new UserDAOImpl();
    		int uId = (Integer)session.getAttribute("uId");
    		User user = daoImpl.fetch(uId);
    	%>
        <div>
            Welcome, <span><%= user.getUserName() != null ? user.getUserName() : "Guest" %></span>!
        </div>
        <div style="display: flex; align-items: center;">
          
           <!-- Cart Option -->
            <a href="cart.jsp" class="cart-link">
                <span>🛒 Cart</span>
                <%
                	@SuppressWarnings("unchecked")
                	TreeMap<CartItem,Integer> cartMap = (TreeMap<CartItem,Integer>)(session.getAttribute("cartItems"));
                %>
                <span class="notification-badge"><%= cartMap == null ? 0 : cartMap.size() %></span>
            </a>

            <!-- Order Page Link -->
            <a href="orders.jsp" class="cart-link">
                <span>🍽️ Orders</span>
            </a>

            <!-- Profile Section -->
            <div class="profile-section" style="margin-right: 20px;">
                <a href="profile.jsp" class="profile-link" >
                    <img src="https://www.shutterstock.com/image-vector/profile-icon-vectororange-260nw-591156221.jpg" alt="Profile" class="profile-pic">
                </a>
                <div id="hov"> Profile </div>
            </div>

            <!-- Logout Button -->
            <form action="Logout" method="post" style="margin: 0;">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </header>

    <!-- Search Bar Section -->
    <div class="search-bar-container">
        <input type="text" class="search-bar" placeholder="Search Restaurants..." />
        <button class="search-btn">Search</button>
    </div>

    <!-- Welcome Message -->
    <div class="welcome">
        Find your favorite restaurants and enjoy delicious meals delivered to your doorstep!
    </div>

    <!-- Restaurants Section -->
    <div class="restaurant-container">
        <% 
            Object obj = session.getAttribute("restaurants");
            @SuppressWarnings("unchecked")
            List<Restaurant> restaurants = (List<Restaurant>) obj;
            if (restaurants != null && !restaurants.isEmpty()) {
                for (Restaurant restaurant : restaurants) { 
                    byte[] imageBytes = restaurant.getImage();
                    String base64Image = (imageBytes != null) 
                        ? Base64.getEncoder().encodeToString(imageBytes) 
                        : ""; 
        %>
        <!-- Card Template -->
        <div class="restaurant-card">
            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= restaurant.getName() %>" class="card-image">
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
        <p style="text-align: center; color: #e74c3c;">No restaurants available at the moment.</p>
        <% 
            } 
        %>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2024 Foodies. All Rights Reserved.
    </footer>
</body>
<script type="text/javascript">
	document.getElementsByClassName('profile-pic')[0].addEventListener('mouseover', function(event) {
    	var tooltip = document.getElementById('hov');
    
    	var rect = event.target.getBoundingClientRect();
    
    	tooltip.style.left = rect.left + window.scrollX + 'px';  
    	tooltip.style.top = rect.top + window.scrollY + 'px';  
    	tooltip.style.display = 'block';
	});

	document.getElementsByClassName('profile-pic')[0].addEventListener('mouseout', function() {
		document.getElementById('hov').style.display = 'none';
	});
</script>
</html>
