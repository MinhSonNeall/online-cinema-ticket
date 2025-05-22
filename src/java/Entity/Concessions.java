/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author HP
 */
import java.math.BigDecimal;

public class Concessions { // Tên class giữ nguyên là 'Concessions'

    private String concession_id;
    private String name;
    private BigDecimal price;

    // Constructor mặc định
    public Concessions() {
    }

    // Constructor với tất cả các trường
    public Concessions(String concession_id, String name, BigDecimal price) {
        this.concession_id = concession_id;
        this.name = name;
        this.price = price;
    }

    // Getters và Setters

    public String getConcession_id() {
        return concession_id;
    }

    public void setConcession_id(String concession_id) {
        this.concession_id = concession_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Concessions{" +
               "concession_id='" + concession_id + '\'' +
               ", name='" + name + '\'' +
               ", price=" + price +
               '}';
    }
}