package dao;

import model.Tour;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TourDAO {
    
    public List<Tour> getAllTours() {
        return getTours("SELECT t.*, c.name as category_name, " +
            "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.id) as review_count " +
            "FROM tours t LEFT JOIN categories c ON t.category_id = c.id " +
            "LEFT JOIN reviews r ON t.id = r.tour_id " +
            "GROUP BY t.id, c.name ORDER BY t.created_at DESC");
    }
    
    public List<Tour> getFeaturedTours() {
        return getTours("SELECT t.*, c.name as category_name, " +
            "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.id) as review_count " +
            "FROM tours t LEFT JOIN categories c ON t.category_id = c.id " +
            "LEFT JOIN reviews r ON t.id = r.tour_id " +
            "WHERE t.featured = true " +
            "GROUP BY t.id, c.name LIMIT 6");
    }
    
    public List<Tour> searchTours(String keyword, Integer categoryId, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder(
            "SELECT t.*, c.name as category_name, " +
            "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.id) as review_count " +
            "FROM tours t LEFT JOIN categories c ON t.category_id = c.id " +
            "LEFT JOIN reviews r ON t.id = r.tour_id WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (LOWER(t.name) LIKE ? OR LOWER(t.location) LIKE ?)");
            String likeKeyword = "%" + keyword.toLowerCase() + "%";
            params.add(likeKeyword);
            params.add(likeKeyword);
        }
        
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND t.category_id = ?");
            params.add(categoryId);
        }
        
        if (minPrice != null) {
            sql.append(" AND t.price >= ?");
            params.add(minPrice);
        }
        
        if (maxPrice != null) {
            sql.append(" AND t.price <= ?");
            params.add(maxPrice);
        }
        
        sql.append(" GROUP BY t.id, c.name ORDER BY t.created_at DESC");
        
        return getTours(sql.toString(), params.toArray());
    }
    
    public Tour getTourById(int id) {
        String sql = "SELECT t.*, c.name as category_name, " +
            "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.id) as review_count " +
            "FROM tours t LEFT JOIN categories c ON t.category_id = c.id " +
            "LEFT JOIN reviews r ON t.id = r.tour_id " +
            "WHERE t.id = ? GROUP BY t.id, c.name";
        List<Tour> tours = getTours(sql, id);
        return tours.isEmpty() ? null : tours.get(0);
    }
    
    public boolean createTour(Tour tour) {
        String sql = "INSERT INTO tours (name, description, location, duration, price, discount, " +
            "image, available_seats, departure_date, category_id, vehicle, itinerary, featured) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setTourParams(ps, tour);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateTour(Tour tour) {
        String sql = "UPDATE tours SET name = ?, description = ?, location = ?, duration = ?, " +
            "price = ?, discount = ?, image = ?, available_seats = ?, departure_date = ?, " +
            "category_id = ?, vehicle = ?, itinerary = ?, featured = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setTourParams(ps, tour);
            ps.setInt(14, tour.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteTour(int id) {
        String sql = "DELETE FROM tours WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateAvailableSeats(int tourId, int seats) {
        String sql = "UPDATE tours SET available_seats = available_seats - ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seats);
            ps.setInt(2, tourId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private List<Tour> getTours(String sql, Object... params) {
        List<Tour> tours = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    tours.add(extractTour(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tours;
    }
    
    private void setTourParams(PreparedStatement ps, Tour tour) throws SQLException {
        ps.setString(1, tour.getName());
        ps.setString(2, tour.getDescription());
        ps.setString(3, tour.getLocation());
        ps.setInt(4, tour.getDuration());
        ps.setDouble(5, tour.getPrice());
        ps.setDouble(6, tour.getDiscount());
        ps.setString(7, tour.getImage());
        ps.setInt(8, tour.getAvailableSeats());
        ps.setDate(9, tour.getDepartureDate());
        ps.setInt(10, tour.getCategoryId());
        ps.setString(11, tour.getVehicle());
        ps.setString(12, tour.getItinerary());
        ps.setBoolean(13, tour.isFeatured());
    }
    
    private Tour extractTour(ResultSet rs) throws SQLException {
        Tour tour = new Tour();
        tour.setId(rs.getInt("id"));
        tour.setName(rs.getString("name"));
        tour.setDescription(rs.getString("description"));
        tour.setLocation(rs.getString("location"));
        tour.setDuration(rs.getInt("duration"));
        tour.setPrice(rs.getDouble("price"));
        tour.setDiscount(rs.getDouble("discount"));
        
        // Xử lý ảnh mặc định nếu dữ liệu trống
        String img = rs.getString("image");
        tour.setImage(img != null && !img.isEmpty() ? img : "https://placehold.co/300x200?text=No+Image");
        
        tour.setAvailableSeats(rs.getInt("available_seats"));
        tour.setDepartureDate(rs.getDate("departure_date"));
        tour.setCategoryId(rs.getInt("category_id"));
        tour.setCategoryName(rs.getString("category_name"));
        tour.setVehicle(rs.getString("vehicle"));
        tour.setItinerary(rs.getString("itinerary"));
        tour.setFeatured(rs.getBoolean("featured"));
        tour.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Làm tròn rating 1 chữ số thập phân
        double rating = rs.getDouble("avg_rating");
        tour.setAvgRating(Math.round(rating * 10.0) / 10.0);
        tour.setReviewCount(rs.getInt("review_count"));
        return tour;
    }
    public List<Tour> getAllToursPaged(int offset, int limit) {
        String sql = "SELECT t.*, c.name as category_name, " +
                     "0 as avg_rating, 0 as review_count " + 
                     "FROM tours t LEFT JOIN categories c ON t.category_id = c.id " +
                     "ORDER BY t.created_at DESC LIMIT ? OFFSET ?";
                     
        return getTours(sql, limit, offset);
    }

    public int getTotalToursCount() {
        String sql = "SELECT COUNT(*) FROM tours";
        try (Connection conn = util.DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
}