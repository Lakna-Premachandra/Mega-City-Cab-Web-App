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
import java.net.URLEncoder;

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
            User user = userDAO.authenticateUser(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                if (rememberMe) {
                    session.setMaxInactiveInterval(7 * 24 * 60 * 60);
                }
                
                if ("customer".equalsIgnoreCase(user.getUserType())) {
                    Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
                    if (customer != null) {
                        session.setAttribute("customer", customer);
                        session.setAttribute("customerID", customer.getCustomerId());
        session.setAttribute("customerName", customer.getCustomerName());
                    }
                    response.sendRedirect(request.getContextPath() + "/index.html");
                } else if ("driver".equalsIgnoreCase(user.getUserType())) {
                    response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver.jsp");
                } else if ("admin".equalsIgnoreCase(user.getUserType())) {
                    response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/admin.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/auth-layout/sign-in/signIn.jsp");
                }
                
            } else {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Invalid username or password.");
            session.setAttribute("lastUsername", username);
            String errorMessage = "Invalid username or password.";
            response.sendRedirect("views/auth-layout/sign-in/signIn.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
                
            }
            
        } catch (Exception e) {
            getServletContext().log("Error in SignInServlet", e);
            request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("/views/auth-layout/sign-in/signIn.jsp").forward(request, response);
        }
    }
}