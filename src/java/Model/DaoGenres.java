package Model;

import Entity.Genres;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoGenres extends DBContext {

    PreparedStatement ps;
    ResultSet rs;

    public Genres getGenreById(String genreId) {
        String sql = "SELECT genre_id, name FROM Genres WHERE genre_id = ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, genreId);
            rs = ps.executeQuery();
            if (rs.next()) {
                String genreName = rs.getString("name");
                return new Genres(genreId, genreName);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoGenres.class.getName()).log(Level.SEVERE, "Error getting genre by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }

    public Vector<Genres> getAllGenres() {
        Vector<Genres> list = new Vector<>();
        String sql = "SELECT genre_id, name FROM Genres";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                String genreId = rs.getString("genre_id");
                String genreName = rs.getString("name");
                list.add(new Genres(genreId, genreName));
            }
        } catch (Exception e) {
            Logger.getLogger(DaoGenres.class.getName()).log(Level.SEVERE, "Error getting all genres: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return list;
    }
}
