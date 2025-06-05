package Controller;

import Entity.Movies;
import Model.DaoWatchlist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "WatchlistController", urlPatterns = {"/WatchlistController"})
public class WatchlistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Entity.Users user = (Entity.Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String movieId = request.getParameter("movieId");
        DaoWatchlist daoWatchlist = new DaoWatchlist();

        if ("add".equals(action)) {
            daoWatchlist.addToWatchlist(user.getUser_id(), movieId);
            response.sendRedirect("ListMovieDetailController?movieId=" + movieId);
            return;
        } else if ("remove".equals(action)) {
            daoWatchlist.removeFromWatchlist(user.getUser_id(), movieId);
        }

        ArrayList<Movies> watchlist = daoWatchlist.getWatchlist(user.getUser_id());
        request.setAttribute("watchlist", watchlist);
        request.getRequestDispatcher("/jsp/watchlist.jsp").forward(request, response);
    }
}
