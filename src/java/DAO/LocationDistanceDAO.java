package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LocationDistanceDAO {
    
    public double getDistance(int fromLocationID, int toLocationID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        double distance = 0.0;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT distanceKM FROM location_distances WHERE fromLocationID = ? AND toLocationID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, fromLocationID);
            stmt.setInt(2, toLocationID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                distance = rs.getDouble("distanceKM");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LocationDistanceDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return distance;
    }
}