///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package GoogleLogin;
//
//import Entity.Users;
//import static Entity.Users.Roles.ADMIN;
//import static Entity.Users.Roles.CUSTOMER;
//import static Entity.Users.Roles.STAFF;
//import Model.DaoUser;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.util.Vector;
//
///**
// *
// * @author HP
// */
//@WebServlet(name = "LoginGoogleController", urlPatterns = {"/loginGoogle"})
//public class LoginGoogleController extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String code = request.getParameter("code");
//        GoogleLogin gg = new GoogleLogin();
//        String token = gg.getToken(code);
//        GoogleAccount access = gg.getUserInfo(token);
//        System.out.println(access);
//        String email = access.getEmail();
//        DaoUser daoUser = new DaoUser();
//
//        Vector<Users> userdata = daoUser.getuserData(email);
//
//        if (!userdata.isEmpty()) {
//            HttpSession session = request.getSession();
//            session.setAttribute("user", userdata.get(0));
//
//            Users user = userdata.get(0);
//            switch (user.getRole()) {
//                case ADMIN:
//                    response.sendRedirect("adminDashboard.jsp");
//                    return;
//                case STAFF:
//                    response.sendRedirect("staffDashboard.jsp");
//                    return;
//                case CUSTOMER:
//                    response.sendRedirect("customerHome.jsp");
//                    return;
//            }
//
//        }
//
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
