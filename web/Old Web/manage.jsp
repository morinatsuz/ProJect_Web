<%-- 
    Document   : manage
    Created on : May 2, 2018, 7:00:41 PM
    Author     : Amp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix='sql' uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password="root"/>
        <table border="1">
        <sql:query var="db" dataSource="mysql">
                    SELECT * FROM events e JOIN event_type et ON (e.events_type_tid = et.tid)
                </sql:query>
            <thead>
                <tr>
                    <th>Manage</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="rows" varStatus="status" items="${db.rows}" >
                <tr>
                    <td>
                        <form action="ManageEventServlet" method="POST">
                            <c:if test="${status.last}">
                            <input type="text" name="event_id" value="${rows.eid + 1}" readonly="" />
                            <button type="submit" name="event_action" value="create">Create Event</button>
                            </c:if>
                        </form>
                    </td>
                </tr>
                </c:forEach>
                <tr>
                    <td><form action="CheckServlet" method="POST">

                            <button type="submit" name="view" value="result">View User</button>
                        </form></td>
                </tr>
                
                    <tr>

            <td>
                Event List <br>
            <c:forEach var="rows" items="${db.rows}">
                        
                            
                            <form action="ManageEventServlet" method="POST">
                                <input type="text" name="event_id" value="${rows.eid}" readonly="readonly" size="2" /> <c:out value="${rows.title}"/>
                                <button type="submit" name="event_action" value="edit">Edit This Event</button>
                            </form>
                            <form action="ViewRegistered.jsp">
                                <button type="submit" name="regis" value="${rows.eid}">View Registrant</button>
                            </form>
                        
                </c:forEach>
                            </td>
                    </tr>
            </tbody>
        </table>

    </body>
</html>
