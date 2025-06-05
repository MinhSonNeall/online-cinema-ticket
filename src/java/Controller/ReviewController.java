package Controller;

import Entity.Reviews;
import Model.DaoReview;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ReviewController", urlPatterns = {"/ReviewController"})
public class ReviewController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieId = request.getParameter("movieId");
        DaoReview daoReview = new DaoReview();
        ArrayList<Reviews> reviews = daoReview.getReviewsByMovie(movieId);
        request.setAttribute("reviews", reviews);
        request.setAttribute("movieId", movieId);
        request.getRequestDispatcher("/jsp/reviewMovie.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Entity.Users user = (Entity.Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String movieId = request.getParameter("movieId");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        DaoReview daoReview = new DaoReview();
        daoReview.addReview(user.getUser_id(), movieId, rating, comment);

        response.sendRedirect("ReviewController?movieId=" + movieId);
    }
}