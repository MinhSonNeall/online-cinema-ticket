package Controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import Model.DaoRoom;
import Entity.Rooms;
import Model.DaoSeat;
import Entity.Seats;
import Model.DaoCinema;
import Entity.Cinemas;
import Model.DaoShowtime;
import java.util.Map;

@WebServlet(name="ManageRoomSeatServlet", urlPatterns={"/ManageRoomSeat"})
public class ManageRoomSeatServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        if (service == null) {
            service = "listCinemas";
        }
        
        DaoRoom daoRoom = new DaoRoom();
        DaoSeat daoSeat = new DaoSeat();
        DaoCinema daoCinema = new DaoCinema();
        HttpSession session = request.getSession();

        switch (service) {
            case "listCinemas":
                List<Cinemas> cinemas = daoCinema.getAllCinemas();
                request.setAttribute("cinemas", cinemas);
                request.getRequestDispatcher("/jsp/admin/manageCinema.jsp").forward(request, response);
                break;
                
            case "searchCinemas":
                String searchTerm = request.getParameter("searchTerm");
                List<Cinemas> searchResults;
                
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    searchResults = daoCinema.searchCinemas(searchTerm);
                    request.setAttribute("searchTerm", searchTerm); // Store search term to display in the form
                } else {
                    searchResults = daoCinema.getAllCinemas();
                }
                
                request.setAttribute("cinemas", searchResults);
                request.getRequestDispatcher("/jsp/admin/manageCinema.jsp").forward(request, response);
                break;
                
            case "addCinema":
                request.getRequestDispatcher("/jsp/admin/addCinema.jsp").forward(request, response);
                break;
                
            case "saveCinema":
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                
                // Tạo ID mới cho cinema
                int maxId = daoCinema.getMaxCinemaId();
                String newCinemaId = String.valueOf(maxId + 1);
                
                Cinemas newCinema = new Cinemas(newCinemaId, name, address, city);
                boolean success = daoCinema.addCinema(newCinema);
                
                if (success) {
                    session.setAttribute("success", "Cinema added successfully");
                } else {
                    session.setAttribute("error", "Failed to add cinema");
                }
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat");
                break;
                
            case "editCinema":
                String cinemaId = request.getParameter("id");
                Cinemas cinema = daoCinema.getCinemaById(cinemaId);
                request.setAttribute("cinema", cinema);
                request.getRequestDispatcher("/jsp/admin/editCinema.jsp").forward(request, response);
                break;
                
            case "updateCinema":
                String updateCinemaId = request.getParameter("cinemaId");
                String updateName = request.getParameter("name");
                String updateAddress = request.getParameter("address");
                String updateCity = request.getParameter("city");
                
                Cinemas updateCinema = new Cinemas(updateCinemaId, updateName, updateAddress, updateCity);
                boolean updateSuccess = daoCinema.updateCinema(updateCinema);
                
                if (updateSuccess) {
                    session.setAttribute("success", "Cinema updated successfully");
                } else {
                    session.setAttribute("error", "Failed to update cinema");
                }
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat");
                break;
                
            case "deleteCinema":
                String deleteCinemaId = request.getParameter("id");
                boolean deleteSuccess = daoCinema.deleteCinema(deleteCinemaId);
                
                if (deleteSuccess) {
                    session.setAttribute("success", "Cinema deleted successfully");
                } else {
                    session.setAttribute("error", "Failed to delete cinema. It may have rooms associated with it.");
                }
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat");
                break;
                
            case "viewRooms":
                String viewCinemaId = request.getParameter("cinemaId");
                Cinemas viewCinema = daoCinema.getCinemaById(viewCinemaId);
                List<Rooms> rooms = daoRoom.getRoomsByCinemaId(viewCinemaId);
                
                request.setAttribute("cinema", viewCinema);
                request.setAttribute("rooms", rooms);
                request.getRequestDispatcher("/jsp/admin/manageRooms.jsp").forward(request, response);
                break;
                
            case "addRoom":
                String addRoomCinemaId = request.getParameter("cinemaId");
                Cinemas addRoomCinema = daoCinema.getCinemaById(addRoomCinemaId);
                
                request.setAttribute("cinema", addRoomCinema);
                request.getRequestDispatcher("/jsp/admin/addRoom.jsp").forward(request, response);
                break;
                
            case "saveRoom":
                String roomCinemaId = request.getParameter("cinemaId");
                String roomName = request.getParameter("name");
                int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
                
                // Tạo ID mới cho room
                int maxRoomId = daoRoom.getMaxRoomId();
                int newRoomIdInt = maxRoomId + 1;
                String newRoomId = String.valueOf(newRoomIdInt);
                
                System.out.println("Debug - Creating new room with ID: " + newRoomId + " (max ID was: " + maxRoomId + ")");
                
                Rooms newRoom = new Rooms();
                newRoom.setRoom_id(newRoomId);
                newRoom.setCinema_id(roomCinemaId);
                newRoom.setName(roomName);
                newRoom.setTotal_seats(totalSeats);
                
                boolean roomSuccess = daoRoom.addRoom(newRoom);
                
                if (roomSuccess) {
                    session.setAttribute("success", "Room added successfully");
                } else {
                    session.setAttribute("error", "Failed to add room");
                }
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat?service=viewRooms&cinemaId=" + roomCinemaId);
                break;
                
            case "editRoom":
                String editRoomId = request.getParameter("id");
                Rooms room = daoRoom.getRoomById(editRoomId);
                Cinemas roomCinema = daoCinema.getCinemaById(room.getCinema_id());
                
                request.setAttribute("room", room);
                request.setAttribute("cinema", roomCinema);
                request.getRequestDispatcher("/jsp/admin/editRoom.jsp").forward(request, response);
                break;
                
            case "updateRoom":
                String updateRoomId = request.getParameter("roomId");
                String updateRoomCinemaId = request.getParameter("cinemaId");
                String updateRoomName = request.getParameter("name");
                int updateTotalSeats = Integer.parseInt(request.getParameter("totalSeats"));
                
                Rooms updateRoom = new Rooms();
                updateRoom.setRoom_id(updateRoomId);
                updateRoom.setCinema_id(updateRoomCinemaId);
                updateRoom.setName(updateRoomName);
                updateRoom.setTotal_seats(updateTotalSeats);
                
                boolean roomUpdateSuccess = daoRoom.updateRoom(updateRoom);
                
                if (roomUpdateSuccess) {
                    session.setAttribute("success", "Room updated successfully");
                } else {
                    session.setAttribute("error", "Failed to update room");
                }
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat?service=viewRooms&cinemaId=" + updateRoomCinemaId);
                break;
                
            case "deleteRoom":
                String deleteRoomId = request.getParameter("id");
                Rooms deleteRoom = daoRoom.getRoomById(deleteRoomId);
                String deleteRoomCinemaId = deleteRoom.getCinema_id();
                
                boolean roomDeleteSuccess = daoRoom.deleteRoom(deleteRoomId);
                
                if (roomDeleteSuccess) {
                    session.setAttribute("success", "Room deleted successfully");
                } else {
                    session.setAttribute("error", "Failed to delete room. It may be in use.");
                }
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat?service=viewRooms&cinemaId=" + deleteRoomCinemaId);
                break;
                
            case "viewSeats":
                String roomId = request.getParameter("roomId");
                List<Seats> seats = daoSeat.getSeatsByRoom(roomId);
                Rooms seatRoom = daoRoom.getRoomById(roomId);
                
                request.setAttribute("seats", seats);
                request.setAttribute("room", seatRoom);
                request.getRequestDispatcher("/jsp/admin/viewSeats.jsp").forward(request, response);
                break;
                
            case "viewRoomShowtimeSlots":
                String viewSlotRoomId = request.getParameter("roomId");
                Rooms viewSlotRoom = daoRoom.getRoomById(viewSlotRoomId);
                Cinemas viewSlotCinema = daoCinema.getCinemaById(viewSlotRoom.getCinema_id());
                
                DaoShowtime daoShowtime = new DaoShowtime();
                List<Map<String, Object>> roomSlots = daoShowtime.getShowtimeSlotsByRoomId(viewSlotRoomId);
                
                request.setAttribute("room", viewSlotRoom);
                request.setAttribute("cinema", viewSlotCinema);
                request.setAttribute("roomSlots", roomSlots);
                request.getRequestDispatcher("/jsp/admin/viewRoomShowtimeSlots.jsp").forward(request, response);
                break;
                
            default:
                response.sendRedirect(request.getContextPath() + "/ManageRoomSeat");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing cinemas, rooms and seats";
    }
}
