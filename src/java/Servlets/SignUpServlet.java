/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.CustomerDAO;
import DAO.UserDAO;
import Models.Customer;
import Models.User;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/**
 *
 * @author PC
 */


@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    private CustomerDAO customerDAO;
    
    public SignUpServlet() {
        super();
        userDAO = new UserDAO();
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters from form
            String customerName = request.getParameter("customername");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String nic = request.getParameter("nic");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            // First check if username already exists
            if (userDAO.checkUsernameExists(username)) {
                request.setAttribute("errorMessage", "Username already exists. Please choose a different username.");
                request.getRequestDispatcher("path/to/sign-up/signUp.jsp").forward(request, response);
                return;
            }
            
            // Create User object and add to database
            User user = new User();
            user.setUsername(username);
            user.setPassword(password); // In real application, you should hash the password
            user.setUserType("Customer");
            
            int userId = userDAO.addUser(user);
            
            if (userId > 0) {
                // Create Customer object and add to database
                Customer customer = new Customer();
                customer.setUserId(userId);
                customer.setCustomerName(customerName);
                customer.setAddress(address);
                customer.setPhoneNo(phoneNumber);
                customer.setEmail(email);
                customer.setNIC(nic);
                
                int customerId = customerDAO.addCustomer(customer);
                
                if (customerId > 0) {
                    // Set success message and redirect to login page
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Registration successful. Please login.");
                    response.sendRedirect(request.getContextPath() + "/views/auth-layout/sign-in/signIn.jsp");
                } else {
                    // If customer creation failed, delete the user we just created
                    userDAO.deleteUser(userId);
                    request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    request.getRequestDispatcher("path/to/sign-up/signUp.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("path/to/sign-up/signUp.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("path/to/sign-up/signUp.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}