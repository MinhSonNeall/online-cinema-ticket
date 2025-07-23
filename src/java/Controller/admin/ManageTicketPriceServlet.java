package Controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.DaoTicketPrice;
import Entity.TicketPrices;

@WebServlet(name="ManageTicketPriceServlet", urlPatterns={"/admin/ManageTicketPrice"})
public class ManageTicketPriceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        if (service == null) {
            service = "listAll";
        }
        
        DaoTicketPrice dao = new DaoTicketPrice();

        switch (service) {
            case "listAll":
                List<TicketPrices> prices = dao.getAllTicketPrices();
                request.setAttribute("ticketPrices", prices);
                request.getRequestDispatcher("/jsp/admin/manageTicketPrice.jsp").forward(request, response);
                break;
            case "editPrice":
                // Logic for showing edit price form
                // This will require fetching a specific price and forwarding to an edit page
                response.sendRedirect(request.getContextPath() + "/jsp/admin/editTicketPrice.jsp");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/ManageTicketPrice?service=listAll");
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
        return "Servlet for managing ticket prices";
    }
}
