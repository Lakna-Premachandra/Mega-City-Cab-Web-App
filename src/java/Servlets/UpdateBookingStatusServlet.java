package Servlets;

import DAO.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateBookingStatusServlet", urlPatterns = {"/UpdateBookingStatusServlet"})
public class UpdateBookingStatusServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String status = request.getParameter("status");
            
            BookingDAO.updateBookingStatusDriver(bookingId, status);
            
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/driver.jsp");
            
        } catch (Exception e) {
            getServletContext().log("Error updating booking status", e);
            request.setAttribute("errorMessage", "Failed to update booking status: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}