/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
/**
 *
 * @author PC
 */
@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/CancelBookingServlet"})
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            
            BookingDAO bookingDAO = new BookingDAO();
            bookingDAO.updateBookingStatus(bookingId, "Cancelled");
            
            response.sendRedirect(request.getContextPath() + "/views/main-layout/customer-account.jsp");
            
        } catch (SQLException | ClassNotFoundException e) {
            getServletContext().log("Error cancelling booking", e);
            request.setAttribute("errorMessage", "Failed to cancel booking: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}

