package com.tourbook.dao;

import com.tourbook.model.Booking;
import com.tourbook.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    
    public int createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, tour_id, departure_date, num_people, " +
            "total_price, contact_name, contact_phone, contact_email, notes, status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getTourId());
            ps.setDate(3, booking.getDepartureDate());
            ps.setInt(4, booking.getNumPeople());
            ps.setDouble(5, booking.getTotalPrice());
            ps.setString(6, booking.getContactName());
            ps.setString(7, booking.getContactPhone());
            ps.setString(8, booking.getContactEmail());
            ps.setString(9, booking.getNotes());
            ps.setString(10, booking.getStatus());
            
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public List<Booking> getBookingsByUserId(int userId) {
        String sql = "SELECT b.*, t.name as tour_name FROM bookings b " +
            "JOIN tours t ON b.tour_id = t.id " +
            "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
        return getBookings(sql, userId);
    }
    
    public List<Booking> getAllBookings() {
        String sql = "SELECT b.*, t.name as tour_name, u.username, u.fullname as user_fullname " +
            "FROM bookings b " +
            "JOIN tours t ON b.tour_id = t.id " +
            "JOIN users u ON b.user_id = u.id " +
            "ORDER BY b.booking_date DESC";
        return getBookings(sql);
    }
    
    public Booking getBookingById(int id) {
        String sql = "SELECT b.*, t.name as tour_name, u.username, u.fullname as user_fullname " +
            "FROM bookings b " +
            "JOIN tours t ON b.tour_id = t.id " +
            "JOIN users u ON b.user_id = u.id " +
            "WHERE b.id = ?";
        List<Booking> bookings = getBookings(sql, id);
        return bookings.isEmpty() ? null : bookings.get(0);
    }
    
    public boolean updateBookingStatus(int id, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean cancelBooking(int id, int userId) {
        String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE id = ? AND user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private List<Booking> getBookings(String sql, Object... params) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(extractBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    private Booking extractBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setId(rs.getInt("id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setTourId(rs.getInt("tour_id"));
        booking.setBookingDate(rs.getTimestamp("booking_date"));
        booking.setDepartureDate(rs.getDate("departure_date"));
        booking.setNumPeople(rs.getInt("num_people"));
        booking.setTotalPrice(rs.getDouble("total_price"));
        booking.setContactName(rs.getString("contact_name"));
        booking.setContactPhone(rs.getString("contact_phone"));
        booking.setContactEmail(rs.getString("contact_email"));
        booking.setNotes(rs.getString("notes"));
        booking.setStatus(rs.getString("status"));
        booking.setTourName(rs.getString("tour_name"));
        try { booking.setUsername(rs.getString("username")); } catch (SQLException e) {}
        try { booking.setUserFullname(rs.getString("user_fullname")); } catch (SQLException e) {}
        return booking;
    }
}
