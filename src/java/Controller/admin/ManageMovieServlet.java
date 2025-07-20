package Controller.admin;

import Entity.Movies;
import Model.DaoMovie;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageMovieServlet", urlPatterns = {"/ManageMovie"})
public class ManageMovieServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            DaoMovie daoMovie = new DaoMovie();

            if (service == null) {
                service = "listAllMovies"; // Default action
            }

            switch (service) {
                case "listAllMovies":
                    List<Movies> movies = daoMovie.getAllMovies(); // Revert to original method
                    request.setAttribute("moviesList", movies);
                    request.getRequestDispatcher("/jsp/admin/manageMovie.jsp").forward(request, response);
                    break;
                case "addMovieForm":
                    request.getRequestDispatcher("/jsp/admin/addMovie.jsp").forward(request, response);
                    break;
                case "movieDetail":
                    String movieId = request.getParameter("id"); // Keep as String
                    Movies movieDetail = daoMovie.getMovieById(movieId); // Use existing method
                    request.setAttribute("movieDetail", movieDetail);
                    request.getRequestDispatcher("/jsp/Movie/moviedetail.jsp").forward(request, response);
                    break;
                case "deleteMovie":
                    String deleteId = request.getParameter("id"); // Keep as String
                    daoMovie.deleteMovie(deleteId); // Use new method (will be added to DaoMovie)
                    response.sendRedirect("manageMovie?service=listAllMovies");
                    break;
                case "searchMovie":
                    String searchTitle = request.getParameter("title");
                    List<Movies> searchResults = daoMovie.searchMoviesByTitle(searchTitle); // Use new method (will be added to DaoMovie)
                    request.setAttribute("moviesList", searchResults);
                    request.setAttribute("searchTitle", searchTitle); // Keep search term in input
                    request.getRequestDispatcher("/jsp/admin/manageMovie.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("manageMovie?service=listAllMovies");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response); // Assuming an error.jsp
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        DaoMovie daoMovie = new DaoMovie();

        if ("addMovie".equals(service)) {
            try {
                // Retrieve form parameters for adding a movie based on the provided schema
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String trailerUrl = request.getParameter("trailerUrl");
                String posterUrl = request.getParameter("posterUrl");
                int duration = Integer.parseInt(request.getParameter("duration"));
                int ageRestriction = Integer.parseInt(request.getParameter("ageRestriction"));
                String releaseDate = request.getParameter("releaseDate"); // YYYY-MM-DD format
                String statusParam = request.getParameter("status"); // Assuming status is passed as a string

                // Create a new Movies object with fields from the provided schema
                Movies newMovie = new Movies();
                newMovie.setTitle(title);
                newMovie.setDescription(description);
                newMovie.setTrailer_url(trailerUrl);
                newMovie.setPoster_url(posterUrl);
                newMovie.setDuration(duration);
                newMovie.setAge_restriction(ageRestriction);
                newMovie.setRelease_date(java.sql.Date.valueOf(releaseDate));
                
                // Set status from parameter, default to NOW_SHOWING if not provided or invalid
                try {
                    newMovie.setStatus(Movies.Status.valueOf(statusParam.toUpperCase()));
                } catch (IllegalArgumentException | NullPointerException e) {
                    newMovie.setStatus(Movies.Status.NOW_SHOWING); // Default status
                }

                // Add movie to database using the new method
                daoMovie.addMovie(newMovie); // Use new method

                response.sendRedirect("manageMovie?service=listAllMovies");
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid number format for duration or age restriction.");
                request.getRequestDispatcher("/jsp/admin/addMovie.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to add movie: " + e.getMessage());
                request.getRequestDispatcher("/jsp/admin/addMovie.jsp").forward(request, response);
            }
        } else {
            processRequest(request, response); // Handle other services via doGet if not 'addMovie'
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing movies (Add, Detail, Delete, Search)";
    }
}
