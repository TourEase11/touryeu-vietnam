package servlet;

import dao.CategoryDAO;
import dao.ReviewDAO;
import dao.TourDAO;
import dao.BookingDAO;

import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/tours/*")
public class TourServlet extends HttpServlet {
	private BookingDAO bookingDAO = new BookingDAO();
    private TourDAO tourDAO = new TourDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        if (pathInfo == null || "/".equals(pathInfo)) {
            handleList(req, resp);
        } else if (pathInfo.startsWith("/detail/")) {
            handleDetail(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/tours");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        if ("/review".equals(pathInfo)) {
            handleReview(req, resp);
        }
    }
    
    private void handleList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String categoryIdStr = req.getParameter("categoryId");
        String minPriceStr = req.getParameter("minPrice");
        String maxPriceStr = req.getParameter("maxPrice");
        
        Integer categoryId = null;
        Double minPrice = null;
        Double maxPrice = null;
        
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            categoryId = Integer.parseInt(categoryIdStr);
        }
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            minPrice = Double.parseDouble(minPriceStr);
        }
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            maxPrice = Double.parseDouble(maxPriceStr);
        }
        
        List<Tour> tours;
        if (keyword != null || categoryId != null || minPrice != null || maxPrice != null) {
            tours = tourDAO.searchTours(keyword, categoryId, minPrice, maxPrice);
        } else {
            tours = tourDAO.getAllTours();
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        
        req.setAttribute("tours", tours);
        req.setAttribute("categories", categories);
        req.setAttribute("keyword", keyword);
        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("minPrice", minPrice);
        req.setAttribute("maxPrice", maxPrice);
        
        req.getRequestDispatcher("/WEB-INF/views/tours.jsp").forward(req, resp);
    }
    
    private void handleDetail(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        int tourId = Integer.parseInt(pathInfo.substring("/detail/".length()));
        
        Tour tour = tourDAO.getTourById(tourId);
        if (tour == null) {
            resp.sendRedirect(req.getContextPath() + "/tours");
            return;
        }
        
        List<Review> reviews = reviewDAO.getReviewsByTourId(tourId);
        
        HttpSession session = req.getSession(false);
        boolean canReview = false;
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            //canReview = !reviewDAO.hasUserReviewed(tourId, user.getId());
        }
        
        req.setAttribute("tour", tour);
        req.setAttribute("reviews", reviews);
        req.setAttribute("canReview", canReview);
        
        req.getRequestDispatcher("/WEB-INF/views/tour-detail.jsp").forward(req, resp);
    }
    
    private void handleReview(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");
        
     // 1️ Check booking COMPLETED + đúng user
        Booking booking = bookingDAO.getCompletedBookingForReview(bookingId, user.getId());
        if (booking == null) {
            resp.sendError(403, "Booking không hợp lệ hoặc chưa hoàn thành");
            return;
        }

        // 2️ Check đã review chưa
        if (reviewDAO.hasReviewedBooking(bookingId)) {
            resp.sendError(400, "Booking này đã được review");
            return;
        }
        
        
     // 3️ Create review
        Review review = new Review();
        review.setBookingId(bookingId);
        review.setTourId(booking.getTourId());
        review.setUserId(user.getId());
        review.setRating(rating);
        review.setComment(comment);
        
        reviewDAO.createReview(review);
        
        resp.sendRedirect(req.getContextPath() +  "/my-bookings");
    }
}
