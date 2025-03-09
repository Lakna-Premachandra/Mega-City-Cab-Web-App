<%-- 
    Document   : helpPage
    Created on : Mar 9, 2025, 11:07:40 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Help Center</title>
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
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                           url('https://images.unsplash.com/photo-1511632765486-a01980e01a18?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
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

            .search-container {
                max-width: 600px;
                margin: 30px auto 0;
                position: relative;
            }
            
            .search-box {
                width: 100%;
                padding: 15px 20px;
                border-radius: 50px;
                border: none;
                font-size: 16px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }
            
            .search-btn {
                position: absolute;
                right: 5px;
                top: 5px;
                background: #2563eb;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 50px;
                cursor: pointer;
            }

            /* Help Content */
            .help-container {
                max-width: 1200px;
                margin: -50px auto 80px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                padding: 40px;
                position: relative;
            }

            .help-categories {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 50px;
            }

            .help-category {
                flex: 1 0 200px;
                background: #f9fafb;
                border-radius: 8px;
                padding: 25px;
                text-align: center;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .help-category:hover {
                background: #f0f7ff;
                transform: translateY(-5px);
            }

            .help-category i {
                font-size: 32px;
                color: #2563eb;
                margin-bottom: 15px;
            }

            .help-category h3 {
                margin-bottom: 10px;
            }

            .help-category p {
                color: #6b7280;
                font-size: 14px;
            }

            .faq-section {
                margin-top: 60px;
            }

            .section-title {
                text-align: center;
                margin-bottom: 40px;
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

            .faq-item {
                margin-bottom: 20px;
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                overflow: hidden;
            }

            .faq-question {
                padding: 20px;
                background: #f9fafb;
                cursor: pointer;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-weight: 600;
            }

            .faq-question i {
                color: #2563eb;
                transition: transform 0.3s ease;
            }

            .faq-answer {
                padding: 0 20px;
                max-height: 0;
                overflow: hidden;
                transition: all 0.3s ease;
                line-height: 1.6;
            }

            .faq-item.active .faq-answer {
                padding: 20px;
                max-height: 300px;
            }

            .faq-item.active .faq-question i {
                transform: rotate(180deg);
            }

            .contact-support {
                background: linear-gradient(135deg, #2563eb, #1e40af);
                border-radius: 8px;
                padding: 40px;
                color: white;
                text-align: center;
                margin-top: 60px;
            }

            .contact-support h3 {
                font-size: 24px;
                margin-bottom: 15px;
            }

            .contact-support p {
                margin-bottom: 25px;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            .contact-buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .contact-btn {
                padding: 12px 25px;
                border-radius: 50px;
                background: white;
                color: #2563eb;
                font-weight: 600;
                display: flex;
                align-items: center;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .contact-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }

            .contact-btn i {
                margin-right: 10px;
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
                    font-size: 2rem;
                }
                
                .help-container {
                    padding: 20px;
                    margin-top: 20px;
                }
                
                .contact-buttons {
                    flex-direction: column;
                }
                
                #header {
                    padding: 15px;
                }
                
                #navbar li {
                    padding: 0 10px;
                }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
    <body>
        <!-- Header Section -->
        <section id="header">
            <a href="#" class="logo"><img width="60" src="./assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab"></a>
            <div>
                <ul id="navbar">
                    <li><a href="../../index.html">Home</a></li>
                    <li><a href="../main-layout/Services.jsp">Services</a></li>
                    <li><a class="active" href="../main-layout/helpPage.jspl">Help</a></li>
                    <li><a href="account.html">My Account</a></li>
                    <button id="booknow"><a class='booknow' href="contact.html">Contact Us</a></button>
                </ul>
            </div>
        </section>

        <!-- Hero Section -->
        <div class="hero-section">
            <h1>HOW CAN WE HELP YOU?</h1>
            <p>Find answers to your questions and get the support you need</p>
            
            <div class="search-container">
                <input type="text" class="search-box" placeholder="Search for help topics...">
                <button class="search-btn"><i class="fas fa-search"></i></button>
            </div>
        </div>

        <!-- Help Content -->
        <div class="help-container">
            <div class="help-categories">
                <div class="help-category">
                    <i class="fas fa-book"></i>
                    <h3>Booking Help</h3>
                    <p>Learn how to book, modify or cancel your rides</p>
                </div>
                
                <div class="help-category">
                    <i class="fas fa-credit-card"></i>
                    <h3>Payment Issues</h3>
                    <p>Resolve payment methods and billing questions</p>
                </div>
                
                <div class="help-category">
                    <i class="fas fa-car"></i>
                    <h3>During Your Ride</h3>
                    <p>Get help during your ride or with driver issues</p>
                </div>
                
                <div class="help-category">
                    <i class="fas fa-user"></i>
                    <h3>Account Help</h3>
                    <p>Manage your account settings and profile</p>
                </div>
                
                <div class="help-category">
                    <i class="fas fa-gift"></i>
                    <h3>Promotions</h3>
                    <p>Learn about deals, discounts and referrals</p>
                </div>
            </div>
            
            <div class="faq-section">
                <div class="section-title">
                    <h2>Frequently Asked Questions</h2>
                    <p>Quick answers to the most common questions</p>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        How do I book a ride? <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Booking a ride with Mega City Cab is simple. You can book through our website by clicking on the "Book Now" button, then filling in your pickup and drop-off locations, preferred date and time, and vehicle type. You can also book by calling our customer service at +92-321-4655990.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        How can I cancel my booking? <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>You can cancel your booking by logging into your account, going to "My Bookings," and selecting the "Cancel" option next to the relevant booking. Please note that cancellations made less than 2 hours before the scheduled pickup time may incur a cancellation fee.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        What payment methods do you accept? <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>We accept various payment methods including credit/debit cards (Visa, Mastercard, American Express), cash payments to the driver, and mobile wallet payments such as JazzCash and EasyPaisa. Corporate clients can also set up billing accounts with us for monthly invoicing.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        Is there a waiting charge if I make the driver wait? <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>Yes, there is a waiting charge after the first 5 minutes of the scheduled pickup time. The waiting charge is PKR 50 per 5 minutes. We recommend being ready at your pickup location at the scheduled time to avoid any additional charges.</p>
                    </div>
                </div>
                
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleFAQ(this)">
                        How do I report an item left in the cab? <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>If you've left an item in one of our cabs, please contact our lost and found department immediately at +92-321-4655990 or email us at lostfound@megacitycab.com with details of your ride and a description of the lost item. Our team will coordinate with the driver to retrieve your belongings.</p>
                    </div>
                </div>
            </div>
            
            <div class="contact-support">
                <h3>Still Need Help?</h3>
                <p>Our customer support team is available 24/7 to assist you with any questions or concerns you may have about our services.</p>
                
                <div class="contact-buttons">
                    <a href="tel:+923214655990" class="contact-btn">
                        <i class="fas fa-phone-alt"></i> Call Us
                    </a>
                    <a href="mailto:support@megacitycab.com" class="contact-btn">
                        <i class="fas fa-envelope"></i> Email Support
                    </a>
                    <a href="#" class="contact-btn">
                        <i class="fas fa-comment"></i> Live Chat
                    </a>
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

        <script>
            function toggleFAQ(element) {
                const faqItem = element.parentElement;
                
                // Close all other FAQ items
                const allFaqItems = document.querySelectorAll('.faq-item');
                allFaqItems.forEach(item => {
                    if (item !== faqItem) {
                        item.classList.remove('active');
                    }
                });
                
                // Toggle the clicked FAQ item
                faqItem.classList.toggle('active');
            }
        </script>
    </body>
</html>
