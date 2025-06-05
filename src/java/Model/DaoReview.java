package Model;

import Entity.Reviews;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.UUID;

public class DaoReview extends DBContext {

    public void addReview(String userId, String movieId, int rating, String comment) {
        String sql = "INSERT INTO movie_ticketing.reviews (review_id, user_id, movie_id, rating, comment) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, UUID.randomUUID().toString());
            ps.setString(2, userId);
            ps.setString(3, movieId);
            ps.setInt(4, rating);
            ps.setString(5, comment);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, null);
        }
    }

    public ArrayList<Reviews> getReviewsByMovie(String movieId) {
        ArrayList<Reviews> reviews = new ArrayList<>();
        String sql = "SELECT r.review_id, r.rating, r.comment, r.created_at, u.full_name " +
                     "FROM movie_ticketing.reviews r " +
                     "JOIN movie_ticketing.users u ON r.user_id = u.user_id " +
                     "WHERE r.movie_id = ?";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, movieId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reviews review = new Reviews();
                review.setReview_id(rs.getString("review_id"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setCreated_at(rs.getTimestamp("created_at"));
                review.setUserName(rs.getString("full_name"));
                reviews.add(review);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return reviews;
    }
}