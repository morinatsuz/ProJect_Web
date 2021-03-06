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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import utils.Validator;

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
        
        if (!Validator.authorize(request, "admin")) {
            response.sendError(403);
            return;
        }
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");
            HttpSession session = request.getSession();
            int admins_aid = (int) session.getAttribute("uid")-168;
            String fname = (String) session.getAttribute("fname");
            String lname = (String) session.getAttribute("lname");
            
            String event_id = request.getParameter("event_id");
            String event_action = request.getParameter("event_action");
            out.println(event_id + " " + event_action);
            
            if (event_action.equals("create")) {
                Statement stmt = conn.createStatement();
                String query2 = "SELECT COUNT(t_title) 'Total_No' FROM event_type";
                String query3 = "SELECT t_title FROM event_type ORDER BY tid";
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
                request.setAttribute("admins_aid", admins_aid);
                request.setAttribute("fullname", fname+" "+lname);
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
                String queryP = "SELECT pic_url FROM pictures WHERE events_eid = " + event_id;
                        
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                
                //Set all event attributes
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

                int creatorAID = rs.getInt("admins_aid");
                int user_uid = creatorAID+168;
                String events_type_tid = rs.getString("events_type_tid");
                
                request.setAttribute("start_date", fd.format(start));
                request.setAttribute("start_time", ft.format(start));
                request.setAttribute("end_date", fd.format(end));
                request.setAttribute("end_time", ft.format(end));
                request.setAttribute("expired_date", fd.format(expired));
                request.setAttribute("expired_time", ft.format(expired));
                request.setAttribute("gmap_url", rs.getString("gmap_url"));
                request.setAttribute("events_type_tid", events_type_tid);
                request.setAttribute("admins_aid", creatorAID);
                
                //Find event type name
                String queryT = "SELECT t_title FROM event_type WHERE tid = " + events_type_tid;
                ResultSet rst = stmt.executeQuery(queryT);
                rst.next();
                request.setAttribute("event_type_name", rst.getString("t_title"));
                
                //Get fullname of event creator
                String queryC = "SELECT CONCAT(fname, ' ', lname) FROM users WHERE uid = " + user_uid;
                ResultSet rsf = stmt.executeQuery(queryC);
                rsf.next();
                String fullname = rsf.getString("CONCAT(fname, ' ', lname)");
                request.setAttribute("fullname", fullname);
                
                //Query for getting pic_url
                ResultSet rsp = stmt.executeQuery(queryP);
                while (rsp.next()) {
                    String pic_url = rsp.getString("pic_url");
                    request.setAttribute("pic_url", pic_url.isEmpty() ? "" : pic_url);
                }

                String query2 = "SELECT COUNT(t_title) 'Total_No' FROM event_type";
                String query3 = "SELECT t_title FROM event_type ORDER BY tid";

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
                //Get all event parameters from request scope
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
                String events_type_tid = request.getParameter("event_type_tid");
                String creatorAID = request.getParameter("admins_aid");
                
                //Get all picture parameters from request scope
                String pic_url = request.getParameter("pic_url");
                
                //SQL command for editing event
                String query = "UPDATE events SET title='"
                        + title + "', descript='" + descript + "', received_no="
                        + received_no + ", registered_no=" + registered_no
                        + ", location='" + location + "', start_date='"
                        + start_date + " " + start_time + "', end_date='"
                        + end_date + " " + end_time + "', expired_date='"
                        + expired_date + " " + expired_time + "', gmap_url='"
                        + gmap_url + "', events_type_tid=" + events_type_tid
                        + ", admins_aid=" + creatorAID + " WHERE eid=" + event_id;
                
                //SQL command for editing picture
                String queryP = "UPDATE pictures SET pic_url='"
                        + (pic_url.isEmpty() ? null : "'" + pic_url + "'") 
                        + "' WHERE events_eid = " + event_id;
                
                //Query update from all command
                Statement stmt = conn.createStatement();
                int numRow = 0;
                numRow += stmt.executeUpdate(query);
                numRow += stmt.executeUpdate(queryP);
                
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
                String creatorAID = request.getParameter("admins_aid");
                
                //SQL command for finding total events
                String queryE = "SELECT MAX(eid) FROM events;";
                
                //SQL command for inserting event information
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
                        + events_type_tid + ", " + creatorAID + ");";
                out.print("<h1>Access Create Condition</h1>");

                Statement stmt = conn.createStatement();
                int numRow = 0;
                
                //Run SQL commands
                ResultSet rs = stmt.executeQuery(queryE);
                rs.next();
                int total_event = rs.getInt("MAX(eid)") + 1;
                
                //SQL command for inserting event picture
                String pic_url = request.getParameter("pic_url");
                String queryP = "INSERT INTO pictures (`pic_url`, `events_eid`)"
                        + " VALUES ('" + pic_url + "', " + total_event + ");";
                out.println(queryP);
                out.println(queryC);
                numRow += stmt.executeUpdate(queryC);
                numRow += stmt.executeUpdate(queryP);
                    
                RequestDispatcher obj = request.getRequestDispatcher("manage.jsp");
                    obj.forward(request, response);
            } 
            else if (event_action.equals("Delete")) {
                String query1 = "DELETE FROM events WHERE eid = " + event_id;
                String query2 = "DELETE FROM student_event WHERE event_eid = " + event_id;
                String query3 = "DELETE FROM user_event WHERE event_eid = " + event_id;
                String query4 = "DELETE FROM pictures WHERE events_eid = " + event_id;
                Statement stmt = conn.createStatement();
                int numRow = 0;
                numRow += stmt.executeUpdate(query2);
                numRow += stmt.executeUpdate(query3);
                numRow += stmt.executeUpdate(query4);
                numRow += stmt.executeUpdate(query1);
                RequestDispatcher obj = request.getRequestDispatcher("manage.jsp");
                    obj.forward(request, response);
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
