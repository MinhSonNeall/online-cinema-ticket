/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Genres {

    private String genre_id;
    private String name;

    // Constructor mặc định
    public Genres() {
    }

    // Constructor với tất cả các trường
    public Genres(String genre_id, String name) {
        this.genre_id = genre_id;
        this.name = name;
    }

    // Getters và Setters

    public String getGenre_id() {
        return genre_id;
    }

    public void setGenre_id(String genre_id) {
        this.genre_id = genre_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Genre{" +
               "genre_id='" + genre_id + '\'' +
               ", name='" + name + '\'' +
               '}';
    }
}
