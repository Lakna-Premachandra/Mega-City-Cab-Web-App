package DAO;

import Models.Location;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LocationDAO {
    
    public List<Location> getAllLocations() {
        List<Location> locations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM locations ORDER BY locationName";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("locationID");
                String name = rs.getString("locationName");
                locations.add(new Location(id, name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return locations;
    }
    
       public String getLocationNameById(String locationId) throws SQLException, ClassNotFoundException {
        String locationName = "";
        String query = "SELECT locationName FROM locations WHERE locationID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, locationId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    locationName = rs.getString("locationName");
                }
            }
        } catch (SQLException e) {
//            LOGGER.log(Level.SEVERE, "Error retrieving location name for ID: " + locationId, e);
            throw e;
        }
        
        return locationName;
    }
}