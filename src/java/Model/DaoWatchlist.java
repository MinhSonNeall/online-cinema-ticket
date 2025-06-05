package Model;

import Entity.Movies;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.UUID;

public class DaoWatchlist extends DBContext {

    public void addToWatchlist(String userId, String movieId) {
        String sql = "INSERT INTO movie_ticketing.wishlists (wishlist_id, user_id, movie_id) " +
                     "VALUES (?, ?, ?)";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, UUID.randomUUID().toString());
            ps.setString(2, userId);
            ps.setString(3, movieId);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public void removeFromWatchlist(String userId, String movieId) {
        String sql = "DELETE FROM movie_ticketing.wishlists WHERE user_id = ? AND movie_id = ?";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setString(2, movieId);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public ArrayList<Movies> getWatchlist(String userId) {
        ArrayList<Movies> watchlist = new ArrayList<>();
        String sql = "SELECT m.* FROM movie_ticketing.wishlists w " +
                     "JOIN movie_ticketing.movies m ON w.movie_id = m.movie_id " +
                     "WHERE w.user_id = ?";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Movies movie = new Movies(
                    rs.getString("movie_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("duration"),
                    rs.getInt("age_restriction"),
                    rs.getString("poster_url"),
                    rs.getString("trailer_url")
                );
                watchlist.add(movie);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return watchlist;
    }
}
