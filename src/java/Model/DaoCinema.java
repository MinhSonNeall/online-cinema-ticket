package Model;

import Entity.Cinemas;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoCinema extends DBContext {

    PreparedStatement ps;
    ResultSet rs;
    Connection connection;
    
    public List<Cinemas> getAllCinemas() {
        List<Cinemas> cinemas = new Vector<>();
        String sql = "SELECT * FROM Cinemas";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Cinemas cinema = new Cinemas();
                cinema.setCinema_id(rs.getString("cinema_id"));
                cinema.setName(rs.getString("name"));
                cinema.setAddress(rs.getString("address"));
                cinema.setCity(rs.getString("city"));
                cinemas.add(cinema);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error getting all cinemas: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return cinemas;
    }
    
    public Cinemas getCinemaById(String cinemaId) {
        String sql = "SELECT * FROM Cinemas WHERE cinema_id = ?";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, cinemaId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Cinemas cinema = new Cinemas();
                cinema.setCinema_id(rs.getString("cinema_id"));
                cinema.setName(rs.getString("name"));
                cinema.setAddress(rs.getString("address"));
                cinema.setCity(rs.getString("city"));
                return cinema;
            }
        } catch (Exception e) {
            Logger.getLogger(DaoCinema.class.getName()).log(Level.SEVERE, "Error getting cinema by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }
} 