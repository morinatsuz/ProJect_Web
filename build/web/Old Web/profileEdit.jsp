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
            SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid) WHERE s.sid = <%= num2%>
        </sql:query>
        <c:forEach var="rows" items="${db.rows}">
            <form action="ProfileUpdateServlet" method="POST" >
                <h3>รหัสนักศึกษา </h3>  <br> <c:out value="${rows.sid}" />
                <h3>ชื่อจริง นามสกุล </h3>  <br> <c:out value="${rows.fname} ${rows.lname}" />
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
                <h3>เพศ </h3>    <br>
                <c:choose>
            <c:when test="${rows.sex == 'Female'}">
                <input type="radio" name="sex" value="Male"/> Male <input type="radio" name="sex" value="Female" checked="checked"/> Female
            </c:when>
            <c:otherwise>
                <input type="radio" name="sex" value="Male" checked="checked"/> Male <input type="radio" name="sex" value="Female"/> Female
            </c:otherwise>
        </c:choose>
                <h3>อายุ </h3>    <br> <input type="text" name="age" value="${rows.age}" />
                <h3>ศาสนา </h3>  <br> <select name="religion">
                    <option value="Buddhist">Buddhist</option>
                    <option value="Christianity">Christianity</option>
                    <option value="Islam">Islam</option>
                    <option value="None">None</option>
                    <option value="Other">Other</option>
                </select>
                <h3>ชั้นปี </h3>     <br> <select name="year">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <h3>ส่วนสูง </h3>   <br> <input type="text" name="height" value="${rows.height}}"/>
                <h3>น้ำหนัก </h3>   <br> <input type="text" name="weight" value="${rows.weight}"/>
                <h3>รอบอก </h3>  <br> <input type="text" name="chest" value="${rows.chest_size}"/>
                <h3>รอบเอว </h3>  <br> <input type="text" name="waist" value="${rows.waist_size}"/>
                <h3>โรคประจำตัว </h3> <br> <input type="text" name="disease" value="${rows.congenital_diseases}"/>
                <h3>สิ่งที่แพ้ </h3> <br> <input type="text" name="allergy" value="${rows.allergies}"/>
                <h3>อื่นๆ </h3> <br> <textarea name="other" rows="5" cols="20" >
                </textarea>
                <button type="submit" name="update" value="updateP">Update</button>
            </form> 
        </c:forEach>
    </body>
</html>
