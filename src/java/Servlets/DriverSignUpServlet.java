/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.CarDAO;
import DAO.DriverDAO;
import DAO.UserDAO;
import Models.Vehicle;
import Models.Driver;
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
import java.util.Calendar;

/**
 *
 * @author PC
 */
@WebServlet("/DriverSignUpServlet")
public class DriverSignUpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    private DriverDAO driverDAO;
    private CarDAO carDAO;

    public DriverSignUpServlet() {
        super();
        userDAO = new UserDAO();
        driverDAO = new DriverDAO();
        carDAO = new CarDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters from form
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String driverLicense = request.getParameter("driverLicense");
            String vehicleType = request.getParameter("vehicleType");
            String vehicleRegNumber = request.getParameter("vehicleRegNumber");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (userDAO.checkUsernameExists(username)) {
                 HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Username already exists. Please choose a different username.");
                String errorMessage = "Username already exists. Please choose a different username.";
                response.sendRedirect("views/auth-layout/sign-up/DriverSignUp.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
                return;
            }

            if (driverDAO.checkLicenseExists(driverLicense)) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Driver license already registered.");
                String errorMessage = "Driver license already registered.";
                response.sendRedirect("views/auth-layout/sign-up/DriverSignUp.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
                return;
            }

            if (carDAO.checkPlateNumberExists(vehicleRegNumber)) {
                 HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Vehicle registration number already registered.");
                String errorMessage = "Vehicle registration number already registered";
                response.sendRedirect("views/auth-layout/sign-up/DriverSignUp.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
                return;
            }

            User user = new User();
            user.setUsername(username);
            user.setPassword(password); 
            user.setUserType("Driver");

            int userId = userDAO.addUser(user);

            if (userId > 0) {
                Vehicle car = new Vehicle();
                car.setModel("Default"); 
                car.setYear(Calendar.getInstance().get(Calendar.YEAR));
                car.setPlateNumber(vehicleRegNumber);
                car.setLicenseNumber(driverLicense);
                car.setVehicleType(vehicleType);

                int carId = carDAO.addCar(car);

                if (carId > 0) {
                    Driver driver = new Driver();
                    driver.setUserId(userId);
                    driver.setDriverName(fullName);
                    driver.setPhoneNo(phoneNumber);
                    driver.setEmail(email);
                    driver.setLicenseNumber(driverLicense);
                    driver.setCarId(carId);
                    driver.setAddress(address);

                    int driverId = driverDAO.addDriver(driver);

                    if (driverId > 0) {
                        HttpSession session = request.getSession();
                        session.setAttribute("successMessage", "Registration successful. Please login.");
                        response.sendRedirect(request.getContextPath() + "/views/auth-layout/sign-in/signIn.jsp");

                    } else {
                        carDAO.deleteCar(carId);
                        userDAO.deleteUser(userId);
                                        
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("views/auth-layout/sign-up/DriverSignUp.jsp").forward(request, response);
     
                    }
                } else {
                    userDAO.deleteUser(userId);
                    request.setAttribute("errorMessage", "Vehicle registration failed. Please try again.");
                    request.getRequestDispatcher("views/auth-layout/sign-up/DriverSignUp.jsp").forward(request, response);
                    
                }
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("views/auth-layout/sign-up/DriverSignUp.jsp").forward(request, response);
                
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("views/auth-layout/sign-up/DriverSignUp.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}
