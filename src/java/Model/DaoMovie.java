/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import Entity.Movies;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
/**
 *
 * @author Cuong
 */
public class DaoMovie extends DBContext{
    PreparedStatement ps;
    ResultSet rs;
    
    public ArrayList<Movies> getAllMovies() {
        ArrayList<Movies> list = new ArrayList<>();
        String sql = "SELECT * FROM movie_ticketing.movies";
        try {
            Movies movie = null;
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                movie = new Movies(
                    rs.getString("movie_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("duration"),
                    rs.getInt("age_restriction")
                );
                list.add(movie);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            closeConnection(connection, ps, rs);
        }
        return list;
    }
    
    
    public static void main(String[] args) {
        DaoMovie dao = new DaoMovie();
        ArrayList<Movies> movies = dao.getAllMovies();
        if (movies.isEmpty()) {
            System.out.println("No movies found or an error occurred.");
        } else {
            for (Movies movie : movies) {
                System.out.println(movie);
            }
        }
    }
    
}
