package Servlets;

import DAO.DriverDAO;
import Models.Driver;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DriverServlet", urlPatterns = {"/DriverServlet"})
public class DriverServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            DriverDAO driverDAO = new DriverDAO();
            
            if ("delete".equals(action)) {
                int driverId = Integer.parseInt(request.getParameter("id"));
                driverDAO.deleteDriver(driverId);
                
                HttpSession session = request.getSession();
                session.setAttribute("message", "Driver deleted successfully!");
            }
            
            // Redirect back to the driver management page
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver.jsp");
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            DriverDAO driverDAO = new DriverDAO();
            
            if ("add".equals(action)) {
                // Create a new Driver object
                Driver driver = new Driver();
                driver.setDriverName(request.getParameter("driverName"));
                driver.setUsername(request.getParameter("username"));
                driver.setPhoneNo(request.getParameter("phoneNo"));
                driver.setEmail(request.getParameter("email"));
                driver.setLicenseNumber(request.getParameter("licenseNumber"));
                driver.setCarId(Integer.parseInt(request.getParameter("carID")));
                driver.setPassword(request.getParameter("password"));

                
                driverDAO.addDriver(driver);
                
                HttpSession session = request.getSession();
                session.setAttribute("message", "Driver added successfully!");
            } else if ("update".equals(action)) {
                // Create a Driver object for updating
                Driver driver = new Driver();
                driver.setDriverId(Integer.parseInt(request.getParameter("driverID")));
                driver.setDriverName(request.getParameter("driverName"));
                driver.setPhoneNo(request.getParameter("phoneNo"));
                driver.setEmail(request.getParameter("email"));
                driver.setLicenseNumber(request.getParameter("licenseNumber"));
                driver.setCarId(Integer.parseInt(request.getParameter("carID")));
                
                // Update the driver
                driverDAO.updateDriver(driver);
                
                HttpSession session = request.getSession();
                session.setAttribute("message", "Driver updated successfully!");
            }
            
            // Redirect back to the driver management page
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/admin.jsp");
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/admin.jsp");
        }
    }
}