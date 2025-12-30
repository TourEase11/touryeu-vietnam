package servlet;

import dao.BookingDAO;
import dao.TourDAO;
import dao.ReviewDAO;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/booking/*")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    private TourDAO tourDAO = new TourDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        
        String pathInfo = req.getPathInfo();
        
        if ("/create".equals(pathInfo)) {
            handleShowBookingForm(req, resp);
        } else if ("/my-bookings".equals(pathInfo)) {
            handleMyBookings(req, resp);
        } else if (pathInfo != null && pathInfo.startsWith("/cancel/")) {
            handleCancelBooking(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        
        String pathInfo = req.getPathInfo();
        
        if ("/create".equals(pathInfo)) {
            handleCreateBooking(req, resp);
        }
    }
    
    private void handleShowBookingForm(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        int tourId = Integer.parseInt(req.getParameter("tourId"));
        Tour tour = tourDAO.getTourById(tourId);
        
        if (tour == null) {
            resp.sendRedirect(req.getContextPath() + "/tours");
            return;
        }
        
        req.setAttribute("tour", tour);
        req.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(req, resp);
    }
    
    private void handleCreateBooking(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        
        int tourId = Integer.parseInt(req.getParameter("tourId"));
        int numPeople = Integer.parseInt(req.getParameter("numPeople"));
        Date departureDate = Date.valueOf(req.getParameter("departureDate"));
        String contactName = req.getParameter("contactName");
        String contactPhone = req.getParameter("contactPhone");
        String contactEmail = req.getParameter("contactEmail");
        String notes = req.getParameter("notes");
        
        Tour tour = tourDAO.getTourById(tourId);
        double totalPrice = tour.getFinalPrice() * numPeople;
        
        Booking booking = new Booking();
        booking.setUserId(user.getId());
        booking.setTourId(tourId);
        booking.setDepartureDate(departureDate);
        booking.setNumPeople(numPeople);
        booking.setTotalPrice(totalPrice);
        booking.setContactName(contactName);
        booking.setContactPhone(contactPhone);
        booking.setContactEmail(contactEmail);
        booking.setNotes(notes);
        booking.setStatus("PENDING");
        
        int bookingId = bookingDAO.createBooking(booking);
        
        if (bookingId > 0) {
            tourDAO.updateAvailableSeats(tourId, numPeople);
            resp.sendRedirect(req.getContextPath() + "/booking/payment?bookingId=" + bookingId);
        } else {
            req.setAttribute("error", "Đặt tour thất bại!");
            req.setAttribute("tour", tour);
            req.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(req, resp);
        }
    }
    
    private void handleMyBookings(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        List<Booking> bookings = bookingDAO.getBookingsByUserId(user.getId());
     
        // Kiểm tra từng booking đã review chưa
        ReviewDAO reviewDAO = new ReviewDAO();
        for (Booking b : bookings) {
            b.setReviewed(reviewDAO.hasReviewedBookingForUserBooking(b.getId(), user.getId()));
        }
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/WEB-INF/views/my-bookings.jsp").forward(req, resp);
    }
    
    private void handleCancelBooking(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        String pathInfo = req.getPathInfo();
        int bookingId = Integer.parseInt(pathInfo.substring("/cancel/".length()));
        
        bookingDAO.cancelBooking(bookingId, user.getId());
        resp.sendRedirect(req.getContextPath() + "/booking/my-bookings");
    }
}