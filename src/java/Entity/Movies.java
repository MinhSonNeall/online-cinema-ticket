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

    public enum Status { // Enum for 'status' field
        NOW_SHOWING,   // Maps to 'now_showing'
        COMING_SOON,   // Maps to 'coming_soon'
        STOP_SHOWING   // Maps to 'stop_showing'
    }

    private String movie_id;
    private String title;
    private String description;
    private String trailer_url;
      private String poster_url;
    private int duration;
    private String age_restriction; // Changed to String to match database schema
    private Date release_date;
    private Status status;
    private Timestamp created_at;
    private Timestamp updated_at;
    private String director;
    private String genere_name; // This seems to be for display purposes
    private String start_time_movie; // This also seems to be for display

    // Constructor mặc định
    public Movies() {
    }

    public Movies(String movie_id, String title, String description, int duration, String age_restriction, Date release_date, Status status, String genere_name, String director) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.release_date = release_date;
        this.status = status;
        this.genere_name = genere_name;
        this.director = director;
    }



    public Movies(String movie_id, String title, String description, String trailer_url, String poster_url, int duration, String age_restriction, Date release_date, Status status, Timestamp created_at, Timestamp updated_at) {
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
    
    

    // Constructor with all fields
    public Movies(String movie_id, String title, String description,
            String trailer_url, String poster_url, int duration,
            String age_restriction, Date release_date, Status status,
            Timestamp created_at, Timestamp updated_at, String director) { // Added director
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
        this.director = director; // Initialize director
    }

    public Movies(String movie_id, String title, String description, int duration, String age_restriction, String poster_url, String trailer_url, String genere_name) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.genere_name = genere_name;
    }
        public Movies(String movie_id, String title, String description, int duration, String age_restriction, String poster_url, String trailer_url, String genere_name,String director,Date release_date) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.genere_name = genere_name;
        this.director=director;
        this.release_date=release_date;
    }
            public Movies(String movie_id, String title, String description, int duration, String age_restriction, String poster_url, String trailer_url, String genere_name,String director) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.genere_name = genere_name;
        this.director=director;
        
    }

    public Movies(String movie_id, String title, String description, int duration, String age_restriction, String poster_url, String trailer_url) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
    }

    public Movies(String movie_id, String title, String description, String trailer_url, String poster_url, int duration, String age_restriction, String start_time_movie, String genere_name, String director) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.trailer_url = trailer_url;
        this.poster_url = poster_url;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.start_time_movie = start_time_movie;
        this.genere_name = genere_name;
        this.director=director;
    }

    public Movies(String movie_id, String title, String description, String trailer_url, String poster_url, int duration, String age_restriction, Date release_date) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.trailer_url = trailer_url;
        this.poster_url = poster_url;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.release_date = release_date;
    }
    
    // New constructor for adding movie with director, language, country, rating, is_active
    public Movies(String title, String description, int duration, String poster_url, String trailer_url,
            String director, String language, String country, String rating, boolean is_active, String release_date, String age_restriction) {
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.director = director;
        // Assuming language, country, rating, is_active are not directly mapped to existing fields
        // You might need to add these as new fields in the Movies class if they are part of your DB schema
        // For now, I'll just add them as parameters to this constructor.
        // If they are meant to be stored, you'll need to add private fields and getters/setters for them.
        this.release_date = Date.valueOf(release_date);
        this.age_restriction = age_restriction;
    }
    
    // New constructor for getMovieById in DaoMovie
    public Movies(int movie_id, String title, String description, int duration, String age_restriction,
            String poster_url, String trailer_url, String director, String language, String country,
            String rating, boolean is_active, Date release_date, String genre_name) {
        this.movie_id = String.valueOf(movie_id); // Convert int to String for existing movie_id field
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.age_restriction = age_restriction;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.director = director;
        // Assuming language, country, rating, is_active are not directly mapped to existing fields
        // You might need to add these as new fields in the Movies class if they are part of your DB schema
        this.release_date = release_date;
        this.genere_name = genre_name;
    }


    public String getStart_time_movie() {
        return start_time_movie;
    }

    public void setStart_time_movie(String start_time_movie) {
        this.start_time_movie = start_time_movie;
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

    public String getAge_restriction() {
        return age_restriction;
    }

    public void setAge_restriction(String age_restriction) {
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
    
    public String getDirector() { // Getter for director
        return director;
    }

    public void setDirector(String director) { // Setter for director
        this.director = director;
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
               ", age_restriction='" + age_restriction + '\'' +
               ", release_date=" + release_date +
               ", status=" + status +
               ", created_at=" + created_at +
               ", updated_at=" + updated_at +
               '}';
    }
}
