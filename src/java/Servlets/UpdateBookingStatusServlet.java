package Servlets;

import DAO.BookingDAO;
import DAO.DriverDAO;
import Models.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UpdateBookingStatusServlet", urlPatterns = {"/UpdateBookingStatusServlet"})
public class UpdateBookingStatusServlet extends HttpServlet {
    
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String status = request.getParameter("status");
        
        getServletContext().log("Received status: " + status);
        
        HttpSession session = request.getSession();
        Driver driver = (Driver) session.getAttribute("driver");
        
        if ("approved".equalsIgnoreCase(status)) {
            if (driver != null) {
                int driverId = driver.getDriverId();
                int carId = driver.getCarId();
                
                getServletContext().log("Driver ID: " + driverId + ", Car ID: " + carId);
                
                BookingDAO.updateBookingWithDriver(bookingId, driverId, carId, status);
                getServletContext().log("Booking updated successfully with driver and car");
            } else {
                getServletContext().log("Driver not found in session");
                BookingDAO.updateBookingStatusDriver(bookingId, status);
            }
        } else {
            BookingDAO.updateBookingStatusDriver(bookingId, status);
        }
        
        response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver.jsp");
        
    } catch (Exception e) {
        getServletContext().log("Error updating booking status", e);
        request.setAttribute("errorMessage", "Failed to update booking status: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}
}