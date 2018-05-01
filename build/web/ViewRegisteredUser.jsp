<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : ViewRegisteredUser
    Created on : Apr 30, 2018, 4:35:34 AM
    Author     : Amp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% int sid = (int)request.getAttribute("usersid"); %>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password=""/>
        
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM students WHERE user_uid = <%= sid %>
        </sql:query>
        <a href="event.jsp"><button type="submit" name="view" value="${rows.eid}" >Home</button></a>
        <a href="LogoutServlet"><button type="submit">Logout</button></a> <br>
        <c:forEach var="rows" items="${db.rows}"> 
            <h3>รหัสนักศึกษา </h3> <c:out value="${rows.sid}"/> <br>
            <h3>วันเกิด </h3>    <c:out value="${rows.birthday}"/> <br>
            <h3>เพศ </h3>    <c:out value="${rows.sex}"/> <br>
            <h3>อายุ </h3>    <c:out value="${rows.age}"/> <br>
            <h3>ศาสนา </h3>    <c:out value="${rows.religion}"/> <br>
            <h3>ชั้นปี </h3>    <c:out value="${rows.year}"/> <br>
            <h3>ส่วนสูง </h3>    <c:out value="${rows.height}"/> <br>
            <h3>น้ำหนัก </h3>    <c:out value="${rows.weight}"/> <br>
            <h3>รอบอก </h3>    <c:out value="${rows.chest_size}"/> <br>
            <h3>รอบเอว </h3>    <c:out value="${rows.waist_size}"/> <br>
            <h3>โรคประจำตัว </h3>    <c:out value="${rows.congenital_diseases}"/> <br>
            <h3>สิ่งที่แพ้ </h3>    <c:out value="${rows.allergies}"/> <br>
            <h3>อื่นๆ </h3>    <c:out value="${rows.others}"/> <br>
        </c:forEach>
    </body>
</html>
