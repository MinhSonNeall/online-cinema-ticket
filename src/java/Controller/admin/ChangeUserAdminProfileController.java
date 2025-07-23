package Controller.admin;

import Entity.Users;
import Model.DaoUser;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ChangeUserAdminProfileController", urlPatterns = {"/ChangeUserAdminProfile"})
public class ChangeUserAdminProfileController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Users adminUser = (Users) session.getAttribute("user");
        
        // Kiểm tra xem người dùng đã đăng nhập và có quyền admin không
       
        String action = request.getParameter("action");
        
        if (action == null) {
            // Hiển thị form thay đổi thông tin
            request.setAttribute("adminUser", adminUser);
            request.getRequestDispatcher("jsp/admin/changeUserAdminProfile.jsp").forward(request, response);
        } else if (action.equals("update")) {
            // Xử lý cập nhật thông tin
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            DaoUser daoUser = new DaoUser();
            
            // Kiểm tra mật khẩu hiện tại
            if (currentPassword != null && !currentPassword.isEmpty()) {
                if (!daoUser.checkPassword(adminUser.getUser_id(), currentPassword)) {
                    request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng");
                    request.setAttribute("adminUser", adminUser);
                    request.getRequestDispatcher("jsp/admin/changeUserAdminProfile.jsp").forward(request, response);
                    return;
                }
                
                // Kiểm tra mật khẩu mới và xác nhận mật khẩu
                if (newPassword == null || newPassword.isEmpty() || !newPassword.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp");
                    request.setAttribute("adminUser", adminUser);
                    request.getRequestDispatcher("jsp/admin/changeUserAdminProfile.jsp").forward(request, response);
                    return;
                }
                
                // Cập nhật mật khẩu
                daoUser.updatePasswordById(adminUser.getUser_id(), newPassword);
            }
            
            // Cập nhật thông tin cá nhân
            adminUser.setFull_name(fullName);
            adminUser.setEmail(email);
            adminUser.setPhone_number(phone);
            
            boolean updateSuccess = daoUser.updateUserProfile(adminUser);
            
            if (updateSuccess) {
                // Cập nhật thông tin trong session
                session.setAttribute("user", adminUser);
                request.setAttribute("successMessage", "Cập nhật thông tin thành công");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thông tin thất bại");
            }
            
            request.setAttribute("adminUser", adminUser);
            request.getRequestDispatcher("jsp/admin/changeUserAdminProfile.jsp").forward(request, response);
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
        return "Change Admin Profile Controller";
    }
} 