/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author PC
 */

public class UserDAO {
    
    // Add a new user
    public int addUser(User user) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int userId = -1;
        
        try {
            conn = DBConnection.getConnection();
            
            // Use prepared statement to prevent SQL injection
            String sql = "INSERT INTO user_details (username, password, userType) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword()); // In real application, hash the password
            stmt.setString(3, user.getUserType());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            
            // Get the auto-generated userId
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                userId = rs.getInt(1);
                user.setUserId(userId);
            } else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            // Don't close connection here, might be reused
        }
        
        return userId;
    }
    
    // Check if username already exists
    public boolean checkUsernameExists(String username) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT COUNT(*) FROM user_details WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            
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
    
    // Delete a user by ID
    public boolean deleteUser(int userId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "DELETE FROM user_details WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } finally {
            // Close resources
            if (stmt != null) stmt.close();
        }
    }
    
    // Get user by ID
    public User getUserById(int userId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM user_details WHERE userID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setUserType(rs.getString("userType"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return user;
    }
    
    // Authenticate user
    public User authenticateUser(String username, String password) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM user_details WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password); // In real application, verify against hashed password
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setUserType(rs.getString("userType"));
            }
            
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
        
        return user;
    }
}