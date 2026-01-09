package servlet;

import dao.UserDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if ("/login".equals(action)) {
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        } else if ("/register".equals(action)) {
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
        } else if ("/logout".equals(action)) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/");
        } else if ("/profile".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                resp.sendRedirect(req.getContextPath() + "/auth/login");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if ("/login".equals(action)) {
            handleLogin(req, resp);
        } else if ("/register".equals(action)) {
            handleRegister(req, resp);
        } else if ("/update-profile".equals(action)) {
            handleUpdateProfile(req, resp);
        } else if ("/change-password".equals(action)) {
            handleChangePassword(req, resp);
        }
    }
    
    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        User user = userDAO.login(username, password);
        
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }
    
    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        
        if (userDAO.getUserByUsername(username) != null) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }
        
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        
        if (userDAO.register(user)) {
            req.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
        }
    }
    
    private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        
        currentUser.setFullname(req.getParameter("fullname"));
        currentUser.setEmail(req.getParameter("email"));
        currentUser.setPhone(req.getParameter("phone"));
        currentUser.setAddress(req.getParameter("address"));
        
        if (userDAO.updateUser(currentUser)) {
            session.setAttribute("user", currentUser);
            req.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            req.setAttribute("error", "Cập nhật thông tin thất bại!");
        }
        
        req.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(req, resp);
    }
    
    private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");
        
        if (!oldPassword.equals(currentUser.getPassword())) {
            req.setAttribute("error", "Mật khẩu cũ không đúng!");
            req.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(req, resp);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu mới không khớp!");
            req.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(req, resp);
            return;
        }
        
        if (userDAO.changePassword(currentUser.getId(), newPassword)) {
            currentUser.setPassword(newPassword);
            session.setAttribute("user", currentUser);
            req.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            req.setAttribute("error", "Đổi mật khẩu thất bại!");
        }
        
        req.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(req, resp);
    }
}