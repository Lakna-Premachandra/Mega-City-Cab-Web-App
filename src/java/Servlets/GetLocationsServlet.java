package Servlets;

import DAO.LocationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import Models.Location;
/**
 *
 * @author PC
 */
@WebServlet("/index.html")
public class GetLocationsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        LocationDAO locationDAO = new LocationDAO();
        List<Location> locationsList = locationDAO.getAllLocations();
        request.setAttribute("locationsList", locationsList);
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}