/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author PC
 */
import Models.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {
    public boolean registerCustomer(Customer customer) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pstmtUser = null;
        PreparedStatement pstmtCustomer = null;
        ResultSet rs = null;
        boolean isRegistered = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String sqlUser = "INSERT INTO user_details (username, password, userType) VALUES (?, ?, 'Customer')";
            pstmtUser = conn.prepareStatement(sqlUser, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmtUser.setString(1, customer.getUsername());
            pstmtUser.setString(2, customer.getPassword()); // Hash password before passing
            pstmtUser.executeUpdate();

            rs = pstmtUser.getGeneratedKeys();
            int userID = 0;
            if (rs.next()) {
                userID = rs.getInt(1);
            }

            String sqlCustomer = "INSERT INTO customer_details (userID, customerName, address, phoneNo, email, NIC) VALUES (?, ?, ?, ?, ?, ?)";
            pstmtCustomer = conn.prepareStatement(sqlCustomer);
            pstmtCustomer.setInt(1, userID);
            pstmtCustomer.setString(2, customer.getCustomerName());
            pstmtCustomer.setString(3, customer.getAddress());
            pstmtCustomer.setString(4, customer.getPhoneNo());
            pstmtCustomer.setString(5, customer.getEmail());
            pstmtCustomer.setString(6, customer.getNic());
            pstmtCustomer.executeUpdate();

            conn.commit(); 
            isRegistered = true;

        } catch (SQLException e) {
            System.out.println("CustomerDAO: Error in registerCustomer()");
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); 
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmtUser != null) pstmtUser.close();
                if (pstmtCustomer != null) pstmtCustomer.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isRegistered;
    }
}

