package servlet;

import dao.*;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    private TourDAO tourDAO = new TourDAO();
    private BookingDAO bookingDAO = new BookingDAO();
    private UserDAO userDAO = new UserDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        if (!isAdmin(req, resp)) return;
        
        String pathInfo = req.getPathInfo();
        
        if (pathInfo == null || "/dashboard".equals(pathInfo)) {
            handleDashboard(req, resp);
        } else if ("/tours".equals(pathInfo)) {
            handleToursList(req, resp);
        } else if ("/tours/create".equals(pathInfo)) {
            handleTourForm(req, resp, null);
        } else if (pathInfo.startsWith("/tours/edit/")) {
            int tourId = Integer.parseInt(pathInfo.substring("/tours/edit/".length()));
            Tour tour = tourDAO.getTourById(tourId);
            handleTourForm(req, resp, tour);
        } else if (pathInfo.startsWith("/tours/delete/")) {
            handleDeleteTour(req, resp);
        } else if ("/bookings".equals(pathInfo)) {
            handleBookingsList(req, resp);
        } else if (pathInfo.startsWith("/bookings/update-status")) {
            handleUpdateBookingStatus(req, resp);
        } else if ("/users".equals(pathInfo)) {
            handleUsersList(req, resp);
        } else if (pathInfo.startsWith("/users/delete/")) {
            handleDeleteUser(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        if (!isAdmin(req, resp)) return;
        
        String pathInfo = req.getPathInfo();
        
        if ("/tours/save".equals(pathInfo)) {
            handleSaveTour(req, resp);
        }
    }
    
    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return false;
        }
        return true;
    }
    
    private void handleDashboard(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Booking> recentBookings = bookingDAO.getAllBookings();
        List<Tour> tours = tourDAO.getAllTours();
        List<User> users = userDAO.getAllUsers();
        
        req.setAttribute("totalBookings", recentBookings.size());
        req.setAttribute("totalTours", tours.size());
        req.setAttribute("totalUsers", users.size());
        req.setAttribute("recentBookings", recentBookings.subList(0, Math.min(5, recentBookings.size())));
        
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
    
    private void handleToursList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Tour> tours = tourDAO.getAllTours();
        req.setAttribute("tours", tours);
        req.getRequestDispatcher("/WEB-INF/views/admin/tours.jsp").forward(req, resp);
    }
    
    private void handleTourForm(HttpServletRequest req, HttpServletResponse resp, Tour tour) 
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        req.setAttribute("categories", categories);
        if (tour != null) {
            req.setAttribute("tour", tour);
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/tour-form.jsp").forward(req, resp);
    }
    
    private void handleSaveTour(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Tour tour = new Tour();
        
        if (idStr != null && !idStr.isEmpty()) {
            tour.setId(Integer.parseInt(idStr));
        }
        
        tour.setName(req.getParameter("name"));
        tour.setDescription(req.getParameter("description"));
        tour.setLocation(req.getParameter("location"));
        tour.setDuration(Integer.parseInt(req.getParameter("duration")));
        tour.setPrice(Double.parseDouble(req.getParameter("price")));
        tour.setDiscount(Double.parseDouble(req.getParameter("discount")));
        tour.setImage(req.getParameter("image"));
        tour.setAvailableSeats(Integer.parseInt(req.getParameter("availableSeats")));
        tour.setDepartureDate(Date.valueOf(req.getParameter("departureDate")));
        tour.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        tour.setVehicle(req.getParameter("vehicle"));
        tour.setItinerary(req.getParameter("itinerary"));
        tour.setFeatured("on".equals(req.getParameter("featured")));
        
        boolean success;
        if (idStr != null && !idStr.isEmpty()) {
            success = tourDAO.updateTour(tour);
        } else {
            success = tourDAO.createTour(tour);
        }
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/tours");
        } else {
            req.setAttribute("error", "Lưu tour thất bại!");
            handleTourForm(req, resp, tour);
        }
    }
    
    private void handleDeleteTour(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        String pathInfo = req.getPathInfo();
        int tourId = Integer.parseInt(pathInfo.substring("/tours/delete/".length()));
        tourDAO.deleteTour(tourId);
        resp.sendRedirect(req.getContextPath() + "/admin/tours");
    }
    
    private void handleBookingsList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Booking> bookings = bookingDAO.getAllBookings();
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/WEB-INF/views/admin/bookings.jsp").forward(req, resp);
    }
    
    private void handleUpdateBookingStatus(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        int bookingId = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        bookingDAO.updateBookingStatus(bookingId, status);
        resp.sendRedirect(req.getContextPath() + "/admin/bookings");
    }
    
    private void handleUsersList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }
    
    private void handleDeleteUser(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        String pathInfo = req.getPathInfo();
        int userId = Integer.parseInt(pathInfo.substring("/users/delete/".length()));
        userDAO.deleteUser(userId);
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}