/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
import java.sql.Date; // Sử dụng java.sql.Date cho cột DATE
import java.sql.Timestamp;

public class Movies {

  

    public enum Status { // Enum cho trường 'status'
        NOW_SHOWING, // Ánh xạ 'now_showing'
        COMING_SOON   // Ánh xạ 'coming_soon'
    }

    private String movie_id;
    private String title;
    private String description;
    private String trailer_url;
    private String poster_url;
    private int duration;
    private int age_restriction;
    private Date release_date; // Sử dụng java.sql.Date
    private Status status;     // Sử dụng Enum Status
    private Timestamp created_at;
    private Timestamp updated_at;
    private String genere_name;

    // Constructor mặc định
    public Movies() {
    }

    // Constructor với tất cả các trường
    public Movies(String movie_id, String title, String description, 
                 String trailer_url, String poster_url,int duration, 
                 int age_restriction, Date release_date, Status status, 
                 Timestamp created_at, Timestamp updated_at) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.trailer_url = trailer_url;
        this.poster_url = poster_url;
        this.duration = duration;
       
        this.age_restriction = age_restriction;
        this.release_date = release_date;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Movies(String movie_id, String title, String description, int duration,int age_restriction, String poster_url,String trailer_url, String genere_name) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
       
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.genere_name = genere_name;
    }
    
    public Movies(String movie_id, String title, String description, int duration,int age_restriction, String poster_url,String trailer_url) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
       
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
    }
    
    

    public Movies(String movie_id, String title, String description, String trailer_url, String poster_url, int duration,int age_restriction, Date release_date) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.trailer_url = trailer_url;
        this.poster_url = poster_url;
        this.duration = duration;
       
        this.age_restriction = age_restriction;
        this.release_date = release_date;
    }
 
    
    public String getGenere_name() {
        return genere_name;
    }

    // Getters và Setters
    public void setGenere_name(String genere_name) {
        this.genere_name = genere_name;
    }

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTrailer_url() {
        return trailer_url;
    }

    public void setTrailer_url(String trailer_url) {
        this.trailer_url = trailer_url;
    }

    public String getPoster_url() {
        return poster_url;
    }

    public void setPoster_url(String poster_url) {
        this.poster_url = poster_url;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }


    public int getAge_restriction() {
        return age_restriction;
    }

    public void setAge_restriction(int age_restriction) {
        this.age_restriction = age_restriction;
    }

    public Date getRelease_date() {
        return release_date;
    }

    public void setRelease_date(Date release_date) {
        this.release_date = release_date;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    @Override
    public String toString() {
        return "Movie{" +
               "movie_id='" + movie_id + '\'' +
               ", title='" + title + '\'' +
               ", description='" + (description != null ? description.substring(0, Math.min(description.length(), 50)) + (description.length() > 50 ? "..." : "") : "null") + '\'' +
               ", trailer_url='" + trailer_url + '\'' +
               ", poster_url='" + poster_url + '\'' +
               ", duration=" + duration +
               ", age_restriction=" + age_restriction +
               ", release_date=" + release_date +
               ", status=" + status +
               ", created_at=" + created_at +
               ", updated_at=" + updated_at +
               '}';
    }
}
