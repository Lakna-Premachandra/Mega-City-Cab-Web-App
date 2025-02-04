<%-- 
    Document   : sign-in
    Created on : Feb 4, 2025, 2:08:12 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In Page</title>
        <link rel="stylesheet" href="../../../assets/css/signIn.css"/>
    </head>
    <body>
<div class="container">
        <form id="signinForm" class="signin-form">
            <div id="errorMessage" class="error-message"></div>
            <h2 class="form-title">Sign In</h2>
            <p class="form-subtitle">Create an account to book your vehicle tickets seamlessly.</p>

            <input
                type="text"
                id="username"
                name="username"
                placeholder="Username"
                class="form-input"
            />

            <input
                type="password"
                id="password"
                name="password"
                placeholder="Password"
                class="form-input"
            />

            <button type="submit" class="submit-button">Sign In</button>

            <p class="form-footer">
                Create an account? <a href="../sign-up/signUp.jsp" class="form-link">Sign Up</a>
            </p>
        </form>
    </div>

    <script>
        document.getElementById('signinForm').addEventListener('submit', function(event) {
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
