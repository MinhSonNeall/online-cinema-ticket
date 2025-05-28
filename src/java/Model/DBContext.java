package Model;

import Constant.IConstant;
import com.mysql.cj.jdbc.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

/**
 *
 * @author Admin
 */
public class DBContext {
   protected Connection connection;
    
    public static Connection getConnection() throws Exception {
        
        try {
            Class.forName(IConstant.DB_CLASSFORNAME);
            
            return DriverManager.getConnection(IConstant.DB_URL, IConstant.DB_USER_NAME, IConstant.DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw e;
        }
    }

    public void closeConnection(Connection conn, PreparedStatement ps, CallableStatement cs, ResultSet rs) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
            if (cs != null && !cs.isClosed()) {
                cs.close();
            }
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
        } catch (SQLException e) {
        }

    }
    
    public void closeConnection(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
        } catch (SQLException e) {
        }

    }
    
    

    public static void main(String[] args) throws Exception {
        Connection c = getConnection();
        if (c == null) {
            System.out.println("something wrong");
        } else {
            System.out.println("ok");
        }
    }
  
}






