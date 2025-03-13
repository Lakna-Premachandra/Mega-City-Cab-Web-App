package Servlets;

import DAO.BookingDAO;
import java.io.IOException;
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
                     HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Booking Updated Successfully");
                String errorMessage = "Booking Updated Successfully";
                response.sendRedirect("views/dashboard-layout/admin.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
            } else if ("delete".equals(action)) {
                bookingDAO.deleteBooking(bookingId);
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Booking Deleted Successfully");
                String errorMessage = "Booking Deleted Successfully";
                response.sendRedirect("views/dashboard-layout/admin.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
            }
            
        
            
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}