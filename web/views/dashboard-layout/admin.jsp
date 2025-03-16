<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.BookingDAO"%>
<%@ page import="Models.Booking"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Bookings Management</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
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

            .admin-profile {
                display: flex;
                align-items: center;
            }

            .admin-profile img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .admin-info h4 {
                font-size: 16px;
                margin-bottom: 2px;
            }

            .admin-info p {
                font-size: 12px;
                color: #6b7280;
            }

            /* Data Cards */
            .data-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                padding: 20px;
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
                color: #333;
            }

            .data-card-buttons {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 8px 15px;
                border-radius: 4px;
                font-weight: 500;
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
                color: #2563eb;
                border: 1px solid #2563eb;
            }

            .btn-outline:hover {
                background-color: rgba(37, 99, 235, 0.1);
            }

            /* Tables */
            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead th {
                text-align: left;
                padding: 12px 15px;
                background-color: #f9fafb;
                border-bottom: 1px solid #e5e7eb;
                color: #6b7280;
                font-weight: 600;
                font-size: 14px;
            }

            tbody td {
                padding: 12px 15px;
                border-bottom: 1px solid #e5e7eb;
                color: #4b5563;
                font-size: 14px;
            }

            tbody tr:hover {
                background-color: #f9fafb;
            }

            .status-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .status-pending {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-active {
                background-color: #d1fae5;
                color: #065f46;
            }

            .status-inactive {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .table-actions {
                display: flex;
                gap: 5px;
            }

            .action-btn {
                width: 30px;
                height: 30px;
                border-radius: 4px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s;
                border: none;
            }

            .action-btn.edit {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .action-btn.delete {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .action-btn:hover {
                opacity: 0.8;
            }

            /* Responsive */
            @media (max-width: 991px) {
                .sidebar {
                    width: 70px;
                    padding: 20px 0;
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

                .data-card-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .table-responsive {
                    overflow-x: auto;
                }
            }
            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                animation: fadeIn 0.3s;
            }

            .modal-content {
                position: relative;
                background-color: white;
                margin: 50px auto;
                width: 80%;
                max-width: 700px;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
                padding: 25px;
                animation: slideIn 0.3s;
            }

            .close {
                position: absolute;
                right: 20px;
                top: 15px;
                color: #6b7280;
                font-size: 28px;
                font-weight: 700;
                cursor: pointer;
                transition: color 0.3s;
            }

            .close:hover {
                color: #1f2937;
            }

            .modal h2 {
                margin-bottom: 20px;
                color: #1f2937;
                font-size: 22px;
                font-weight: 600;
            }

            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
                margin-bottom: 25px;
            }

            .form-group {
                margin-bottom: 10px;
            }

            .form-group label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #4b5563;
                font-size: 14px;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 10px 14px;
                border: 1px solid #e5e7eb;
                border-radius: 6px;
                font-size: 14px;
                color: #1f2937;
                transition: border-color 0.3s;
            }

            .form-group input:focus,
            .form-group select:focus {
                border-color: #2563eb;
                outline: none;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 12px;
            }

            .btn-primary {
                background-color: #2563eb;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-primary:hover {
                background-color: #1d4ed8;
            }

            .btn-secondary {
                background-color: #f3f4f6;
                color: #4b5563;
                border: 1px solid #e5e7eb;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-secondary:hover {
                background-color: #e5e7eb;
            }

            /* Status badges for assigned/unassigned */
            .status-assigned {
                background-color: #d1fae5;
                color: #065f46;
            }

            .status-unassigned {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .status-completed {
                background-color: #d1fae5;
                color: #065f46;
            }

            .status-pending {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-approved {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .status-cancelled {
                background-color: #fee2e2;
                color: #b91c1c;
            }
            
            .errorMessage_login_cred {
                color: white;
                background-color: green; 
                padding: 10px 15px;
                border-radius: 8px;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
                width: 100%;
                max-width: 400px;
                margin-left: auto;
                margin-right: auto;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.5s ease-in-out;
              }

              @keyframes fadeIn {
                from {
                  opacity: 0;
                  transform: translateY(-10px);
                }
                to {
                  opacity: 1;
                  transform: translateY(0);
                }
              }

            /* Animations */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            /* Responsive styling for modals */
            @media (max-width: 768px) {
                .modal-content {
                    width: 95%;
                    margin: 20px auto;
                    padding: 15px;
                }

                .form-grid {
                    grid-template-columns: 1fr;
                }
            }

        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-logo">
                <img src="../../assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab">
                <h2>Admin Panel</h2>
            </div>

            <ul class="sidebar-menu">
                <li><a href="admin.jsp" class="active"><i class="fas fa-taxi"></i> <span>Bookings</span></a></li>
                <li><a href="driver-management.jsp"><i class="fas fa-users"></i> <span>Drivers</span></a></li>
                <li><a href="vehicle-management.jsp"><i class="fas fa-car"></i> <span>Vehicles</span></a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <h1>Bookings Management</h1>
                <div class="admin-profile">
                    <div class="admin-info">
                        <a href="${pageContext.request.contextPath}/LogoutServlet" style="color: #6b7280; font-size: 16px;">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>

            <% if (session.getAttribute("errorMessage") != null) {%>
            <div class="errorMessage_login_cred" id="errorMessage">
                <%= session.getAttribute("errorMessage")%>
            </div>
            <% session.removeAttribute("errorMessage"); %>
            <% }%>
            
            <div class="data-card">
                <div class="data-card-header">
                    <h2>Booking Records</h2>
                </div>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer Name</th>
                                <th>Booking Date</th>
                                <th>Booking Time</th>
                                <th>Pickup Location</th>
                                <th>Drop Location</th>
                                <th>Mobile No</th>
                                <th>Driver</th>
                                <th>Vehicle Type</th>
                                <th>Address</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    BookingDAO bookingDAO = new BookingDAO();
                                    List<Booking> bookingList = bookingDAO.getAllBookings();

                                    for (Booking booking : bookingList) {
                                        String statusClass = "";
                                        if (booking.getStatus().equals("Completed")) {
                                            statusClass = "status-completed";
                                        } else if (booking.getStatus().equals("Pending")) {
                                            statusClass = "status-pending";
                                        } else if (booking.getStatus().equals("Approved")) {
                                            statusClass = "status-approved";
                                        } else if (booking.getStatus().equals("Cancelled")) {
                                            statusClass = "status-cancelled";
                                        }
                            %>
                            <tr>
                                <td>#BK-<%= String.format("%03d", booking.getBookingID())%></td>
                                <td><%= booking.getCustomerName()%></td>
                                <td><%= booking.getBookingDateTime()%></td>
                                <td><%= booking.getBookingTime()%></td>
                                <td><%= booking.getStartLocationName()%></td>
                                <td><%= booking.getEndLocationName()%></td>
                                <td><%= booking.getCustomerMobile()%></td>
                                <td><%= booking.getDriverID() == 0 ? "Unassigned" : booking.getDriverName()%></td>
                                <td><%= booking.getVehicleType()%></td>
                                <td><%= booking.getAddress()%></td>
                                <td>$<%= String.format("%.2f", booking.getAmount())%></td>
                                <td><span class="status-badge <%= statusClass%>"><%= booking.getStatus()%></span></td>
                                <td>
                                    <div class="table-actions">
                                        <div class="status-dropdown">
                                            <select style="padding:6px 5px;border-radius: 3px;border:1px solid gray;margin-right:4px" name="status" onchange="window.location.href = this.value;">
                                                <option value="#">Select Status</option>
                                                <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID()%>&status=Pending">Pending</option>
                                                <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID()%>&status=Approved">Approved</option>
                                                <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID()%>&status=Completed">Completed</option>
                                                <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID()%>&status=Cancelled">Cancelled</option>
                                            </select>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/BookingActions?action=delete&id=<%= booking.getBookingID()%>" 
                                           class="action-btn delete" 
                                           title="Delete Booking"
                                           onclick="return confirm('Are you sure you want to delete this booking?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='9'>Error retrieving booking data: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>