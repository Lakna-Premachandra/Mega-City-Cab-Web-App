/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import Models.Booking;
import DAO.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        
        try {
            List<Booking> bookings = new BookingDAO().getAllBookings();
            out.println("[");
            for (int i = 0; i < bookings.size(); i++) {
                Booking b = bookings.get(i);
                out.println("{" +
                        "\"bookingID\": " + b.getBookingID() +
                        ", \"customerID\": " + b.getCustomerID() +
                        ", \"driverID\": " + b.getDriverID() +
                        ", \"carID\": " + b.getCarID() +
                        ", \"startDestination\": \"" + b.getStartDestination() + "\"" +
                        ", \"endDestination\": \"" + b.getEndDestination() + "\"" +
                        ", \"bookingDateTime\": \"" + b.getBookingDateTime() + "\"" +
                        ", \"amount\": " + b.getAmount() +
                        ", \"status\": \"" + b.getStatus() + "\"" +
                        "}");
                if (i < bookings.size() - 1) out.println(",");
            }
            out.println("]");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
