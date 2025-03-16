package Servlets;

import DAO.BookingDAO;
import DAO.LocationDAO;
import Models.Booking;
import Models.Location;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PC
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(BookingServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Retrieve customerID from the session
            HttpSession session = request.getSession();
            Integer customerID = (Integer) session.getAttribute("customerID");

            if (customerID == null) {
                // If customerID is not in session, redirect to login
                response.sendRedirect("./views/auth-layout/sign-in/signIn.jsp");
                return;
            }

            // Extract form data
            String vehicleType = request.getParameter("vehicleType");
            String fromLocationID = request.getParameter("fromLocationID");
            String toLocationID = request.getParameter("toLocationID");
            String bookingDate = request.getParameter("bookingDateTime"); // Get the date
            String bookingTime = request.getParameter("bookingTime"); // Get the time
            String description = request.getParameter("description");
            String address = request.getParameter("address"); // Get the address
            String name = request.getParameter("name");
            String mobile = request.getParameter("mobile");

            // Combine date and time into a single string
            String bookingDateTime = bookingDate + " " + bookingTime;

            // Get location names using the location IDs
            LocationDAO locationDAO = new LocationDAO();
            String startLocationName = locationDAO.getLocationNameById(fromLocationID);
            String endLocationName = locationDAO.getLocationNameById(toLocationID);

            double amount = 0.0;
            try {
                amount = Double.parseDouble(request.getParameter("calculatedTotalPrice"));
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Error parsing total price: {0}", e.getMessage());
                // Use a default value or handle appropriately
            }

            String status = "Pending"; // Default status for new bookings

            // Create a Booking object
            Booking booking = new Booking();
            booking.setCustomerID(customerID);
            booking.setVehicleType(vehicleType);
            booking.setStartDestination(fromLocationID); // Store ID for database reference
            booking.setEndDestination(toLocationID); // Store ID for database reference
            booking.setStartLocationName(startLocationName); // Store location name
            booking.setEndLocationName(endLocationName); // Store location name
            booking.setBookingDateTime(bookingDateTime); // Combined date and time
            booking.setBookingTime(bookingTime); // Store time separately if needed
            booking.setAmount(amount);
            booking.setStatus(status);
            booking.setDescription(description);
            booking.setAddress(address); // Set the address
            booking.setCustomerName(name); // Set customer name
            booking.setCustomerMobile(mobile); // Set customer mobile

            // Save the booking to the database
            BookingDAO bookingDAO = new BookingDAO();
            int bookingId = bookingDAO.saveBooking(booking);

            if (bookingId > 0) {
                // Store booking ID and data in session for confirmation page
                session.setAttribute("bookingId", bookingId);
                session.setAttribute("startLocationName", startLocationName);
                session.setAttribute("endLocationName", endLocationName);
                session.setAttribute("bookingDateTime", bookingDateTime);
                session.setAttribute("bookingTime", bookingTime);
                session.setAttribute("vehicleType", vehicleType);
                session.setAttribute("totalAmount", amount);
                session.setAttribute("customerAddress", address);
                session.setAttribute("bookingSuccess", true);

                // Redirect to a success page
//            response.sendRedirect("./index.jsp");
                session.setAttribute("errorMessage", "Your Booking Added Successfully!");
                String errorMessage = "Vehicle added successfully!";
                response.sendRedirect("./index.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));

            } else {
                // Booking failed
            
                
                session.setAttribute("errorMessage", "Failed to create booking. Please try again.");
                String errorMessage = "Failed to create booking. Please try again.";
                response.sendRedirect("./index.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
            }

        } catch (SQLException | ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Database error while saving booking", ex);

            // Handle the error
            request.setAttribute("errorMessage", "An error occurred while saving the booking: " + ex.getMessage());
            request.getRequestDispatcher("./index.jsp").forward(request, response);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Unexpected error in BookingServlet", ex);

            // Handle other unexpected errors
//            request.setAttribute("errorMessage", "An unexpected error occurred: " + ex.getMessage());
            HttpSession session = request.getSession();

            request.getRequestDispatcher("./index.jsp").forward(request, response);
             session.setAttribute("errorMessage", "Failed to create booking. Please try again.");
                String errorMessage = "Failed to create booking. Please try again.";
                response.sendRedirect("./index.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
        }
    }
}
