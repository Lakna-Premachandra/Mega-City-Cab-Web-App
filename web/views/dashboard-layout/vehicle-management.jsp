<%-- 
    Document   : vehicle-management
    Created on : Mar 14, 2025, 12:05:06 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.VehicleDAO"%>
<%@ page import="Models.Vehicle"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Vehicle Management</title>
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
                <li><a href="admin.jsp"><i class="fas fa-taxi"></i> <span>Bookings</span></a></li>
                <li><a href="driver-management.jsp"><i class="fas fa-users"></i> <span>Drivers</span></a></li>
                <li><a href="vehicle-management.jsp" class="active"><i class="fas fa-car"></i> <span>Vehicles</span></a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <h1>Vehicle Management</h1>
                <div class="admin-profile">
                    <div class="admin-info">
                        <a href="${pageContext.request.contextPath}/LogoutServlet" style="color: #6b7280; font-size: 16px;">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>

            <% if (session.getAttribute("errorMessage") != null) {%>
            <div class="errorMessage_login_cred" id="errorMessage" style="color: green; margin-bottom: 15px; text-align: center;">
                <%= session.getAttribute("errorMessage")%>
            </div>
            <% session.removeAttribute("errorMessage"); %>
            <% }%>

            <div class="data-card">
                <div class="data-card-header">
                   
                    <h2>Vehicles Management</h2>
                    <div class="data-card-buttons">
                        <button class="btn btn-primary" onclick="openAddVehicleModal()">Add New Vehicle</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Vehicle</th>
                                <th>Year</th>
                                <th>License Plate</th>
                                <th>License Number</th>
                                <th>Type</th>
<!--                                <th>Status</th>
                                <th>Driver</th>-->
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    VehicleDAO vehicleDAO = new VehicleDAO();
                                    List<Vehicle> vehicleList = vehicleDAO.getAllVehicles();

                                    for (Vehicle vehicle : vehicleList) {
                                        String statusClass = vehicle.isAssigned() ? "status-assigned" : "status-unassigned";
                            %>
                            <tr>
                                <td><%= vehicle.getCarId()%></td>
                                <td><%= vehicle.getModel()%></td>
                                <td><%= vehicle.getYear()%></td>
                                <td><%= vehicle.getPlateNumber()%></td>
                                <td><%= vehicle.getLicenseNumber()%></td>
                                <td><%= vehicle.getVehicleType()%></td>
                                <!--<td><span class="status-badge <%= statusClass%>"><%= vehicle.isAssigned() ? "Assigned" : "Unassigned"%></span></td>-->
                                <!--<td><%= vehicle.isAssigned() ? vehicle.getDriverName() : "N/A"%></td>-->
                                
                                <td>
                                    <div class="table-actions">
                                        <a href="#" class="action-btn edit" 
                                           onclick="openEditVehicleModal(<%= vehicle.getCarId()%>, '<%= vehicle.getModel()%>', <%= vehicle.getYear()%>, '<%= vehicle.getPlateNumber()%>', '<%= vehicle.getLicenseNumber()%>', '<%= vehicle.getVehicleType()%>')">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/VehicleServlet?action=delete&id=<%= vehicle.getCarId()%>" 
                                           class="action-btn delete" 
                                           onclick="return confirm('Are you sure you want to delete this vehicle?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='9'>Error retrieving vehicle data: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Add Vehicle Modal -->
            <div id="addVehicleModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeAddVehicleModal()">&times;</span>
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
                            <button type="button" class="btn-secondary" onclick="closeAddVehicleModal()">Cancel</button>
                            <button type="submit" class="btn-primary">Add Vehicle</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Vehicle Modal -->
            <div id="editVehicleModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeEditVehicleModal()">&times;</span>
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
                            <button type="button" class="btn-secondary" onclick="closeEditVehicleModal()">Cancel</button>
                            <button type="submit" class="btn-primary">Update Vehicle</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            var addVehicleModal = document.getElementById("addVehicleModal");
            var editVehicleModal = document.getElementById("editVehicleModal");

            // Function to open the add vehicle modal
            function openAddVehicleModal() {
                addVehicleModal.style.display = "block";
            }

            // Function to close the add vehicle modal
            function closeAddVehicleModal() {
                addVehicleModal.style.display = "none";
            }

            // Function to open the edit vehicle modal with vehicle data
            function openEditVehicleModal(carId, model, year, plateNumber, licenseNumber, vehicleType) {
                document.getElementById("editCarID").value = carId;
                document.getElementById("editModel").value = model;
                document.getElementById("editYear").value = year;
                document.getElementById("editPlateNumber").value = plateNumber;
                document.getElementById("editLicenseNumber").value = licenseNumber;
                document.getElementById("editVehicleType").value = vehicleType;
                
                editVehicleModal.style.display = "block";
            }

            // Function to close the edit vehicle modal
            function closeEditVehicleModal() {
                editVehicleModal.style.display = "none";
            }

            // When user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
                if (event.target == addVehicleModal) {
                    addVehicleModal.style.display = "none";
                }
                if (event.target == editVehicleModal) {
                    editVehicleModal.style.display = "none";
                }
            }
        </script>
    </body>
</html>
