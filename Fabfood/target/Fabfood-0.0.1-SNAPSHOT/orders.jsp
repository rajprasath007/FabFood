<%@page import="com.food.model.dao.model.OrderHistory"%>
<%@page import="com.food.model.dao.impl.OrderHistoryDAOImpl"%>
<%@page import="com.food.model.dao.impl.OrdersDAOImpl"%>
<%@page import="com.food.model.dao.impl.RestaurantDAOImpl"%>
<%@page import="com.food.model.dao.impl.MenuDAOImpl"%>
<%@page import="com.food.model.dao.impl.OrderItemDAOImpl"%>
<%@page import="com.food.model.dao.model.OrderItem" %>
<%@page import="java.util.List" %>
<%@page import="com.food.model.dao.model.Order" %>
<%@page import="com.food.model.dao.pojo.CartItem"%>
<%@page import="java.util.TreeMap"%>
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
    <title>Order History</title>
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

        .container {
            padding: 20px;
            margin: 0 auto;
            max-width: 80%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #ff5722;
            color: white;
        }

        .status {
            padding: 5px 10px;
            border-radius: 3px;
        }

        .pending {
            background-color: #f39c12;
            color: white;
        }

        .completed {
            background-color: #2ecc71;
            color: white;
        }

        .cancelled {
            background-color: #e74c3c;
            color: white;
        }

        .back-btn-container {
            margin-top: 20px;
            text-align: center;
        }

        .back-btn {
            background-color: #ff5722;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
        }

        .back-btn:hover {
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
            <a href="javascript:history.back();">Back</a>
        </div>
        <div style="display: flex; align-items: center;">
            <!-- Cart Section with Notification -->
            <a href="cart.jsp">
                🛒 Cart
                <%
                    @SuppressWarnings("unchecked")
                    TreeMap<CartItem, Integer> cartMap = (TreeMap<CartItem, Integer>) (session.getAttribute("cartItems"));
                %>
                <span class="notification-badge"><%= cartMap == null ? 0 : cartMap.size() %></span> <!-- Notification Count -->
            </a>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container">
        <h1>Order History</h1>
        <table>
            <thead>
                <tr>
                    <th>Restaurant</th>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Ordered Date</th> <!-- New Column for Date -->
                </tr>
            </thead>
            <tbody>
                <%
                	OrderHistoryDAOImpl orderHistoryDAOImpl = new OrderHistoryDAOImpl();
                	List<OrderHistory> orderHistoryList =orderHistoryDAOImpl.fetchAll((int) session.getAttribute("uId"));
                    
                	for(OrderHistory orderHistory : orderHistoryList){
                %>
                <tr>
                    <td><%= orderHistory.getRestaurantName()  %></td>
                    <td><%= orderHistory.getItemName() %></td>
                    <td><%= orderHistory.getPrice() %></td>
                    <td><%= orderHistory.getQuantity() %></td>
                    <td>₹<%= orderHistory.getItemTotal() %></td>
                    <td class="status"> <%= orderHistory.getStatus()  %> </td>
                    <td><%= orderHistory.getOrderDate() %></td>
                </tr>
                <%
                        }
                %>
            </tbody>
        </table>

        <!-- Additional Back Button at the Bottom -->
        <div class="back-btn-container">
            <a href="dashboard.jsp" class="back-btn">Back</a>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2025 FabFoods. All Rights Reserved.
    </footer>
</body>
</html>
