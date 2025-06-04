/*
 * DaoMovie.java
 * Class to handle database operations for movies
 */
package Model;

import Entity.Movies;
import Entity.Movies.Status;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Movies
 */
public class DaoMovie extends DBContext {

    /**
     * Get all movies from the database
     * @return Vector of Movies
     */
    public Vector<Movies> getAllMovies() {
        return getMoviesByStatus(null);
    }

    /**
     * Get movies by status
     * @param status The status to filter ("now_showing" or "coming_soon" or null for all)
     * @return Vector of Movies
     */
    public Vector<Movies> getMoviesByStatus(String status) {
        Vector<Movies> movies = new Vector<>();
        String sql = "SELECT * FROM movie_ticketing.movies";
        if (status != null) {
            sql += " WHERE status = ?";
        }
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            if (status != null) {
                pre.setString(1, status);
            }
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Movies movie = new Movies();
                    movie.setMovie_id(rs.getString("movie_id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDescription(rs.getString("description"));
                    movie.setTrailer_url(rs.getString("trailer_url"));
                    movie.setPoster_url(rs.getString("poster_url"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setAge_restriction(rs.getInt("age_restriction"));
                    movie.setRelease_date(rs.getDate("release_date"));
                    movie.setStatus(Status.valueOf(rs.getString("status").toUpperCase()));
                    movie.setCreated_at(rs.getTimestamp("created_at"));
                    movie.setUpdated_at(rs.getTimestamp("updated_at"));
                    movies.add(movie);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error fetching movies with status: " + status, ex);
        }
        return movies;
    }

    /**
     * Get movie details by movie_id
     * @param movieId The ID of the movie
     * @return Movies object or null if not found
     */
    public Movies getMovieById(String movieId) {
        String sql = "SELECT * FROM movie_ticketing.movies WHERE movie_id = ?";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, movieId);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    Movies movie = new Movies();
                    movie.setMovie_id(rs.getString("movie_id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDescription(rs.getString("description"));
                    movie.setTrailer_url(rs.getString("trailer_url"));
                    movie.setPoster_url(rs.getString("poster_url"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setAge_restriction(rs.getInt("age_restriction"));
                    movie.setRelease_date(rs.getDate("release_date"));
                    movie.setStatus(Status.valueOf(rs.getString("status").toUpperCase()));
                    movie.setCreated_at(rs.getTimestamp("created_at"));
                    movie.setUpdated_at(rs.getTimestamp("updated_at"));
                    return movie;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DaoMovie.class.getName()).log(Level.SEVERE, "Error fetching movie by ID: " + movieId, ex);
        }
        return null;
    }
}
