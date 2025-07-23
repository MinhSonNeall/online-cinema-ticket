package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import Entity.Movie_Genres;

public class DaoMovie_Genres extends DBContext {

    PreparedStatement ps;

    public boolean insertMovieGenre(String movieId, String genreId) {
        String sql = "INSERT INTO Movie_Genres (movie_id, genre_id) VALUES (?, ?)";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            ps.setString(2, genreId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoMovie_Genres.class.getName()).log(Level.SEVERE, "Error inserting movie genre: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
    }
    }

    public Vector<Movie_Genres> getMovieGenresByMovieId(String movieId) {
        Vector<Movie_Genres> list = new Vector<>();
        String sql = "SELECT movie_id, genre_id FROM Movie_Genres WHERE movie_id = ?";
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Movie_Genres mg = new Movie_Genres();
                mg.setMovie_id(rs.getString("movie_id"));
                mg.setGenre_id(rs.getString("genre_id"));
                list.add(mg);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoMovie_Genres.class.getName()).log(Level.SEVERE, "Error getting movie genres by movie ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return list;
    }

    public boolean deleteMovieGenres(String movieId) {
        String sql = "DELETE FROM Movie_Genres WHERE movie_id = ?";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoMovie_Genres.class.getName()).log(Level.SEVERE, "Error deleting movie genres: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
}
