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

@WebServlet(name = "loginController", urlPatterns = {"/loginController"})
public class loginController extends HttpServlet {

    private static final long COOKIE_EXPIRY_SECONDS = 7 * 24 * 60 * 60;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                    DaoUser daoUser = new DaoUser();
                    if (daoUser.checkRole(email) == role) {
                        HttpSession session = request.getSession();
                        session.setAttribute("email", email);
                        session.setAttribute("role", role);
                        Vector<Users> users = daoUser.getuserData(email);
                        if (!users.isEmpty()) {
                            session.setAttribute("user", users.get(0));
                        }
                        switch (role) {
                            case ADMIN:
                                response.sendRedirect("adminDashboard.jsp");
                                return;
                            case STAFF:
                                response.sendRedirect("staffDashboard.jsp");
                                return;
                            case CUSTOMER:
                                response.sendRedirect("customerHome.jsp");
                                return;
                        }
                    }
                } catch (IllegalArgumentException e) {
                }
            }
        }
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember_me = request.getParameter("remember_me");

        DaoUser daoUser = new DaoUser();

        if (daoUser.login(email, password)) {
            Users.Roles role = daoUser.checkRole(email);
            if (role != null && role != Users.Roles.GUEST) {
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("role", role);
                Vector<Users> users = daoUser.getuserData(email);
                if (!users.isEmpty()) {
                    session.setAttribute("user", users.get(0)); 
                }
                if (remember_me != null) {
                    Cookie emailCookie = new Cookie("remember_meEmail", email);
                    emailCookie.setMaxAge((int) COOKIE_EXPIRY_SECONDS);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);

                    Cookie roleCookie = new Cookie("remember_meRole", role.name());
                    roleCookie.setMaxAge((int) COOKIE_EXPIRY_SECONDS);
                    roleCookie.setPath("/");
                    response.addCookie(roleCookie);
                }
                switch (role) {
                    case ADMIN:
                        response.sendRedirect("adminDashboard.jsp");
                        break;
                    case STAFF:
                        response.sendRedirect("staffDashboard.jsp");
                        break;
                    case CUSTOMER:
                        response.sendRedirect("customerHome.jsp");
                        break;
                    default:
                        request.setAttribute("error", "Invalid email or password!");
                        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                        break;
                }
            } else {
                request.setAttribute("error", "Invalid email or password!");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}