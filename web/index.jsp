<%-- 
    Document   : index
    Created on : Mar 10, 2025, 8:47:55 PM
    Author     : PC
--%>

<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.LocationDAO"%>
<%@ page import="Models.Location"%>
<%@ page import="java.util.List"%>
<%@ page import="DAO.LocationDistanceDAO"%>
<%@ page import="DAO.VehiclePriceDAO"%>
<%@ page import="Models.LocationDistance"%>
<%@ page import="Models.VehiclePrice"%>
<%@ page import="Models.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Book Now</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Lato', sans-serif;
            }

            body {
                margin: 0;
                padding: 0;
                color: #333;
                background-color: #f5f5f5;
            }

            /* Header Styles */
            #header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 15px 40px;
                background-color: #ffffff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 0;
                z-index: 999;
            }

            .logo {
                height: 60px;
                width: auto;
            }

            #navbar {
                display: flex;
                align-items: center;
                justify-content: center;
                list-style: none;
            }

            #navbar li {
                padding: 0 20px;
                position: relative;
            }

            #navbar li a {
                text-decoration: none;
                font-size: 16px;
                font-weight: 600;
                color: #333;
                transition: 0.3s ease;
            }

            #navbar li a:hover,
            #navbar li a.active {
                color: #2563eb;
            }

            #navbar li a.active::after,
            #navbar li a:hover::after {
                content: "";
                width: 30%;
                height: 2px;
                background: #2563eb;
                position: absolute;
                bottom: -4px;
                left: 20px;
            }

            #booknow {
                background-color: #2563eb;
                padding: 10px 20px;
                border-radius: 4px;
                border: none;
                margin-left: 20px;
                cursor: pointer;
                transition: 0.3s ease;
            }

            #booknow:hover {
                background-color: #1e40af;
            }

            #booknow a {
                text-decoration: none;
                color: white;
                font-weight: 600;
            }
            
             #user-menu {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 0 20px;
                position: relative;
            }

            #user-icon {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                background-color: #ccc; 
                margin-bottom: 5px;
            }

            #username span {
                font-size: 14px;
                color: #333;
                font-weight: 600;
            }


            /* Hero Section */
            .hero-section {
                background-image:  linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.6)), 
                        url('assets/images/background.jpg');
                background-size: cover;
                background-position: center;
                color: white;
                text-align: center;
                padding: 80px 20px;
            }

            .hero-section h1 {
                font-size: 3rem;
                font-weight: 900;
                margin-bottom: 20px;
                letter-spacing: 1px;
            }

            .hero-section p {
                font-size: 1.2rem;
                max-width: 700px;
                margin: 0 auto 30px;
                line-height: 1.6;
            }

            .cta-buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .btn {
                padding: 12px 30px;
                border-radius: 4px;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                border: none;
            }

            .btn-primary {
                background-color: #2563eb;
                color: white;
            }

            .btn-primary:hover {
                background-color: #1e40af;
            }

            .btn-outline {
                background-color: transparent;
                color: white;
                border: 2px solid white;
            }

            .btn-outline:hover {
                background-color: white;
                color: #2563eb;
            }

            /* Booking Form */
            .booking-section {
                padding: 60px 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .booking-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                padding: 40px;
                margin-top: -100px;
                position: relative;
            }

            .booking-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .booking-header h2 {
                font-size: 28px;
                color: #333;
                margin-bottom: 10px;
            }

            .booking-header p {
                color: #6b7280;
                font-size: 16px;
            }

            .form-row {
                display: flex;
                flex-wrap: wrap;
                margin: 0 -15px;
            }

            .form-group {
                flex: 1 0 calc(50% - 30px);
                margin: 0 15px 20px;
                position: relative;
            }

            @media (max-width: 768px) {
                .form-group {
                    flex: 1 0 calc(100% - 30px);
                }
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #4b5563;
                font-size: 14px;
            }

            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 16px;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: #2563eb;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
                outline: none;
            }

            .error-message {
                color: #ef4444;
                font-size: 12px;
                margin-top: 5px;
                display: none;
            }

            .vehicle-options {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 30px;
            }

            .vehicle-option {
                flex: 1;
                min-width: 120px;
                border: 2px solid #d1d5db;
                border-radius: 8px;
                padding: 15px;
                text-align: center;
                cursor: pointer;
                transition: all 0.3s;
            }

            .vehicle-option:hover {
                border-color: #2563eb;
            }

            .vehicle-option.selected {
                border-color: #2563eb;
                background-color: rgba(37, 99, 235, 0.05);
            }

            .vehicle-option img {
                height: 60px;
                margin-bottom: 10px;
            }

            .vehicle-option h4 {
                margin-bottom: 5px;
                font-size: 16px;
            }

            .vehicle-option p {
                color: #6b7280;
                font-size: 14px;
            }

            .submit-btn {
                background-color: #2563eb;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 14px 30px;
                font-size: 16px;
                font-weight: 600;
                width: 100%;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 10px;
            }

            .submit-btn:hover {
                background-color: #1e40af;
            }
            
            /* Price info styling */
.price-info {
    font-size: 0.85em;
    color: #666;
    margin-top: 5px;
}

/* Price section styling */
.price-section {
    margin: 20px 0;
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    padding: 15px;
    background-color: #f9f9f9;
}

.price-details {
    width: 100%;
}

.price-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
    font-size: 14px;
}

.price-row.total {
    margin-top: 10px;
    padding-top: 10px;
    border-top: 1px solid #ddd;
    font-weight: bold;
    font-size: 16px;
}

/* Vehicle option selected state */
.vehicle-option.selected {
    border-color: #4CAF50;
    background-color: rgba(76, 175, 80, 0.1);
}

.vehicle-option {
    border: 2px solid #ddd;
    border-radius: 5px;
    padding: 10px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
}

.vehicle-option:hover {
    border-color: #4CAF50;
}

            /* Features Section */
            .features-section {
                padding: 80px 20px;
                background-color: #f9fafb;
            }

            .features-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .section-title {
                text-align: center;
                margin-bottom: 50px;
            }

            .section-title h2 {
                font-size: 32px;
                color: #333;
                margin-bottom: 15px;
            }

            .section-title p {
                color: #6b7280;
                max-width: 700px;
                margin: 0 auto;
            }

            .features-grid {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 30px;
            }

            .feature-card {
                flex: 1 0 250px;
                max-width: 350px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                padding: 30px;
                text-align: center;
                transition: all 0.3s;
            }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .feature-icon {
                width: 60px;
                height: 60px;
                background-color: rgba(37, 99, 235, 0.1);
                border-radius: 50%;
                margin: 0 auto 20px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .feature-icon i {
                font-size: 24px;
                color: #2563eb;
            }

            .feature-card h3 {
                margin-bottom: 15px;
                color: #333;
            }

            .feature-card p {
                color: #6b7280;
                line-height: 1.6;
            }

            /* Footer */
            footer {
                background-color: #1f2937;
                color: white;
                padding: 60px 20px 20px;
            }

            .footer-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .footer-col {
                flex: 1 0 200px;
                margin-bottom: 30px;
            }

            .footer-col h4 {
                font-size: 18px;
                margin-bottom: 20px;
                position: relative;
            }

            .footer-col h4::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: -8px;
                height: 2px;
                width: 50px;
                background-color: #2563eb;
            }

            .footer-col p {
                margin-bottom: 10px;
                color: #d1d5db;
            }

            .footer-col a {
                display: block;
                margin-bottom: 10px;
                color: #d1d5db;
                text-decoration: none;
                transition: all 0.3s;
            }

            .footer-col a:hover {
                color: white;
                padding-left: 5px;
            }

            .social-icons {
                display: flex;
                gap: 15px;
                margin-top: 20px;
            }

            .social-icons a {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                background-color: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                transition: all 0.3s;
            }

            .social-icons a:hover {
                background-color: #2563eb;
                transform: translateY(-3px);
            }

            .footer-bottom {
                text-align: center;
                padding-top: 30px;
                margin-top: 30px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                color: #9ca3af;
            }
            .vehicle-option {
    cursor: pointer;
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.vehicle-option:hover {
    background-color: #f5f5f5;
}

.vehicle-option.selected {
    background-color: #f0f8ff;
    border: 2px solid #007bff;
}

.price-result {
    margin: 20px 0;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f9f9f9;
}

.price-details {
    margin-top: 10px;
}

.total-price {
    font-size: 1.2em;
    color: #0066cc;
    margin-top: 10px;
}

.error {
    color: red;
}
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>
        <section id="header">
            <a href="#" class="logo"><img width="60" src="./assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab"></a>
            <div>
                <ul id="navbar">
                    <li><a href="">Home</a></li>
                    <li><a href="./views/main-layout/Services.jsp">Services</a></li>
                    <li><a href="./views/main-layout/helpPage.jsp">Help</a></li>
                    <% 
            HttpSession userSession = request.getSession(false);
            User user = (userSession != null) ? (User)userSession.getAttribute("user") : null;
            
           if(user == null) { 
            %>
                <button id="booknow"><a class='booknow' href="./views/auth-layout/sign-in/signIn.jsp">Sign In</a></button>
            <% } else { %>
                <button id="booknow"><a href="LogoutServlet">Log Out</a></button>
                <li id="user-menu">
                    <i class="fa-solid fa-user" id="user-icon"></i>
                    <div id="username">
                        <span><%= user.getUsername() %></span> 
                    </div>
                </li>
            <% } %>
            
                </ul>
            </div>
        </section>

        <div class="hero-section">
            <h1>BOOK YOUR RIDE NOW</h1>
            <p>Experience comfortable, safe and reliable transportation across the city with our professional drivers and well-maintained vehicles.</p>
            <div class="cta-buttons">
                <button class="btn btn-primary">Book Now</button>
                <button class="btn btn-outline">Learn More</button>
            </div>
        </div>
        
<section class="booking-section">
    <div class="booking-container">
        <div class="booking-header">
            <h2>MAKE A RESERVATION</h2>
            <p>Fill in the details below to book your ride</p>
        </div>

        <h3 class="form-label">Select Vehicle Type</h3>
        <div class="vehicle-options">
            <div class="vehicle-option" onclick="selectVehicle('economy')">
                <h4>Economy</h4>
                <p>Up to 4 passengers</p>
                <p class="price-info">Rs. 60/km + Rs. 150 base</p>
            </div>
            <div class="vehicle-option" onclick="selectVehicle('premium')">
                <h4>Premium</h4>
                <p>Up to 4 passengers</p>
                <p class="price-info">Rs. 80/km + Rs. 200 base</p>
            </div>
            <div class="vehicle-option" onclick="selectVehicle('suv')">
                <h4>SUV</h4>
                <p>Up to 6 passengers</p>
                <p class="price-info">Rs. 100/km + Rs. 250 base</p>
            </div>
            <div class="vehicle-option" onclick="selectVehicle('van')">
                <h4>Van</h4>
                <p>Up to 12 passengers</p>
                <p class="price-info">Rs. 120/km + Rs. 300 base</p>
            </div>
        </div>
        <!--<input type="hidden" id="vehicleType" name="vehicleType" value="">-->

        <form id="bookingForm">
                    <input type="hidden" id="vehicleType" name="vehicleType" value="">

            <div class="form-row">
                <div class="form-group">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Enter your full name">
                    <span id="nameError" class="error-message"></span>
                </div>

                <div class="form-group">
                    <label for="mobile" class="form-label">Mobile Number</label>
                    <input type="text" id="mobile" name="mobile" class="form-control" placeholder="Enter your mobile number">
                    <span id="mobileError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="date" class="form-label">Pickup Date</label>
                    <input type="date" id="date" name="date" class="form-control">
                    <span id="dateError" class="error-message"></span>
                </div>

                <div class="form-group">
                    <label for="time" class="form-label">Pickup Time</label>
                    <input type="time" id="time" name="time" class="form-control">
                    <span id="timeError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="pickupLocation" class="form-label">Pickup Location</label>
                    <select id="pickupLocation" name="pickupLocation" class="form-control" required>
                        <option value="">Select Pickup Location</option>
                        <% 
                        LocationDAO locationDAO = new LocationDAO();
                        List<Location> locations = locationDAO.getAllLocations();

                        for(Location location : locations) {
                        %>
                            <option value="<%= location.getLocationID() %>"><%= location.getLocationName() %></option>
                        <% } %>
                    </select>
                    <span id="pickupError" class="error-message"></span>
                </div>

                <div class="form-group">
                    <label for="dropLocation" class="form-label">Drop Location</label>
                    <select id="dropLocation" name="dropLocation" class="form-control" required>
                        <option value="">Select Drop Location</option>
                        <% for(Location location : locations) { %>
                            <option value="<%= location.getLocationID() %>"><%= location.getLocationName() %></option>
                        <% } %>
                    </select>
                    <span id="dropError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="passengers" class="form-label">Number of Passengers</label>
                    <select id="passengers" name="passengers" class="form-control">
                        <option value="1">1 passenger</option>
                        <option value="2">2 passengers</option>
                        <option value="3">3 passengers</option>
                        <option value="4">4 passengers</option>
                        <option value="5">5 passengers</option>
                        <option value="6">6+ passengers</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="address" class="form-label">Your Address</label>
                    <input type="text" id="address" name="address" class="form-control" placeholder="Enter your address">
                    <span id="addressError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group" style="flex-basis: 100%;">
                    <label for="notes" class="form-label">Special Instructions (Optional)</label>
                    <textarea id="notes" name="notes" class="form-control" rows="3" placeholder="Any special requests or instructions for your driver"></textarea>
                </div>
            </div>

            <div class="price-section">
                <div class="price-details">
                    <div class="price-row">
                        <span>Distance:</span>
                        <span id="distance-value">0.00 km</span>
                    </div>
                    <div class="price-row">
                        <span>Base Price:</span>
                        <span id="base-price">Rs. 0.00</span>
                    </div>
                    <div class="price-row">
                        <span>Distance Cost:</span>
                        <span id="distance-cost">Rs. 0.00</span>
                    </div>
                    <div class="price-row total">
                        <span>Total Price:</span>
                        <span id="total-price">Rs. 0.00</span>
                    </div>
                </div>
            </div>
                        
            <div id="priceCalculationResult"></div>

            <!-- Add hidden fields to store calculation results for booking -->
            <input type="hidden" id="calculatedDistance" name="calculatedDistance" value="">
            <input type="hidden" id="calculatedBasePrice" name="calculatedBasePrice" value="">
            <input type="hidden" id="calculatedDistanceCost" name="calculatedDistanceCost" value="">
            <input type="hidden" id="calculatedTotalPrice" name="calculatedTotalPrice" value="">
            <input type="hidden" id="fromLocationID" name="fromLocationID" value="">
            <input type="hidden" id="toLocationID" name="toLocationID" value="">
            <!-- Include email and NIC fields that will be needed for customer record -->
            <input type="hidden" id="email" name="email" value="customer@example.com">
            <input type="hidden" id="nic" name="nic" value="NIC12345">

            <button type="button" class="submit-btn" onclick="validateForm()">BOOK NOW</button>
        </form>
    </div>
</section>

        <section class="features-section">
            <div class="features-container">
                <div class="section-title">
                    <h2>Why Choose Mega City Cab</h2>
                    <p>Experience the best in transportation services with our professional drivers and premium vehicles</p>
                </div>

                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3>Punctual Service</h3>
                        <p>We value your time and ensure our drivers arrive at the scheduled pickup time, every time.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Safe Rides</h3>
                        <p>All our drivers are professionally trained, vetted, and committed to your safety.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <h3>Clean Vehicles</h3>
                        <p>Our vehicles are regularly maintained and sanitized to ensure a comfortable journey.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <h3>Transparent Pricing</h3>
                        <p>Know exactly what you'll pay with our upfront pricing policy with no hidden charges.</p>
                    </div>
                </div>
            </div>
        </section>

        <footer>
            <div class="footer-container">
                <div class="footer-col">
                    <img src="./assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab" width="60">
                    <p>Mega City Cab provides reliable transportation services across the city, ensuring comfort and safety for all passengers.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>

                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <a href="index.jsp">Home</a>
                    <a href="services.html">Our Services</a>
                    <a href="about.html">About Us</a>
                    <a href="booking.html">Book a Ride</a>
                    <a href="contact.html">Contact Us</a>
                </div>

                <div class="footer-col">
                    <h4>Services</h4>
                    <a href="#">Airport Transfer</a>
                    <a href="#">City Tours</a>
                    <a href="#">Corporate Service</a>
                    <a href="#">Intercity Travel</a>
                    <a href="#">Special Events</a>
                </div>

                <div class="footer-col">
                    <h4>Contact Info</h4>
                    <p><i class="fas fa-map-marker-alt"></i> Lahore, Pakistan - 54840</p>
                    <p><i class="fas fa-phone"></i> +92-321-4655990</p>
                    <p><i class="fas fa-envelope"></i> info@megacitycab.com</p>
                    <p><i class="fas fa-clock"></i> 24/7 Customer Support</p>
                </div>
            </div>

            <div class="footer-bottom">
                <p>© 2025 Mega City Cab | All Rights Reserved</p>
            </div>
        </footer>

      <script>
              // Global variables to store data
    let selectedVehicleType = '';
    let distancesList = [];
    let pricesList = [];

    // Initialize data when the page loads
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize the data
        loadDistanceData();
        loadPriceData();
        
        // Set up event listeners
        document.getElementById('pickupLocation').addEventListener('change', function() {
            document.getElementById('pickupError').innerText = '';
            if (selectedVehicleType && document.getElementById('dropLocation').value) {
                calculatePrice();
            }
        });

        document.getElementById('dropLocation').addEventListener('change', function() {
            document.getElementById('dropError').innerText = '';
            if (selectedVehicleType && document.getElementById('pickupLocation').value) {
                calculatePrice();
            }
        });
    });

    // Load distance data
    function loadDistanceData() {
        <%
        List<LocationDistance> distances = (List<LocationDistance>) request.getAttribute("distancesList");
        if (distances != null) {
            for (LocationDistance distance : distances) {
        %>
            distancesList.push({
                fromLocationID: <%= distance.getFromLocationID() %>,
                toLocationID: <%= distance.getToLocationID() %>,
                distanceKM: <%= distance.getDistanceKM() %>
            });
        <%
            }
        }
        %>
        console.log("Loaded " + distancesList.length + " distance records");
    }

    // Load price data
    function loadPriceData() {
        <%
        List<VehiclePrice> prices = (List<VehiclePrice>) request.getAttribute("pricesList");
        if (prices != null) {
            for (VehiclePrice price : prices) {
        %>
            pricesList.push({
                vehicleType: "<%= price.getVehicleType() %>",
                pricePerKM: <%= price.getPricePerKM() %>,
                basePrice: <%= price.getBasePrice() %>
            });
        <%
            }
        }
        %>
        console.log("Loaded " + pricesList.length + " price records");
    }

        // Select a vehicle
        function selectVehicle(vehicleType) {
            // Highlight the selected vehicle
            const options = document.querySelectorAll('.vehicle-option');
            options.forEach(option => {
                option.classList.remove('selected');
            });
            event.currentTarget.classList.add('selected');
            
            // Update the hidden input
            document.getElementById('vehicleType').value = vehicleType;
            selectedVehicleType = vehicleType;
            
            console.log("Selected vehicle: " + selectedVehicleType);
            
            // Calculate price if both locations are also selected
            const pickupLocationId = document.getElementById('pickupLocation').value;
            const dropLocationId = document.getElementById('dropLocation').value;
            
            if (pickupLocationId && dropLocationId) {
                calculatePrice();
            }
        }

        // Calculate price based on selected locations and vehicle type
        function calculatePrice() {
            const pickupLocationId = parseInt(document.getElementById('pickupLocation').value);
            const dropLocationId = parseInt(document.getElementById('dropLocation').value);
            
            // Validate inputs
            if (!pickupLocationId || !dropLocationId || !selectedVehicleType) {
                console.log("Missing data for calculation", {
                    pickup: pickupLocationId,
                    drop: dropLocationId,
                    vehicle: selectedVehicleType
                });
                return;
            }
            
            // Check if pickup and drop are the same
            if (pickupLocationId === dropLocationId) {
                document.getElementById('dropError').innerText = 'Pickup and drop locations cannot be the same';
                clearPriceDisplay();
                return;
            } else {
                document.getElementById('dropError').innerText = '';
            }
            
            // Find distance between locations
            let distance = 0;
            for (let i = 0; i < distancesList.length; i++) {
                if ((distancesList[i].fromLocationID === pickupLocationId && 
                     distancesList[i].toLocationID === dropLocationId) ||
                    (distancesList[i].fromLocationID === dropLocationId && 
                     distancesList[i].toLocationID === pickupLocationId)) {
                    distance = distancesList[i].distanceKM;
                    break;
                }
            }
            
            if (distance === 0) {
                document.getElementById('priceCalculationResult').innerHTML = 
                    '<p class="error">Distance not found between selected locations</p>';
                clearPriceDisplay();
                return;
            }
            
            // Find vehicle price details
            let vehiclePrice = null;
            for (let i = 0; i < pricesList.length; i++) {
                if (pricesList[i].vehicleType.toLowerCase() === selectedVehicleType.toLowerCase()) {
                    vehiclePrice = pricesList[i];
                    break;
                }
            }
            
            if (!vehiclePrice) {
                // If we can't find the price in the database, use hardcoded values
                // based on the vehicle selection UI
                switch(selectedVehicleType.toLowerCase()) {
                    case 'economy':
                        vehiclePrice = { pricePerKM: 60, basePrice: 150 };
                        break;
                    case 'premium':
                        vehiclePrice = { pricePerKM: 80, basePrice: 200 };
                        break;
                    case 'suv':
                        vehiclePrice = { pricePerKM: 100, basePrice: 250 };
                        break;
                    case 'van':
                        vehiclePrice = { pricePerKM: 120, basePrice: 300 };
                        break;
                    default:
                        document.getElementById('priceCalculationResult').innerHTML = 
                            '<p class="error">Price details not found for selected vehicle</p>';
                        clearPriceDisplay();
                        return;
                }
            }
            
            // Calculate costs
            const basePrice = vehiclePrice.basePrice;
            const distanceCost = distance * vehiclePrice.pricePerKM;
            const totalPrice = basePrice + distanceCost;
            
            // Display the results
            document.getElementById('distance-value').textContent = distance.toFixed(2) + ' km';
            document.getElementById('base-price').textContent = 'Rs. ' + basePrice.toFixed(2);
            document.getElementById('distance-cost').textContent = 'Rs. ' + distanceCost.toFixed(2);
            document.getElementById('total-price').textContent = 'Rs. ' + totalPrice.toFixed(2);
            
            // Store values in hidden fields for form submission
            document.getElementById('calculatedDistance').value = distance;
            document.getElementById('calculatedBasePrice').value = basePrice;
            document.getElementById('calculatedDistanceCost').value = distanceCost;
            document.getElementById('calculatedTotalPrice').value = totalPrice;
            document.getElementById('fromLocationID').value = pickupLocationId;
            document.getElementById('toLocationID').value = dropLocationId;
            
            // Clear any previous calculation errors
            document.getElementById('priceCalculationResult').innerHTML = '';
        }

        // Clear price display values
        function clearPriceDisplay() {
            document.getElementById('distance-value').textContent = '0.00 km';
            document.getElementById('base-price').textContent = 'Rs. 0.00';
            document.getElementById('distance-cost').textContent = 'Rs. 0.00';
            document.getElementById('total-price').textContent = 'Rs. 0.00';
            
            // Clear hidden fields
            document.getElementById('calculatedDistance').value = '';
            document.getElementById('calculatedBasePrice').value = '';
            document.getElementById('calculatedDistanceCost').value = '';
            document.getElementById('calculatedTotalPrice').value = '';
        }

        // Validation function
        function validateForm() {
            let isValid = true;
            
            // Check if a vehicle type is selected
            if (!document.getElementById('vehicleType').value) {
                alert('Please select a vehicle type');
                isValid = false;
                return;
            }
            
            // Check the name field
            const name = document.getElementById('name').value;
            if (!name) {
                document.getElementById('nameError').innerText = 'Name is required';
                isValid = false;
            } else {
                document.getElementById('nameError').innerText = '';
            }
            
            // Check the mobile field
            const mobile = document.getElementById('mobile').value;
            if (!mobile) {
                document.getElementById('mobileError').innerText = 'Mobile number is required';
                isValid = false;
            } else if (!/^[0-9]{10}$/.test(mobile)) {
                document.getElementById('mobileError').innerText = 'Invalid mobile number';
                isValid = false;
            } else {
                document.getElementById('mobileError').innerText = '';
            }
            
            // Check date and time
            const date = document.getElementById('date').value;
            const time = document.getElementById('time').value;
            
            if (!date) {
                document.getElementById('dateError').innerText = 'Date is required';
                isValid = false;
            } else {
                document.getElementById('dateError').innerText = '';
            }
            
            if (!time) {
                document.getElementById('timeError').innerText = 'Time is required';
                isValid = false;
            } else {
                document.getElementById('timeError').innerText = '';
            }
            
            // Check pickup and drop locations
            const pickup = document.getElementById('pickupLocation').value;
            const drop = document.getElementById('dropLocation').value;
            
            if (!pickup) {
                document.getElementById('pickupError').innerText = 'Pickup location is required';
                isValid = false;
            } else {
                document.getElementById('pickupError').innerText = '';
            }
            
            if (!drop) {
                document.getElementById('dropError').innerText = 'Drop location is required';
                isValid = false;
            } else {
                document.getElementById('dropError').innerText = '';
            }
            
            // Check if pickup and drop are the same
            if (pickup && drop && pickup === drop) {
                document.getElementById('dropError').innerText = 'Pickup and drop locations cannot be the same';
                isValid = false;
            }
            
            // Check address
            const address = document.getElementById('address').value;
            if (!address) {
                document.getElementById('addressError').innerText = 'Address is required';
                isValid = false;
            } else {
                document.getElementById('addressError').innerText = '';
            }
            
            if (isValid) {
                // If all validations pass, submit the form
                document.getElementById('bookingForm').action = "BookingServlet";
                document.getElementById('bookingForm').method = "POST";
                document.getElementById('bookingForm').submit();
            }
        }
    </script>
    </body>
</html>
