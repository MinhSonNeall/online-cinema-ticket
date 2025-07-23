package Controller.admin;

import Entity.Movies;
import Model.DaoMovie;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import Model.DaoGenres;
import Model.DaoProducers;
import Entity.Genres;
import Entity.Producers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;
import java.util.Vector;
import java.util.stream.Collectors;
import Model.DaoMovie_Genres;
import Model.DaoMovie_Producers;
import Entity.Movies.Status;

@WebServlet(name = "ManageMovieServlet", urlPatterns = {"/ManageMovie"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ManageMovieServlet extends HttpServlet {

    private String getPartContent(Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return ""; // Return empty string instead of null for empty parts
        }
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
            return reader.lines().collect(Collectors.joining(System.lineSeparator()));
        }
    }

    private String saveUploadedFile(Part filePart, String uploadDir) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        System.out.println("Attempting to save uploaded file: " + fileName);
        if (fileName == null || fileName.isEmpty()) {
            System.out.println("Uploaded file name is null or empty, not saving.");
            return null;
        }
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

        // Get the path to the deployed web application root (e.g., .../build/web/ or .../webapps/your_app/)
        String deployedWebappPath = getServletContext().getRealPath("/");

        java.io.File projectRoot = null;
        java.io.File webappDir = new java.io.File(deployedWebappPath);

        // Attempt to find the project root by navigating up from the deployed webapp path
        // This assumes a NetBeans-like build structure where webapp root is in build/web
        // If deployed directly to webapps, this might need adjustment.
        if (webappDir.getName().equals("web") && webappDir.getParentFile() != null && webappDir.getParentFile().getName().equals("build")) {
            projectRoot = webappDir.getParentFile().getParentFile(); // Go up from build/web to project_root
        } else {
            // Fallback for other deployment scenarios or direct deployment to webapps
            // Try to find "online-cinema-ticket" by traversing up
            java.io.File currentDir = webappDir;
            while (currentDir != null && !currentDir.getName().equals("online-cinema-ticket")) {
                currentDir = currentDir.getParentFile();
            }
            projectRoot = currentDir;
        }

        if (projectRoot == null) {
            System.err.println("Could not determine project root dynamically. Falling back to user.dir.");
            projectRoot = new java.io.File(System.getProperty("user.dir")); // Fallback
        }

        String fullUploadPath = Paths.get(projectRoot.getAbsolutePath(), "web", uploadDir.substring(1)).toString(); // Append web/resources/images or web/resources/videos

        System.out.println("Deployed webapp path: " + deployedWebappPath);
        System.out.println("Inferred project root: " + (projectRoot != null ? projectRoot.getAbsolutePath() : "null"));
        System.out.println("Full upload directory (target source): " + fullUploadPath);
        System.out.println("Unique file name: " + uniqueFileName);

        java.io.File uploadDirFile = new java.io.File(fullUploadPath);
        if (!uploadDirFile.exists()) {
            System.out.println("Creating directories: " + fullUploadPath);
            uploadDirFile.mkdirs();
        }

        try {
            Files.copy(filePart.getInputStream(), Paths.get(fullUploadPath, uniqueFileName), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File saved successfully to: " + Paths.get(fullUploadPath, uniqueFileName).toString());
            return uploadDir + "/" + uniqueFileName; // Return relative path for database (e.g., /resources/images/uuid_file.jpg)
        } catch (IOException e) {
            System.err.println("Error saving file: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw to be caught by the outer try-catch
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            DaoMovie daoMovie = new DaoMovie();
            DaoGenres daoGenres = new DaoGenres();
            DaoProducers daoProducers = new DaoProducers();
            DaoMovie_Genres daoMovieGenres = new DaoMovie_Genres();
            DaoMovie_Producers daoMovieProducers = new DaoMovie_Producers();

            if (service == null) {
                service = "listAllMovies"; // Default action
            }

            switch (service) {
                case "listAllMovies":
                    List<Movies> movies = daoMovie.getAllMoviesForAdmin(); // Revert to original method
                    request.setAttribute("moviesList", movies);
                    request.getRequestDispatcher("/jsp/admin/manageMovie.jsp").forward(request, response);
                    break;
                case "addMovieForm":
                    // Re-initialize DAOs here to ensure they are available for this specific case
                    daoGenres = new DaoGenres();
                    Vector<Genres> genres = daoGenres.getAllGenres();
                    request.setAttribute("genresList", genres);

                    daoProducers = new DaoProducers();
                    Vector<Producers> producers = daoProducers.getAllProducers();
                    request.setAttribute("producersList", producers);

                    request.getRequestDispatcher("/jsp/admin/addMovie.jsp").forward(request, response);
                    break;
                case "movieDetail":
                    String movieId = request.getParameter("id");
                    Movies movieDetail = daoMovie.detailMovieForAdmin(movieId); // Use the new function
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    if (movieDetail != null) {
                        // Manually construct JSON for simplicity, or use a JSON library
                        out.print("{");
                        out.print("\"movie_id\": \"" + movieDetail.getMovie_id() + "\",");
                        out.print("\"title\": \"" + escapeJson(movieDetail.getTitle()) + "\",");
                        out.print("\"description\": \"" + escapeJson(movieDetail.getDescription()) + "\",");
                        out.print("\"trailer_url\": \"" + (movieDetail.getTrailer_url() != null ? escapeJson(movieDetail.getTrailer_url()) : "") + "\",");
                        out.print("\"poster_url\": \"" + (movieDetail.getPoster_url() != null ? escapeJson(movieDetail.getPoster_url()) : "") + "\",");
                        out.print("\"duration\": " + movieDetail.getDuration() + ",");
                        out.print("\"age_restriction\": " + movieDetail.getAge_restriction() + ",");
                        out.print("\"release_date\": \"" + movieDetail.getRelease_date() + "\",");
                        out.print("\"status\": \"" + movieDetail.getStatus() + "\",");
                        out.print("\"created_at\": \"" + movieDetail.getCreated_at() + "\",");
                        out.print("\"updated_at\": \"" + movieDetail.getUpdated_at() + "\",");
                        out.print("\"director\": \"" + escapeJson(movieDetail.getDirector()) + "\","); // Producers are now director in the old model
                        out.print("\"genere_name\": \"" + escapeJson(movieDetail.getGenere_name()) + "\""); // Genres are now genere_name in the old model
                        out.print("}");
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        out.print("{\"error\": \"Movie not found\"}");
                    }
                    break;
                case "editMovieForm":
                    String editMovieId = request.getParameter("id");
                    Movies movieToEdit = daoMovie.detailMovieForAdmin(editMovieId);
                    Vector<Genres> allGenres = daoGenres.getAllGenres();
                    Vector<Producers> allProducers = daoProducers.getAllProducers();
                    Vector<Entity.Movie_Genres> movieGenres = daoMovieGenres.getMovieGenresByMovieId(editMovieId);
                    Vector<Entity.Movie_Producers> movieProducers = daoMovieProducers.getMovieProducersByMovieId(editMovieId);

                    request.setAttribute("movie", movieToEdit);
                    request.setAttribute("genresList", allGenres);
                    request.setAttribute("producersList", allProducers);
                    request.setAttribute("movieGenres", movieGenres);
                    request.setAttribute("movieProducers", movieProducers);
                    request.getRequestDispatcher("/jsp/admin/editMovie.jsp").forward(request, response);
                    break;
                case "deleteMovie":
                    String deleteId = request.getParameter("id"); // Keep as String
                    boolean check = daoMovie.deleteMovie(deleteId); // Use new method (will be added to DaoMovie)
                    if (check) {
                        request.getSession().setAttribute("successMessage", "Delete movie sucesss!");
                        response.sendRedirect("ManageMovie");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Film in use!");
                        response.sendRedirect("ManageMovie");

                    }
                    break;
                case "searchMovie":
                    String searchTitle = request.getParameter("title").trim().replaceAll("\\s+", " ");
                    List<Movies> searchResults = daoMovie.searchMoviesByTitle(searchTitle); // Use new method (will be added to DaoMovie)
                    request.setAttribute("moviesList", searchResults);
                    request.setAttribute("searchTitle", searchTitle); // Keep search term in input
                    request.getRequestDispatcher("/jsp/admin/manageMovie.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("manageMovie?service=listAllMovies");
                    break;
                case "changeMovieStatus":
                    String movieIdToUpdate = request.getParameter("movieId");
                    String currentStatus = request.getParameter("currentStatus");
                    String newStatus = "";
                    if ("coming_soon".equalsIgnoreCase(currentStatus)) {
                        newStatus = "now_showing";
                    } else if ("now_showing".equalsIgnoreCase(currentStatus)) {
                        newStatus = "coming_soon";
                    }
                    boolean updated = daoMovie.updateMovieStatus(movieIdToUpdate, newStatus);
                    if (updated) {
                        response.sendRedirect("ManageMovie?service=listAllMovies");
                    } else {
                        request.setAttribute("error", "Failed to update movie status.");
                        request.getRequestDispatcher("/jsp/admin/manageMovie.jsp").forward(request, response);
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Assuming an error.jsp
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
        DaoMovie_Genres daoMovieGenres = new DaoMovie_Genres();
        DaoMovie_Producers daoMovieProducers = new DaoMovie_Producers();

        if (service == null || service.isEmpty()) {
            processRequest(request, response); // Handle default case or redirect
            return; // Exit doPost
        }

        switch (service) {
            case "add": // Changed from "addMovie" to "add" based on JSP
                try {
                // Retrieve form parameters
                String title = getPartContent(request.getPart("movieName"));
                String description = getPartContent(request.getPart("description"));
                int duration = Integer.parseInt(getPartContent(request.getPart("duration")));
                String ageRestriction = getPartContent(request.getPart("ageLimit"));

                // Handle Poster File
                String finalPosterUrl = null;
                Part posterFilePart = request.getPart("posterFile");
                System.out.println("Poster File Part: " + (posterFilePart != null ? "exists, size=" + posterFilePart.getSize() + ", filename=" + posterFilePart.getSubmittedFileName() : "null"));
                if (posterFilePart != null && posterFilePart.getSize() > 0 && posterFilePart.getSubmittedFileName() != null && !posterFilePart.getSubmittedFileName().isEmpty()) {
                    finalPosterUrl = saveUploadedFile(posterFilePart, "/resources/images");
                }

                // Handle Trailer File
                String finalTrailerUrl = null;
                Part trailerFilePart = request.getPart("trailerFile");
                System.out.println("Trailer File Part: " + (trailerFilePart != null ? "exists, size=" + trailerFilePart.getSize() + ", filename=" + trailerFilePart.getSubmittedFileName() : "null"));
                if (trailerFilePart != null && trailerFilePart.getSize() > 0 && trailerFilePart.getSubmittedFileName() != null && !trailerFilePart.getSubmittedFileName().isEmpty()) {
                    finalTrailerUrl = saveUploadedFile(trailerFilePart, "/resources/videos");
                }

                // Generate movie_id
                String lastMovieId = daoMovie.getLastMovieId();
                String newMovieId;
                if (lastMovieId != null && lastMovieId.matches("MOVIE\\d+")) {
                    int num = Integer.parseInt(lastMovieId.substring(5)) + 1;
                    newMovieId = String.format("MOVIE%03d", num);
                } else {
                    newMovieId = "MOVIE001"; // Default starting ID
                }

                // Set current date and time
                Date releaseDate = Date.valueOf(LocalDate.now());
                Timestamp now = Timestamp.valueOf(LocalDateTime.now());

                // Create new Movies object
                Movies newMovie = new Movies();
                newMovie.setMovie_id(newMovieId);
                newMovie.setTitle(title);
                newMovie.setDescription(description);
                newMovie.setTrailer_url(finalTrailerUrl); // Use the final determined URL/path
                newMovie.setPoster_url(finalPosterUrl);   // Use the final determined URL/path
                newMovie.setDuration(duration);
                newMovie.setAge_restriction(ageRestriction);
                newMovie.setRelease_date(releaseDate);
                newMovie.setStatus(Status.COMING_SOON); // Set status to COMING_SOON
                newMovie.setCreated_at(now);
                newMovie.setUpdated_at(now);

                // Add movie to database
                boolean movieAdded = daoMovie.addMovie(newMovie);

                if (movieAdded) {
                    // Insert selected genres
                    String[] genreIds = request.getParameterValues("genreIds[]");
                    if (genreIds != null) {
                        for (String genreIdStr : genreIds) {
                            if (genreIdStr != null && !genreIdStr.trim().isEmpty()) {
                                daoMovieGenres.insertMovieGenre(newMovieId, genreIdStr); // Pass String IDs
                            }
                        }
                    }

                    // Insert selected producers
                    String[] producerIds = request.getParameterValues("producerIds[]");
                    if (producerIds != null) {
                        for (String producerIdStr : producerIds) {
                            if (producerIdStr != null && !producerIdStr.trim().isEmpty()) {
                                daoMovieProducers.insertMovieProducer(newMovieId, producerIdStr); // Pass String IDs
                            }
                        }
                    }
                    request.getSession().setAttribute("successMessage", "Movie added successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to add movie to database.");
                }
                response.sendRedirect("ManageMovie?service=listAllMovies"); // Redirect to manageMovie.jsp

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid number format for duration or age restriction: " + e.getMessage());
                response.sendRedirect("ManageMovie?service=addMovieForm"); // Redirect back to addMovieForm with error
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Failed to add movie: " + e.getMessage());
                response.sendRedirect("ManageMovie"); // Redirect back to ManageMovie with error
            }
            break;
            case "updateMovie":
                try {
                String movieId = request.getParameter("movieId");
                String title = getPartContent(request.getPart("movieName"));
                String description = getPartContent(request.getPart("description"));
                int duration = Integer.parseInt(getPartContent(request.getPart("duration")));
                String ageRestriction = getPartContent(request.getPart("ageLimit"));
                Date releaseDate = Date.valueOf(getPartContent(request.getPart("releaseDate")));

                Movies existingMovie = daoMovie.getMovieById(movieId);
                String currentPosterUrl = existingMovie != null ? existingMovie.getPoster_url() : null;
                String currentTrailerUrl = existingMovie != null ? existingMovie.getTrailer_url() : null;

                // Handle Poster File
                String finalPosterUrl = currentPosterUrl;
                Part posterFilePart = request.getPart("posterFile");
                if (posterFilePart != null && posterFilePart.getSize() > 0 && posterFilePart.getSubmittedFileName() != null && !posterFilePart.getSubmittedFileName().isEmpty()) {
                    finalPosterUrl = saveUploadedFile(posterFilePart, "/resources/images");
                }

                // Handle Trailer File
                String finalTrailerUrl = currentTrailerUrl;
                Part trailerFilePart = request.getPart("trailerFile");
                if (trailerFilePart != null && trailerFilePart.getSize() > 0 && trailerFilePart.getSubmittedFileName() != null && !trailerFilePart.getSubmittedFileName().isEmpty()) {
                    finalTrailerUrl = saveUploadedFile(trailerFilePart, "/resources/videos");
                }

                Movies updatedMovie = new Movies();
                updatedMovie.setMovie_id(movieId);
                updatedMovie.setTitle(title);
                updatedMovie.setDescription(description);
                updatedMovie.setDuration(duration);
                updatedMovie.setAge_restriction(ageRestriction);
                updatedMovie.setRelease_date(releaseDate);
                updatedMovie.setPoster_url(finalPosterUrl);
                updatedMovie.setTrailer_url(finalTrailerUrl);

                boolean movieUpdated = daoMovie.updateMovie(updatedMovie);

                if (movieUpdated) {
                    // Update genres
                    daoMovieGenres.deleteMovieGenres(movieId); // Delete existing genres
                    String[] genreIds = request.getParameterValues("genreIds[]");
                    if (genreIds != null) {
                        for (String genreIdStr : genreIds) {
                            if (genreIdStr != null && !genreIdStr.trim().isEmpty()) {
                                daoMovieGenres.insertMovieGenre(movieId, genreIdStr);
                            }
                        }
                    }

                    // Update producers
                    daoMovieProducers.deleteMovieProducers(movieId); // Delete existing producers
                    String[] producerIds = request.getParameterValues("producerIds[]");
                    if (producerIds != null) {
                        for (String producerIdStr : producerIds) {
                            if (producerIdStr != null && !producerIdStr.trim().isEmpty()) {
                                daoMovieProducers.insertMovieProducer(movieId, producerIdStr);
                            }
                        }
                    }
                    request.getSession().setAttribute("successMessage", "Movie updated successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to update movie.");
                }
                response.sendRedirect("ManageMovie?service=listAllMovies");

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid number format for duration or age restriction: " + e.getMessage());
                response.sendRedirect("ManageMovie?service=editMovieForm&id=" + request.getParameter("movieId"));
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Failed to update movie: " + e.getMessage());
                response.sendRedirect("ManageMovie?service=editMovieForm&id=" + request.getParameter("movieId"));
            }
            break;
            default:
                processRequest(request, response); // Handle other services via doGet if not 'add' or 'updateMovie'
                break;
        }
    }

    private String escapeJson(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing movies (Add, Detail, Delete, Search)";
    }
}
