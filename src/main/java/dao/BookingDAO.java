package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Booking;
import util.DatabaseUtil;

public class BookingDAO {

	public int createBooking(Booking booking) {
		String sql = "INSERT INTO bookings (user_id, tour_id, departure_date, num_people, "
				+ "total_price, contact_name, contact_phone, contact_email, notes, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
		String sql = "SELECT b.*, t.name as tour_name FROM bookings b " + "JOIN tours t ON b.tour_id = t.id "
				+ "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
		return getBookings(sql, userId);
	}

	public List<Booking> getAllBookings() {
		String sql = "SELECT b.*, t.name as tour_name, u.username, u.fullname as user_fullname " + "FROM bookings b "
				+ "JOIN tours t ON b.tour_id = t.id " + "JOIN users u ON b.user_id = u.id "
				+ "ORDER BY b.booking_date DESC";
		return getBookings(sql);
	}

	public Booking getBookingById(int id) {
		String sql = "SELECT b.*, t.name as tour_name, u.username, u.fullname as user_fullname " + "FROM bookings b "
				+ "JOIN tours t ON b.tour_id = t.id " + "JOIN users u ON b.user_id = u.id " + "WHERE b.id = ?";
		List<Booking> bookings = getBookings(sql, id);
		return bookings.isEmpty() ? null : bookings.get(0);
	}

	public boolean updateBookingStatus(int id, String status) {
	    // Chuẩn hóa status về viết hoa để khớp với các điều kiện <c:if> trong JSP
	    String formattedStatus = (status != null) ? status.trim().toUpperCase() : ""; 
	    String sql = "UPDATE bookings SET status = ? WHERE id = ?";
	    
	    try (Connection conn = DatabaseUtil.getConnection()) {
	        if (conn == null) {
	            System.err.println("DEBUG: Không thể kết nối Database!");
	            return false;
	        }
	        
	        try (PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, formattedStatus);
	            ps.setInt(2, id);
	            
	            int rowsAffected = ps.executeUpdate();
	            System.out.println("DEBUG: SQL Update đơn #" + id + " thành [" + formattedStatus + "]. Số dòng ảnh hưởng: " + rowsAffected);
	            return rowsAffected > 0;
	        }
	    } catch (SQLException e) {
	        System.err.println("DEBUG: Lỗi SQL tại BookingDAO: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return false;
	}
	public boolean cancelBooking(int id, int userId) {
		String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE id = ? AND user_id = ?";
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
		try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
		try {
			booking.setUsername(rs.getString("username"));
		} catch (SQLException e) {
		}
		try {
			booking.setUserFullname(rs.getString("user_fullname"));
		} catch (SQLException e) {
		}
		return booking;
	}

	public List<Object[]> getRevenueByDateRange(java.sql.Date from, java.sql.Date to) {
		List<Object[]> list = new ArrayList<>();
		// Mở rộng điều kiện để lấy cả đơn đã xác nhận
		String sql = "SELECT CAST(booking_date AS DATE) AS day, SUM(total_price) AS revenue " + "FROM bookings "
				+ "WHERE status IN ('CONFIRMED', 'COMPLETED') " + "AND CAST(booking_date AS DATE) BETWEEN ? AND ? "
				+ "GROUP BY CAST(booking_date AS DATE) " + "ORDER BY day ASC";

		try (Connection conn = util.DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDate(1, from);
			ps.setDate(2, to);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(new Object[] { rs.getDate("day"), rs.getDouble("revenue") });
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public int countByStatus(String status) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM bookings WHERE status = ?";

		try (Connection conn = util.DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, status);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	// --- THÊM VÀO DƯỚI DÒNG 182 ĐỂ FIX LỖI TOURSERVLET ---
    public Booking getCompletedBookingForReview(int bookingId, int userId) {
        String sql = "SELECT id, tour_id, user_id, status FROM bookings WHERE id = ? AND user_id = ? AND status = 'COMPLETED'";
        try (Connection conn = DatabaseUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking b = new Booking();
                    b.setId(rs.getInt("id"));
                    b.setTourId(rs.getInt("tour_id"));
                    b.setUserId(rs.getInt("user_id"));
                    b.setStatus(rs.getString("status"));
                    return b;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}