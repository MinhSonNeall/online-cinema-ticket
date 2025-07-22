package Model;

import Entity.Rooms;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoRoom extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection;
    
    public List<Rooms> getAllRooms() {
        List<Rooms> rooms = new Vector<>();
        String sql = "SELECT * FROM Rooms";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                rooms.add(room);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting all rooms: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return rooms;
    }

    public Rooms getRoomById(String roomId) {
        String sql = "SELECT * FROM Rooms WHERE room_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                return room;
            }
        } catch (Exception e) {
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting room by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }

    public List<Rooms> getRoomsByCinemaId(String cinemaId) {
        List<Rooms> rooms = new Vector<>();
        String sql = "SELECT * FROM Rooms WHERE cinema_id = ?";
        System.out.println("Debug - Executing SQL: " + sql + " with cinemaId = " + cinemaId);
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinemaId);
            rs = ps.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
                Rooms room = new Rooms();
                room.setRoom_id(rs.getString("room_id"));
                room.setCinema_id(rs.getString("cinema_id"));
                room.setName(rs.getString("name"));
                room.setTotal_seats(rs.getInt("total_seats"));
                rooms.add(room);
                System.out.println("Debug - Found room: ID=" + room.getRoom_id() + ", Name=" + room.getName() + 
                                  ", CinemaID=" + room.getCinema_id() + ", TotalSeats=" + room.getTotal_seats());
            }
            System.out.println("Debug - Found " + count + " rooms for cinema ID " + cinemaId);
        } catch (Exception e) {
            System.out.println("Error getting rooms by cinema ID: " + e.getMessage());
            Logger.getLogger(DaoRoom.class.getName()).log(Level.SEVERE, "Error getting rooms by cinema ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return rooms;
    }
}