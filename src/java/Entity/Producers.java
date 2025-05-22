/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
public class Producers { // Tên class giữ nguyên là 'Producers' để khớp với tên bảng

    private String producer_id;
    private String name;

    // Constructor mặc định
    public Producers() {
    }

    // Constructor với tất cả các trường
    public Producers(String producer_id, String name) {
        this.producer_id = producer_id;
        this.name = name;
    }

    // Getters và Setters

    public String getProducer_id() {
        return producer_id;
    }

    public void setProducer_id(String producer_id) {
        this.producer_id = producer_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Producers{" +
               "producer_id='" + producer_id + '\'' +
               ", name='" + name + '\'' +
               '}';
    }
}
