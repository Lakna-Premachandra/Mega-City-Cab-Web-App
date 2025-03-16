package DAO;

import Models.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PC
 */
public class BookingDAO {
    
    public static List<Booking> getAllBookings() throws SQLException, ClassNotFoundException {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT b.*, d.driverName FROM booking_details b " +
                  "LEFT JOIN driver_details d ON b.driverID = d.driverID";
        
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
               Booking booking = new Booking();
               booking.setBookingID(rs.getInt("bookingID"));
               booking.setCustomerName(rs.getString("customerName"));
               booking.setDriverID(rs.getInt("driverID"));
               booking.setCarID(rs.getInt("carID"));
               booking.setStartLocationName(rs.getString("startLocationName"));
               booking.setEndLocationName(rs.getString("endLocationName"));
               booking.setBookingDateTime(rs.getString("bookingDateTime"));
               booking.setBookingTime(rs.getString("bookingTime"));
               booking.setCustomerMobile(rs.getString("customerMobile"));
               booking.setVehicleType(rs.getString("vehicleType"));
               booking.setAddress(rs.getString("address"));
               booking.setAmount(rs.getDouble("amount"));
               booking.setStatus(rs.getString("status"));
               booking.setDriverName(rs.getString("driverName"));
                
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
    
    public static void updateBookingStatusDriver(int bookingId, String status) throws SQLException, ClassNotFoundException {
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

// In BookingDAO.java
public void updateBookingStatus(int bookingId, String status) throws SQLException, ClassNotFoundException {
    String query = "UPDATE booking_details SET status = ? WHERE bookingID = ?";
    
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setString(1, status);
        stmt.setInt(2, bookingId);
        
        stmt.executeUpdate();
    }
}

// New method to delete a booking
public void deleteBooking(int bookingId) throws SQLException, ClassNotFoundException {
    String query = "DELETE FROM booking_details WHERE bookingID = ?";
    
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setInt(1, bookingId);
        
        stmt.executeUpdate();
    }
}

public static List<Booking> getBookingsByCustomerID(int customerID) throws SQLException, ClassNotFoundException {
    String query = "SELECT * FROM booking_details WHERE customerID = ? ORDER BY bookingDateTime DESC";
    List<Booking> bookings = new ArrayList<>();
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setInt(1, customerID);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Booking booking = new Booking();
//            booking.setDriverID(rs.getInt("driverID"));
            
               booking.setBookingID(rs.getInt("bookingID"));
               booking.setCustomerName(rs.getString("customerName"));
               booking.setDriverID(rs.getInt("driverID"));
               booking.setCarID(rs.getInt("carID"));
               booking.setStartLocationName(rs.getString("startLocationName"));
               booking.setEndLocationName(rs.getString("endLocationName"));
               booking.setBookingDateTime(rs.getString("bookingDateTime"));
               booking.setBookingTime(rs.getString("bookingTime"));
               booking.setCustomerMobile(rs.getString("customerMobile"));
               booking.setVehicleType(rs.getString("vehicleType"));
               booking.setAddress(rs.getString("address"));
               booking.setAmount(rs.getDouble("amount"));
               booking.setStatus(rs.getString("status"));
            
            bookings.add(booking);
        }
    }
    
    return bookings;
}
 public int saveBooking(Booking booking) throws SQLException, ClassNotFoundException {
          String query = "INSERT INTO booking_details (customerID, vehicleType, startDestination, endDestination, " +
               "bookingDateTime, amount, status, description, address, customerName, customerMobile, " +
               "startLocationName, endLocationName, bookingTime) " +
               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setInt(1, booking.getCustomerID());
            stmt.setString(2, booking.getVehicleType());
            stmt.setString(3, booking.getStartDestination());
            stmt.setString(4, booking.getEndDestination());
            stmt.setString(5, booking.getBookingDateTime());
            stmt.setDouble(6, booking.getAmount());
            stmt.setString(7, booking.getStatus());
            stmt.setString(8, booking.getDescription());
            stmt.setString(9, booking.getAddress());
            stmt.setString(10, booking.getCustomerName());
            stmt.setString(11, booking.getCustomerMobile());
            stmt.setString(12, booking.getStartLocationName());
            stmt.setString(13, booking.getEndLocationName());
            stmt.setString(14, booking.getBookingTime());

            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating booking failed, no rows affected.");
            }
            
            generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating booking failed, no ID obtained.");
            }
        } catch (SQLException e) {
//            LOGGER.log(Level.SEVERE, "Error saving booking: " + e.getMessage(), e);
            throw e;
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException e) { /* ignored */ }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignored */ }
        }  
 }
 
public static void updateBookingWithDriver(int bookingId, int driverId, int carId, String status) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        conn = DBConnection.getConnection();
        
        // Log the parameters for debugging
        System.out.println("Updating booking: " + bookingId + " with driver: " + driverId + ", car: " + carId + ", status: " + status);
        
        String sql = "UPDATE booking_details SET status = ?, driverID = ?, carID = ? WHERE bookingID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, status);
        stmt.setInt(2, driverId);
        stmt.setInt(3, carId);
        stmt.setInt(4, bookingId);
        
        int rowsAffected = stmt.executeUpdate();
        System.out.println("Rows affected: " + rowsAffected);
        
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
}
}

