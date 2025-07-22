/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Entity.Cinemas;
import Entity.DateItem;
import Entity.InfomationMovie;
import Entity.Location;
import Entity.Movies;
import Entity.Seats;
import Entity.ShowSeat;
import Entity.ShowtimeSlot;
import Entity.Showtimes;
import Model.DaoMovie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Cuong
 */
@WebServlet(name = "ListMovieDetailController", urlPatterns = {"/ListMovieDetailController"})
public class ListMovieDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListMovieDetailController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListMovieDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieId = request.getParameter("movieId");
        String selectedDateStr = request.getParameter("selectedDate");
        String selectedCinemaId = request.getParameter("room_id");
        String selectedCityName = request.getParameter("cityName");
        String selectedSlotId = request.getParameter("slot_id");
        DaoMovie daoMovie = new DaoMovie();
        Movies movie = daoMovie.getMovieById(movieId);
        if (movie == null) {
            response.sendRedirect("/jsp/error.jsp");
            return;
        }
        
        InfomationMovie infomationMovie = daoMovie.getInfomation(movieId, selectedCityName, selectedDateStr,selectedCinemaId,selectedSlotId);
        // Lấy danh sách suất chiếu
        ArrayList<Showtimes> showtimeList = daoMovie.getShowtimes(movieId);
        if (showtimeList.isEmpty()) {
            System.out.println("movieList is null");
            request.setAttribute("errorMessage", "Không có suất chiếu nào tại rạp CGV Hùng Vương Plaza vào ngày 01/06/2025.");
            request.getRequestDispatcher("/jsp/Movie/index.jsp").forward(request, response);
            return;
        }
        
        List<ShowtimeSlot> showtimeListOf = new ArrayList<>();
            if (movieId != null && selectedCityName != null && selectedDateStr != null) {
                showtimeListOf = daoMovie.getTimeSlot(movieId, selectedCityName, selectedDateStr,selectedCinemaId);
            }else {
                System.out.println("kh co du lieu");
            }
            
        List<ShowSeat> showSeatList = new ArrayList<>();
            if (movieId != null && selectedCityName != null && selectedDateStr != null) {
                showSeatList = daoMovie.getShowSeat(movieId, selectedCityName, selectedDateStr,selectedCinemaId,selectedSlotId);
            }else {
                System.out.println("kh co du lieu");
            }

        
        List<DateItem> dateListTesst = daoMovie.getDayOfMoview(movieId);
        
        LocalDate selectedDate;
        if(selectedDateStr != null && !selectedDateStr.isEmpty()){
            selectedDate = LocalDate.parse(selectedDateStr);
        }else{
            selectedDate = LocalDate.now();
        }
        List<Location> locationList = daoMovie.getCinemasByMovieAndDate(movieId, selectedDate);
        List<Cinemas> listCinema = daoMovie.GetCinemaByCity(movieId, selectedCityName);

        for (DateItem dateItem : dateListTesst) {
            LocalDate itemDate = LocalDate.of(selectedDate.getYear(), selectedDate.getMonth(), Integer.parseInt(dateItem.getDay()));
            dateItem.setActive(itemDate.equals(selectedDate));
        }
        
        request.setAttribute("infomationMovie", infomationMovie);
        request.setAttribute("showSeatList", showSeatList);
        request.setAttribute("listCinema", listCinema);
        request.setAttribute("showtimeListOf", showtimeListOf);
        request.setAttribute("selectedDate", selectedDate.toString());
        request.setAttribute("locationList", locationList);
        request.setAttribute("dateListTesst", dateListTesst);
        request.setAttribute("movieId", movieId);
        request.setAttribute("movieTitle", movie.getTitle());
        request.setAttribute("movieDuration", movie.getDuration());
        request.setAttribute("movieAge", movie.getAge_restriction());
        request.setAttribute("showtimeList", showtimeList);
        request.setAttribute("poster", movie.getPoster_url());
        request.getRequestDispatcher("/jsp/Movie/listmovedetail.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
