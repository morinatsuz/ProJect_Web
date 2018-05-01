<%-- 
    Document   : detail
    Created on : Apr 17, 2018, 8:26:57 PM
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
        <% request.setCharacterEncoding("UTF-8"); %>
        <% String adminCheck = (String) session.getAttribute("type"); %>
        <% int num = (int) session.getAttribute("view"); %>
        <% int num2 = (int) session.getAttribute("sid");%>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password="root"/>
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM events WHERE eid = <%= num%>
        </sql:query>
        <a href="event.jsp"><button type="submit" name="view" value="${rows.eid}" >Home</button></a>
        <a href="LogoutServlet"><button type="submit">Logout</button></a> 
        <a href="ProfileServlet"><button type="submit">Profile</button></a> <br>
        <h1><c:forEach var="rows" items="${db.rows}">
               ชื่อกิจกรรม : <c:out value="${rows.title}"/> <br>
               รายละเอียด : <c:out value="${rows.descript}"/> <br>
               จำนวนที่รับสมัครเข้ากิจกรรม <c:out value="${rows.received_no}"/> <br>
               สถานที่ <c:out value="${rows.location}"/> <br>
               เวลาที่เริ่มกิจกรรม <c:out value="${rows.start_date}"/> <br>
               เวลาที่จบกิจกรรม <c:out value="${rows.end_date}"/> <br>
               เวลาที่ปิดรับสมัคร <c:out value="${rows.expired_date}"/> <br>
                <c:out value="${rows.gmap_url}"/> <br>

            </c:forEach>

        </h1>
        <sql:query var="db2" dataSource="mysql" >
            SELECT * FROM student_event WHERE student_sid = <%= num2%> AND event_eid = <%= num%>
        </sql:query>
        <c:choose>
            <c:when test="${db2.rowCount == 0}">
                <form action="join.jsp" method="POST">
                    <button type="submit" name="joinValue" value="join" >Join</button>
                </form>
            </c:when>
            <c:otherwise>
                <form action="join.jsp" method="POST">
                    <button type="submit" name="joinValue" value="unjoin" >Unjoin</button>
                </form>
            </c:otherwise>
        </c:choose>
        Comment
        <sql:query var="db3" dataSource="mysql" >
            SELECT * FROM user_event WHERE event_eid = <%= num %>
        </sql:query>
        <c:forEach var="rows" items="${db3.rows}">
            <h4> User: <c:out value="${rows.user_uid} Time:  ${rows.timedate}"/> </h4> <br>
            <c:out value="${rows.message}"/>  <br> <br>
        </c:forEach>
        <form action="CommentUpdate.jsp" method="POST">
        <textarea name="comment" rows="4" cols="20">
        </textarea>
            <button type="submit" name="post" value="" >Post</button>
        </form>
    </body>
</html>
