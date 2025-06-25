package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.DaoUser;
import Entity.Users;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;

/**
 *
 * @author HP
 */
@WebServlet(name = "loginController", urlPatterns = {"/loginController"})
public class loginController extends HttpServlet {

    private static final long COOKIE_EXPIRY_SECONDS = 7 * 24 * 60 * 60; // 7 ngày

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra cookie
        String email = null;
        String roleStr = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_meEmail".equals(cookie.getName())) {
                    email = cookie.getValue();
                } else if ("remember_meRole".equals(cookie.getName())) {
                    roleStr = cookie.getValue();
                }
            }
            if (email != null && roleStr != null) {
                try {
                    Users.Roles role = Users.Roles.valueOf(roleStr);
                    // Xác thực lại với database
                    DaoUser daoUser = new DaoUser();
                    if (daoUser.checkRole(email) == role) {
                        HttpSession session = request.getSession();
                        session.setAttribute("email", email);
                        session.setAttribute("role", role);
                        // Lấy dữ liệu user và lưu vào session
                        Vector<Users> users = daoUser.getuserData(email);
                        if (!users.isEmpty()) {
                            session.setAttribute("user", users.get(0)); // Lưu user đầu tiên
                        }
                        switch (role) {
                            case ADMIN:
                                response.sendRedirect("adminController");
                                return;
                            case STAFF:
                                response.sendRedirect("adminController");
                                return;
                            case CUSTOMER:
                                response.sendRedirect("ListMovieController");
                                return;
                        }
                    }
                } catch (IllegalArgumentException e) {
                    // Role không hợp lệ
                }
            }
        }
        
        // Check for success message from session and pass to request
        HttpSession session = request.getSession();
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage"); // Clear from session after retrieving
        }
        
        // Ensure no lingering error message from previous requests on a fresh GET
        request.removeAttribute("error");
        
        // Hiển thị trang login nếu không có cookie hợp lệ hoặc sau khi xử lý cookie
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember_me = request.getParameter("remember_me");

        DaoUser daoUser = new DaoUser();

        // Kiểm tra đăng nhập
        if (daoUser.login(email, password)) {
            // Lấy vai trò của user
            Users.Roles role = daoUser.checkRole(email);
            if (role != null && role != Users.Roles.GUEST) {
                // Lưu thông tin vào session
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("role", role);
                // Lấy dữ liệu user và lưu vào session
                Vector<Users> users = daoUser.getuserData(email);
                if (!users.isEmpty()) {
                    session.setAttribute("user", users.get(0)); 
                }
                if (remember_me != null) {
                    // Lưu email và role vào cookie
                    Cookie emailCookie = new Cookie("remember_meEmail", email);
                    emailCookie.setMaxAge((int) COOKIE_EXPIRY_SECONDS);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);

                    Cookie roleCookie = new Cookie("remember_meRole", role.name());
                    roleCookie.setMaxAge((int) COOKIE_EXPIRY_SECONDS);
                    roleCookie.setPath("/");
                    response.addCookie(roleCookie);
                }
                // Chuyển hướng dựa trên vai trò
                switch (role) {
                    case ADMIN:
                        response.sendRedirect("adminController");
                        break;
                    case STAFF:
                        response.sendRedirect("adminController");
                        break;
                    case CUSTOMER:
                        response.sendRedirect("ListMovieController");
                        break;
                    default:
                        request.setAttribute("error", "Invalid email or password!");
                        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                        break;
                }
            } else {
                // Role không hợp lệ
                request.setAttribute("error", "Invalid email or password!");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
