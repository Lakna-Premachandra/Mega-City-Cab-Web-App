package Servlets;

import DAO.VehicleDAO;
import Models.Vehicle;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "VehicleServlet", urlPatterns = {"/VehicleServlet"})
public class VehicleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            VehicleDAO vehicleDAO = new VehicleDAO();
            
            if ("delete".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("id"));
                vehicleDAO.deleteVehicle(vehicleId);
                
                HttpSession session = request.getSession();
                session.setAttribute("message", "Vehicle deleted successfully!");
            }
            
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/vehicle-management.jsp");
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/vehicle-management.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            VehicleDAO vehicleDAO = new VehicleDAO();
            
            if ("add".equals(action)) {
                // Create a new Vehicle object
                Vehicle vehicle = new Vehicle();
                vehicle.setModel(request.getParameter("model"));
                vehicle.setYear(Integer.parseInt(request.getParameter("year")));
                vehicle.setPlateNumber(request.getParameter("plateNumber"));
                vehicle.setLicenseNumber(request.getParameter("licenseNumber"));
                vehicle.setVehicleType(request.getParameter("vehicleType"));
                
                // Add the vehicle
                vehicleDAO.addVehicle(vehicle);
                
                HttpSession session = request.getSession();
                session.setAttribute("message", "Vehicle added successfully!");
            } else if ("update".equals(action)) {
                // Create a Vehicle object for updating
                Vehicle vehicle = new Vehicle();
                vehicle.setCarId(Integer.parseInt(request.getParameter("carID")));
                vehicle.setModel(request.getParameter("model"));
                vehicle.setYear(Integer.parseInt(request.getParameter("year")));
                vehicle.setPlateNumber(request.getParameter("plateNumber"));
                vehicle.setLicenseNumber(request.getParameter("licenseNumber"));
                vehicle.setVehicleType(request.getParameter("vehicleType"));
                
                // Update the vehicle
                vehicleDAO.updateVehicle(vehicle);
                
                HttpSession session = request.getSession();
                session.setAttribute("message", "Vehicle updated successfully!");
            }
            
            // Redirect back to the vehicle management page
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/vehicle-management.jsp");
            
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/vehicle-management.jsp");
        }
    }
}