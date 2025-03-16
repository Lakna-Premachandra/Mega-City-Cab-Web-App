<%-- 
    Document   : driver-management.jsp
    Created on : Mar 14, 2025, 12:03:43 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.DriverDAO"%>
<%@ page import="Models.Driver"%>
<%@ page import="DAO.VehicleDAO"%>
<%@ page import="Models.Vehicle"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Driver Management</title>
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
        <div class="sidebar">
            <div class="sidebar-logo">
                <img src="../../assets/images/checkered-circle-taxi-frame_78370-3172.avif" alt="Mega City Cab">
                <h2>Admin Panel</h2>
            </div>

            <ul class="sidebar-menu">
                <li><a href="admin.jsp"><i class="fas fa-taxi"></i> <span>Bookings</span></a></li>
                <li><a href="driver-management.jsp" class="active"><i class="fas fa-users"></i> <span>Drivers</span></a></li>
                <li><a href="vehicle-management.jsp"><i class="fas fa-car"></i> <span>Vehicles</span></a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="dashboard-header">
                <h1>Driver Management</h1>
                <div class="admin-profile">
                    <div class="admin-info">
                        <a href="${pageContext.request.contextPath}/LogoutServlet"">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>

            <% if (session.getAttribute("errorMessage") != null) {%>
            <div class="errorMessage_login_cred" id="errorMessage">
                    <%= session.getAttribute("errorMessage") %>
                </div>
            <% session.removeAttribute("errorMessage"); %>
            <% }%>
            
            <div class="data-card">
                <div class="data-card-header">
                    <h2>Drivers Management</h2>
                    <div class="data-card-buttons">
                        <button class="btn btn-primary" onclick="openAddDriverModal()">Add New Driver</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>License No.</th>
                                <th>Vehicle Type</th>
                                <th>Plate No</th>
                                <th>Model</th>
                                <th>Year</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    DriverDAO driverDAO = new DriverDAO();
                                    List<Driver> driverList = driverDAO.getAllDrivers();

                                    for (Driver driver : driverList) {
                            %>
                            <tr>
                                <td><%= driver.getDriverId()%></td>
                                <td><%= driver.getDriverName()%></td>
                                <td><%= driver.getUsername()%></td>
                                <td><%= driver.getPassword()%></td>
                                <td><%= driver.getPhoneNo()%></td>
                                <td><%= driver.getEmail()%></td>
                                <td><%= driver.getLicenseNumber()%></td>
                                <td><%= driver.getVehicleType()%> </td>
                                <td><%= driver.getPlateNumber()%></td>
                                <td><%= driver.getCarModel()%> </td>
                                <td><%= driver.getYear()%> </td>
                                <td>
                                    <div class="table-actions">
                                        <a href="#" class="action-btn edit" 
                                           onclick="openEditDriverModal(<%= driver.getDriverId()%>, '<%= driver.getDriverName()%>', '<%= driver.getUsername()%>', '<%= driver.getPassword()%>', '<%= driver.getPhoneNo()%>', '<%= driver.getEmail()%>', '<%= driver.getLicenseNumber()%>', <%= driver.getCarId()%>, '<%= driver.getVehicleType()%>', '<%= driver.getPlateNumber()%>','<%= driver.getCarModel()%>', <%= driver.getYear()%>)">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/DriverServlet?action=delete&id=<%= driver.getDriverId()%>" 
                                           class="action-btn delete" 
                                           onclick="return confirm('Are you sure you want to delete this driver?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='8'>Error retrieving driver data: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Add Driver Modal -->
            <div id="addDriverModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeAddDriverModal()">&times;</span>
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
                                <label for="plateNumber">Plate Number</label>
                                <input type="text" id="plateNumber" name="plateNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="model">Model</label>
                                <input type="text" id="model" name="model" required>
                            </div>
                            <div class="form-group">
                                <label for="year">Year</label>
                                <input type="number" id="year" name="year" required>
                            </div>
                            <div class="form-group">
                                <label for="vehicleType">Vehicle Type</label>
                                <select id="vehicleType" name="vehicleType" required>
                                    <option value="">Select Vehicle Type</option>
                                    <option value="Economy">Economy</option>
                                    <option value="Premium">Premium</option>
                                    <option value="SUV">SUV</option>
                                    <option value="Van">Van</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn-secondary" onclick="closeAddDriverModal()">Cancel</button>
                            <button type="submit" class="btn-primary">Add Driver</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Driver Modal -->
            <div id="editDriverModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeEditDriverModal()">&times;</span>
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
                                <label for="editUsername">Username</label>
                                <input type="text" id="editUsername" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" id="editPassword" name="password" required>
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
                                <label for="editPlateNumber">Plate Number</label>
                                <input type="text" id="editPlateNumber" name="plateNumber" required>
                            </div>
                            <div class="form-group">
                                <label for="editModel">Model</label>
                                <input type="text" id="editModel" name="model" required>
                            </div>
                            <div class="form-group">
                                <label for="editYear">Year</label>
                                <input type="number" id="editYear" name="year" required>
                            </div>
                             
                                <input type="hidden" id="editCarID" name="carID" required>
                            <div class="form-group">
                               <div class="form-group">
                                <label for="editVehicleType">Vehicle Type</label>
                                <select id="editVehicleType" name="vehicleType" required>
                                    <option value="">Select Vehicle Type</option>
                                    <option value="Economy">Economy</option>
                                    <option value="Premium">Premium</option>
                                    <option value="SUV">SUV</option>
                                    <option value="Van">Van</option>
                                </select>
                            </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn-secondary" onclick="closeEditDriverModal()">Cancel</button>
                            <button type="submit" class="btn-primary">Update Driver</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            var addDriverModal = document.getElementById("addDriverModal");
            var editDriverModal = document.getElementById("editDriverModal");

            function openAddDriverModal() {
                addDriverModal.style.display = "block";
            }

            function closeAddDriverModal() {
                addDriverModal.style.display = "none";
            }
function openEditDriverModal(
    driverId, 
    driverName, 
    username, 
    password, 
    phoneNo, 
    email, 
    licenseNumber, 
    carID, 
    vehicleType, 
    plateNumber, 
    model, 
    year
) {
    // Bind values to the modal fields
    document.getElementById("editDriverID").value = driverId;
    document.getElementById("editDriverName").value = driverName;
    document.getElementById("editUsername").value = username;
    document.getElementById("editPassword").value = password;
    document.getElementById("editPhoneNo").value = phoneNo;
    document.getElementById("editEmail").value = email;
    document.getElementById("editLicenseNumber").value = licenseNumber;
    document.getElementById("editCarID").value = carID;
    document.getElementById("editPlateNumber").value = plateNumber;
    document.getElementById("editModel").value = model;
    document.getElementById("editYear").value = year;

    // Set the vehicle type dropdown
    var typeSelect = document.getElementById("editVehicleType");
    for (var i = 0; i < typeSelect.options.length; i++) {
        if (typeSelect.options[i].value === vehicleType) {
            typeSelect.selectedIndex = i;
            break;
        }
    }

    // Display the modal
    editDriverModal.style.display = "block";
}

            function closeEditDriverModal() {
                editDriverModal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == addDriverModal) {
                    addDriverModal.style.display = "none";
                }
                if (event.target == editDriverModal) {
                    editDriverModal.style.display = "none";
                }
            }
        </script>
    </body>
</html>
