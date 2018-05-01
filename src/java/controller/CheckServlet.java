/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author Amp
 */
@WebServlet(name = "CheckServlet", urlPatterns = {"/CheckServlet"})
public class CheckServlet extends HttpServlet {

    @Resource(name = "mysql")
    private DataSource mysql;

    private Connection conn;

    public void init() {
        try {
            conn = mysql.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

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

        if (request.getParameter("view").equals("result")) {
            RequestDispatcher obj = request.getRequestDispatcher("ViewUser.jsp");
            obj.forward(request, response);
        }
        else if (request.getParameter("view").equals("manage")) {

            RequestDispatcher obj = request.getRequestDispatcher("index.html");
            obj.forward(request, response);
        } else {
            int check = Integer.parseInt(request.getParameter("view"));
            HttpSession session = request.getSession();
            session.setAttribute("view", check);
            int uid = (int) session.getAttribute("uid");
            String sql = "SELECT * FROM students WHERE user_uid = " + uid;
            int num = 0;
            try {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    session.setAttribute("sid", rs.getInt("sid"));
                    RequestDispatcher obj = request.getRequestDispatcher("detail.jsp");
                    obj.forward(request, response);
                } else {
                    RequestDispatcher obj = request.getRequestDispatcher("event.jsp");
                    obj.forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckServlet at "  + "</h1>");
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
        processRequest(request, response);
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
