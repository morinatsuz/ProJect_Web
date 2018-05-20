<%-- 
    Document   : join
    Created on : Apr 27, 2018, 11:05:36 AM
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
                           user="root"  password=""/>
        <% request.setCharacterEncoding("UTF-8"); %>
        <% int num = (int) session.getAttribute("view"); %>
        <% int num2 = (int) session.getAttribute("sid"); %>
        <% String checkJoin = request.getParameter("joinValue");%>
        <a href="event.jsp"><button type="submit" name="view" value="${rows.eid}" >Home</button></a>
        <%= checkJoin%>
        <% if (checkJoin.equals("join")) {%>
        <sql:query var="db" dataSource="mysql">
            SELECT registered_no FROM events WHERE eid = <%= num %> 
        </sql:query>
        <c:forEach var="rows" items="${db.rows}">
            <sql:update var="db2" dataSource="mysql">
                UPDATE events
                SET registered_no = <c:out value="${rows.registered_no + 1}"/>
                WHERE eid = <%= num%>
            </sql:update>
        </c:forEach>
        <sql:update var="db" dataSource="mysql">
            INSERT INTO student_event (student_sid, event_eid, registered_date)
            VALUES (<%= num2%>, <%= num%>, CURRENT_TIMESTAMP)
        </sql:update>
        <% } %>
        <% if (checkJoin.equals("unjoin")) {%>
        <sql:query var="db" dataSource="mysql">
            SELECT registered_no FROM events WHERE eid = <%= num %> 
        </sql:query>
        <c:forEach var="rows" items="${db.rows}">
            <sql:update var="db2" dataSource="mysql">
                UPDATE events
                SET registered_no = <c:out value="${rows.registered_no - 1}"/>
                WHERE eid = <%= num%>
            </sql:update>
        </c:forEach>
        <sql:update var="db" dataSource="mysql">
            DELETE FROM student_event
            WHERE student_sid = <%= num2%> AND event_eid = <%= num%>
        </sql:update>
        <% }%>
        <c:redirect url="detail.jsp"></c:redirect>
    </body>
</html>
