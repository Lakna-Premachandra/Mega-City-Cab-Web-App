package Servlets;

import DAO.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "BookingActions", urlPatterns = {"/BookingActions"})
public class BookingActions extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("id"));
        
        try {
            BookingDAO bookingDAO = new BookingDAO();
            
            if ("updateStatus".equals(action)) {
                String status = request.getParameter("status");
                bookingDAO.updateBookingStatus(bookingId, status);
            } else if ("delete".equals(action)) {
                bookingDAO.deleteBooking(bookingId);
            }
            
            // Redirect back to the admin dashboard
            response.sendRedirect(request.getContextPath() + "/views/dashboard-layout/admin.jsp");
            
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}