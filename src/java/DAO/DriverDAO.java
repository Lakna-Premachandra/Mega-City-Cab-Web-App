/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Models.Driver;
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
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return exists;
    }
    
       public static List<Driver> getAllDrivers() throws SQLException, ClassNotFoundException {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT d.*, c.model, c.plate_number, c.vehicle_type, u.username " +
                      "FROM driver_details d " +
                      "JOIN car_details c ON d.carID = c.carID " +
                      "JOIN user_details u ON d.userID = u.userID";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Driver driver = new Driver();
                driver.setDriverId(rs.getInt("driverID"));
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
}
