<%-- 
    Document   : customer-account
    Created on : Mar 15, 2025, 10:16:05 AM
    Author     : PC
--%>
<%@page import="Models.Customer"%>
<%@ page import="DAO.BookingDAO"%>
<%@ page import="Models.Booking"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!--<meta http-equiv="refresh" content="30">   Refresh every 30 seconds -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookings - Mega City Cab</title>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background-color: #1f2937;
            color: white;
            padding: 20px 0;
            height: 100vh;
            position: fixed;
            overflow-y: auto;
        }

        .sidebar-logo {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .sidebar-logo img {
            height: 50px;
            width: auto;
            margin-right: 10px;
        }

        .sidebar-logo h2 {
            font-size: 18px;
            font-weight: 700;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            margin-bottom: 5px;
        }

        .sidebar-menu a {
            display: block;
            padding: 12px 20px;
            color: #d1d5db;
            text-decoration: none;
            transition: all 0.3s;
            font-weight: 500;
            cursor: pointer;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background-color: rgba(37, 99, 235, 0.8);
            color: white;
        }

        .sidebar-menu a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 20px;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background-color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .dashboard-header h1 {
            font-size: 24px;
            color: #333;
        }

        .user-profile {
            display: flex;
            align-items: center;
        }

        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .user-info h4 {
            font-size: 16px;
            margin-bottom: 2px;
        }

        .user-info p {
            font-size: 12px;
            color: #6b7280;
        }

        /* Data Card Styles */
        .data-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 30px;
        }

        .data-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .data-card-header h2 {
            font-size: 20px;
            color: #1f2937;
            font-weight: 600;
        }

        .data-card-buttons {
            display: flex;
            gap: 10px;
        }

        /* Table Styles */
        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        table th {
            background-color: #f9fafb;
            font-weight: 600;
            color: #4b5563;
        }

        table tr:hover {
            background-color: #f9fafb;
        }

        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 500;
        }

        .status-pending {
            background-color: #fff7ed;
            color: #c2410c;
        }

        .status-approved {
            background-color: #ecfdf5;
            color: #065f46;
        }

        .status-completed {
            background-color: #eff6ff;
            color: #1e40af;
        }

        .status-cancelled {
            background-color: #fef2f2;
            color: #b91c1c;
        }

        /* Button Styles */
        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1e40af;
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #4b5563;
            border: 1px solid #e5e7eb;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
        }

        .btn-success {
            background-color: #10b981;
            color: white;
        }

        .btn-success:hover {
            background-color: #059669;
        }

        .btn-danger {
            background-color: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background-color: #dc2626;
        }

        /* Action buttons in table */
        .booking-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px;
            border-radius: 4px;
            color: white;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            font-size: 14px;
        }

        .view-btn {
            background-color: #3b82f6;
        }

        .view-btn:hover {
            background-color: #2563eb;
        }

        .cancel-btn {
            background-color: #ef4444;
        }

        .cancel-btn:hover {
            background-color: #dc2626;
        }

        /* Booking filters */
        .booking-filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            align-items: center;
        }

        .filter-group label {
            margin-right: 8px;
            font-weight: 500;
            color: #4b5563;
        }

        .filter-group select {
            padding: 8px 12px;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            font-size: 14px;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
        }

        .empty-state i {
            font-size: 48px;
            color: #d1d5db;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #4b5563;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #6b7280;
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 991px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-logo {
                justify-content: center;
                padding: 0 10px 20px;
            }

            .sidebar-logo h2,
            .sidebar-menu a span {
                display: none;
            }

            .sidebar-menu a {
                padding: 15px 0;
                text-align: center;
            }

            .sidebar-menu a i {
                margin-right: 0;
                font-size: 18px;
            }

            .main-content {
                margin-left: 70px;
            }
        }

        @media (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .booking-filters {
                flex-direction: column;
                align-items: flex-start;
            }

            .data-card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .data-card-buttons {
                width: 100%;
            }
            
            .data-card-buttons .btn {
                flex: 1;
            }

            .action-btn {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <%
        // Check if user is logged in
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/views/auth-layout/sign-in/signIn.jsp");
            return;
        }
        
        int customerID = customer.getCustomerId();
        String customerName = customer.getCustomerName();
    %>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <img src="images/logo.png" alt="Mega City Cab Logo">
            <h2>Mega City Cab</h2>
        </div>
        <ul class="sidebar-menu">
            <!--<li><a href="bookings.jsp" class="active"><i class="fas fa-calendar-check"></i> <span>My Bookings</span></a></li>-->
            <li><a href="newBooking.jsp"><i class="fas fa-plus-circle"></i> <span>New Booking</span></a></li>
            <!--<li><a href="profile.jsp"><i class="fas fa-user"></i> <span>My Profile</span></a></li>-->
            <!--<li><a href="<%=request.getContextPath()%>/LogoutServlet"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>-->
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="dashboard-header">
            <h1>My Bookings</h1>
            <div class="user-profile">
                <img src="images/user-avatar.png" alt="User Avatar">
                <div class="user-info">
                    <h4><%= customerName %></h4>
                    <p>Customer</p>
                </div>
            </div>
        </div>

        <div class="data-card">
            <div class="data-card-header">
                <h2>All Bookings</h2>
                <div class="data-card-buttons">
                    <a href="newBooking.jsp" class="btn btn-primary"><i class="fas fa-plus"></i> New Booking</a>
                </div>
            </div>
            
            <div class="table-responsive">
                <table id="bookingsTable">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Date & Time</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Driver ID</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                BookingDAO bookingDAO = new BookingDAO();
                                List<Booking> bookingList = bookingDAO.getBookingsByCustomerID(customerID);

                                if (bookingList.isEmpty()) {
                                    %>
                                    <tr>
                                        <td colspan="8">No bookings found. <a href="newBooking.jsp">Create a new booking</a></td>
                                    </tr>
                                    <%
                                } else {
                                    for (Booking booking : bookingList) {
                                        %>
                                        <tr>
                                            <td>#BK-<%= String.format("%03d", booking.getBookingID())%></td>
                                            <td><%= booking.getBookingDateTime()%></td>
                                            <td><%= booking.getStartDestination()%></td>
                                            <td><%= booking.getEndDestination()%></td>
                                            <td><%= booking.getDriverID() == 0 ? "Unassigned" : booking.getDriverID()%></td>
                                            <td>$<%= String.format("%.2f", booking.getAmount())%></td>
                                            <td>
                                                <span class="status-badge <%= booking.getStatus().toLowerCase() %>">
                                                    <%= booking.getStatus() %>
                                                </span>
                                            </td>
                                            <td>
                                                <% if (booking.getStatus().equalsIgnoreCase("pending")) { %>
                                                    <button onclick="cancelBooking(<%= booking.getBookingID() %>)" class="btn btn-danger btn-sm">
                                                        <i class="fas fa-times"></i> Cancel
                                                    </button>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <%
                                    }
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='8'>Error retrieving booking data: " + e.getMessage() + "</td></tr>");
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // Function to handle booking cancellation
        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                window.location.href = '<%=request.getContextPath()%>/CancelBookingServlet?bookingId=' + bookingId;
            }
        }
        
        // Function to refresh bookings
        function refreshBookings() {
            // This would be better implemented with AJAX
            // For now, we'll use a simple page refresh
            // location.reload();
        }
        
        // Initialize the page
        document.addEventListener('DOMContentLoaded', function() {
            // Set up the refresh interval - uncomment if needed
            // setInterval(refreshBookings, 30000);
        });
    </script>
</body>
</html>
