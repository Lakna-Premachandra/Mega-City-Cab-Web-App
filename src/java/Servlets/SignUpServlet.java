/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.CustomerDAO;
import Models.Customer;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.UserLoginDetails;
import Models.VehicleDetails;
import DAO.VehicleDAO;
import Models.DriverDetails;
import DAO.DriverDAO;
/**
 *
 * @author PC
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String customerName = request.getParameter("customername");
//        String phoneNumber = request.getParameter("phoneNumber");
//        String address = request.getParameter("address");
//        String email = request.getParameter("email");
//        String nic = request.getParameter("nic");
        String userType = request.getParameter("userType");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/views/auth-layout/sign-up/signUp.jsp").forward(request, response);
            return;
        }
        
//        if (role == null || role.trim().isEmpty()) {
//        role = "Customer"; 
//        }

        String hashedPassword = hashPassword(password);

//        Customer customer = new Customer(customerName, address, phoneNumber, email, nic);
        UserLoginDetails userLogin = new UserLoginDetails(username, hashedPassword, userType);
        
        boolean isRegistered = false;

        try {
//            CustomerDAO customerDAO = new CustomerDAO();
//            boolean isRegistered = customerDAO.registerCustomer(customer, userLogin);

             if ("driver".equalsIgnoreCase(userType)) {
                // Driver registration
                String driverName = request.getParameter("driverName");
                String phoneNo = request.getParameter("phoneNo");
                String email = request.getParameter("email");
                String licenseNumber = request.getParameter("license_number");

                // Vehicle details
                String carModel = request.getParameter("model");
                int carYear = Integer.parseInt(request.getParameter("year"));
                String plateNumber = request.getParameter("plate_number");

                VehicleDetails vehicle = new VehicleDetails(carModel, carYear, plateNumber);
                VehicleDAO vehicleDAO = new VehicleDAO();
                int carID = vehicleDAO.insertCar(vehicle);

                DriverDetails driver = new DriverDetails(driverName, phoneNo, email, licenseNumber, carID);
                DriverDAO driverDAO = new DriverDAO();
                isRegistered = driverDAO.registerDriver(driver, userLogin);

            } else {
                // Customer registration
                String customerName = request.getParameter("customerName");
                String phoneNumber = request.getParameter("phoneNumber");
                String address = request.getParameter("address");
                String email = request.getParameter("email");
                String nic = request.getParameter("nic");

                Customer customer = new Customer(customerName, address, phoneNumber, email, nic);
                CustomerDAO customerDAO = new CustomerDAO();
                isRegistered = customerDAO.registerCustomer(customer, userLogin);
            }

            if (isRegistered) {
                response.sendRedirect(request.getContextPath() + "/views/auth-layout/sign-in/signIn.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/views/auth-layout/sign-up/signUp.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("/views/auth-layout/sign-up/signUp.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
