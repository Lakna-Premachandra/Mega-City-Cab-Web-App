<%-- 
    Document   : signUp
    Created on : Feb 4, 2025, 2:09:01 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Page</title>
        <link rel="stylesheet" href="../../../assets/css/signUp.css"/>
    </head>
    <body>
        <div class="min-h-screen flex justify-center items-center bg-gray-100">
        <form class="form-container">
            <div id="errorMessage" class="hidden text-white text-center bg-red-400 rounded-sm p-1">
                Fields are required
            </div>
            <h2 class="form-title">Sign Up</h2>
            <p class="form-subtitle">
                Create an account to book your vehicle tickets seamlessly.
            </p>

            <input
                name="username"
                type="text"
                placeholder="Username"
                class="form-input"
            />
            <input
                name="phoneNumber"
                type="number"
                placeholder="Phone Number"
                class="form-input"
            />
            <input
                name="address"
                type="text"
                placeholder="Address"
                class="form-input"
            />
            <input
                name="email"
                type="email"
                placeholder="Email"
                class="form-input"
            />
            <input
                name="password"
                type="password"
                placeholder="Password"
                class="form-input"
            />
            <input
                name="confirmPassword"
                type="password"
                placeholder="Confirm Password"
                class="form-input"
            />

            <button
                type="submit"
                class="submit-button"
            >
                Sign Up
            </button>

            <p class="form-footer">
                Already have an account? 
                <a href="../sign-in/signIn.jsp" class="form-link">Sign In</a>
            </p>
        </form>
    </div>
    </body>
</html>
