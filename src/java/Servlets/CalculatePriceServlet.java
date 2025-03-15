package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.DBConnection;
import Utils.SimpleJsonBuilder; // Import the custom SimpleJsonBuilder
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "CalculatePriceServlet", urlPatterns = {"/CalculatePriceServlet"})
public class CalculatePriceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            String vehicleType = request.getParameter("vehicleType");
            int startLocationID = Integer.parseInt(request.getParameter("startLocation"));
            int endLocationID = Integer.parseInt(request.getParameter("endLocation"));
            
            // Get the distance between locations
            double distance = getDistance(startLocationID, endLocationID);
            
            // Get the vehicle price per km and base price
            double[] vehiclePrices = getVehiclePrices(vehicleType);
            double pricePerKm = vehiclePrices[0];
            double basePrice = vehiclePrices[1];
            
            // Calculate costs
            double distanceCost = distance * pricePerKm;
            double totalPrice = basePrice + distanceCost;
            
            // Build JSON response using SimpleJsonBuilder
            SimpleJsonBuilder jsonBuilder = new SimpleJsonBuilder();
            jsonBuilder.add("distance", distance)
                       .add("basePrice", basePrice)
                       .add("distanceCost", distanceCost)
                       .add("totalPrice", totalPrice);
            
            // Send response
            out.print(jsonBuilder.build());
            
        } catch (Exception e) {
            // Handle errors using SimpleJsonBuilder
            SimpleJsonBuilder errorBuilder = new SimpleJsonBuilder();
            errorBuilder.add("error", "Error calculating price: " + e.getMessage());
            out.print(errorBuilder.build());
        } finally {
            out.flush();
        }
    }
    
    private double getDistance(int fromLocationID, int toLocationID) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        double distance = 0;
        
        try {
            conn = DBConnection.getConnection();
            
            // First try to get the direct distance
            String sql = "SELECT distanceKM FROM location_distances WHERE fromLocationID = ? AND toLocationID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, fromLocationID);
            stmt.setInt(2, toLocationID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                distance = rs.getDouble("distanceKM");
            } else {
                // If direct distance not found, try the reverse direction
                if (stmt != null) stmt.close();
                if (rs != null) rs.close();
                
                sql = "SELECT distanceKM FROM location_distances WHERE fromLocationID = ? AND toLocationID = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, toLocationID);
                stmt.setInt(2, fromLocationID);
                rs = stmt.executeQuery();
                
                if (rs.next()) {
                    distance = rs.getDouble("distanceKM");
                }
            }
            
            return distance;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
    
    private double[] getVehiclePrices(String vehicleType) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        double[] prices = new double[2]; // [0] = pricePerKM, [1] = basePrice
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT pricePerKM, basePrice FROM vehicle_prices WHERE vehicleType = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, vehicleType);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                prices[0] = rs.getDouble("pricePerKM");
                prices[1] = rs.getDouble("basePrice");
            } else {
                // If not found, use default values based on the form
                switch (vehicleType) {
                    case "economy":
                        prices[0] = 60.0;
                        prices[1] = 150.0;
                        break;
                    case "premium":
                        prices[0] = 80.0;
                        prices[1] = 200.0;
                        break;
                    case "suv":
                        prices[0] = 100.0;
                        prices[1] = 250.0;
                        break;
                    case "van":
                        prices[0] = 120.0;
                        prices[1] = 300.0;
                        break;
                    default:
                        prices[0] = 60.0;
                        prices[1] = 150.0;
                }
            }
            
            return prices;
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
}