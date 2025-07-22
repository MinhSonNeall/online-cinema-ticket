package Entity;

import java.math.BigDecimal;

public class TicketPrices {
    private String price_id;
    private String seat_type;
    private BigDecimal price;

    public TicketPrices() {
    }

    public TicketPrices(String price_id, String seat_type, BigDecimal price) {
        this.price_id = price_id;
        this.seat_type = seat_type;
        this.price = price;
    }

    public String getPrice_id() {
        return price_id;
    }

    public void setPrice_id(String price_id) {
        this.price_id = price_id;
    }

    public String getSeat_type() {
        return seat_type;
    }

    public void setSeat_type(String seat_type) {
        this.seat_type = seat_type;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
} 