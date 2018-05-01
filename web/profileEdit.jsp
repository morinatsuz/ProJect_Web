<%-- 
    Document   : profileEdit
    Created on : Apr 27, 2018, 9:34:32 PM
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
            SELECT * FROM students WHERE sid = <%= num2%>
        </sql:query>
        <c:forEach var="rows" items="${db.rows}">
            <form action="ProfileUpdateServlet" method="POST" >
                <h3>รหัสนักศึกษา </h3>  <br> <c:out value="${rows.sid}" />
                <h3>วันเกิด </h3>     <br> 
                วัน <select name="bday">
                    <c:forEach var="day" begin="1" end="31">
                        <option value="${day}"><c:out value="${day}"/></option>
                    </c:forEach>
                </select>
                เดือน <select name="bmonth">
                    <c:forEach var="month" begin="1" end="12">
                        <option value="${month}"><c:out value="${month}"/></option>
                    </c:forEach>
                </select>
                ปี <select name="byear">
                    <c:forEach var="year" begin="1960" end="2018">
                        <option value="${year}"><c:out value="${year}"/></option>
                    </c:forEach>
                </select>
                <h3>เพศ </h3>    <br>   <input type="radio" name="sex" value="ชาย" /> ชาย <input type="radio" name="sex" value="หญิง" /> หญิง
                <h3>อายุ </h3>    <br> <input type="text" name="age" value="" />
                <h3>ศาสนา </h3>  <br> <select name="religion">
                    <option value="พุทธ">พุทธ</option>
                    <option value="คริสต์">คริสต์</option>
                    <option value="อิสลาม">อิสลาม</option>
                    <option value="ไม่มี">ไม่มี</option>
                    <option value="อื่นๆ">อื่นๆ</option>
                </select>
                <h3>ชั้นปี </h3>     <br> <select name="year">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <h3>ส่วนสูง </h3>   <br> <input type="text" name="height" value=""/>
                <h3>น้ำหนัก </h3>   <br> <input type="text" name="weight" value=""/>
                <h3>รอบอก </h3>  <br> <input type="text" name="chest" value=""/>
                <h3>รอบเอว </h3>  <br> <input type="text" name="waist" value=""/>
                <h3>โรคประจำตัว </h3> <br> <input type="text" name="disease" value=""/>
                <h3>สิ่งที่แพ้ </h3> <br> <input type="text" name="allergy" value=""/>
                <h3>อื่นๆ </h3> <br> <textarea name="other" rows="5" cols="20" >
                </textarea>
                <button type="submit" name="update" value="updateP">Update</button>
            </form> 
        </c:forEach>
    </body>
</html>
