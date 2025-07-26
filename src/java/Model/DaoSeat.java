package Model;

import Entity.Seats;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class DaoSeat extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection;
    
    public List<Seats> getSeatsByRoom(String roomId) {
        List<Seats> seats = new Vector<>();
        String sql = "SELECT * FROM Seats WHERE room_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            rs = ps.executeQuery();
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
            Logger.getLogger(DaoSeat.class.getName()).log(Level.SEVERE, "Error getting seats by room: " + e.getMessage(), e);

        } finally {
            closeConnection(connection, ps, rs);
        }
        return seats;
    }
  public String getSeatNumberbySeatId(String seatIdsStr)  {
        if (seatIdsStr == null || seatIdsStr.isEmpty()) {
            return "";
        }

        // Tách chuỗi seat_id thành mảng
        String[] idArray = seatIdsStr.split(",");
        // Tạo danh sách placeholder (?) tương ứng
        String placeholders = Arrays.stream(idArray)
                .map(id -> "?")
                .collect(Collectors.joining(","));
        String sql = "SELECT GROUP_CONCAT(seat_number) AS seat_numbers FROM seats WHERE seat_id IN (" + placeholders + ")";

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);

            // Gán giá trị cho các placeholder
            for (int i = 0; i < idArray.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(idArray[i]));
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                String result = rs.getString("seat_numbers");
                return result != null ? result : "";
            }
        } catch (Exception e) {
            Logger.getLogger(DaoSeat.class.getName()).log(Level.SEVERE, "Error getting seats by ID: " + e.getMessage(), e);
            // Ném lại ngoại lệ để lớp gọi xử lý
        
        } finally {
            closeConnection(connection, ps, rs);
        }

        return "";
    }

    public String generateNextSeatId() {
        int maxId = 0;
        String sql = "SELECT MAX(CAST(seat_id AS UNSIGNED)) as max_id FROM Seats";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next() && rs.getString("max_id") != null) {
                maxId = rs.getInt("max_id");
                System.out.println("Debug - Current max seat ID: " + maxId);
            } else {
                System.out.println("Debug - No seats found in database, starting from ID: 1");
            }
        } catch (Exception e) {
            System.out.println("Error generating next seat ID: " + e.getMessage());
            Logger.getLogger(DaoSeat.class.getName()).log(Level.SEVERE, "Error generating next seat ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        int nextId = maxId + 1;
        System.out.println("Debug - Generated next seat ID: " + nextId);
        return String.valueOf(nextId);
    }

    public void insertSeatForSlot(Seats seat, String slotId) {
        String sql = "INSERT INTO Seats (seat_id, room_id, seat_number, type, slot_id, price, check_seat) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, seat.getSeat_id());
            ps.setString(2, seat.getRoom_id());
            ps.setString(3, seat.getSeat_number());
            ps.setString(4, seat.getType().name().toLowerCase());
            ps.setString(5, slotId);
            ps.setBigDecimal(6, new BigDecimal(5000));
            ps.setInt(7, 0);
            ps.executeUpdate();
        } catch (Exception e) {
            Logger.getLogger(DaoSeat.class.getName()).log(Level.SEVERE, "Error inserting seat for slot: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, null);
        }
    }
} 