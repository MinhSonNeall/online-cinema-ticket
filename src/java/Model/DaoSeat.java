package Model;

import Entity.Seats;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class DaoSeat extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    public List<Seats> getSeatsByRoom(String roomId) {
        List<Seats> seats = new Vector<>();
        String sql = "SELECT * FROM Seats WHERE room_id = ?";
        try {
            ps = getConnection().prepareStatement(sql);
            ps.setString(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Seats seat = new Seats();
                seat.setSeat_id(rs.getString("seat_id"));
                seat.setRoom_id(rs.getString("room_id"));
                seat.setSeat_number(rs.getString("seat_number"));
                seat.setType(Seats.Type.valueOf(rs.getString("type").toUpperCase()));
                seat.setPrice(rs.getBigDecimal("price"));
                seats.add(seat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return seats;
    }

    public void addSeat(Seats seat) {
        // Implementation for adding a seat
    }

    public void updateSeat(Seats seat) {
        // Implementation for updating a seat
    }

    public void deleteSeat(String seatId) {
        // Implementation for deleting a seat
    }
} 