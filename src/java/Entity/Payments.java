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
import java.sql.Timestamp;

public class Payments {

    // Enum cho trường 'payment_status'
    public enum PaymentStatus {
        PENDING,
        COMPLETED,
        FAILED,
        REFUNDED,
        CANCELLED // Đã thêm giá trị 'CANCELLED'
    }

    private String payment_id;
    private String booking_id;
    private BigDecimal amount;
    private String payment_method;
    private Timestamp payment_date;
    private PaymentStatus payment_status; // Ánh xạ cột ENUM
    private String transaction_id;

    // Constructor mặc định
    public Payments() {
    }

    // Constructor với tất cả các trường
    public Payments(String payment_id, String booking_id, BigDecimal amount, 
                   String payment_method, Timestamp payment_date, 
                   PaymentStatus payment_status, String transaction_id) {
        this.payment_id = payment_id;
        this.booking_id = booking_id;
        this.amount = amount;
        this.payment_method = payment_method;
        this.payment_date = payment_date;
        this.payment_status = payment_status;
        this.transaction_id = transaction_id;
    }

    // Getters và Setters

    public String getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(String payment_id) {
        this.payment_id = payment_id;
    }

    public String getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(String booking_id) {
        this.booking_id = booking_id;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getPayment_method() {
        return payment_method;
    }

    public void setPayment_method(String payment_method) {
        this.payment_method = payment_method;
    }

    public Timestamp getPayment_date() {
        return payment_date;
    }

    public void setPayment_date(Timestamp payment_date) {
        this.payment_date = payment_date;
    }

    public PaymentStatus getPayment_status() {
        return payment_status;
    }

    public void setPayment_status(PaymentStatus payment_status) {
        this.payment_status = payment_status;
    }

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    @Override
    public String toString() {
        return "Payment{" +
               "payment_id='" + payment_id + '\'' +
               ", booking_id='" + booking_id + '\'' +
               ", amount=" + amount +
               ", payment_method='" + payment_method + '\'' +
               ", payment_date=" + payment_date +
               ", payment_status=" + payment_status +
               ", transaction_id='" + (transaction_id != null ? transaction_id : "null") + '\'' +
               '}';
    }
}