<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="icon" type="image/webp" href="fabfood.webp">
    <style>
        /* General Page Styles */
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f3e9;
            background : url('https://static.vecteezy.com/system/resources/previews/006/400/482/non_2x/food-delivery-application-online-on-mobile-3d-illustration-photo.jpg') no-repeat center center/cover;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 900px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
            background-color: #fff;
        }

        .image-section {
            flex: 1;
            background: url('https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg') no-repeat center center/cover;
        }

        .form-section {
            flex: 1;
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: flex-end;
            padding: 10px 20px;
            background-color: #ff5722;
            color: white;
        }

        .header a {
            color: white;
            text-decoration: none;
            font-size: 0.95em;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .header a:hover {
            color: #ffe0b2;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            font-size: 2em;
            margin-top: 10px;
            font-weight: bold;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
            font-size: 0.95em;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #ff5722;
            box-shadow: 0 0 5px rgba(255, 87, 34, 0.5);
            outline: none;
        }

        .error {
            color: #e74c3c;
            font-size: 0.85em;
            margin-top: -10px;
            margin-bottom: 5px;
        }

        button {
            background-color: #ff5722;
            color: #fff;
            padding: 12px;
            font-size: 1.1em;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        button:hover {
            background-color: #e64a19;
            transform: translateY(-2px);
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 0.85em;
            color: #7f8c8d;
        }

        .footer-text a {
            color: #ff5722;
            text-decoration: none;
        }

        .footer-text a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .image-section {
                height: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- Header with Register -->

    <div class="container">
        <!-- Left Image Section -->
        <div class="image-section"></div>

        <!-- Right Form Section -->
        <div class="form-section">
            <h2>Login to Foodies</h2>
            <form id="loginForm" action="ValidateLogin" method="post" onsubmit="return validateLogin();">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter your email" required>
                <p id="emailError" class="error"></p>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <p id="passwordError" class="error"></p>

                <button id="submitButton" type="submit">Login</button>
            </form>
            <div class="footer-text">
                Don't have an account? <a href="register.jsp">Register here</a>
            </div>
        </div>
    </div>
    <script>
    
    	const emailInput = document.getElementById('email');
    	const passwordInput = document.getElementById('password');
    	const emailError = document.getElementById('emailError');
    	const passwordError = document.getElementById('passwordError');
    	let isValid = true;
 		
    	
     // Email Validation
    	function validateEmail(email){
        	const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        	return regex.test(email);
        }
    	
 		// Password Validation
		function validatePassword(password) {
			const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
			return regex.test(password);
		}
 		
		// Real-time Validation for Email
    	emailInput.addEventListener('input', () => {
        	const valid = validateEmail(emailInput.value);
        	console.log(valid);
        	isValid = valid;
        	emailError.style.color = isValid ? '' : '#e74c3c';
        	emailError.textContent = isValid ? '' : 'Enter valid email.';
    	});
    	
        
     // Real-time Validation for Password
    	passwordInput.addEventListener('input', () => {
        	const valid = validatePassword(passwordInput.value);
        	isValid = valid;
        	passwordError.style.color = isValid ? '' : '#e74c3c';
        	passwordError.textContent = isValid ? '' : 'Must be at least 8 characters, including a number, an uppercase letter, and a symbol.';
    	});
        
    	document.getElementById("loginForm").addEventListener("submit", async function (event) {
    	    event.preventDefault(); // Prevent the default form submission

    	    const email = emailInput.value.trim();
    	    const password = passwordInput.value.trim();

    	    // Reset error messages
    	    emailError.textContent = '';
    	    passwordError.textContent = '';
    	    let isValid = true;

    	    // Validate email
    	    if (!validateEmail(email)) {
    	        emailError.textContent = 'Enter a valid email.';
    	        isValid = false;
    	    }

    	    // Validate password
    	    if (!validatePassword(password)) {
    	        passwordError.textContent = 'Password must include at least 8 characters, a number, an uppercase letter, and a special symbol.';
    	        isValid = false;
    	    }

    	    // Stop submission if validation fails
    	    if (!isValid) return;

    	    // Encode form data
    	    const formData = new URLSearchParams();
    	    formData.append("email", email);
    	    formData.append("password", password);

    	    // Submit form data to the server
    	    try {
    	        const response = await fetch(this.action, {
    	            method: "POST",
    	            headers: {
    	                "Content-Type": "application/x-www-form-urlencoded",
    	            },
    	            body: formData.toString(),
    	        });

    	        if (response.redirected) {
    	            // If the server redirects on success
    	            window.location.href = response.url;
    	        } else {
    	            const result = await response.json(); // Parse JSON response for errors
    	            if (result.status === "error") {
    	            	if(result.message === "No user found"){
    	            		emailError.textContent = 'Enter existing email.'
    	            	}
    	            	else{
    	            		passwordError.textContent = 'Enter correct password.'
    	            	}
    	                alert(result.message); // Display server error message in pop-up
    	            }
    	        }
    	    } catch (error) {
    	        console.error("Error:", error);
    	        alert("Something went wrong. Please try again.");
    	    }
    	});


    	/*// Add login validation script
        function validateLogin() {
            

            // Clear errors
            emailError.textContent = '';
            passwordError.textContent = '';

            // Username validation
            if (usernameInput.value.trim() === '') {
                usernameError.textContent = 'Username is required.';
                isValid = false;
            }

            // Password validation
            if (passwordInput.value.trim() === '') {
                passwordError.textContent = 'Password is required.';
                isValid = false;
            }

            return isValid;
        }*/
        
        
    </script>
</body>
</html>