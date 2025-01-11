<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
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
            background: url('https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg') no-repeat center center/cover;
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
        input[type="email"],
        input[type="tel"],
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
            margin-bottom: 2px;
        }

        .password-hint {
            font-size: 0.85em;
            color: #555;
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

        /* Footer Text */
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
    <div class="container">
        <!-- Left Image Section -->
        <div class="image-section"></div>

        <!-- Right Form Section -->
        <div class="form-section">
            <h2>Register to Foodies</h2>
            <form id="registrationForm" action="register" method="post" onsubmit="return validateForm();">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                <p id="nameError" class="error"></p>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                <p id="emailError" class="error"></p>

                <label for="mobileNumber">Mobile Number:</label>
                <input type="tel" id="tel" name="tel" placeholder="Enter your mobile number" required>
                <p id="telError" class="error"></p>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
                <p id="passwordHint" class="password-hint"></p>

                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter your password" required>
                <p id="confirmPasswordError" class="error"></p>

                <button id="submitButton" type="submit">Register</button>
            </form>
            <div class="footer-text">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </div>
    </div>
    
    <script>
    
    	const form = document.getElementById('registrationForm');
    	const nameInput = document.getElementById('name');
    	const emailInput = document.getElementById('email');
    	const mobileInput = document.getElementById('tel');
    	const passwordInput = document.getElementById('password');
    	const confirmPasswordInput = document.getElementById('confirmPassword');
    	const submitButton = document.getElementById('submitButton');
    	const passwordHint = document.getElementById('passwordHint');
    	let isValid = true;
    	
    	let correctName = false;
        let correctEmail = false;
        let correctMobile = false;
        let correctPassword = false;
        let correctConfirmPassword = false;
        
        function checkValidity(){
        	if(correctName && correctEmail && correctMobile && correctPassword && correctConfirmPassword) isValid = true;
        	else isValid = false;
        }
    	
    	function validateForm() {
	        
    		submitButton.textContent = 'Register';
    		
	        if(isValid){
	        	mobileInput.value = mobileInput.value.slice(-10);
	        }
	        return isValid;
    	}
    	
    	// Mobile Validation
    	function validateMobile(mobileNumber){
        	const regex = /^(\+?91[-.\s]?)?[6-9]\d{9}$/;
        	return regex.test(mobileNumber);
        }
    	
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
    	
    	// Real-time Validation for Name
        nameInput.addEventListener('input', () => {
            if(nameInput.value.trim() === ''){
            	correctName = false;
            	nameError.style.color = '#e74c3c';
            	nameError.textContent = 'Name is required.';
            }
            else{
            	correctName = true;
            	nameError.textContent = '';
            	checkValidity();
            }
        });
    	
    	// Real-time Validation for Mobile Number
        mobileInput.addEventListener('input', () => {
            const valid = validateMobile(mobileInput.value);
            correctMobile = valid;
            checkValidity();
            telError.style.color = correctMobile ? '' : '#e74c3c';
            telError.textContent = correctMobile ? '' : 'Enter valid mobile number.';
        });
    	
    	// Real-time Validation for Email
        emailInput.addEventListener('input', () => {
            const valid = validateEmail(emailInput.value);
            correctEmail = valid;
            checkValidity();
            emailError.style.color =  correctEmail ? '' : '#e74c3c';
            emailError.textContent = correctEmail ? '' : 'Enter valid email.';
        });
    	
    	// Real-time Validation for Password
        passwordInput.addEventListener('input', () => {
            const valid = validatePassword(passwordInput.value);
            correctPassword = valid;
            checkValidity();
            passwordHint.style.color = correctPassword ? '' : '#e74c3c';
            passwordHint.textContent = correctPassword ? '' : 'Must be at least 8 characters, including a number, an uppercase letter, and a symbol.';
        });
    	
     	// Confirm Password Match
        confirmPasswordInput.addEventListener('input', () => {
            const confirmError = document.getElementById('confirmPasswordError');
            if (passwordInput.value !== confirmPasswordInput.value) {
            	correctConfirmPassword = false;
            	checkValidity();
                confirmError.textContent = "Passwords do not match.";
            } else {
            	correctConfirmPassword = true;
            	checkValidity();
                confirmError.textContent = "";
            }
        });
     	
        form.addEventListener('submit', (e) => {
            submitButton.disabled = isValid ? true : false;
            submitButton.textContent = isValid ? "Submitting..." : "Register";
        });
    
	</script>
        
</body>
</html>


