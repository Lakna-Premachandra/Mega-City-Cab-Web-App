/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.User;
import Models.Vehicle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author PC
 */

public class VehicleDAO {
    
    public static List<Vehicle> getAllVehicles() throws SQLException, ClassNotFoundException {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM car_details";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setCarId(rs.getInt("carID"));
                vehicle.setModel(rs.getString("model"));
                vehicle.setYear(rs.getInt("year"));
                vehicle.setPlateNumber(rs.getString("plate_number"));
                vehicle.setLicenseNumber(rs.getString("lisence_number"));
                vehicle.setVehicleType(rs.getString("vehicle_type"));
                
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }
    
    public static int addVehicle(Vehicle vehicle) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO car_details (model, year, plate_number, lisence_number, vehicle_type) " +
                      "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, vehicle.getModel());
            stmt.setInt(2, vehicle.getYear());
            stmt.setString(3, vehicle.getPlateNumber());
            stmt.setString(4, vehicle.getLicenseNumber());
            stmt.setString(5, vehicle.getVehicleType());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }
    
    public static void updateVehicle(Vehicle vehicle) throws SQLException, ClassNotFoundException {
        String query = "UPDATE car_details SET model = ?, year = ?, plate_number = ?, lisence_number = ?, vehicle_type = ? " +
                      "WHERE carID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, vehicle.getModel());
            stmt.setInt(2, vehicle.getYear());
            stmt.setString(3, vehicle.getPlateNumber());
            stmt.setString(4, vehicle.getLicenseNumber());
            stmt.setString(5, vehicle.getVehicleType());
            stmt.setInt(6, vehicle.getCarId());
            
            stmt.executeUpdate();
        }
    }
    
    public static boolean isVehicleAssignedToDriver(int carId) throws SQLException, ClassNotFoundException {
        String query = "SELECT COUNT(*) FROM driver_details WHERE carID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, carId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }  

    public void deleteVehicle(int carID) throws SQLException, ClassNotFoundException {
        // First check if the vehicle is assigned to any driver
        String checkQuery = "SELECT COUNT(*) FROM driver_details WHERE carID = ?";
        String deleteQuery = "DELETE FROM car_details WHERE carID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            
            checkStmt.setInt(1, carID);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("Cannot delete vehicle. It is assigned to a driver.");
            }
            
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                deleteStmt.setInt(1, carID);
                deleteStmt.executeUpdate();
            }
        }
    }
    
    public List<Vehicle> getUnassignedVehicles() throws SQLException, ClassNotFoundException {
        List<Vehicle> vehicleList = new ArrayList<>();
        
        String query = "SELECT c.* FROM car_details c " +
                       "LEFT JOIN driver_details d ON c.carID = d.carID " +
                       "WHERE d.driverID IS NULL";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setCarId(rs.getInt("carID"));
                vehicle.setModel(rs.getString("model"));
                vehicle.setYear(rs.getInt("year"));
                vehicle.setPlateNumber(rs.getString("plate_number"));
                vehicle.setLicenseNumber(rs.getString("lisence_number"));
                vehicle.setVehicleType(rs.getString("vehicle_type"));
                vehicle.setAssigned(false);
                
                vehicleList.add(vehicle);
            }
        }
        
        return vehicleList;
    }
    
    public Vehicle getVehicleById(int carID) throws SQLException, ClassNotFoundException {
        Vehicle vehicle = null;
        
        String query = "SELECT * FROM car_details WHERE carID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, carID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    vehicle = new Vehicle();
                    vehicle.setCarId(rs.getInt("carID"));
                    vehicle.setModel(rs.getString("model"));
                    vehicle.setYear(rs.getInt("year"));
                    vehicle.setPlateNumber(rs.getString("plate_number"));
                    vehicle.setLicenseNumber(rs.getString("lisence_number"));
                    vehicle.setVehicleType(rs.getString("vehicle_type"));
                }
            }
        }
        
        return vehicle;
    }
}
