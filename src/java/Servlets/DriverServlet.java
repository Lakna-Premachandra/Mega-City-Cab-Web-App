package Servlets;

import DAO.DriverDAO;
import Models.Driver;
import Models.Vehicle;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;

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
                session.setAttribute("errorMessage", "Driver deleted successfully!");
                String errorMessage = "Driver deleted successfully!";
                response.sendRedirect("views/dashboard-layout/driver-management.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
            }

        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver-management.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            DriverDAO driverDAO = new DriverDAO();

            if ("add".equals(action)) {
                Driver driver = new Driver();
                driver.setDriverName(request.getParameter("driverName"));
                driver.setUsername(request.getParameter("username"));
                driver.setPhoneNo(request.getParameter("phoneNo"));
                driver.setEmail(request.getParameter("email"));
                driver.setLicenseNumber(request.getParameter("licenseNumber"));
                driver.setPassword(request.getParameter("password"));

                Vehicle car = new Vehicle();
                car.setModel(request.getParameter("model"));
                car.setPlateNumber(request.getParameter("plateNumber"));
                car.setVehicleType(request.getParameter("vehicleType"));

                DriverDAO driverDAO2 = new DriverDAO();
                int driverId = driverDAO2.addDriverWithCar(driver, car);
                
                if (driverId > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "Driver added successfully!");
                    String errorMessage = "Driver added successfully!";
                    response.sendRedirect("views/dashboard-layout/driver-management.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "Failed to add driver!");
                    response.sendRedirect("views/dashboard-layout/driver-management.jsp");
                }
                
            } 
            else if ("update".equals(action)) {
                Driver driver = new Driver();
                driver.setDriverId(Integer.parseInt(request.getParameter("driverID")));
                driver.setDriverName(request.getParameter("driverName"));
                driver.setPhoneNo(request.getParameter("phoneNo"));
                driver.setEmail(request.getParameter("email"));
                driver.setLicenseNumber(request.getParameter("licenseNumber"));
                driver.setCarId(Integer.parseInt(request.getParameter("carID")));

                driverDAO.updateDriver(driver);

                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Driver updated successfully!");
                String errorMessage = "Driver updated successfully!";
                response.sendRedirect("views/dashboard-layout/driver-management.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
            }

        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver-management.jsp");
        }
    }

}
