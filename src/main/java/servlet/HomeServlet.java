package servlet;

import dao.CategoryDAO;
import dao.TourDAO;
import model.Category;
import model.Tour;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    private TourDAO tourDAO = new TourDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Tour> featuredTours = tourDAO.getFeaturedTours();
        List<Category> categories = categoryDAO.getAllCategories();
        
        req.setAttribute("featuredTours", featuredTours);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}