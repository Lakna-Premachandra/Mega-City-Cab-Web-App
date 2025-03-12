package DAO;

import Models.Booking;
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
public class BookingDAO {
    
    public static List<Booking> getAllBookings() throws SQLException, ClassNotFoundException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking_details";
        
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
               Booking booking = new Booking();
               booking.setBookingID(rs.getInt("bookingID"));
               booking.setCustomerID(rs.getInt("customerID"));
               booking.setDriverID(rs.getInt("driverID"));
               booking.setCarID(rs.getInt("carID"));
               booking.setStartDestination(rs.getString("startDestination"));
               booking.setEndDestination(rs.getString("endDestination"));
               booking.setBookingDateTime(rs.getString("bookingDateTime"));
               booking.setAmount(rs.getDouble("amount"));
               booking.setStatus(rs.getString("status"));
                
               bookings.add(booking);
           }
       }
       return bookings;
    }
    
    public static List<Booking> getBookingsByVehicleType(String vehicleType) throws SQLException, ClassNotFoundException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT b.* FROM booking_details b " +
                      "JOIN car_details c ON b.carID = c.carID " +
                      "WHERE c.vehicle_type = ?";
        
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, vehicleType);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingID(rs.getInt("bookingID"));
                    booking.setCustomerID(rs.getInt("customerID"));
                    booking.setDriverID(rs.getInt("driverID"));
                    booking.setCarID(rs.getInt("carID"));
                    booking.setStartDestination(rs.getString("startDestination"));
                    booking.setEndDestination(rs.getString("endDestination"));
                    booking.setBookingDateTime(rs.getString("bookingDateTime"));
                    booking.setAmount(rs.getDouble("amount"));
                    booking.setStatus(rs.getString("status"));
                    
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }
    
    public static List<String> getAllVehicleTypes() throws SQLException, ClassNotFoundException {
        List<String> vehicleTypes = new ArrayList<>();
        String query = "SELECT DISTINCT vehicle_type FROM car_details WHERE vehicle_type IS NOT NULL";
        
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                vehicleTypes.add(rs.getString("vehicle_type"));
            }
        }
        return vehicleTypes;
    }
    
    public static void updateBookingStatus(int bookingId, String status) throws SQLException, ClassNotFoundException {
        String query = "UPDATE booking_details SET status = ? WHERE bookingID = ?";
        
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected == 0) {
                throw new SQLException("Failed to update booking status, no rows affected.");
            }
        }
    }
}