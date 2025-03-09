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
import java.io.PrintWriter;
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
@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    private CustomerDAO customerDAO;
    
    public SignInServlet() {
        super();
        userDAO = new UserDAO();
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean rememberMe = request.getParameter("remember") != null;
        
        try {
            // Authenticate user
            User user = userDAO.authenticateUser(username, password);
            
            if (user != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Set session timeout (30 minutes by default)
                if (rememberMe) {
                    // If "Remember Me" is checked, extend session timeout (e.g., 7 days)
                    session.setMaxInactiveInterval(7 * 24 * 60 * 60);
                }
                
                // Load additional user information based on user type
                if ("customer".equalsIgnoreCase(user.getUserType())) {
                    Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
                    if (customer != null) {
                        session.setAttribute("customer", customer);
                    }
                    // Redirect to index.html for customers
                    response.sendRedirect(request.getContextPath() + "/index.html");
                } else if ("driver".equalsIgnoreCase(user.getUserType())) {
                    // For driver, you would need to load driver details
                    // Redirect to index.html for drivers
                    response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver.jsp");
                } else if ("admin".equalsIgnoreCase(user.getUserType())) {
                    // Redirect to admin dashboard
                    response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/admin.jsp");
                } else {
                    // Generic redirect to index.html if user type is not recognized
                    response.sendRedirect(request.getContextPath() + "/views/auth-layout/sign-in/signIn.jsp");
                }
                
            } else {
                // Authentication failed
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/views/auth-layout/sign-in/signIn.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Log the exception
            getServletContext().log("Error in SignInServlet", e);
            
            // Send error message to the login page
            request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("/sign-in/signIn.jsp").forward(request, response);
        }
    }
}