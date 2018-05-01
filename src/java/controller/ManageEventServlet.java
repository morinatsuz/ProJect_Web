/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 *
 * @author Boom
 */
@WebServlet(name = "ManageEventServlet", urlPatterns = {"/ManageEventServlet"})
public class ManageEventServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");
            String event_id = request.getParameter("event_id");
            String event_action = request.getParameter("event_action");
            out.println(event_id + " " + event_action);
            
//            int k = 0/0;
            if (event_action.equals("create")) {
                Statement stmt = conn.createStatement();
                String query2 = "SELECT COUNT(t_title) 'Total_No' FROM event_type";
                String query3 = "SELECT t_title FROM event_type";
                ResultSet rs2 = stmt.executeQuery(query2);
                out.print("<br>" + query2);
                rs2.next();
                int rowcount = rs2.getInt("Total_No");
                out.print("<br>rowcount = " + rowcount);
                String[] event_types = new String[rowcount];
                ResultSet rs3 = stmt.executeQuery(query3);
                rowcount = 0;
                while (rs3.next()) {
                    event_types[rowcount] = rs3.getString("t_title");
                    out.println("<br>" + (rs3.getString("t_title")) + "idx = " + rowcount);
                    rowcount++;
                }
                request.setAttribute("event_types", event_types);
                request.setAttribute("admins_aid", "4");
                request.setAttribute("registered_no", "0");
                request.setAttribute("start_date", "01 May 2018");
                request.setAttribute("start_time", "00:00:00");
                request.setAttribute("end_date", "05 May 2018");
                request.setAttribute("end_time", "00:00:00");
                request.setAttribute("expired_date", "28 Apr 2018");
                request.setAttribute("expired_time", "00:00:00");
                request.setAttribute("event_action", "create");

                RequestDispatcher rd = request.getRequestDispatcher("ManageEvent.jsp");
                rd.forward(request, response);
            } else if (event_action.equals("edit")) {
                request.setAttribute("event_id", event_id);
                String query = "SELECT * FROM events WHERE eid=" + event_id;
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                rs.next();
                request.setAttribute("title", rs.getString("title"));
                request.setAttribute("descript", rs.getString("descript"));
                request.setAttribute("received_no", rs.getString("received_no"));
                request.setAttribute("registered_no", rs.getString("registered_no"));
                request.setAttribute("location", rs.getString("location"));

                SimpleDateFormat fd = new SimpleDateFormat("dd MMM yyyy");
                SimpleDateFormat ft = new SimpleDateFormat("hh:mm:ss");
                Date start = rs.getDate("start_date");
                Date end = rs.getDate("end_date");
                Date expired = rs.getDate("expired_date");

                request.setAttribute("start_date", fd.format(start));
                request.setAttribute("start_time", ft.format(start));
                request.setAttribute("end_date", fd.format(end));
                request.setAttribute("end_time", ft.format(end));
                request.setAttribute("expired_date", fd.format(expired));
                request.setAttribute("expired_time", ft.format(expired));
                request.setAttribute("gmap_url", rs.getString("gmap_url"));
                request.setAttribute("events_type_tid", rs.getString("events_type_tid"));
                request.setAttribute("admins_aid", rs.getString("admins_aid"));

                String query2 = "SELECT COUNT(t_title) 'Total_No' FROM event_type";
                String query3 = "SELECT t_title FROM event_type";

                ResultSet rs2 = stmt.executeQuery(query2);
                out.print("<br>" + query2);

                rs2.next();
                int rowcount = rs2.getInt("Total_No");
                out.print("<br>rowcount = " + rowcount);
                String[] event_type = new String[rowcount];
                ResultSet rs3 = stmt.executeQuery(query3);
                rowcount = 0;
                while (rs3.next()) {
                    event_type[rowcount] = rs3.getString("t_title");
                    out.println("<br>" + (rs3.getString("t_title")) + "idx = " + rowcount);
                    rowcount++;
                }
                request.setAttribute("event_types", event_type);
                request.setAttribute("event_action", "edit");

                RequestDispatcher rd = request.getRequestDispatcher("ManageEvent.jsp");
                rd.forward(request, response);
            } else if (event_action.equals("Save")) {
                String title = request.getParameter("title");
                String descript = request.getParameter("descript");
                String received_no = request.getParameter("received_no");
                String registered_no = request.getParameter("registered_no");
                String location = request.getParameter("location");

                String start_date1 = request.getParameter("start_date");
                String start_time = request.getParameter("start_time");
                String end_date1 = request.getParameter("end_date");
                String end_time = request.getParameter("end_time");
                String expired_date1 = request.getParameter("expired_date");
                String expired_time = request.getParameter("expired_time");

                DateFormat originalFormat = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
                DateFormat targetFormat = new SimpleDateFormat("yyyy.MM.dd");

                java.util.Date start = originalFormat.parse(start_date1);
                java.util.Date end = originalFormat.parse(end_date1);
                java.util.Date expire = originalFormat.parse(expired_date1);

                String start_date = targetFormat.format(start);
                String end_date = targetFormat.format(end);
                String expired_date = targetFormat.format(expire);

                String gmap_url = request.getParameter("gmap_url");
                String events_type_tid = request.getParameter("events_type_tid");
                String admins_aid = request.getParameter("admins_aid");
                String query = "UPDATE events SET title='"
                        + title + "', descript='" + descript + "', received_no="
                        + received_no + ", registered_no=" + registered_no
                        + ", location='" + location + "', start_date='"
                        + start_date + " " + start_time + "', end_date='"
                        + end_date + " " + end_time + "', expired_date='"
                        + expired_date + " " + expired_time + "', gmap_url='"
                        + gmap_url + "', events_type_tid=" + events_type_tid
                        + ", admins_aid=" + admins_aid + " WHERE eid=" + event_id;
                Statement stmt = conn.createStatement();
                int numRow = stmt.executeUpdate(query);
                response.sendRedirect("event.jsp");
            } else if (event_action.equals("Create")) {
                String title = request.getParameter("title");
                String descript = request.getParameter("descript");
                String received_no = request.getParameter("received_no");
                String registered_no = request.getParameter("registered_no");
                String location = request.getParameter("location");

                String start_date1 = request.getParameter("start_date");
                String start_time = request.getParameter("start_time");
                String end_date1 = request.getParameter("end_date");
                String end_time = request.getParameter("end_time");
                String expired_date1 = request.getParameter("expired_date");
                String expired_time = request.getParameter("expired_time");

                DateFormat originalFormat = new SimpleDateFormat("dd MMM yyyy");
                DateFormat targetFormat = new SimpleDateFormat("yyyy.MM.dd");

                java.util.Date start = originalFormat.parse(start_date1);
                java.util.Date end = originalFormat.parse(end_date1);
                java.util.Date expire = originalFormat.parse(expired_date1);

                String start_date = targetFormat.format(start);
                String end_date = targetFormat.format(end);
                String expired_date = targetFormat.format(expire);

                String gmap_url = request.getParameter("gmap_url");
                String events_type_tid = request.getParameter("event_type_tid");
                out.print("events_type_tid.isEmpty() = " + events_type_tid.isEmpty());
                String admins_aid = request.getParameter("admins_aid");
                String queryC = "INSERT INTO events (`title`, `descript`,"
                        + " `received_no`, `registered_no`, `location`, `start_date`,"
                        + " `end_date`, `expired_date`, `gmap_url`, `events_type_tid`,"
                        + " `admins_aid`) VALUES ('" + title + "',"
                        + " '" + descript + "', " + received_no + ", "
                        + registered_no + ", '" + location + "', "
                        + "'" + start_date + " " + start_time
                        + "', '" + end_date + " " + end_time + "',"
                        + " '" + expired_date + " " + expired_time + "' , "
                        + (gmap_url.isEmpty() ? null : "'" + gmap_url + "'") + ", "
                        + events_type_tid + ", " + admins_aid + ");";
                out.print("<br>Access Create Condition<br>");

                Statement stmt = conn.createStatement();
                int numRow = stmt.executeUpdate(queryC);
                response.sendRedirect("event.jsp");
            } 
            else if (event_action.equals("Delete")) {
                String query1 = "DELETE FROM events WHERE eid = " + event_id;
                String query2 = "DELETE FROM student_event WHERE event_eid = " + event_id;
                String query3 = "DELETE FROM user_event WHERE event_eid = " + event_id;
                String query4 = "DELETE FROM pictures WHERE events_eid = " + event_id;
                Statement stmt = conn.createStatement();
                int numRow = 0;
                numRow += stmt.executeUpdate(query1);
                numRow += stmt.executeUpdate(query2);
                numRow += stmt.executeUpdate(query3);
                numRow += stmt.executeUpdate(query4);
                response.sendRedirect("index.html");
            }else {
                out.println("event_action is not in choices.");
            }
        } catch (Exception ex) {
            Logger.getLogger(ManageEventServlet.class.getName()).log(Level.SEVERE, null, ex);
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
