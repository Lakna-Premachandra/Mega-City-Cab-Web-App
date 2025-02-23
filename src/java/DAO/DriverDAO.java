/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.DriverDetails;
import Models.UserLoginDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author PC
 */

public class DriverDAO {
    public boolean registerDriver(DriverDetails driver, UserLoginDetails userLogin) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pstmtUser = null;
        PreparedStatement pstmtDriver = null;
        ResultSet rs = null;
        boolean isRegistered = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Insert into user_details
            String sqlUser = "INSERT INTO user_details (username, password, userType) VALUES (?, ?, ?)";
            pstmtUser = conn.prepareStatement(sqlUser, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmtUser.setString(1, userLogin.getUsername());
            pstmtUser.setString(2, userLogin.getPassword());
            pstmtUser.setString(3, userLogin.getUserType());
            pstmtUser.executeUpdate();

            rs = pstmtUser.getGeneratedKeys();
            int userID = 0;
            if (rs.next()) {
                userID = rs.getInt(1);
            }

            // Insert into drivers
            String sqlDriver = "INSERT INTO driver_details (userID, driverName, phoneNo, email, license_number, carID) VALUES (?, ?, ?, ?, ?, ?)";
            pstmtDriver = conn.prepareStatement(sqlDriver);
            pstmtDriver.setInt(1, userID);
            pstmtDriver.setString(2, driver.getDriverName());
            pstmtDriver.setString(3, driver.getPhoneNo());
            pstmtDriver.setString(4, driver.getEmail());
            pstmtDriver.setString(5, driver.getLicenseNumber());
            pstmtDriver.setInt(6, driver.getCarID());

            int rowsInserted = pstmtDriver.executeUpdate();
            if (rowsInserted > 0) {
                isRegistered = true;
                conn.commit();
            } else {
                conn.rollback();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmtUser != null) pstmtUser.close();
                if (pstmtDriver != null) pstmtDriver.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isRegistered;
    }
}

