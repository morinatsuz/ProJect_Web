<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix='sql' uri="http://java.sun.com/jsp/jstl/sql" %>
<%-- 
    Document   : ViewRegistered
    Created on : Apr 28, 2018, 10:30:48 PM
    Author     : Boom
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Registered</title>
    </head>
    <body>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password=""/>
        <% String regis = request.getParameter("regis") ;%>
       
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM student_event se join students s on (se.student_sid = s.sid)
            join users u on (u.uid = s.user_uid) where se.event_eid = <%= regis %>
        </sql:query>
        <h1>Registered Students</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Year</th>
                    <th>First name</th>
                    <th>Last name</th>
                    <th>Registered date</th>
                    
                </tr>
            </thead>
            <tbody>
                <c:forEach var="rows" items="${db.rows}">
                    <tr>
                        <th>${rows.sid}</th>
                        <th>${rows.year}</th>
                        <th>${rows.fname}</th>
                        <th>${rows.lname}</th>
                        <th>${rows.registered_date}</th>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table></body>
</html>
