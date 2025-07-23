package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import Entity.Movie_Producers;

public class DaoMovie_Producers extends DBContext {

    PreparedStatement ps;

    public boolean insertMovieProducer(String movieId, String producerId) {
        String sql = "INSERT INTO Movie_Producers (movie_id, producer_id) VALUES (?, ?)";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            ps.setString(2, producerId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoMovie_Producers.class.getName()).log(Level.SEVERE, "Error inserting movie producer: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public Vector<Movie_Producers> getMovieProducersByMovieId(String movieId) {
        Vector<Movie_Producers> list = new Vector<>();
        String sql = "SELECT movie_id, producer_id FROM Movie_Producers WHERE movie_id = ?";
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Movie_Producers mp = new Movie_Producers();
                mp.setMovie_id(rs.getString("movie_id"));
                mp.setProducer_id(rs.getString("producer_id"));
                list.add(mp);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoMovie_Producers.class.getName()).log(Level.SEVERE, "Error getting movie producers by movie ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return list;
    }

    public boolean deleteMovieProducers(String movieId) {
        String sql = "DELETE FROM Movie_Producers WHERE movie_id = ?";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            Logger.getLogger(DaoMovie_Producers.class.getName()).log(Level.SEVERE, "Error deleting movie producers: " + e.getMessage(), e);
            return false;
        } finally {
            closeConnection(connection, ps, null);
        }
    }
}
