package Controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.DaoUser;
import Entity.Users;
import jakarta.servlet.http.HttpSession;
import java.util.Vector;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "ManageUserAccountServlet", urlPatterns = {"/ManageUserAccount", "/customer"})
public class ManageUserAccountServlet extends HttpServlet {

    private void listUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DaoUser dao = new DaoUser();
        Vector<Users> data;

        String searchBy = request.getParameter("searchBy");
        String searchValue = request.getParameter("searchValue");

        if (searchBy == null || searchValue == null || searchBy.isEmpty() || searchValue.isEmpty()) {
            data = dao.listAllUser();
        } else {
            data = dao.getSpecificuserData(searchBy, searchValue);
            request.setAttribute("userList", data);
        request.getRequestDispatcher("/jsp/admin/manageUserAccount.jsp").forward(request, response);
        }

        request.setAttribute("userList", data);
        request.getRequestDispatcher("/jsp/admin/manageUserAccount.jsp").forward(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String submit = request.getParameter("submit");
        if (submit == null) {
            String email = request.getParameter("email");
            DaoUser dao = new DaoUser();
            Vector<Users> user = dao.getuserData(email);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/jsp/admin/updateCustomer.jsp").forward(request, response);

        } else {
            String user_id = request.getParameter("user_id");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String full_name = request.getParameter("full_name");
            String phone_number = request.getParameter("phone_number");

            Timestamp updated_at = Timestamp.valueOf(LocalDateTime.now());

            DaoUser dao = new DaoUser();
            Users user = new Users(user_id, email, password, full_name, phone_number, updated_at);
            int updated = dao.updateCustomer(user);

            if (updated > 0) {
                // Optionally, set a success message
                request.getSession().setAttribute("message", "User update successfully");
            } else {
                request.getSession().setAttribute("message", "Failed to update user");
            }

            // Redirect to the list of users
            listUser(request, response); // Or use a redirect to the list page
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        DaoUser dao = new DaoUser();
        boolean deleted = dao.deleteCustomer(email);

        if (deleted) {
            // Set a success message
            request.getSession().setAttribute("message", "User deleted successfully");

        } else {
            // Set an error message
            request.getSession().setAttribute("message", "Failed to delete user");
        }

        // Redirect to the list of users
        listUser(request, response); // Or use a redirect to the list page
    }
    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email=request.getParameter("email");
        DaoUser dao= new DaoUser();
        Vector<Users> data=dao.getuserData(email);
        request.setAttribute("userDetail", data);
        request.getRequestDispatcher("/jsp/admin/userDetail.jsp").forward(request, response);
        
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");

        try {
            if (service != null) {
                switch (service) {
                    case "list":
                        listUser(request, response);
                        break;
                    case "update":
                        updateUser(request, response);
                        break;
                    case "delete":
                        deleteUser(request, response);
                    case "detail":
                        showDetail(request,response);

                    default:
                        // Handle other actions or invalid actions
                        listUser(request, response);
                }
            } else {
                listUser(request, response);
            }
        } catch (Exception e) {
            // Handle exceptions
            response.getWriter().println("Error: " + e.getMessage());
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
