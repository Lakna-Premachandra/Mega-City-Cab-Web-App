/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Models.Vehicle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author PC
 */

public class CarDAO {
    
    // Add a new car
    public int addCar(Vehicle car) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int carId = -1;
        
        try {
            conn = DBConnection.getConnection();
            
            // Use prepared statement to prevent SQL injection
            String sql = "INSERT INTO car_details (model, year, plate_number, lisence_number, vehicle_type) " +
                         "VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setString(1, car.getModel());
            stmt.setInt(2, car.getYear());
            stmt.setString(3, car.getPlateNumber());
            stmt.setString(4, car.getLicenseNumber());
            stmt.setString(5, car.getVehicleType());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating car failed, no rows affected.");
            }
            
            // Get the auto-generated carId
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                carId = rs.getInt(1);
                car.setCarId(carId);
            } else {
                throw new SQLException("Creating car failed, no ID obtained.");
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            // Don't close connection here, might be reused
        }
        
        return carId;
    }
    
    // Get car by ID
    public Vehicle getCarById(int carId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Vehicle car = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM car_details WHERE carID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, carId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                car = new Vehicle();
                car.setCarId(rs.getInt("carID"));
                car.setModel(rs.getString("model"));
                car.setYear(rs.getInt("year"));
                car.setPlateNumber(rs.getString("plate_number"));
                car.setLicenseNumber(rs.getString("lisence_number"));
                car.setVehicleType(rs.getString("vehicle_type"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return car;
    }
    
    // Check if a plate number already exists
    public boolean checkPlateNumberExists(String plateNumber) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT COUNT(*) FROM car_details WHERE plate_number = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, plateNumber);
            
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
    
    // Delete a car by ID
    public boolean deleteCar(int carId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "DELETE FROM car_details WHERE carID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, carId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } finally {
            // Close resources
            if (stmt != null) stmt.close();
        }
    }
}