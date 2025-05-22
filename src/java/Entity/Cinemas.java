/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Cinemas { // Tên class giữ nguyên là 'Cinemas'

    private String cinema_id;
    private String name;
    private String address;
    private String city;

    // Constructor mặc định
    public Cinemas() {
    }

    // Constructor với tất cả các trường
    public Cinemas(String cinema_id, String name, String address, String city) {
        this.cinema_id = cinema_id;
        this.name = name;
        this.address = address;
        this.city = city;
    }

    // Getters và Setters

    public String getCinema_id() {
        return cinema_id;
    }

    public void setCinema_id(String cinema_id) {
        this.cinema_id = cinema_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Override
    public String toString() {
        return "Cinemas{" +
               "cinema_id='" + cinema_id + '\'' +
               ", name='" + name + '\'' +
               ", address='" + address + '\'' +
               ", city='" + city + '\'' +
               '}';
    }
}