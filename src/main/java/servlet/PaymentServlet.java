package servlet;

import dao.BookingDAO;
import model.Booking;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/booking/payment")
public class PaymentServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        Booking booking = bookingDAO.getBookingById(bookingId);
        
        if (booking == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        req.setAttribute("booking", booking);
        req.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String paymentMethod = req.getParameter("paymentMethod");
        
        // Giả lập thanh toán thành công
        bookingDAO.updateBookingStatus(bookingId, "CONFIRMED");
        
        req.setAttribute("success", true);
        req.setAttribute("bookingId", bookingId);
        req.getRequestDispatcher("/WEB-INF/views/payment-success.jsp").forward(req, resp);
    }
}
