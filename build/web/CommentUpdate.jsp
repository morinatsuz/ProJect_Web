<%-- 
    Document   : CommentUpdate
    Created on : Apr 30, 2018, 11:25:05 PM
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
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password="root"/>
        <% int eid = (int) session.getAttribute("view"); %>
        <% int uid = (int) session.getAttribute("uid"); %>
        <% String commentText = request.getParameter("comment");%>
        <sql:update var="db" dataSource="mysql">
            INSERT INTO user_event (user_uid, event_eid, message, timedate)
            VALUES (<%= uid %>, <%= eid%>, '<%= commentText %>', CURRENT_TIMESTAMP)
        </sql:update>
        <c:redirect url="detail_1.jsp"></c:redirect>
    </body>
</html>
