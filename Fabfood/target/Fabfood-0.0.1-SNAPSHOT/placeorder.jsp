<%@ page language="java" contentType="text/html; charset=UTF-16"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="icon" type="image/webp" href="fabfood.webp">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f7f3e9;
            color: #333;
            text-align: center;
        }

        .confirmation-container {
            max-width: 600px;
            margin: 100px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #ff9800;
        }

        p {
            font-size: 1.2em;
        }

        .loader {
            border: 5px solid #f3f3f3;
            border-top: 5px solid #ff5722;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }

        .tick {
            font-size: 3em;
            color: #ff9800;
            display: none;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .home-button, .orders-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff5722;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .home-button:hover, .orders-button:hover {
            background-color: #e64a19;
        }
    </style>
    <script>
        setTimeout(() => {
            document.querySelector(".loader").style.display = "none";
            document.querySelector(".tick").style.display = "block";
        }, 1000);
    </script>
</head>
<body>
    <div class="confirmation-container">
        <h1>Order Placed Successfully!</h1>
        <p>Your order is being processed. You will receive a confirmation soon.</p>
        <div class="loader"></div>
        <div class="tick">✔</div>
        <a href="dashboard.jsp" class="home-button">Go to Home</a>
        <a href="orders.jsp" class="orders-button">View Orders</a> <!-- Added Orders button -->
    </div>
    <%
        session.setAttribute("cartItems", null);
    %>
</body>
</html>
    