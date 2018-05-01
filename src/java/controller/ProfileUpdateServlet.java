/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "ProfileUpdateServlet", urlPatterns = {"/ProfileUpdateServlet"})
public class ProfileUpdateServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        int num2 = (int) session.getAttribute("sid");
        String bday = request.getParameter("bday");
        String bmonth = request.getParameter("bmonth");
        String byear = request.getParameter("byear");
        String birth = byear + "-" + bmonth + "-" + bday;
        String sex = request.getParameter("sex");
        int age = Integer.parseInt(request.getParameter("age"));
        String religion = request.getParameter("religion");
        int year = Integer.parseInt(request.getParameter("year"));
        float height = Float.parseFloat(request.getParameter("height"));
        float weight = Float.parseFloat(request.getParameter("weight"));
        int chest = Integer.parseInt(request.getParameter("chest"));
        int waist = Integer.parseInt(request.getParameter("waist"));
        String congenital = request.getParameter("disease");
        String allergy = request.getParameter("allergy");
        String other = request.getParameter("other");
        String sql = "UPDATE students SET birthday = ?, sex = ?, age = ?, religion = ?, year = ?, height = ?, weight = ?, "
                + "chest_size = ?, waist_size = ?, congenital_diseases = ?, allergies = ?, others = ? WHERE sid = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, birth);
            stmt.setString(2, sex);
            stmt.setInt(3, age);
            stmt.setString(4, religion);
            stmt.setInt(5, year);
            stmt.setFloat(6, height);
            stmt.setFloat(7, weight);
            stmt.setInt(8, chest);
            stmt.setInt(9, waist);
            stmt.setString(10, congenital);
            stmt.setString(11, allergy);
            stmt.setString(12, other);
            stmt.setInt(13, num2);
            int rows = stmt.executeUpdate();
            RequestDispatcher obj = request.getRequestDispatcher("ProfileServlet");
            obj.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileUpdateServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" + birth + "</h1>");
            out.println("<h1>" + sex + "</h1>");
            out.println("<h1>" + age + "</h1>");
            out.println("<h1>" + religion + "</h1>");
            out.println("<h1>" + year + "</h1>");
            out.println("<h1>" + height + "</h1>");
            out.println("<h1>" + weight + "</h1>");
            out.println("<h1>" + chest + "</h1>");
            out.println("<h1>" + waist + "</h1>");
            out.println("<h1>" + congenital + "</h1>");
            out.println("<h1>" + allergy + "</h1>");
            out.println("<h1>" + other + "</h1>");
            out.println("<h1>" + num2 + "</h1>");
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
