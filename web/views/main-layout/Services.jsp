<%@ page import="Models.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Services</title>
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
                        url('../../assets/images/premium_photo-1728723283456-c39c5d62e12d.jpeg');
                background-size: cover;
                background-position: center;
                color: white;
                text-align: center;
                padding: 100px 20px;
            }

            .hero-section h1 {
                font-size: 3.5rem;
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

            .hero-btn {
                display: inline-block;
                background-color: #2563eb;
                color: white;
                padding: 15px 30px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                margin-top: 20px;
                font-size: 16px;
            }

            .hero-btn:hover {
                background-color: #1e40af;
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }

            /* Services Container */
            .services-container {
                max-width: 1200px;
                margin: -50px auto 80px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                padding: 40px;
                position: relative;
            }

            .section-title {
                text-align: center;
                margin-bottom: 60px;
            }

            .section-title h2 {
                font-size: 32px;
                color: #333;
                margin-bottom: 15px;
                position: relative;
                display: inline-block;
            }

            .section-title h2::after {
                content: '';
                position: absolute;
                width: 70px;
                height: 3px;
                background-color: #2563eb;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
            }

            .section-title p {
                color: #6b7280;
                max-width: 700px;
                margin: 0 auto;
            }

            /* Featured Services */
            .featured-services {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 30px;
                margin-bottom: 60px;
            }

            .service-card {
                background: #fff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            .service-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            }

            .service-img {
                height: 200px;
                width: 100%;
                background-size: cover;
                background-position: center;
            }

            .service-content {
                padding: 25px;
            }

            .service-content h3 {
                font-size: 22px;
                margin-bottom: 15px;
                color: #333;
            }

            .service-content p {
                color: #6b7280;
                margin-bottom: 20px;
                line-height: 1.6;
            }

            .service-btn {
                display: inline-block;
                padding: 10px 20px;
                background: #f0f7ff;
                color: #2563eb;
                text-decoration: none;
                border-radius: 50px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .service-btn:hover {
                background: #2563eb;
                color: white;
            }

            /* How It Works */
            .how-it-works {
                margin: 80px 0;
            }

            .process-steps {
                display: flex;
                justify-content: space-between;
                margin-top: 50px;
                flex-wrap: wrap;
            }

            .step {
                flex: 1;
                min-width: 200px;
                text-align: center;
                padding: 0 20px;
                position: relative;
                margin-bottom: 30px;
            }

            .step:not(:last-child)::after {
                content: '';
                position: absolute;
                top: 50px;
                right: 0;
                width: 70%;
                height: 2px;
                background: #e5e7eb;
                transform: translateX(50%);
            }

            .step-icon {
                width: 100px;
                height: 100px;
                background: #f0f7ff;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                color: #2563eb;
                font-size: 40px;
                position: relative;
            }

            .step-number {
                position: absolute;
                top: -10px;
                right: -10px;
                width: 40px;
                height: 40px;
                background: #2563eb;
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                font-size: 18px;
            }

            .step h3 {
                margin-bottom: 15px;
                color: #333;
            }

            .step p {
                color: #6b7280;
                line-height: 1.6;
            }

            /* Additional Services */
            .additional-services {
                background: #f0f7ff;
                padding: 40px;
                border-radius: 10px;
                margin-top: 60px;
            }

            .services-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }

            .service-item {
                background: white;
                padding: 25px;
                border-radius: 8px;
                display: flex;
                align-items: flex-start;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }

            .service-icon {
                color: #2563eb;
                font-size: 24px;
                margin-right: 15px;
                min-width: 30px;
            }

            .service-details h4 {
                margin-bottom: 10px;
                color: #333;
            }

            .service-details p {
                color: #6b7280;
                font-size: 14px;
                line-height: 1.6;
            }

            /* Testimonials */
            .testimonials {
                margin: 80px 0 40px;
            }

            .testimonial-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 30px;
                margin-top: 50px;
            }

            .testimonial-card {
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                display: flex;
                flex-direction: column;
            }

            .testimonial-content {
                margin-bottom: 20px;
                line-height: 1.6;
                color: #4b5563;
                font-style: italic;
            }

            .testimonial-content i {
                color: #2563eb;
                font-size: 20px;
                margin-right: 10px;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
                margin-top: auto;
            }

            .author-img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-size: cover;
                background-position: center;
                margin-right: 15px;
            }

            .author-info h4 {
                margin-bottom: 5px;
                color: #333;
            }

            .author-info p {
                color: #6b7280;
                font-size: 14px;
            }

            .rating {
                color: #f59e0b;
                margin-top: 5px;
            }

            /* CTA Section */
            .cta-section {
                background: linear-gradient(135deg, #2563eb, #1e40af);
                border-radius: 10px;
                padding: 60px 40px;
                color: white;
                text-align: center;
                margin-top: 80px;
            }

            .cta-section h3 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            .cta-section p {
                margin-bottom: 30px;
                max-width: 700px;
                margin-left: auto;
                margin-right: auto;
                line-height: 1.6;
            }

            .cta-buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .cta-btn {
                padding: 15px 30px;
                border-radius: 50px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .cta-btn.primary {
                background: white;
                color: #2563eb;
            }

            .cta-btn.secondary {
                background: transparent;
                border: 2px solid white;
                color: white;
            }

            .cta-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
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

            @media (max-width: 768px) {
                .hero-section h1 {
                    font-size: 2.5rem;
                }
                
                .services-container {
                    padding: 20px;
                    margin-top: 20px;
                }
                
                .process-steps {
                    flex-direction: column;
                }
                
                .step:not(:last-child)::after {
                    display: none;
                }
                
                #header {
                    padding: 15px;
                }
                
                #navbar li {
                    padding: 0 10px;
                }
                
                .how-it-works {
                    margin: 40px 0;
                }
                
                .cta-section {
                    padding: 40px 20px;
                }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
    <body>
        <section id="header">
             <a href="#" class="logo"><img width="60" src="./../../assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab"></a>
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
                <a href="views/auth-layout/sign-up/DriverSignUp.jsp"></a>
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

        <!-- Hero Section -->
        <div class="hero-section">
            <h1>OUR PREMIUM SERVICES</h1>
            <p>Discover a new standard of comfort and reliability with our wide range of transportation solutions</p>
            <a href="booking.html" class="hero-btn">Book Your Ride Now</a>
        </div>

        <!-- Services Content -->
        <div class="services-container">
            <div class="section-title">
                <h2>Featured Services</h2>
                <p>Premium transportation options tailored to your needs</p>
            </div>
            
            <div class="featured-services">
                <div class="service-card">
                    <div class="service-img" style="background-image: url('../../assets/images/airport.jpeg');"></div>
                    <div class="service-content">
                        <h3>Airport Transfers</h3>
                        <p>Reliable and comfortable transportation to and from airports with professional drivers and on-time pickups.</p>
                        <a href="#" class="service-btn">Learn More</a>
                    </div>
                </div>
                
                <div class="service-card">
                    <div class="service-img" style="background-image: url('../../assets/images/premium_photo-1728723283456-c39c5d62e12d.jpeg');"></div>
                    <div class="service-content">
                        <h3>City Tours</h3>
                        <p>Explore the city with our knowledgeable drivers who can show you the best attractions and hidden gems.</p>
                        <a href="#" class="service-btn">Learn More</a>
                    </div>
                </div>
                
                <div class="service-card">
                    <div class="service-img" style="background-image: url('../../assets/images/premium_photo-1728723283456-c39c5d62e12d.jpeg');"></div>
                    <div class="service-content">
                        <h3>Corporate Service</h3>
                        <p>Professional transportation solutions for businesses with customized billing options and priority service.</p>
                        <a href="#" class="service-btn">Learn More</a>
                    </div>
                </div>
            </div>
            
            <div class="how-it-works">
                <div class="section-title">
                    <h2>How It Works</h2>
                    <p>Book your ride in just a few simple steps</p>
                </div>
                
                <div class="process-steps">
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-map-marker-alt"></i>
                            <div class="step-number">1</div>
                        </div>
                        <h3>Book Your Ride</h3>
                        <p>Choose your pickup location, destination, and preferred vehicle type through our website or app.</p>
                    </div>
                    
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-car"></i>
                            <div class="step-number">2</div>
                        </div>
                        <h3>Get Matched</h3>
                        <p>We'll assign a professional driver with a well-maintained vehicle to meet your requirements.</p>
                    </div>
                    
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-route"></i>
                            <div class="step-number">3</div>
                        </div>
                        <h3>Track Your Ride</h3>
                        <p>Monitor your driver's arrival in real-time through our app with accurate ETA updates.</p>
                    </div>
                    
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-smile"></i>
                            <div class="step-number">4</div>
                        </div>
                        <h3>Enjoy & Rate</h3>
                        <p>Relax during your comfortable ride and provide feedback to help us improve our service.</p>
                    </div>
                </div>
            </div>
            
            <div class="additional-services">
                <div class="section-title" style="margin-bottom: 30px;">
                    <h2>Additional Services</h2>
                    <p>We offer a wide range of specialized services to meet all your transportation needs</p>
                </div>
                
                <div class="services-grid">
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-plane"></i>
                        </div>
                        <div class="service-details">
                            <h4>Intercity Travel</h4>
                            <p>Comfortable and reliable transportation between cities with experienced drivers.</p>
                        </div>
                    </div>
                    
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-glass-cheers"></i>
                        </div>
                        <div class="service-details">
                            <h4>Event Transportation</h4>
                            <p>Special services for weddings, parties, and corporate events with luxury vehicles.</p>
                        </div>
                    </div>
                    
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <div class="service-details">
                            <h4>Business Travel</h4>
                            <p>Premium services for executives with priority scheduling and professional drivers.</p>
                        </div>
                    </div>
                    
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="service-details">
                            <h4>24/7 Availability</h4>
                            <p>Round-the-clock service for all your transportation needs, any time of day.</p>
                        </div>
                    </div>
                    
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="service-details">
                            <h4>Group Transportation</h4>
                            <p>Vans and minibuses available for larger groups with customized routes.</p>
                        </div>
                    </div>
                    
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-wheelchair"></i>
                        </div>
                        <div class="service-details">
                            <h4>Accessible Vehicles</h4>
                            <p>Specially equipped vehicles to accommodate passengers with mobility needs.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="testimonials">
                <div class="section-title">
                    <h2>What Our Customers Say</h2>
                    <p>Real experiences from satisfied clients</p>
                </div>
                
                <div class="testimonial-grid">
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <i class="fas fa-quote-left"></i>
                            I've been using Mega City Cab for my daily commute for the past 6 months and I couldn't be happier with the service. The drivers are always professional and the vehicles are clean and comfortable.
                        </div>
                        <div class="testimonial-author">
                            <div class="author-img" style="background-image: url('/api/placeholder/100/100');"></div>
                            <div class="author-info">
                                <h4>Sarah Ahmed</h4>
                                <p>Regular Customer</p>
                                <div class="rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <i class="fas fa-quote-left"></i>
                            I used their airport transfer service during my business trip to Lahore and was impressed by the punctuality and professionalism. My driver was waiting for me despite my flight being delayed.
                        </div>
                        <div class="testimonial-author">
                            <div class="author-img" style="background-image: url('/api/placeholder/100/100');"></div>
                            <div class="author-info">
                                <h4>John Wilson</h4>
                                <p>Business Traveler</p>
                                <div class="rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <i class="fas fa-quote-left"></i>
                            We hired Mega City Cab for our corporate event transportation and everything went smoothly. The coordination was excellent and all our executives were picked up and dropped off without any issues.
                        </div>
                        <div class="testimonial-author">
                            <div class="author-img" style="background-image: url('/api/placeholder/100/100');"></div>
                            <div class="author-info">
                                <h4>Amina Khan</h4>
                                <p>Event Manager</p>
                                <div class="rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="cta-section">
                <h3>Ready to Experience Our Premium Services?</h3>
                <p>Book your ride today and discover why thousands of customers trust Mega City Cab for their transportation needs.</p>
                
                <div class="cta-buttons">
                    <a href="booking.html" class="cta-btn primary">Book Now</a>
                    <a href="contact.html" class="cta-btn secondary">Contact Us</a>
                </div>
            </div>
        </div>

        <!-- Footer -->
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
                    <a href="index.html">Home</a>
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
    </body>
</html>