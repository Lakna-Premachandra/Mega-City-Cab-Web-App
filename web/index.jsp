<%-- 
    Document   : index
    Created on : Mar 10, 2025, 8:47:55 PM
    Author     : PC
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.LocationDAO"%>
<%@ page import="Models.Location"%>
<%@ page import="java.util.List"%>
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
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
    <body>
        <section id="header">
            <a href="#" class="logo"><img width="60" src="./assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab"></a>
            <div>
                <ul id="navbar">
                    <li><a href="">Home</a></li>
                    <li><a href="./views/main-layout/Services.jsp">Services</a></li>
                    <li><a href="./views/main-layout/helpPage.jsp">Help</a></li>
                    <li><a href="./views/auth-layout/sign-in/signIn.jsp">Sign In</a></li>
                    <button id="booknow"><a class='booknow' href="contact.html">Contact Us</a></button>
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
                <img src="/api/placeholder/120/60" alt="Economy Car">
                <h4>Economy</h4>
                <p>Up to 4 passengers</p>
                <p class="price-info">Rs. 60/km + Rs. 150 base</p>
            </div>
            <div class="vehicle-option" onclick="selectVehicle('premium')">
                <img src="/api/placeholder/120/60" alt="Premium Car">
                <h4>Premium</h4>
                <p>Up to 4 passengers</p>
                <p class="price-info">Rs. 80/km + Rs. 200 base</p>
            </div>
            <div class="vehicle-option" onclick="selectVehicle('suv')">
                <img src="/api/placeholder/120/60" alt="SUV">
                <h4>SUV</h4>
                <p>Up to 6 passengers</p>
                <p class="price-info">Rs. 100/km + Rs. 250 base</p>
            </div>
            <div class="vehicle-option" onclick="selectVehicle('van')">
                <img src="/api/placeholder/120/60" alt="Van">
                <h4>Van</h4>
                <p>Up to 12 passengers</p>
                <p class="price-info">Rs. 120/km + Rs. 300 base</p>
            </div>
        </div>
        <input type="hidden" id="vehicleType" name="vehicleType" value="">

        <form id="bookingForm">
            <div class="form-row">
                <div class="form-group">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" id="name" class="form-control" placeholder="Enter your full name">
                    <span id="nameError" class="error-message"></span>
                </div>

                <div class="form-group">
                    <label for="mobile" class="form-label">Mobile Number</label>
                    <input type="text" id="mobile" class="form-control" placeholder="Enter your mobile number">
                    <span id="mobileError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="date" class="form-label">Pickup Date</label>
                    <input type="date" id="date" class="form-control">
                    <span id="dateError" class="error-message"></span>
                </div>

                <div class="form-group">
                    <label for="time" class="form-label">Pickup Time</label>
                    <input type="time" id="time" class="form-control">
                    <span id="timeError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="pickup" class="form-label">Pickup Location</label>
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
                    <label for="drop" class="form-label">Drop Location</label>
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
                    <select id="passengers" class="form-control">
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
                    <input type="text" id="address" class="form-control" placeholder="Enter your address">
                    <span id="addressError" class="error-message"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group" style="flex-basis: 100%;">
                    <label for="notes" class="form-label">Special Instructions (Optional)</label>
                    <textarea id="notes" class="form-control" rows="3" placeholder="Any special requests or instructions for your driver"></textarea>
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
let locations = [];
let selectedVehicleType = '';
let basePrice = 0;
let pricePerKm = 0;

document.addEventListener('DOMContentLoaded', function() {
    loadLocations();
    
    document.getElementById('pickup').addEventListener('change', calculatePriceIfPossible);
    document.getElementById('drop').addEventListener('change', calculatePriceIfPossible);
});

function loadLocations() {
    fetch('getLocations')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            locations = data;
            
            const pickupSelect = document.getElementById('pickup');
            const dropSelect = document.getElementById('drop');
            
            while (pickupSelect.options.length > 1) {
                pickupSelect.remove(1);
            }
            
            while (dropSelect.options.length > 1) {
                dropSelect.remove(1);
            }
            
            locations.forEach(location => {
                const pickupOption = document.createElement('option');
                pickupOption.value = location.locationID;
                pickupOption.textContent = location.locationName;
                pickupSelect.appendChild(pickupOption);
                
                const dropOption = document.createElement('option');
                dropOption.value = location.locationID;
                dropOption.textContent = location.locationName;
                dropSelect.appendChild(dropOption);
            });
        })
        .catch(error => {
            console.error('Error loading locations:', error);
            alert('Failed to load locations. Please refresh the page or try again later.');
        });
}

function selectVehicle(vehicleType) {
    document.getElementById('vehicleType').value = vehicleType;
    selectedVehicleType = vehicleType;
    
    // Update visual selection
    const options = document.querySelectorAll('.vehicle-option');
    options.forEach(option => {
        option.classList.remove('selected');
    });
    
    event.currentTarget.classList.add('selected');
    
    switch(vehicleType) {
        case 'economy':
            basePrice = 150;
            pricePerKm = 60;
            break;
        case 'premium':
            basePrice = 200;
            pricePerKm = 80;
            break;
        case 'suv':
            basePrice = 250;
            pricePerKm = 100;
            break;
        case 'van':
            basePrice = 300;
            pricePerKm = 120;
            break;
    }
    
    document.getElementById('base-price').textContent = `Rs. ${basePrice.toFixed(2)}`;
    
    calculatePriceIfPossible();
}

function calculatePriceIfPossible() {
    const pickupId = document.getElementById('pickup').value;
    const dropId = document.getElementById('drop').value;
    
    if (pickupId && dropId && selectedVehicleType) {
        calculatePrice(pickupId, dropId);
    }
}

function calculatePrice(fromLocationId, toLocationId) {
    document.getElementById('distance-value').textContent = 'Calculating...';
    document.getElementById('distance-cost').textContent = 'Calculating...';
    document.getElementById('total-price').textContent = 'Calculating...';
    
    fetch(`calculatePrice?fromLocationId=${fromLocationId}&toLocationId=${toLocationId}&vehicleType=${selectedVehicleType}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                document.getElementById('distance-value').textContent = `${data.distance.toFixed(2)} km`;
                
                document.getElementById('base-price').textContent = `Rs. ${data.basePrice.toFixed(2)}`;
                
                document.getElementById('distance-cost').textContent = `Rs. ${data.distanceCost.toFixed(2)}`;
                
                document.getElementById('total-price').textContent = data.formattedPrice;
            } else {
                document.getElementById('distance-value').textContent = 'N/A';
                document.getElementById('distance-cost').textContent = 'N/A';
                document.getElementById('total-price').textContent = 'Route not available';
                
                alert(data.error || 'Route not available between the selected locations.');
            }
        })
        .catch(error => {
            console.error('Error calculating price:', error);
            
            // Reset displays
            document.getElementById('distance-value').textContent = 'Error';
            document.getElementById('distance-cost').textContent = 'Error';
            document.getElementById('total-price').textContent = 'Error';
            
            alert('Failed to calculate price. Please try again later.');
        });
}

function validateForm() {
    const name = document.getElementById('name');
    const date = document.getElementById('date');
    const time = document.getElementById('time');
    const pickup = document.getElementById('pickup');
    const drop = document.getElementById('drop');
    const mobile = document.getElementById('mobile');
    const address = document.getElementById('address');
    const vehicleType = document.getElementById('vehicleType');

    const nameError = document.getElementById('nameError');
    const dateError = document.getElementById('dateError');
    const timeError = document.getElementById('timeError');
    const pickupError = document.getElementById('pickupError');
    const dropError = document.getElementById('dropError');
    const mobileError = document.getElementById('mobileError');
    const addressError = document.getElementById('addressError');

    nameError.textContent = '';
    nameError.style.display = 'none';
    dateError.textContent = '';
    dateError.style.display = 'none';
    timeError.textContent = '';
    timeError.style.display = 'none';
    pickupError.textContent = '';
    pickupError.style.display = 'none';
    dropError.textContent = '';
    dropError.style.display = 'none';
    mobileError.textContent = '';
    mobileError.style.display = 'none';
    addressError.textContent = '';
    addressError.style.display = 'none';

    let isValid = true;

    if (name.value.trim() === '') {
        nameError.textContent = 'Full name is required';
        nameError.style.display = 'block';
        isValid = false;
    }

    if (date.value.trim() === '') {
        dateError.textContent = 'Pickup date is required';
        dateError.style.display = 'block';
        isValid = false;
    } else {
        // Validate date is not in the past
        const selectedDate = new Date(date.value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        
        if (selectedDate < today) {
            dateError.textContent = 'Please select a future date';
            dateError.style.display = 'block';
            isValid = false;
        }
    }
    
    if (time.value.trim() === '') {
        timeError.textContent = 'Pickup time is required';
        timeError.style.display = 'block';
        isValid = false;
    }

    if (pickup.value.trim() === '') {
        pickupError.textContent = 'Pickup location is required';
        pickupError.style.display = 'block';
        isValid = false;
    }

    if (drop.value.trim() === '') {
        dropError.textContent = 'Drop location is required';
        dropError.style.display = 'block';
        isValid = false;
    }

    if (mobile.value.trim() === '') {
        mobileError.textContent = 'Mobile number is required';
        </script>
    </body>
</html>
