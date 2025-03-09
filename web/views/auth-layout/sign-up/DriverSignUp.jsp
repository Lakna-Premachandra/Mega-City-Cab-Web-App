<%-- 
    Document   : DriverSignUp
    Created on : Mar 9, 2025, 12:01:33 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Driver Sign Up</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                overflow: hidden;
            }

            .main-container {
                display: flex;
                height: 100vh;
            }

            .image-container {
                flex: 1;
                background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)),
                    url('../../../assets/images/lee-ane-villeneuve-RNrMJdYuIWw-unsplash.jpg');
                background-size: cover;
                background-position: center;
                position: relative;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .logo {
                position: absolute;
                top: 20px;
                left: 20px;
                background-color: #2563eb;
                color: white;
                padding: 10px 15px;
                font-weight: bold;
                z-index: 10;
            }

            .form-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                background-color: white;
                overflow-y: auto;
            }

            .form-content {
                width: 100%;
                max-width: 400px;
                padding: 20px;
            }

            .form-header {
                margin-bottom: 20px;
            }

            .form-title {
                font-size: 24px;
                font-weight: bold;
                color: #374151;
                margin-bottom: 5px;
            }

            .form-subtitle {
                font-size: 14px;
                color: #6b7280;
            }

            .error-message {
                display: none;
                color: white;
                background: #f87171;
                padding: 8px;
                border-radius: 5px;
                font-size: 14px;
                margin-bottom: 15px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-label {
                display: block;
                font-size: 14px;
                color: #6b7280;
                margin-bottom: 5px;
                text-align: left;
            }

            .form-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 14px;
                outline: none;
            }

            .form-input:focus {
                border-color: #2563eb;
                box-shadow: 0 0 4px rgba(37, 99, 235, 0.3);
            }

            .input-error {
                font-size: 12px;
                color: #ef4444;
                margin-top: 2px;
                display: none;
            }

            .submit-button {
                width: 100%;
                background: #2563eb;
                color: white;
                font-size: 16px;
                font-weight: bold;
                padding: 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background 0.3s;
                margin-top: 10px;
                margin-bottom: 15px;
            }

            .submit-button:hover {
                background: #1e40af;
            }

            .signup-link {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
                color: #6b7280;
            }

            .signup-link a {
                color: #2563eb;
                text-decoration: none;
            }

            .signup-link a:hover {
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                .main-container {
                    flex-direction: column;
                }

                .image-container {
                    height: 150px;
                }

                .form-container {
                    flex: 2;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="image-container">
                <div class="logo">Megacity Cab</div>
            </div>

            <div class="form-container">
                <div class="form-content">
                    <div class="form-header">
                        <h2 class="form-title">Driver Sign Up</h2>
                        <p class="form-subtitle">Create an account to join our team of professional drivers.</p>
                    </div>

                    <div id="errorMessage" class="error-message">Please fill all required fields!</div>

                    <form id="driverSignUpForm" action="<%= request.getContextPath()%>/DriverSignUpServlet" method="POST">
                        <!-- Personal Information -->
                        <div class="form-group">
                            <input id="fullName" name="fullName" type="text" placeholder="Full Name" class="form-input"/>
                            <div id="fullNameError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <input id="phoneNumber" name="phoneNumber" type="number" placeholder="Phone Number" class="form-input"/>
                            <div id="phoneNumberError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <input id="email" name="email" type="email" placeholder="Email" class="form-input"/>
                            <div id="emailError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <input id="address" name="address" type="text" placeholder="Address" class="form-input"/>
                            <div id="addressError" class="input-error"></div>
                        </div>

                        <!-- Driver-Specific Information -->
                        <div class="form-group">
                            <input id="driverLicense" name="driverLicense" type="text" placeholder="Driver License Number" class="form-input"/>
                            <div id="driverLicenseError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <select id="vehicleType" name="vehicleType" class="form-input">
                                <option value="">Select Vehicle Type</option>
                                <option value="Economy">Economy</option>
                                <option value="Premium">Premium</option>
                                <option value="SUV">SUV</option>
                                <option value="Van">Van</option>
                            </select>
                            <div id="vehicleTypeError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <input id="vehicleRegNumber" name="vehicleRegNumber" type="text" placeholder="Vehicle Registration Number" class="form-input"/>
                            <div id="vehicleRegNumberError" class="input-error"></div>
                        </div>

                        <!-- Account Information -->
                        <div class="form-group">
                            <input id="username" name="username" type="text" placeholder="Username" class="form-input"/>
                            <div id="usernameError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <input id="password" name="password" type="password" placeholder="Password" class="form-input"/>
                            <div id="passwordError" class="input-error"></div>
                        </div>

                        <div class="form-group">
                            <input id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm Password" class="form-input"/>
                            <div id="confirmPasswordError" class="input-error"></div>
                        </div>

                        <button type="submit" class="submit-button">Sign Up</button>

                        <div class="signup-link">
                            Already have an account? <a href="../sign-in/driverSignIn.jsp">Sign In</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('driverSignUpForm').addEventListener('submit', function (event) {
                event.preventDefault();

                let hasError = false;
                const errorMessage = document.getElementById('errorMessage');

                // Reset error messages
                const errorElements = document.querySelectorAll('.input-error');
                errorElements.forEach(element => {
                    element.style.display = 'none';
                    element.textContent = '';
                });

                // Validate Full Name
                const fullName = document.getElementById('fullName').value.trim();
                if (!fullName) {
                    document.getElementById('fullNameError').textContent = 'Full name is required';
                    document.getElementById('fullNameError').style.display = 'block';
                    hasError = true;
                }

                // Validate Phone Number
                const phoneNumber = document.getElementById('phoneNumber').value.trim();
                if (!phoneNumber) {
                    document.getElementById('phoneNumberError').textContent = 'Phone number is required';
                    document.getElementById('phoneNumberError').style.display = 'block';
                    hasError = true;
                } else if (!/^\d{10}$/.test(phoneNumber)) {
                    document.getElementById('phoneNumberError').textContent = 'Please enter a valid 10-digit phone number';
                    document.getElementById('phoneNumberError').style.display = 'block';
                    hasError = true;
                }

                // Validate Email
                const email = document.getElementById('email').value.trim();
                if (!email) {
                    document.getElementById('emailError').textContent = 'Email is required';
                    document.getElementById('emailError').style.display = 'block';
                    hasError = true;
                } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    document.getElementById('emailError').textContent = 'Please enter a valid email address';
                    document.getElementById('emailError').style.display = 'block';
                    hasError = true;
                }

                // Validate Address
                const address = document.getElementById('address').value.trim();
                if (!address) {
                    document.getElementById('addressError').textContent = 'Address is required';
                    document.getElementById('addressError').style.display = 'block';
                    hasError = true;
                }

                // Validate Driver License
                const driverLicense = document.getElementById('driverLicense').value.trim();
                if (!driverLicense) {
                    document.getElementById('driverLicenseError').textContent = 'Driver license number is required';
                    document.getElementById('driverLicenseError').style.display = 'block';
                    hasError = true;
                }

                // Validate Vehicle Type
                const vehicleType = document.getElementById('vehicleType').value;
                if (!vehicleType) {
                    document.getElementById('vehicleTypeError').textContent = 'Vehicle type is required';
                    document.getElementById('vehicleTypeError').style.display = 'block';
                    hasError = true;
                }

                // Validate Vehicle Registration Number
                const vehicleRegNumber = document.getElementById('vehicleRegNumber').value.trim();
                if (!vehicleRegNumber) {
                    document.getElementById('vehicleRegNumberError').textContent = 'Vehicle registration number is required';
                    document.getElementById('vehicleRegNumberError').style.display = 'block';
                    hasError = true;
                }

                // Validate Username
                const username = document.getElementById('username').value.trim();
                if (!username) {
                    document.getElementById('usernameError').textContent = 'Username is required';
                    document.getElementById('usernameError').style.display = 'block';
                    hasError = true;
                }

                // Validate Password
                const password = document.getElementById('password').value;
                if (!password) {
                    document.getElementById('passwordError').textContent = 'Password is required';
                    document.getElementById('passwordError').style.display = 'block';
                    hasError = true;
                } else if (password.length < 6) {
                    document.getElementById('passwordError').textContent = 'Password must be at least 6 characters';
                    document.getElementById('passwordError').style.display = 'block';
                    hasError = true;
                }

                // Validate Confirm Password
                const confirmPassword = document.getElementById('confirmPassword').value;
                if (!confirmPassword) {
                    document.getElementById('confirmPasswordError').textContent = 'Please confirm your password';
                    document.getElementById('confirmPasswordError').style.display = 'block';
                    hasError = true;
                } else if (password !== confirmPassword) {
                    document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
                    document.getElementById('confirmPasswordError').style.display = 'block';
                    hasError = true;
                }

                if (hasError) {
                    errorMessage.style.display = 'block';
                } else {
                    errorMessage.style.display = 'none';
                    // Submit the form
                    this.submit();
                }
            });
        </script>
    </body>
</html>
