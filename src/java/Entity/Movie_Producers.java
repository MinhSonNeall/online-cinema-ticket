/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Movie_Producers { // Tên class giữ nguyên là 'Movie_Producers'

    private String movie_id;
    private String producer_id;

    // Constructor mặc định
    public Movie_Producers() {
    }

    // Constructor với tất cả các trường
    public Movie_Producers(String movie_id, String producer_id) {
        this.movie_id = movie_id;
        this.producer_id = producer_id;
    }

    // Getters và Setters

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getProducer_id() {
        return producer_id;
    }

    public void setProducer_id(String producer_id) {
        this.producer_id = producer_id;
    }

    @Override
    public String toString() {
        return "Movie_Producers{" +
               "movie_id='" + movie_id + '\'' +
               ", producer_id='" + producer_id + '\'' +
               '}';
    }
}
