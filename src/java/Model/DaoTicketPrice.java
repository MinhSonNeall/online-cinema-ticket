package Model;

import Entity.TicketPrices;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class DaoTicketPrice extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    public List<TicketPrices> getAllTicketPrices() {
        List<TicketPrices> prices = new Vector<>();
        String sql = "SELECT * FROM TicketPrices";
        try {
            ps = getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TicketPrices price = new TicketPrices();
                price.setPrice_id(rs.getString("price_id"));
                price.setSeat_type(rs.getString("seat_type"));
                price.setPrice(rs.getBigDecimal("price"));
                prices.add(price);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prices;
    }

    public void updateTicketPrice(TicketPrices price) {
        // Implementation for updating a ticket price
    }
} 