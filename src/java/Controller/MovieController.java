/*
 * MovieController.java
 * Servlet to handle movie-related requests
 */
package Controller;

import Entity.Movies;
import Entity.Users;
import Model.DaoMovie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Vector;

/**
 * Servlet to handle movie listing and details
 */
@WebServlet(name = "MovieController", urlPatterns = {"/MovieController"})
public class MovieController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("loginController");
            return;
        }

        Users user = (Users) session.getAttribute("user");
        Users.Roles role = user.getRole();
        DaoMovie daoMovie = new DaoMovie();

        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            // View Movie List
            String status = request.getParameter("status");
            Vector<Movies> nowShowingMovies = daoMovie.getMoviesByStatus("now_showing");
            Vector<Movies> comingSoonMovies = daoMovie.getMoviesByStatus("coming_soon");
            request.setAttribute("nowShowingMovies", nowShowingMovies);
            request.setAttribute("comingSoonMovies", comingSoonMovies);
            request.setAttribute("selectedStatus", status != null ? status : "now_showing");
            if (role == Users.Roles.CUSTOMER) {
                request.getRequestDispatcher("/jsp/movieList.jsp").forward(request, response);
            } else if (role == Users.Roles.STAFF || role == Users.Roles.ADMIN) {
                request.getRequestDispatcher("/jsp/adminMovieList.jsp").forward(request, response);
            } else {
                response.sendRedirect("Landingpage.jsp");
            }
        } else if (action.equals("detail")) {
            // View Movie Details
            String movieId = request.getParameter("movieId");
            if (movieId != null && !movieId.isEmpty()) {
                Movies movie = daoMovie.getMovieById(movieId);
                if (movie != null) {
                    request.setAttribute("movie", movie);
                    request.getRequestDispatcher("/jsp/movieDetail.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Movie not found!");
                    request.getRequestDispatcher("/jsp/movieList.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("MovieController?action=list");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle movie listing and details";
    }
}
