package Controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.DaoRoom;
import Entity.Rooms;
import Model.DaoSeat;
import Entity.Seats;

@WebServlet(name="ManageRoomSeatServlet", urlPatterns={"/admin/ManageRoomSeat"})
public class ManageRoomSeatServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        
        DaoRoom daoRoom = new DaoRoom();
        DaoSeat daoSeat = new DaoSeat();

        switch (service) {
            case "listAll":
                List<Rooms> rooms = daoRoom.getAllRooms();
                request.setAttribute("rooms", rooms);
                request.getRequestDispatcher("/jsp/admin/manageRoomSeat.jsp").forward(request, response);
                break;
            case "viewSeats":
                String roomId = request.getParameter("roomId");
                List<Seats> seats = daoSeat.getSeatsByRoom(roomId);
                request.setAttribute("seats", seats);
                request.setAttribute("roomId", roomId);
                request.getRequestDispatcher("/jsp/admin/viewSeats.jsp").forward(request, response);
                break;
            case "addRoom":
                // Logic for showing add room form
                response.sendRedirect(request.getContextPath() + "/jsp/admin/addRoom.jsp");
                break;
            case "editRoom":
                // Logic for showing edit room form
                response.sendRedirect(request.getContextPath() + "/admin/ManageRoomSeat?service=listAll");
                break;
            case "deleteRoom":
                String deleteRoomId = request.getParameter("id");
                daoRoom.deleteRoom(deleteRoomId);
                response.sendRedirect(request.getContextPath() + "/admin/ManageRoomSeat?service=listAll");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/ManageRoomSeat?service=listAll");
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
        return "Servlet for managing rooms and seats";
    }
}
