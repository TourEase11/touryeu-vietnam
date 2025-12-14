package servlet;

import dao.CategoryDAO;

import dao.TourDAO;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/tours/*")
public class TourServlet extends HttpServlet {
    private TourDAO tourDAO = new TourDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
  
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
        req.setAttribute("tour", tour);
      
        req.getRequestDispatcher("/WEB-INF/views/tour-detail.jsp").forward(req, resp);
    }
    
   
}