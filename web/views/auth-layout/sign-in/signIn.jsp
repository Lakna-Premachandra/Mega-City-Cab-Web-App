<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In Page</title>
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
                    url('../../../assets/images/premium_photo-1728723283456-c39c5d62e12d.jpeg');
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

            .food-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .form-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                background-color: white;
            }

            .form-content {
                width: 100%;
                max-width: 400px;
                padding: 20px;
            }

            .form-header {
                margin-bottom: 30px;
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
                margin-bottom: 20px;
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
                padding: 12px;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 16px;
                outline: none;
            }

            .form-input:focus {
                border-color: #2563eb;
                box-shadow: 0 0 4px rgba(37, 99, 235, 0.3);
            }

            .password-container {
                position: relative;
            }

            .password-toggle {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #6b7280;
            }

            .checkbox-container {
                display: flex;
                align-items: center;
                margin: 15px 0;
            }

            .form-checkbox {
                margin-right: 8px;
            }

            .forgot-password {
                margin-left: auto;
                color: #2563eb;
                text-decoration: none;
                font-size: 14px;
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
                margin-bottom: 15px;
            }

            .submit-button:hover {
                background: #1e40af;
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 20px 0;
                color: #9ca3af;
                font-size: 14px;
            }

            .divider::before, .divider::after {
                content: "";
                flex: 1;
                border-bottom: 1px solid #e5e7eb;
            }

            .divider::before {
                margin-right: 10px;
            }

            .divider::after {
                margin-left: 10px;
            }

            .social-button {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                padding: 12px;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                margin-bottom: 10px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                text-decoration: none;
                color: #374151;
                transition: background 0.3s;
            }

            .facebook-button {
                background-color: #3b5998;
                color: white;
            }

            .google-button {
                background-color: #4285f4;
                color: white;
            }

            .social-icon {
                margin-right: 10px;
            }

            .signup-link {
                text-align: center;
                margin-top: 20px;
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
                    height: 200px;
                }

                .form-container {
                    flex: 2;
                    overflow-y: auto;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="image-container">
                <div class="logo">Megacity Cab</div>
                <!-- Replace with your actual image -->
            </div>

            <div class="form-container">
                <div class="form-content">
                    <div class="form-header">
                        <h2 class="form-title">Sign in with your account</h2>
                        <p class="form-subtitle">Create an account to book your vehicle tickets seamlessly.</p>
                    </div>

                    <div id="errorMessage" class="error-message"></div>

                    <form id="signinForm">
                        <div class="form-group">
                            <label for="username" class="form-label">Email</label>
                            <input type="text" id="username" name="username" placeholder="Enter your email" class="form-input">
                        </div>

                        <div class="form-group">
                            <label for="password" class="form-label">Password</label>
                            <div class="password-container">
                                <input type="password" id="password" name="password" placeholder="Enter your password" class="form-input">
                                <span class="password-toggle" onclick="togglePassword()">👁️</span>
                            </div>
                        </div>

                        <div class="checkbox-container">
                            <input type="checkbox" id="remember" class="form-checkbox">
                            <label for="remember">Keep me signed in</label>
                            <a href="#" class="forgot-password">Reset password</a>
                        </div>

                        <button type="submit" class="submit-button">Sign In</button>

                        <div class="divider">or</div>

                        <a href="#" class="social-button facebook-button">
                            Continue with Facebook
                        </a>

                        <a href="#" class="social-button google-button">
                            Continue with Google
                        </a>

                        <div class="signup-link">
                            Create your account? <a href="../sign-up/signUp.jsp">Sign Up</a>
                        </div>

                        <div class="signup-link">
                            Want to join as a driver? <a href="../sign-up/DriverSignUp.jsp">Join US</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function togglePassword() {
                const passwordInput = document.getElementById('password');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                } else {
                    passwordInput.type = 'password';
                }
            }

            document.getElementById('signinForm').addEventListener('submit', function (event) {
                event.preventDefault();
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const errorMessage = document.getElementById('errorMessage');

                if (!username || !password) {
                    errorMessage.textContent = 'Fields are required';
                    errorMessage.style.display = 'block';
                } else {
                    errorMessage.style.display = 'none';
                    // Handle form submission here
                    console.log('Form submitted successfully');
                }
            });
        </script>
    </body>
</html>