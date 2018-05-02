<%-- 
    Document   : profile
    Created on : Apr 27, 2018, 8:32:56 PM
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
        <% int num2 = (int) session.getAttribute("sid");%>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password="root"/>
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid) WHERE s.sid = <%= num2%>
        </sql:query>
        <a href="event.jsp"><button type="submit" name="view" value="${rows.eid}" >Home</button></a>
        <a href="LogoutServlet"><button type="submit">Logout</button></a> 
        <a href="ProfileServlet"><button type="submit">Profile</button></a> <br>
        <c:forEach var="rows" items="${db.rows}"> 
            <h3>รหัสนักศึกษา </h3> <c:out value="${rows.sid}"/> <br>
            <h3>ชื่อจริง นามสกุล </h3> <c:out value="${rows.fname} ${rows.lname}"/> <br>
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
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM events e JOIN student_event se ON (e.eid = se.event_eid) WHERE se.student_sid = <%= num2%>
        </sql:query>
        <h3>กิจกรรมที่เคยเข้าร่วม</h3> <c:out value="${rows.others}"/>
        <c:forEach var="rows" items="${db.rows}">
            <form action="CheckServlet">
                <c:out value="${rows.title}"/> <button type="submit" name="view" value="${rows.eid}">View</button>
            </form>
        </c:forEach>
        <br>
        <form action="profileEdit.jsp" method="POST">
            <button type="submit" name="pEdit" value="edit">Edit Profile</button>
        </form>
    </body>
</html>
