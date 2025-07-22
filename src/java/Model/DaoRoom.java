package Model;

import Entity.Rooms;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Vector;
import java.sql.ResultSet;

public class DaoRoom extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    public List<Rooms> getAllRooms() {
        List<Rooms> rooms = new Vector<>();
        String sql = "SELECT * FROM Rooms";
        try {
            ps = getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                rooms.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public void addRoom(Rooms room) {
        // Implementation for adding a room
    }

    public void updateRoom(Rooms room) {
        // Implementation for updating a room
    }

    public void deleteRoom(String roomId) {
        // Implementation for deleting a room
    }
} 