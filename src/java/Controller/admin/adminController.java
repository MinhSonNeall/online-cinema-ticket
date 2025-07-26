package Controller.admin;

import Entity.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.DaoTicket;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "adminController", urlPatterns = {"/adminController"})
public class adminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            Users adminUser=(Users)session.getAttribute("user");

            if (adminUser != null) {
                // Lấy dữ liệu cho dashboard
                DaoTicket daoTicket = new DaoTicket();
                BigDecimal totalRevenue = daoTicket.getTotalRevenue();
                List<Map<String, Object>> topMovies = daoTicket.getTopMoviesByTicket(5);
                List<String> movieLabels = new ArrayList<>();
                List<Integer> movieData = new ArrayList<>();
                for (Map<String, Object> m : topMovies) {
                    movieLabels.add((String)m.get("title"));
                    movieData.add((Integer)m.get("ticket_count"));
                }
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("movieLabels", movieLabels);
                request.setAttribute("movieData", movieData);

                request.setAttribute("adminUser", adminUser);
                request.setAttribute("role", session.getAttribute("role"));
                request.getRequestDispatcher("/jsp/admindashboard.jsp").forward(request, response);
            } else {
                // Redirect to login page or display an error message
                response.sendRedirect("/jsp/authenticationFailed.jsp"); // Assuming you have a login.jsp
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }
}
