/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Movie_Genres { // Giữ nguyên tên class là Movie_Genres để phản ánh tên bảng

    private String movie_id;
    private String genre_id;

    // Constructor mặc định
    public Movie_Genres() {
    }

    // Constructor với tất cả các trường
    public Movie_Genres(String movie_id, String genre_id) {
        this.movie_id = movie_id;
        this.genre_id = genre_id;
    }

    // Getters và Setters

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getGenre_id() {
        return genre_id;
    }

    public void setGenre_id(String genre_id) {
        this.genre_id = genre_id;
    }

    @Override
    public String toString() {
        return "Movie_Genres{" +
               "movie_id='" + movie_id + '\'' +
               ", genre_id='" + genre_id + '\'' +
               '}';
    }
}
