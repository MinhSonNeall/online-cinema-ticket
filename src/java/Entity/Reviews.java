package Entity;

import java.sql.Timestamp;

public class Reviews {
    private String review_id;
    private String user_id;
    private String movie_id;
    private int rating;
    private String comment;
    private Timestamp created_at;
    private String userName;

    // Getters and Setters
    public String getReview_id() { return review_id; }
    public void setReview_id(String review_id) { this.review_id = review_id; }
    public String getUser_id() { return user_id; }
    public void setUser_id(String user_id) { this.user_id = user_id; }
    public String getMovie_id() { return movie_id; }
    public void setMovie_id(String movie_id) { this.movie_id = movie_id; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Timestamp getCreated_at() { return created_at; }
    public void setCreated_at(Timestamp created_at) { this.created_at = created_at; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}