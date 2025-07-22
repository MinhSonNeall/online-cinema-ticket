package Controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.DaoShowtime;
import Entity.Showtimes;

@WebServlet(name="ManageShowtimeServlet", urlPatterns={"/admin/ManageShowtime"})
public class ManageShowtimeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        
        DaoShowtime dao = new DaoShowtime();

        switch (service) {
            case "listAll":
                List<Showtimes> showtimes = dao.getAllShowtimes();
                request.setAttribute("showtimes", showtimes);
                request.getRequestDispatcher("/jsp/admin/manageShowtime.jsp").forward(request, response);
                break;
            case "addShowtime":
                // Logic to show add form
                response.sendRedirect(request.getContextPath() + "/jsp/admin/addShowtime.jsp");
                break;
            case "editShowtime":
                // Logic to show edit form
                // This will require fetching a specific showtime and forwarding to an edit page
                response.sendRedirect(request.getContextPath() + "/admin/ManageShowtime?service=listAll");
                break;
            case "deleteShowtime":
                String showtimeId = request.getParameter("id");
                dao.deleteShowtime(showtimeId);
                response.sendRedirect(request.getContextPath() + "/admin/ManageShowtime?service=listAll");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/ManageShowtime?service=listAll");
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
        return "Short description";
    }
}
