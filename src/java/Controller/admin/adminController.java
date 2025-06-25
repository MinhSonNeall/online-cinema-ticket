package Controller.admin;

import Entity.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
