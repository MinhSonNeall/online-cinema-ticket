package Model;

import Entity.Producers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProducers extends DBContext {

    PreparedStatement ps;
    ResultSet rs;

    public Producers getProducerById(String producerId) {
        String sql = "SELECT producer_id, name FROM Producers WHERE producer_id = ?";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, producerId);
            rs = ps.executeQuery();
            if (rs.next()) {
                String producerName = rs.getString("name");
                return new Producers(producerId, producerName);
            }
        } catch (Exception e) {
            Logger.getLogger(DaoProducers.class.getName()).log(Level.SEVERE, "Error getting producer by ID: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return null;
    }

    public Vector<Producers> getAllProducers() {
        Vector<Producers> list = new Vector<>();
        String sql = "SELECT producer_id, name FROM Producers";
        
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                String producerId = rs.getString("producer_id");
                String producerName = rs.getString("name");
                list.add(new Producers(producerId, producerName));
            }
        } catch (Exception e) {
            Logger.getLogger(DaoProducers.class.getName()).log(Level.SEVERE, "Error getting all producers: " + e.getMessage(), e);
        } finally {
            closeConnection(connection, ps, rs);
        }
        return list;
    }
}
