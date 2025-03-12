<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.BookingDAO"%>
<%@ page import="Models.Booking"%>
<%@ page import="DAO.DriverDAO"%>
<%@ page import="Models.Driver"%>
<%@ page import="java.util.List"%>
<%@ page import="Models.Vehicle" %>
<%@ page import="DAO.VehicleDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Admin Dashboard</title>
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
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-logo">
                <img src="/api/placeholder/50/50" alt="Mega City Cab">
                <h2>Admin Panel</h2>
            </div>
            
            <ul class="sidebar-menu">
                <li><a onclick="showBookings()" class="active"><i class="fas fa-taxi"></i> <span>Bookings</span></a></li>
                <li><a onclick="showDrivers()"><i class="fas fa-users"></i> <span>Drivers</span></a></li>
                <li><a onclick="showVehicles()"><i class="fas fa-car"></i> <span>Vehicles</span></a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <h1>Admin Dashboard</h1>
                <div class="admin-profile">
                    <div class="admin-info">
                        <!--<h4>John Smith</h4>-->
                         <a href="${pageContext.request.contextPath}/LogoutServlet" style="color: #6b7280; font-size: 16px;">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
                    </div>
                </div>
            </div>
            
            <div class="data-card" id="bookingsSection">
                
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer</th>
                                <th>Date & Time</th>
                                <th>Pickup Location</th>
                                <th>Destination</th>
                                <th>Driver</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                          <tbody>
                    <%
                    try {
                        BookingDAO bookingDAO = new BookingDAO();
                        List<Booking> bookingList = bookingDAO.getAllBookings();
                        
                        for(Booking booking : bookingList) {
                            String statusClass = "";
                            if(booking.getStatus().equals("Completed")) {
                                statusClass = "status-completed";
                            } else if(booking.getStatus().equals("Pending")) {
                                statusClass = "status-pending";
                            } else if(booking.getStatus().equals("Approved")) {
                                statusClass = "status-approved";
                            } else if(booking.getStatus().equals("Cancelled")) {
                                statusClass = "status-cancelled";
                            }
                    %>
                    <tr>
                        <td>#BK-<%= String.format("%03d", booking.getBookingID()) %></td>
                        <td><%= booking.getCustomerID() %></td>
                        <td><%= booking.getBookingDateTime() %></td>
                        <td><%= booking.getStartDestination() %></td>
                        <td><%= booking.getEndDestination() %></td>
                        <td><%= booking.getDriverID() == 0 ? "Unassigned" : booking.getDriverID() %></td>
                        <td>$<%= String.format("%.2f", booking.getAmount()) %></td>
                        <td><span class="status-badge <%= statusClass %>"><%= booking.getStatus() %></span></td>
                        <td>
                            <div class="table-actions">
                                <div class="status-dropdown">
                                    <select name="status" onchange="window.location.href=this.value;">
                                        <option value="#">Select Status</option>
                                        <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID() %>&status=Pending">Pending</option>
                                        <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID() %>&status=Approved">Approved</option>
                                        <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID() %>&status=Completed">Completed</option>
                                        <option value="${pageContext.request.contextPath}/BookingActions?action=updateStatus&id=<%= booking.getBookingID() %>&status=Cancelled">Cancelled</option>
                                    </select>
                                </div>
                                
                                <a href="${pageContext.request.contextPath}/BookingActions?action=delete&id=<%= booking.getBookingID() %>" 
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
                    } catch(Exception e) {
                        out.println("<tr><td colspan='9'>Error retrieving booking data: " + e.getMessage() + "</td></tr>");
                    }
                    %>
                </tbody>
                    </table>
                </div>
            </div>
            
            <div class="data-card" id="driversSection" style="display: none;">
                <div class="data-card-header">
                    <h2>Drivers Management</h2>
                    <div class="data-card-buttons">
                        <button class="btn btn-primary">Add New Driver</button>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Mobile</th>
                                <th>License No.</th>
                                <th>Vehicle</th>
                                <th>Completed Rides</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            try {
                                DriverDAO driverDAO = new DriverDAO();
                                List<Driver> driverList = driverDAO.getAllDrivers();
                                
                                for(Driver driver : driverList) {
                            %>
                            <tr>
                                <td><%= driver.getDriverId() %></td>
                                <td><%= driver.getDriverName() %></td>
                                <td><%= driver.getUsername() %></td>
                                <td><%= driver.getPhoneNo() %></td>
                                <td><%= driver.getEmail() %></td>
                                <td><%= driver.getLicenseNumber() %></td>
                                <td><%= driver.getCarModel() %> (<%= driver.getPlateNumber() %>)</td>
                                <td>
                                    <div class="table-actions">
                                        <a href="#" class="action-btn edit" 
                                           onclick="openEditModal(<%= driver.getDriverId() %>, '<%= driver.getDriverName() %>', '<%= driver.getPhoneNo() %>', '<%= driver.getEmail() %>', '<%= driver.getLicenseNumber() %>', <%= driver.getCarId() %>)">
                                           <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/DriverServlet?action=delete&id=<%= driver.getDriverId() %>" 
                                           class="action-btn delete" 
                                           onclick="return confirm('Are you sure you want to delete this driver?');">
                                           <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <% 
                                }
                            } catch(Exception e) {
                                out.println("<tr><td colspan='8'>Error retrieving driver data: " + e.getMessage() + "</td></tr>");
                            }
                            %>
                        </tbody>
                     </table>

                         <!-- Add Driver Modal -->
    <div id="addDriverModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Add New Driver</h2>
            <form action="${pageContext.request.contextPath}/DriverServlet" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="driverName">Driver Name</label>
                        <input type="text" id="driverName" name="driverName" required>
                    </div>
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="phoneNo">Phone Number</label>
                        <input type="text" id="phoneNo" name="phoneNo" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="licenseNumber">License Number</label>
                        <input type="text" id="licenseNumber" name="licenseNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="carID">Assign Vehicle</label>
                        <select id="carID" name="carID" required>
                            <option value="">Select Vehicle</option>
                            <%
                            try {
                                VehicleDAO vehicleDAO = new VehicleDAO();
                                List<Vehicle> unassignedVehicles = vehicleDAO.getUnassignedVehicles();
                                
                                for(Vehicle vehicle : unassignedVehicles) {
                            %>
                            <option value="<%= vehicle.getCarId() %>"><%= vehicle.getModel() %> (<%= vehicle.getPlateNumber() %>)</option>
                            <%
                                }
                            } catch(Exception e) {
                                out.println("<option value=''>Error loading vehicles</option>");
                            }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn-secondary" onclick="closeAddModal()">Cancel</button>
                    <button type="submit" class="btn-primary">Add Driver</button>
                </div>
            </form>
        </div>
    </div>

     <!-- Edit Driver Modal -->
     <div id="editDriverModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Edit Driver</h2>
            <form action="${pageContext.request.contextPath}/DriverServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editDriverID" name="driverID">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="editDriverName">Driver Name</label>
                        <input type="text" id="editDriverName" name="driverName" required>
                    </div>
                    <div class="form-group">
                        <label for="editPhoneNo">Phone Number</label>
                        <input type="text" id="editPhoneNo" name="phoneNo" required>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email</label>
                        <input type="email" id="editEmail" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="editLicenseNumber">License Number</label>
                        <input type="text" id="editLicenseNumber" name="licenseNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="editCarID">Assign Vehicle</label>
                        <select id="editCarID" name="carID" required>
                            <option value="">Select Vehicle</option>
                            <%
                            try {
                                VehicleDAO vehicleDAO = new VehicleDAO();
                                List<Vehicle> allVehicles = vehicleDAO.getAllVehicles();
                                
                                for(Vehicle vehicle : allVehicles) {
                            %>
                            <option value="<%= vehicle.getCarId() %>"><%= vehicle.getModel() %> (<%= vehicle.getPlateNumber() %>)</option>
                            <%
                                }
                            } catch(Exception e) {
                                out.println("<option value=''>Error loading vehicles</option>");
                            }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn-secondary" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="btn-primary">Update Driver</button>
                </div>
            </form>
        </div>
    </div>

                   
                </div>
            </div>
            
            <div class="data-card" id="vehiclesSection" style="display: none;">
                <div class="data-card-header">
                    <h2>Vehicles Management</h2>
                    <div class="data-card-buttons">
                        <button class="btn btn-primary">Add New Vehicle</button>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Vehicle</th>
                                <th>Type</th>
                                <th>License Plate</th>
                                <th>Year</th>
                                <th>Assigned Driver</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            try {
                                VehicleDAO vehicleDAO = new VehicleDAO();
                                List<Vehicle> vehicleList = vehicleDAO.getAllVehicles();
                                
                                for(Vehicle vehicle : vehicleList) {
                                    String statusClass = vehicle.isAssigned() ? "status-assigned" : "status-unassigned";
                            %>
                            <tr>
                                <td><%= vehicle.getCarId() %></td>
                                <td><%= vehicle.getModel() %></td>
                                <td><%= vehicle.getYear() %></td>
                                <td><%= vehicle.getPlateNumber() %></td>
                                <td><%= vehicle.getLicenseNumber() %></td>
                                <td><%= vehicle.getVehicleType() %></td>
                                <td><span class="status-badge <%= statusClass %>"><%= vehicle.isAssigned() ? "Assigned" : "Unassigned" %></span></td>
                                <td><%= vehicle.isAssigned() ? vehicle.getDriverName() : "N/A" %></td>
                                <td>
                                    <div class="table-actions">
                                        <a href="#" class="action-btn edit" 
                                           onclick="openEditModal(<%= vehicle.getCarId() %>, '<%= vehicle.getModel() %>', <%= vehicle.getYear() %>, '<%= vehicle.getPlateNumber() %>', '<%= vehicle.getLicenseNumber() %>', '<%= vehicle.getVehicleType() %>')">
                                           <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/VehicleServlet?action=delete&id=<%= vehicle.getCarId() %>" 
                                           class="action-btn delete" 
                                           onclick="return confirm('Are you sure you want to delete this vehicle?');">
                                           <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <% 
                                }
                            } catch(Exception e) {
                                out.println("<tr><td colspan='9'>Error retrieving vehicle data: " + e.getMessage() + "</td></tr>");
                            }
                            %>
                        </tbody>
                    </table>
                
        
            <!-- Add Vehicle Modal -->
            <div id="addVehicleModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Add New Vehicle</h2>
                    <form action="${pageContext.request.contextPath}/VehicleServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="model">Model</label>
                                <input type="text" id="model" name="model" required>
                            </div>
                            <div class="form-group">
                                <label for="year">Year</label>
                                <input type="number" id="year" name="year" min="1900" max="2099" required>
                            </div>
                            <div class="form-group">
                                <label for="plateNumber">Plate Number</label>
                                <input type="text" id="plateNumber" name="plateNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="licenseNumber">License Number</label>
                                <input type="text" id="licenseNumber" name="licenseNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="vehicleType">Vehicle Type</label>
                                <select id="vehicleType" name="vehicleType" required>
                                    <option value="">Select Type</option>
                                    <option value="Sedan">Sedan</option>
                                    <option value="SUV">SUV</option>
                                    <option value="Van">Van</option>
                                    <option value="Luxury">Luxury</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn-secondary" onclick="closeAddModal()">Cancel</button>
                            <button type="submit" class="btn-primary">Add Vehicle</button>
                        </div>
                    </form>
                </div>
            </div>
        
            <!-- Edit Vehicle Modal -->
            <div id="editVehicleModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Edit Vehicle</h2>
                    <form action="${pageContext.request.contextPath}/VehicleServlet" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editCarID" name="carID">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="editModel">Model</label>
                                <input type="text" id="editModel" name="model" required>
                            </div>
                            <div class="form-group">
                                <label for="editYear">Year</label>
                                <input type="number" id="editYear" name="year" min="1900" max="2099" required>
                            </div>
                            <div class="form-group">
                                <label for="editPlateNumber">Plate Number</label>
                                <input type="text" id="editPlateNumber" name="plateNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="editLicenseNumber">License Number</label>
                                <input type="text" id="editLicenseNumber" name="licenseNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="editVehicleType">Vehicle Type</label>
                                <select id="editVehicleType" name="vehicleType" required>
                                    <option value="">Select Type</option>
                                    <option value="Sedan">Sedan</option>
                                    <option value="SUV">SUV</option>
                                    <option value="Van">Van</option>
                                    <option value="Luxury">Luxury</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn-secondary" onclick="closeEditModal()">Cancel</button>
                            <button type="submit" class="btn-primary">Update Vehicle</button>
                        </div>
                    </form>
                </div>
            </div>
                        </div>
            </div>

        <script>
            // Get the modal elements
        var addModal = document.getElementById("addDriverModal");
        var editModal = document.getElementById("editDriverModal");
        
        // Get the button that opens the add modal
        var addBtn = document.getElementById("addDriverBtn");
        
        // Get the <span> elements that close the modals
        var spans = document.getElementsByClassName("close");
        
        // When the user clicks the button, open the modal
        addBtn.onclick = function() {
            addModal.style.display = "block";
        }
        
        // When the user clicks on <span> (x), close the modals
        for (var i = 0; i < spans.length; i++) {
            spans[i].onclick = function() {
                addModal.style.display = "none";
                editModal.style.display = "none";
            }
        }
        
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == addModal) {
                addModal.style.display = "none";
            }
            if (event.target == editModal) {
                editModal.style.display = "none";
            }
        }
        
        // Function to close the add modal
        function closeAddModal() {
            addModal.style.display = "none";
        }
        
        // Function to open the edit modal with driver data
        function openEditModal(driverId, driverName, phoneNo, email, licenseNumber, carId) {
            document.getElementById("editDriverID").value = driverId;
            document.getElementById("editDriverName").value = driverName;
            document.getElementById("editPhoneNo").value = phoneNo;
            document.getElementById("editEmail").value = email;
            document.getElementById("editLicenseNumber").value = licenseNumber;
            document.getElementById("editCarID").value = carId;
            
            editModal.style.display = "block";
        }

                // Function to open the edit modal with vehicle data
        function openEditModal(carId, model, year, plateNumber, licenseNumber, vehicleType) {
            document.getElementById("editCarID").value = carId;
            document.getElementById("editModel").value = model;
            document.getElementById("editYear").value = year;
            document.getElementById("editPlateNumber").value = plateNumber;
            document.getElementById("editLicenseNumber").value = licenseNumber;
            document.getElementById("editVehicleType").value = vehicleType;
            
            editModal.style.display = "block";
        }
        
        // Function to close the edit modal
        function closeEditModal() {
            editModal.style.display = "none";
        }
        
        // Auto-hide alert messages after 5 seconds
        window.onload = function() {
            var alertMessage = document.getElementById("alertMessage");
            if (alertMessage) {
                setTimeout(function() {
                    alertMessage.style.display = "none";
                }, 5000);
            }
        }
            // Function to show bookings section
            function showBookings() {
                document.getElementById('bookingsSection').style.display = 'block';
                document.getElementById('driversSection').style.display = 'none';
                document.getElementById('vehiclesSection').style.display = 'none';
                
                // Update active menu item
                updateActiveMenuItem(0);
            }
            
            // Function to show drivers section
            function showDrivers() {
                document.getElementById('bookingsSection').style.display = 'none';
                document.getElementById('driversSection').style.display = 'block';
                document.getElementById('vehiclesSection').style.display = 'none';
                
                // Update active menu item
                updateActiveMenuItem(1);
            }
            
            // Function to show vehicles section
            function showVehicles() {
                document.getElementById('bookingsSection').style.display = 'none';
                document.getElementById('driversSection').style.display = 'none';
                document.getElementById('vehiclesSection').style.display = 'block';
                
                // Update active menu item
                updateActiveMenuItem(2);
            }
            
            // Function to update active menu item
            function updateActiveMenuItem(index) {
                const menuItems = document.querySelectorAll('.sidebar-menu a');
                menuItems.forEach(item => item.classList.remove('active'));
                menuItems[index].classList.add('active');
            }
            
            // Set bookings as default view on load
            window.onload = function() {
                showBookings();
            };
        </script>
    </body>
</html>