	package servlet;
	
	import dao.*;
	import model.*;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.*;
	import java.io.File;
	import java.io.IOException;
	import java.sql.Date;
	import java.time.LocalDate;
	import java.util.List;
	
	@WebServlet("/admin/*")
	public class AdminServlet extends HttpServlet {
		private TourDAO tourDAO = new TourDAO();
		private BookingDAO bookingDAO = new BookingDAO();
		private UserDAO userDAO = new UserDAO();
		private CategoryDAO categoryDAO = new CategoryDAO();
	
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		    req.setCharacterEncoding("UTF-8");
	
		    if (!isAdmin(req, resp)) return;
	
		    String pathInfo = req.getPathInfo();
	
		    if (pathInfo == null || "/".equals(pathInfo) || "/dashboard".equals(pathInfo)) {
		        handleDashboard(req, resp);
		    } else if ("/bookings".equals(pathInfo)) {
		        handleBookingsList(req, resp);
		    } else if ("/bookings/update-status".equals(pathInfo)) {
		        handleUpdateBookingStatus(req, resp);
		    } else if ("/tours".equals(pathInfo)) {
		        handleToursList(req, resp);
		    } 
		    // --- BỔ SUNG CÁC NHÁNH DƯỚI ĐÂY ---
		    else if ("/tours/create".equals(pathInfo)) {
		        handleTourForm(req, resp, null); // Hiện form trống để thêm mới
		    } else if (pathInfo.startsWith("/tours/edit/")) {
		        try {
		            int tourId = Integer.parseInt(pathInfo.substring("/tours/edit/".length()));
		            Tour tour = tourDAO.getTourById(tourId);
		            handleTourForm(req, resp, tour); // Hiện form có dữ liệu để sửa
		        } catch (Exception e) {
		            resp.sendRedirect(req.getContextPath() + "/admin/tours");
		        }
		    } else if (pathInfo.startsWith("/tours/delete/")) {
		        handleDeleteTour(req, resp);
		    }
		    // ----------------------------------
		    else if ("/users".equals(pathInfo)) {
		        handleUsersList(req, resp);
		    } else if (pathInfo.startsWith("/users/delete/")) {
		        handleDeleteUser(req, resp);
		    } else {
		        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
		    }
		}
	
		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			resp.setCharacterEncoding("UTF-8");
			if (!isAdmin(req, resp))
				return;
	
			String pathInfo = req.getPathInfo();
	
			if ("/tours/save".equals(pathInfo)) {
				handleSaveTour(req, resp);
			} else if (pathInfo.startsWith("/bookings/update-status")) {
				handleUpdateBookingStatus(req, resp);
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
			String from = req.getParameter("fromDate");
			String to = req.getParameter("toDate");
			LocalDate fromDate;
			LocalDate toDate;
	
			if (from == null || to == null || from.isEmpty() || to.isEmpty()) {
				toDate = LocalDate.now();
				fromDate = toDate.minusDays(6);
			} else {
				fromDate = LocalDate.parse(from);
				toDate = LocalDate.parse(to);
			}
	
			List<Object[]> revenueList = bookingDAO.getRevenueByDateRange(java.sql.Date.valueOf(fromDate),
					java.sql.Date.valueOf(toDate));
	
			StringBuilder dates = new StringBuilder("[");
			StringBuilder values = new StringBuilder("[");
	
			if (revenueList != null && !revenueList.isEmpty()) {
				for (int i = 0; i < revenueList.size(); i++) {
					Object[] row = revenueList.get(i);
					dates.append("'").append(row[0].toString()).append("'");
					values.append(row[1]);
					if (i < revenueList.size() - 1) {
						dates.append(",");
						values.append(",");
					}
				}
			}
			dates.append("]");
			values.append("]");
	
			req.setAttribute("fromDate", fromDate.toString());
			req.setAttribute("toDate", toDate.toString());
			req.setAttribute("revenueDates", dates.toString());
			req.setAttribute("revenueValues", values.toString());
	
			req.setAttribute("pendingCount", bookingDAO.countByStatus("PENDING"));
			req.setAttribute("confirmedCount", bookingDAO.countByStatus("CONFIRMED"));
			req.setAttribute("completedCount", bookingDAO.countByStatus("COMPLETED"));
			req.setAttribute("cancelledCount", bookingDAO.countByStatus("CANCELLED"));
	
			req.setAttribute("totalTours", tourDAO.getAllTours().size());
			req.setAttribute("totalUsers", userDAO.getAllUsers().size());
	
			List<Booking> allBookings = bookingDAO.getAllBookings();
			req.setAttribute("totalBookings", allBookings.size());
			if (!allBookings.isEmpty()) {
				allBookings.sort((b1, b2) -> b2.getBookingDate().compareTo(b1.getBookingDate()));
				req.setAttribute("recentBookings", allBookings.subList(0, Math.min(5, allBookings.size())));
			}
	
			req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
		}
	
		private void handleToursList(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			req.setAttribute("tours", tourDAO.getAllTours());
			req.getRequestDispatcher("/WEB-INF/views/admin/tours.jsp").forward(req, resp);
		}
	
		private void handleTourForm(HttpServletRequest req, HttpServletResponse resp, Tour tour)
				throws ServletException, IOException {
			req.setAttribute("categories", categoryDAO.getAllCategories());
			if (tour != null)
				req.setAttribute("tour", tour);
			req.getRequestDispatcher("/WEB-INF/views/admin/tour-form.jsp").forward(req, resp);
		}
	
		private void handleSaveTour(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// PHẢI ĐẶT ĐẦU TIÊN để nhận Tiếng Việt chuẩn
			req.setCharacterEncoding("UTF-8");
	
			try {
				String idStr = req.getParameter("id");
				Tour tour = new Tour();
	
				if (idStr != null && !idStr.isEmpty()) {
					tour.setId(Integer.parseInt(idStr));
				}
	
				// Nhận dữ liệu văn bản
				tour.setName(req.getParameter("name"));
				tour.setDescription(req.getParameter("description"));
				tour.setLocation(req.getParameter("location"));
				tour.setDuration(Integer.parseInt(req.getParameter("duration")));
				tour.setPrice(Double.parseDouble(req.getParameter("price")));
				tour.setAvailableSeats(Integer.parseInt(req.getParameter("availableSeats")));
				tour.setDepartureDate(java.sql.Date.valueOf(req.getParameter("departureDate")));
				tour.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
				tour.setFeatured("on".equals(req.getParameter("featured")));
	
				// XỬ LÝ ĐƯỜNG DẪN ẢNH (Quan trọng)
				String rawImage = req.getParameter("image");
				if (rawImage != null && rawImage.startsWith("/TourBooking/")) {
					// Nếu đường dẫn chứa tên project, ta cắt bỏ để chỉ còn: assets/img/tours/...
					rawImage = rawImage.substring("/TourBooking/".length());
				}
				tour.setImage(rawImage);
	
				// Lưu vào Database
				boolean success = (idStr != null && !idStr.isEmpty()) ? tourDAO.updateTour(tour) : tourDAO.createTour(tour);
	
				if (success) {
					resp.sendRedirect(req.getContextPath() + "/admin/tours");
				} else {
					req.setAttribute("error", "Không thể lưu dữ liệu!");
					handleTourForm(req, resp, tour);
				}
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect(req.getContextPath() + "/admin/tours");
			}
		}
	
		private void handleBookingsList(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			List<Booking> list = bookingDAO.getAllBookings();
			req.setAttribute("bookings", list);
			req.getRequestDispatcher("/WEB-INF/views/admin/bookings.jsp").forward(req, resp);
		}
	
		private void handleUpdateBookingStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
			req.setCharacterEncoding("UTF-8");
	
			try {
				String idRaw = req.getParameter("id");
				String status = req.getParameter("status");
	
				if (idRaw != null && status != null) {
					int bookingId = Integer.parseInt(idRaw);
	
					boolean success = bookingDAO.updateBookingStatus(bookingId, status);
	
					if (success) {
						System.out.println("LOG: Cập nhật thành công đơn #" + bookingId + " -> " + status);
					} else {
						System.out.println("LOG: Cập nhật thất bại đơn #" + bookingId);
					}
				}
			} catch (Exception e) {
				System.err.println("Lỗi xử lý Update Status: " + e.getMessage());
				e.printStackTrace();
			}
	
			resp.sendRedirect(req.getContextPath() + "/admin/bookings");
		}
	
		private void handleDeleteTour(HttpServletRequest req, HttpServletResponse resp) throws IOException {
			try {
				int tourId = Integer.parseInt(req.getPathInfo().substring("/tours/delete/".length()));
				tourDAO.deleteTour(tourId);
			} catch (Exception e) {
				e.printStackTrace();
			}
			resp.sendRedirect(req.getContextPath() + "/admin/tours");
		}
	
		private void handleUsersList(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			req.setAttribute("users", userDAO.getAllUsers());
			req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
		}
	
		private void handleDeleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
			try {
				int userId = Integer.parseInt(req.getPathInfo().substring("/users/delete/".length()));
				userDAO.deleteUser(userId);
			} catch (Exception e) {
			}
			resp.sendRedirect(req.getContextPath() + "/admin/users");
		}
	}