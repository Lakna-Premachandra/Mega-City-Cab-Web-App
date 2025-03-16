/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Models.Driver;
import Models.Vehicle;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */

public class DriverDAO {
    
    // Add a new driver
    public int addDriver(Driver driver) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int driverId = -1;
        
        try {
            conn = DBConnection.getConnection();
            
            // Use prepared statement to prevent SQL injection
            String sql = "INSERT INTO driver_details (userID, driverName, phoneNo, email, licenseNumber, carID) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setInt(1, driver.getUserId());
            stmt.setString(2, driver.getDriverName());
            stmt.setString(3, driver.getPhoneNo());
            stmt.setString(4, driver.getEmail());
            stmt.setString(5, driver.getLicenseNumber());
            stmt.setInt(6, driver.getCarId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating driver failed, no rows affected.");
            }
            
            // Get the auto-generated driverId
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                driverId = rs.getInt(1);
                driver.setDriverId(driverId);
            } else {
                throw new SQLException("Creating driver failed, no ID obtained.");
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            // Don't close connection here, might be reused
        }
        
        return driverId;
    }
    
    // Get driver by ID
    public Driver getDriverById(int driverId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Driver driver = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM driver_details WHERE driverID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                driver = new Driver();
                driver.setDriverId(rs.getInt("driverID"));
                driver.setUserId(rs.getInt("userID"));
                driver.setDriverName(rs.getString("driverName"));
                driver.setPhoneNo(rs.getString("phoneNo"));
                driver.setEmail(rs.getString("email"));
                driver.setLicenseNumber(rs.getString("licenseNumber"));
                driver.setCarId(rs.getInt("carID"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return driver;
    }
    
    // Get driver by user ID
    public Driver getDriverByUserId(int userId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Driver driver = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM driver_details WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                driver = new Driver();
                driver.setDriverId(rs.getInt("driverID"));
                driver.setUserId(rs.getInt("userID"));
                driver.setDriverName(rs.getString("driverName"));
                driver.setPhoneNo(rs.getString("phoneNo"));
                driver.setEmail(rs.getString("email"));
                driver.setLicenseNumber(rs.getString("licenseNumber"));
                driver.setCarId(rs.getInt("carID"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return driver;
    }
    
    // Delete a driver by ID
    public boolean deleteDriver(int driverId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "DELETE FROM driver_details WHERE driverID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } finally {
            // Close resources
            if (stmt != null) stmt.close();
        }
    }
    
    // Check if a license number already exists
    public boolean checkLicenseExists(String licenseNumber) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT COUNT(*) FROM driver_details WHERE licenseNumber = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, licenseNumber);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return exists;
    }
    
       public static List<Driver> getAllDrivers() throws SQLException, ClassNotFoundException {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT d.*, c.model, c.year, c.plate_number, c.vehicle_type, u.password, u.username " +
                      "FROM driver_details d " +
                      "JOIN car_details c ON d.carID = c.carID " +
                      "JOIN user_details u ON d.userID = u.userID";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Driver driver = new Driver();
                driver.setUserId(rs.getInt("userID"));
                driver.setDriverName(rs.getString("driverName"));
                driver.setPhoneNo(rs.getString("phoneNo"));
                driver.setEmail(rs.getString("email"));
                driver.setLicenseNumber(rs.getString("licenseNumber"));
                driver.setCarId(rs.getInt("carID"));
                driver.setCarModel(rs.getString("model"));
                driver.setPlateNumber(rs.getString("plate_number"));
                driver.setVehicleType(rs.getString("vehicle_type"));
                driver.setUsername(rs.getString("username"));
                driver.setPassword(rs.getString("password"));
                driver.setYear(rs.getInt("year"));
                driver.setDriverId(rs.getInt("driverID"));

                drivers.add(driver);
            }
        }
        return drivers;
    }
    
        public static void updateDriver(Driver driver) throws SQLException, ClassNotFoundException {
        String query = "UPDATE driver_details SET driverName = ?, phoneNo = ?, email = ?, licenseNumber = ?, carID = ? " +
                      "WHERE driverID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, driver.getDriverName());
            stmt.setString(2, driver.getPhoneNo());
            stmt.setString(3, driver.getEmail());
            stmt.setString(4, driver.getLicenseNumber());
            stmt.setInt(5, driver.getCarId());
            stmt.setInt(6, driver.getDriverId());
            
            stmt.executeUpdate();
        }
    }
        
        public int addDriverWithCar(Driver driver, Vehicle car) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement userStmt = null;
    PreparedStatement carStmt = null;
    PreparedStatement driverStmt = null;
    ResultSet userRs = null;
    ResultSet carRs = null;
    int driverId = -1;
    
    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // For transaction handling
        
        // Step 1: Insert User Data (authentication details)
        String userSql = "INSERT INTO user_details (username, password, userType) VALUES (?, ?, 'Driver')";
        userStmt = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
        userStmt.setString(1, driver.getUsername());
        userStmt.setString(2, driver.getPassword());
        userStmt.executeUpdate();
        
        // Get the auto-generated userID
        userRs = userStmt.getGeneratedKeys();
        int userId = 0;
        if (userRs.next()) {
            userId = userRs.getInt(1);
        } else {
            throw new SQLException("Creating user failed, no ID obtained.");
        }
        
        // Step 2: Insert Car Data
        String carSql = "INSERT INTO car_details (model, plate_number, vehicle_type, lisence_number, year) VALUES (?, ?, ?, ?, ?)";
        carStmt = conn.prepareStatement(carSql, Statement.RETURN_GENERATED_KEYS);
        carStmt.setString(1, car.getModel());
        carStmt.setString(2, car.getPlateNumber());
        carStmt.setString(3, car.getVehicleType());
        carStmt.setString(4, car.getLicenseNumber());
        carStmt.setInt(5, car.getYear());
        carStmt.executeUpdate();
        
        // Get the auto-generated carID
        carRs = carStmt.getGeneratedKeys();
        int carId = 0;
        if (carRs.next()) {
            carId = carRs.getInt(1);
        } else {
            throw new SQLException("Creating car record failed, no ID obtained.");
        }
        
        // Step 3: Insert Driver Data with the userID and carID
        String driverSql = "INSERT INTO driver_details (userID, driverName, phoneNo, email, licenseNumber, carID) VALUES (?, ?, ?, ?, ?, ?)";
        driverStmt = conn.prepareStatement(driverSql, Statement.RETURN_GENERATED_KEYS);
        driverStmt.setInt(1, userId);
        driverStmt.setString(2, driver.getDriverName());
        driverStmt.setString(3, driver.getPhoneNo());
        driverStmt.setString(4, driver.getEmail());
        driverStmt.setString(5, driver.getLicenseNumber());
        driverStmt.setInt(6, carId);
        
        int affectedRows = driverStmt.executeUpdate();
        if (affectedRows > 0) {
            ResultSet driverRs = driverStmt.getGeneratedKeys();
            if (driverRs.next()) {
                driverId = driverRs.getInt(1); // Get the driverID
            }
            driverRs.close();
        }
        
        conn.commit(); // Commit the transaction
        
    } catch (SQLException ex) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback on error
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        throw ex; // Re-throw exception after rollback
    } finally {
        if (userRs != null) try { userRs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (carRs != null) try { carRs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (userStmt != null) try { userStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (carStmt != null) try { carStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (driverStmt != null) try { driverStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    
    return driverId;
}
        
        public void updateDriverWithUserAndCar(Driver driver, String username, String password) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement driverStmt = null;
    PreparedStatement userStmt = null;
    PreparedStatement carStmt = null;
    
    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // Start transaction
        
        // 1. Update driver details
        String driverSql = "UPDATE driver_details SET driverName = ?, phoneNo = ?, email = ?, licenseNumber = ? WHERE driverID = ?";
        driverStmt = conn.prepareStatement(driverSql);
        driverStmt.setString(1, driver.getDriverName());
        driverStmt.setString(2, driver.getPhoneNo());
        driverStmt.setString(3, driver.getEmail());
        driverStmt.setString(4, driver.getLicenseNumber());
        driverStmt.setInt(5, driver.getDriverId());
        driverStmt.executeUpdate();
        
        // 2. Update car details
        String carSql = "UPDATE car_details SET model = ?, plate_number = ?, year = ?, vehicle_type = ? WHERE carID = ?";
        carStmt = conn.prepareStatement(carSql);
        carStmt.setString(1, driver.getCarModel());
        carStmt.setString(2, driver.getPlateNumber());
        carStmt.setInt(3, driver.getYear());
        carStmt.setString(4, driver.getVehicleType());
        carStmt.setInt(5, driver.getCarId());
        carStmt.executeUpdate();
        
        // 3. Update user details if username or password provided
        if (username != null && !username.trim().isEmpty()) {
            String userSql = "UPDATE user_details SET username = ?";
            
            // If password is also provided, include it in the update
            if (password != null && !password.trim().isEmpty()) {
                userSql += ", password = ?";
            }
            
            userSql += " WHERE userID = (SELECT userID FROM driver_details WHERE driverID = ?)";
            
            userStmt = conn.prepareStatement(userSql);
            userStmt.setString(1, username);
            
            if (password != null && !password.trim().isEmpty()) {
                userStmt.setString(2, password);
                userStmt.setInt(3, driver.getDriverId());
            } else {
                userStmt.setInt(2, driver.getDriverId());
            }
            
            userStmt.executeUpdate();
        }
        
        conn.commit(); // Commit the transaction
        
    } catch (SQLException ex) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback on error
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        throw ex;
    } finally {
        if (driverStmt != null) try { driverStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (carStmt != null) try { carStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (userStmt != null) try { userStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { 
            conn.setAutoCommit(true);
            conn.close(); 
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
}
