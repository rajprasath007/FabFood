<%@page import="com.food.model.dao.impl.AddressDAOImpl"%>
<%@page import="com.food.model.dao.model.Address" %>
<%@page import="com.food.model.dao.pojo.CartItem"%>
<%@page import="java.util.TreeMap"%>
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
    <title>Order Summary</title>
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
            justify-content: center;
            align-items: center;
            background-color: #ff5722;
            color: white;
            padding: 15px 20px;
            font-size: 1.8em;
            position: relative;
        }

        header a {
            position: absolute;
            left: 20px;
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

        .order-container {
            max-width: 800px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        .order-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .order-details {
            flex: 1;
            margin-left: 20px;
        }

        .order-details h3 {
            margin: 0;
            font-size: 1.2em;
            color: #2c3e50;
        }

        .order-details p {
            margin: 5px 0;
            color: #555;
        }

        .total-row {
            text-align: right;
            font-size: 1.2em;
            margin: 20px 0;
        }

        .form-section {
            margin-top: 30px;
        }

        .form-section h3 {
            margin-bottom: 10px;
            font-size: 1.2em;
            color: #2c3e50;
        }

        .form-section input, .form-section select, .form-section textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }

        .form-section button {
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-section button:hover {
            background-color: #e64a19;
        }

        .proceed-button {
            background-color: #4caf50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .proceed-button:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <a href="javascript:history.back();">Back</a>
        <span>Order Summary</span>
    </header>

    <!-- Order Container -->
    <div class="order-container">
        <% 
            Object orderObj = session.getAttribute("cartItems"); 
            
            @SuppressWarnings("unchecked")
            TreeMap<CartItem,Integer> cartItems = (TreeMap<CartItem,Integer>) orderObj;

            float ultimateTotal = 0;

            if (cartItems != null && !cartItems.isEmpty()) {
                for (Map.Entry<CartItem,Integer> mapItem : cartItems.entrySet()) {
                    String name = mapItem.getKey().getItemName();
                    String restaurantName = mapItem.getKey().getRestaurantName();
                    float price = mapItem.getKey().getPrice();
                    int quantity = mapItem.getValue();
                    byte[] imageBytes = mapItem.getKey().getImage();

                    String base64Image = "";
                    if (imageBytes != null) {
                        base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    }

                    float itemTotal = price * quantity;
                    ultimateTotal += itemTotal;
                    
        %>
        <!-- Order Item -->
        <div class="order-item">
            <img src="<%= imageBytes != null ? "data:image/jpeg;base64," + base64Image : "default-item.jpg" %>" alt="<%= name %>">
            <div class="order-details">
                <h3><%= name %></h3>
                <p>Restaurant: <%= restaurantName %></p>
                <p>Price: ₹<%= price %></p>
                <p>Quantity: <%= quantity %></p>
                <p>Total: ₹<%= itemTotal %></p>
            </div>
        </div>
        <% 
                }
            } else { 
        %>
        <p style="text-align: center; color: #e74c3c;">Your order is empty.</p>
        <% 
            } 
        %>

        <!-- Total -->
        <div class="total-row">
            Total: ₹<%= ultimateTotal %>
        </div>

        <!-- Address and Payment Form -->
        <div class="form-section">
            <h3>Update Address</h3>
            <form action="Confirmation" method="post">
            	<%
            		String addressValue = null; 
            		if(session.getAttribute("addressId") != null){
            			int addressId = (Integer) session.getAttribute("addressId");
                		AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
                		Address address = addressDAOImpl.fetch(addressId);
                		if(address != null){
                			addressValue = address.getDoorNo()+ "," + address.getStreetName() + "," + address.getCity() + "," + address.getState() + " - " + address.getPincode();
                		}
                	}
            	%>
                <textarea name="address" rows="3" placeholder="Enter your delivery address..." required><%= addressValue != null ? addressValue : "" %></textarea>
                <h3>Select Payment Mode</h3>
                <select name="paymentMode" required>
                    <option value="" disabled selected>Select Payment Mode</option>
                    <option value="creditCard">Credit Card</option>
                    <option value="debitCard">Debit Card</option>
                    <option value="netBanking">Net Banking</option>
                    <option value="cashOnDelivery">Cash on Delivery</option>
                </select>
                <button type="submit" class="proceed-button">Place Order</button>
            </form>
        </div>
    </div>
</body>
</html>
