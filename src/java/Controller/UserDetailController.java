package Controller;

import Entity.Users;
import Model.DaoUser;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UserDetailController", urlPatterns = {"/UserDetail"})
public class UserDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        // Nếu không có người dùng đăng nhập, chuyển hướng đến trang đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginController");
            return;
        }
        
        // Lấy thông tin chi tiết của người dùng từ database
        DaoUser daoUser = new DaoUser();
        Vector<Users> userData = daoUser.getuserData(user.getEmail());
        
        if (!userData.isEmpty()) {
            // Lấy thông tin người dùng từ database
            Users userDetail = userData.get(0);
            request.setAttribute("userDetail", userDetail);
            
            // Chuyển hướng đến trang userDetail.jsp
            request.getRequestDispatcher("/jsp/userDetail.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy thông tin người dùng, hiển thị thông báo lỗi
            request.setAttribute("error", "Không thể tìm thấy thông tin người dùng");
            request.getRequestDispatcher("/jsp/userDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        
        // Nếu không có người dùng đăng nhập, chuyển hướng đến trang đăng nhập
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/loginController");
            return;
        }
        
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Kiểm tra xác nhận mật khẩu
        if (password != null && !password.isEmpty() && !password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            doGet(request, response);
            return;
        }
        
        // Nếu mật khẩu trống, sử dụng mật khẩu hiện tại
        if (password == null || password.isEmpty()) {
            DaoUser daoUser = new DaoUser();
            Vector<Users> userData = daoUser.getuserData(currentUser.getEmail());
            if (!userData.isEmpty()) {
                password = userData.get(0).getPassword();
            }
        }
        
        // Cập nhật thông tin người dùng
        Users updatedUser = new Users();
        updatedUser.setEmail(email);
        updatedUser.setFull_name(fullName);
        updatedUser.setPhone_number(phoneNumber);
        updatedUser.setPassword(password);
        updatedUser.setUpdated_at(new Timestamp(new Date().getTime()));
        
        // Lưu thông tin vào database
        DaoUser daoUser = new DaoUser();
        int result = daoUser.updateCustomer(updatedUser);
        
        if (result > 0) {
            // Cập nhật thông tin trong session
            currentUser.setFull_name(fullName);
            currentUser.setPhone_number(phoneNumber);
            session.setAttribute("user", currentUser);
            session.setAttribute("email", email);
            
            // Hiển thị thông báo thành công
            request.setAttribute("success", "Cập nhật thông tin thành công");
        } else {
            // Hiển thị thông báo lỗi
            request.setAttribute("error", "Cập nhật thông tin thất bại");
        }
        
        // Lấy lại thông tin người dùng mới nhất
        Vector<Users> userData = daoUser.getuserData(email);
        if (!userData.isEmpty()) {
            request.setAttribute("userDetail", userData.get(0));
        }
        
        // Chuyển hướng đến trang userDetail.jsp
        request.getRequestDispatcher("/jsp/userDetail.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "User Detail Controller";
    }
} 