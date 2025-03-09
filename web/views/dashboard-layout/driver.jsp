<!DOCTYPE html>
<html>
    <head>
        <title>Mega City Cab - Driver Dashboard</title>
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

            .driver-profile {
                display: flex;
                align-items: center;
            }

            .driver-profile img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .driver-info h4 {
                font-size: 16px;
                margin-bottom: 2px;
            }

            .driver-info p {
                font-size: 12px;
                color: #6b7280;
            }

            /* Stats Cards */
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                padding: 20px;
                display: flex;
                flex-direction: column;
            }

            .stat-card-title {
                font-size: 14px;
                color: #6b7280;
                margin-bottom: 10px;
            }

            .stat-card-value {
                font-size: 24px;
                font-weight: 700;
                color: #333;
                margin-bottom: 5px;
            }

            .stat-card-change {
                font-size: 12px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .stat-card-change.positive {
                color: #059669;
            }

            .stat-card-change.negative {
                color: #dc2626;
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

            .data-card-filters {
                display: flex;
                gap: 10px;
            }

            .filter-btn {
                padding: 8px 15px;
                border-radius: 4px;
                font-weight: 500;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                border: 1px solid #e5e7eb;
                background-color: white;
            }

            .filter-btn.active {
                background-color: #2563eb;
                color: white;
                border-color: #2563eb;
            }

            .filter-btn:hover {
                background-color: #f9fafb;
            }

            .filter-btn.active:hover {
                background-color: #1e40af;
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

            .status-new {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .status-accepted {
                background-color: #d1fae5;
                color: #065f46;
            }

            .status-rejected {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .status-completed {
                background-color: #e0e7ff;
                color: #3730a3;
            }

            .table-actions {
                display: flex;
                gap: 10px;
            }

            .action-btn {
                padding: 6px 12px;
                border-radius: 4px;
                font-weight: 600;
                font-size: 12px;
                cursor: pointer;
                transition: all 0.3s;
                border: none;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
            }

            .action-btn.accept {
                background-color: #d1fae5;
                color: #065f46;
            }

            .action-btn.accept:hover {
                background-color: #a7f3d0;
            }

            .action-btn.reject {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .action-btn.reject:hover {
                background-color: #fecaca;
            }

            .action-btn.details {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .action-btn.details:hover {
                background-color: #bfdbfe;
            }

            /* Driver status toggle */
            .status-toggle {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-left: 20px;
            }

            .status-toggle-label {
                font-size: 14px;
                color: #6b7280;
            }

            .status-toggle-switch {
                position: relative;
                display: inline-block;
                width: 50px;
                height: 24px;
            }

            .status-toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .status-toggle-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 34px;
            }

            .status-toggle-slider:before {
                position: absolute;
                content: "";
                height: 16px;
                width: 16px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }

            input:checked + .status-toggle-slider {
                background-color: #10b981;
            }

            input:checked + .status-toggle-slider:before {
                transform: translateX(26px);
            }

            .status-toggle-text {
                font-size: 14px;
                font-weight: 600;
            }

            .status-toggle-text.online {
                color: #10b981;
            }

            .status-toggle-text.offline {
                color: #6b7280;
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

                .stats-container {
                    grid-template-columns: 1fr;
                }
                
                .table-responsive {
                    overflow-x: auto;
                }

                .status-toggle {
                    margin-left: 0;
                    margin-top: 10px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-logo">
                <img src="/api/placeholder/50/50" alt="Mega City Cab">
                <h2>Driver Panel</h2>
            </div>
            
            <ul class="sidebar-menu">
                <li><a class="active"><i class="fas fa-taxi"></i> <span>My Bookings</span></a></li>
                <li><a><i class="fas fa-history"></i> <span>Trip History</span></a></li>
                <li><a><i class="fas fa-dollar-sign"></i> <span>Earnings</span></a></li>
                <li><a><i class="fas fa-star"></i> <span>Ratings</span></a></li>
                <li><a><i class="fas fa-user-cog"></i> <span>My Account</span></a></li>
                <li><a><i class="fas fa-question-circle"></i> <span>Support</span></a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <div class="header-left">
                    <h1>Driver Dashboard</h1>
                    <div class="status-toggle">
                        <span class="status-toggle-label">Status:</span>
                        <label class="status-toggle-switch">
                            <input type="checkbox" checked>
                            <span class="status-toggle-slider"></span>
                        </label>
                        <span class="status-toggle-text online">Online</span>
                    </div>
                </div>
                <div class="driver-profile">
                    <img src="/api/placeholder/40/40" alt="Driver Profile">
                    <div class="driver-info">
                        <h4>David Chen</h4>
                        <p>Driver ID: #DR-003</p>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <span class="stat-card-title">Today's Earnings</span>
                    <span class="stat-card-value">$85.50</span>
                    <span class="stat-card-change positive">
                        <i class="fas fa-arrow-up"></i> $12.30 from yesterday
                    </span>
                </div>
                <div class="stat-card">
                    <span class="stat-card-title">Completed Trips</span>
                    <span class="stat-card-value">5</span>
                    <span class="stat-card-change positive">
                        <i class="fas fa-arrow-up"></i> 2 more than yesterday
                    </span>
                </div>
                <div class="stat-card">
                    <span class="stat-card-title">Average Rating</span>
                    <span class="stat-card-value">4.8 <i class="fas fa-star" style="color: #f59e0b; font-size: 18px;"></i></span>
                    <span class="stat-card-change">
                        Based on last 50 rides
                    </span>
                </div>
                <div class="stat-card">
                    <span class="stat-card-title">Acceptance Rate</span>
                    <span class="stat-card-value">92%</span>
                    <span class="stat-card-change negative">
                        <i class="fas fa-arrow-down"></i> 3% from last week
                    </span>
                </div>
            </div>
            
            <!-- Bookings Section -->
            <div class="data-card">
                <div class="data-card-header">
                    <h2>Available Bookings</h2>
                    <div class="data-card-filters">
                        <button class="filter-btn active">All</button>
                        <button class="filter-btn">New Requests</button>
                        <button class="filter-btn">Accepted</button>
                        <button class="filter-btn">Completed</button>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer</th>
                                <th>Time</th>
                                <th>Pickup Location</th>
                                <th>Destination</th>
                                <th>Fare Estimate</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#BK-003</td>
                                <td>Emily Davis</td>
                                <td>11:45 AM Today</td>
                                <td>789 Oak St</td>
                                <td>Central Station</td>
                                <td>$18.50</td>
                                <td><span class="status-badge status-new">New Request</span></td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn accept"><i class="fas fa-check"></i> Accept</button>
                                        <button class="action-btn reject"><i class="fas fa-times"></i> Reject</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#BK-005</td>
                                <td>Olivia Martin</td>
                                <td>03:00 PM Today</td>
                                <td>654 Maple St</td>
                                <td>Grand Theater</td>
                                <td>$12.75</td>
                                <td><span class="status-badge status-new">New Request</span></td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn accept"><i class="fas fa-check"></i> Accept</button>
                                        <button class="action-btn reject"><i class="fas fa-times"></i> Reject</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#BK-004</td>
                                <td>William Taylor</td>
                                <td>01:30 PM Today</td>
                                <td>321 Pine St</td>
                                <td>Sunshine Hotel</td>
                                <td>$22.00</td>
                                <td><span class="status-badge status-accepted">Accepted</span></td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn details"><i class="fas fa-info-circle"></i> Details</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#BK-001</td>
                                <td>Sarah Johnson</td>
                                <td>09:15 AM Today</td>
                                <td>123 Main St</td>
                                <td>Airport Terminal 3</td>
                                <td>$35.50</td>
                                <td><span class="status-badge status-completed">Completed</span></td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn details"><i class="fas fa-info-circle"></i> Details</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#BK-002</td>
                                <td>Robert Wilson</td>
                                <td>10:30 AM Today</td>
                                <td>456 Elm St</td>
                                <td>Downtown Mall</td>
                                <td>$15.75</td>
                                <td><span class="status-badge status-completed">Completed</span></td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn details"><i class="fas fa-info-circle"></i> Details</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#BK-006</td>
                                <td>James Anderson</td>
                                <td>04:15 PM Today</td>
                                <td>987 Cedar Rd</td>
                                <td>City Hospital</td>
                                <td>$28.50</td>
                                <td><span class="status-badge status-rejected">Rejected</span></td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn details"><i class="fas fa-info-circle"></i> Details</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            // Toggle driver status
            const statusToggle = document.querySelector('.status-toggle-switch input');
            const statusText = document.querySelector('.status-toggle-text');
            
            statusToggle.addEventListener('change', function() {
                if(this.checked) {
                    statusText.textContent = 'Online';
                    statusText.classList.add('online');
                    statusText.classList.remove('offline');
                } else {
                    statusText.textContent = 'Offline';
                    statusText.classList.add('offline');
                    statusText.classList.remove('online');
                }
            });
            
            // Filter buttons
            const filterButtons = document.querySelectorAll('.filter-btn');
            
            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Here you would normally add filtering logic
                });
            });
            
            // Accept/Reject booking - simple demo functionality
            const acceptButtons = document.querySelectorAll('.action-btn.accept');
            const rejectButtons = document.querySelectorAll('.action-btn.reject');
            
            acceptButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const statusCell = row.querySelector('td:nth-child(7)');
                    const actionsCell = row.querySelector('td:nth-child(8)');
                    
                    statusCell.innerHTML = '<span class="status-badge status-accepted">Accepted</span>';
                    actionsCell.innerHTML = '<div class="table-actions"><button class="action-btn details"><i class="fas fa-info-circle"></i> Details</button></div>';
                });
            });
            
            rejectButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const statusCell = row.querySelector('td:nth-child(7)');
                    const actionsCell = row.querySelector('td:nth-child(8)');
                    
                    statusCell.innerHTML = '<span class="status-badge status-rejected">Rejected</span>';
                    actionsCell.innerHTML = '<div class="table-actions"><button class="action-btn details"><i class="fas fa-info-circle"></i> Details</button></div>';
                });
            });
        </script>
    </body>
</html>