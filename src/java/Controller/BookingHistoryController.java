package Controller;

import Entity.Tickets;
import Model.DaoTicket;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "BookingHistoryController", urlPatterns = {"/BookingHistoryController"})
public class BookingHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Entity.Users user = (Entity.Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        DaoTicket daoTicket = new DaoTicket();
        ArrayList<Tickets> bookingHistory = daoTicket.getBookingHistory(user.getUser_id());
        request.setAttribute("bookingHistory", bookingHistory);
        request.getRequestDispatcher("/jsp/bookingHistory.jsp").forward(request, response);
    }
}
