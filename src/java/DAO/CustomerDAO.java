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
import java.sql.Statement;

public class CustomerDAO {
    
    // Add a new customer
    public int addCustomer(Customer customer) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int customerId = -1;
        
        try {
            conn = DBConnection.getConnection();
            
            // Use prepared statement to prevent SQL injection
            String sql = "INSERT INTO customer_details (userID, customerName, address, phoneNo, email, NIC) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setInt(1, customer.getUserId());
            stmt.setString(2, customer.getCustomerName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getPhoneNo());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getNIC());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating customer failed, no rows affected.");
            }
            
            // Get the auto-generated customerId
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                customerId = rs.getInt(1);
                customer.setCustomerId(customerId);
            } else {
                throw new SQLException("Creating customer failed, no ID obtained.");
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return customerId;
    }
    
    // Get customer by user ID
    public Customer getCustomerByUserId(int userId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Customer customer = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM customer_details WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                customer = new Customer();
                customer.setCustomerId(rs.getInt("customerID"));
                customer.setUserId(rs.getInt("userID"));
                customer.setCustomerName(rs.getString("customerName"));
                customer.setAddress(rs.getString("address"));
                customer.setPhoneNo(rs.getString("phoneNo"));
                customer.setEmail(rs.getString("email"));
                customer.setNIC(rs.getString("NIC"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return customer;
    }
    
    // Get customer by ID
    public Customer getCustomerById(int customerId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Customer customer = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM customer_details WHERE customerID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                customer = new Customer();
                customer.setCustomerId(rs.getInt("customerID"));
                customer.setUserId(rs.getInt("userID"));
                customer.setCustomerName(rs.getString("customerName"));
                customer.setAddress(rs.getString("address"));
                customer.setPhoneNo(rs.getString("phoneNo"));
                customer.setEmail(rs.getString("email"));
                customer.setNIC(rs.getString("NIC"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return customer;
    }
    
    // Update customer information
    public boolean updateCustomer(Customer customer) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "UPDATE customer_details SET customerName = ?, address = ?, phoneNo = ?, email = ?, NIC = ? WHERE customerID = ?";
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, customer.getCustomerName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhoneNo());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getNIC());
            stmt.setInt(6, customer.getCustomerId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } finally {
            // Close resources
            if (stmt != null) stmt.close();
        }
    }
    
    // Delete customer
    public boolean deleteCustomer(int customerId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "DELETE FROM customer_details WHERE customerID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } finally {
            // Close resources
            if (stmt != null) stmt.close();
        }
    }
}