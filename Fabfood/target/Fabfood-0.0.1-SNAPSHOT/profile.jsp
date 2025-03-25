<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.security.*" %>
<%@ page import="com.food.model.dao.model.User" %>
<%@ page import="com.food.model.dao.model.Address" %>
<%@ page import="com.food.model.dao.impl.UserDAOImpl" %>
<%@ page import="com.food.model.dao.impl.AddressDAOImpl" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
    if(request.getSession().getAttribute("uId") == null){
    	response.sendRedirect("index.jsp");
    }
	UserDAOImpl daoImpl = new UserDAOImpl();
	int uId = (Integer)session.getAttribute("uId");
	User user = daoImpl.fetch(uId);
	Address address = null;
	if(user.getAddressId() != null){
		AddressDAOImpl addressDAOImpl = new AddressDAOImpl();
		address = addressDAOImpl.fetch(user.getAddressId());
	}
	String doorNo = "";
	String street = "";
	String city = "";
	String state = "";
	int pincode = 0;
	String country = "";
	if(address != null){
		doorNo = address.getDoorNo();
		street = address.getStreetName();
		city = address.getCity();
		state = address.getState();
		pincode = address.getPincode();
		country = address.getCountry();
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="icon" type="image/webp" href="fabfood.webp">
    <style>
        /* General Styles */
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f7f3e9;
            background: url('https://static.vecteezy.com/system/resources/previews/006/400/482/non_2x/food-delivery-application-online-on-mobile-3d-illustration-photo.jpg') no-repeat center center/cover;
            color: #2c3e50;
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
      
        .container {
            max-width: 800px;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .profile-picture {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-picture img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #ff5722;
            object-fit: cover;
        }

        .profile-info {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-info .account-date {
            font-size: 0.9em;
            color: #555;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 90%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
            background-color: #f5f5f5;
            pointer-events: none;
            color: #777;
        }

        .edit-btn {
            position: absolute;
            top: 65%;
            right: 10px;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #ff5722;
            cursor: pointer;
            font-size: 1.2em;
            outline: none;
            transition: color 0.3s ease;
        }

        .edit-btn:hover {
            color: #e64a19;
        }

        .error-message {
            color: red;
            font-size: 0.85em;
            margin-top: 5px;
        }

        .btn-submit {
            background-color: #ff5722;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 1em;
            cursor: pointer;
            display: none;
            margin-top: 20px;
        }

        .btn-submit:hover {
            background-color: #e64a19;
        }

        footer {
            text-align: center;
            padding: 10px;
            background-color: #2c3e50;
            color: white;
            font-size: 0.85em;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <a href="javascript:history.back();" style="text-decoration: none; color: white; font-size: 1em; font-weight: bold; padding: 10px 15px; border-radius: 5px; transition: background-color 0.3s ease;"> Back</a> <!-- Added the link here -->
        My Profile
      <form action="Logout" method="post" style="margin: 0;">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
    </header>
    <!-- Profile Container -->
    <div class="container">
        <!-- Profile Picture -->
        <div class="profile-picture">
            <img src="https://www.shutterstock.com/image-vector/profile-icon-vectororange-260nw-591156221.jpg" alt="Profile Picture">
        </div>

        <!-- Profile Info -->
        <div class="profile-info">
            <h2></h2>
            <p class="account-date">Account Created: <%= user.getAccountCreated() != null ? user.getAccountCreated() : "No data" %></p>
        </div>

        <!-- Profile Form -->
        <form id="profileForm" action="UpdateProfile" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="<%= user.getUserName() != null ? user.getUserName() :"" %>">
                <button type="button" class="edit-btn" onclick="enableField('name', 'submitBtn')">✏️</button>
                <div class="error-message" id="nameError"></div>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" >
                <button type="button" class="edit-btn" onclick="enableField('email', 'submitBtn')">✏️</button>
                <div class="error-message" id="emailError"></div>
            </div>
            <div class="form-group">
                <label for="mobile">Mobile Number</label>
                <input type="text" id="mobile" name="mobile" value="<%= user.getMobileNumber() %>" >
                <button type="button" class="edit-btn" onclick="enableField('mobile', 'submitBtn')">✏️</button>
                <div class="error-message" id="mobileError"></div>
            </div>

            <!-- Address Section -->
            <div class="form-group">
                <label for="flat">Flat/Door Number</label>
                <input type="text" id="flat" name="flat" value="<%= doorNo %>" >
                <button type="button" class="edit-btn" onclick="enableField('flat', 'submitBtn')">✏️</button>
                <div class="error-message" id="flatError"></div>
            </div>
            <div class="form-group">
                <label for="street">Street Name</label>
                <input type="text" id="street" name="street" value="<%= street %>" >
                <button type="button" class="edit-btn" onclick="enableField('street', 'submitBtn')">✏️</button>
                <div class="error-message" id="streetError"></div>
            </div>
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" id="city" name="city" value="<%= city %>" >
                <button type="button" class="edit-btn" onclick="enableField('city', 'submitBtn')">✏️</button>
                <div class="error-message" id="cityError"></div>
            </div>
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" id="state" name="state" value="<%= state %>" >
                <button type="button" class="edit-btn" onclick="enableField('state', 'submitBtn')">✏️</button>
                <div class="error-message" id="stateError"></div>
            </div>
            <div class="form-group">
                <label for="pincode">Pincode</label>
                <input type="text" id="pincode" name="pincode" value="<%= pincode <= 0 ? "" : pincode %>" >
                <button type="button" class="edit-btn" onclick="enableField('pincode', 'submitBtn')">✏️</button>
                <div class="error-message" id="pincodeError"></div>
            </div>
            <div class="form-group">
                <label for="country">Country</label>
                <input type="text" id="country" name="country" value="<%= country %>" >
                <button type="button" class="edit-btn" onclick="enableField('country', 'submitBtn')">✏️</button>
                <div class="error-message" id="countryError"></div>
            </div>

            <div>
                <button type="submit" id="submitBtn" class="btn-submit">Update Profile</button>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        &copy; 2024 Foodies. All Rights Reserved.
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Get input fields
            const emailField = document.getElementById('email');
            const mobileField = document.getElementById('mobile');

            // Get error message elements
            const emailError = document.getElementById('emailError');
            const mobileError = document.getElementById('mobileError');

            // Regular expressions for validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const mobileRegex = /^\d{10}$/;

            // Real-time email validation
            emailField.addEventListener('input', () => {
                const email = emailField.value.trim();
                if (email === '' || emailRegex.test(email)) {
                    emailError.textContent = ''; // Clear error if valid
                } else {
                    emailError.textContent = 'Invalid email format.';
                }
            });

            // Real-time mobile validation
            mobileField.addEventListener('input', () => {
                const mobile = mobileField.value.trim();
                if (mobile === '' || mobileRegex.test(mobile)) {
                    mobileError.textContent = ''; // Clear error if valid
                } else {
                    mobileError.textContent = 'Invalid Mobile number.';
                }
            });
        });

        function enableField(id, submitBtnId) {
            const field = document.getElementById(id);
            const submitBtn = document.getElementById(submitBtnId);
            field.removeAttribute('disabled');
            field.style.pointerEvents = 'auto';
            field.style.backgroundColor = '#fff';
            field.style.color = '#2c3e50';
            submitBtn.style.display = 'inline-block';
        }

        function validateForm() {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const mobile = document.getElementById('mobile').value.trim();
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const mobileRegex = /^(\+?91[-.\s]?)?[6-9]\d{9}$/;
            let isValid = true;

            // Clear errors
            document.getElementById('nameError').textContent = '';
            document.getElementById('emailError').textContent = '';
            document.getElementById('mobileError').textContent = '';

            if (name === '') {
                document.getElementById('nameError').textContent = 'Name cannot be empty.';
                isValid = false;
            }
            if (email === '' || !emailRegex.test(email)) {
                document.getElementById('emailError').textContent = 'Invalid email format.';
                isValid = false;
            }
            if (mobile === '' || !mobileRegex.test(mobile)) {
                document.getElementById('mobileError').textContent = 'Mobile number must be 10 digits.';
                isValid = false;
            }

            // Address mandatory check
            const flat = document.getElementById('flat').value.trim();
            const street = document.getElementById('street').value.trim();
            const city = document.getElementById('city').value.trim();
            const state = document.getElementById('state').value.trim();
            const pincode = document.getElementById('pincode').value.trim();
            const country = document.getElementById('country').value.trim();

            if ((flat || street || city || state || pincode || country) &&
                (!flat || !street || !city || !state || !pincode || !country)) {
                alert('All address fields must be filled if one is filled.');
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>
