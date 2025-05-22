/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.time.LocalDateTime;
import java.sql.Timestamp;

/**
 *
 * @author HP
 */
public class Reviews {
     private String review_id;
    private String user_id;
    private String movie_id;
    private int rating;
    private String comment;
    private Timestamp created_at;

    // Constructor mặc định
    public Reviews() {
    }

    // Constructor với tất cả các trường
    public Reviews(String review_id, String user_id, String movie_id, 
                  int rating, String comment, Timestamp created_at) {
        this.review_id = review_id;
        this.user_id = user_id;
        this.movie_id = movie_id;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
    }

    // Getters và Setters

    public String getReviewId() {
        return review_id;
    }

    public void setReviewId(String review_id) {
        this.review_id = review_id;
    }

    public String getUserId() {
        return user_id;
    }

    public void setUserId(String user_id) {
        this.user_id = user_id;
    }

    public String getMovieId() {
        return movie_id;
    }

    public void setMovieId(String movie_id) {
        this.movie_id = movie_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        // Có thể thêm validation ở đây nếu cần, ví dụ:
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5.");
        }
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return created_at;
    }

    public void setCreatedAt(Timestamp created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "Review{" +
               "review_id='" + review_id + '\'' +
               ", user_id='" + user_id + '\'' +
               ", movie_id='" + movie_id + '\'' +
               ", rating=" + rating +
               ", comment='" + (comment != null ? comment.substring(0, Math.min(comment.length(), 50)) + (comment.length() > 50 ? "..." : "") : "null") + '\'' + // Rút gọn comment để dễ đọc
               ", created_at=" + created_at +
               '}';
    }
}
