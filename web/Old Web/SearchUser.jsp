<%-- 
    Document   : SearchUser
    Created on : Apr 29, 2018, 6:02:09 AM
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
        <% String checked = request.getParameter("type"); %>
        <% String keyword = request.getParameter("searchText");%>

        <c:set var="checked" value="<%= checked%>" />
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/db_project"
                           user="root"  password="root" />
        <c:if test="${checked == 'name'}">
            <sql:query var="db" dataSource="mysql">
                SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid)
                WHERE CONCAT(u.fname, ' ', u.lname)
                LIKE '%<%= keyword%>%'
            </sql:query>
        </c:if>
        <c:if test="${checked != 'name'}">
            <sql:query var="db" dataSource="mysql">
                SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid)
                WHERE s.<%= checked%>
                LIKE '%<%= keyword%>%'
            </sql:query>
        </c:if>
                
        <a href="event.jsp"><button type="submit" name="view" value="${rows.eid}" >Home</button></a>
        <a href="LogoutServlet"><button type="submit">Logout</button></a> 
        <a href="ProfileServlet"><button type="submit">Profile</button></a> <br>
        <form action="SearchUser.jsp" method="POST">
            Search : <input type="text" name="searchText" value="" />
            <input type="radio" name="type" value="sid" checked="checked"/> รหัสนักศึกษา
            <input type="radio" name="type" value="name" /> ชื่อ นามสกุล
            <input type="radio" name="type" value="birthday" /> วันเกิด
            <input type="radio" name="type" value="sex" /> เพศ
            <input type="radio" name="type" value="age" /> อายุ 
            <input type="radio" name="type" value="religion" /> ศาสนา
            <input type="radio" name="type" value="year" /> ชั้นปี 
            <button type="submit" name="search" value="searched" >Search</button>
        </form>
        <table border="1">
            <thead>
                <tr>
                    <th>รหัสนักศึกษา</th>
                    <th>ชื่อ นามสกุล</th>
                    <th>วันเกิด</th>
                    <th>เพศ</th>
                    <th>อายุ</th>
                    <th>ศาสนา</th>
                    <th>ชั้นปี</th>
                    <th>ส่วนสูง</th>
                    <th>น้ำหนัก</th>
                    <th>รอบอก</th>
                    <th>รอบเอว</th>
                    <th>โรคประจำตัว</th>
                    <th>สิ่งที่แพ้</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="rows" items="${db.rows}">
                    <tr>

                        <td><c:out value="${rows.sid}" /></td>
                        <td><c:out value="${rows.fname} ${rows.lname}" /></td>
                        <td><c:out value="${rows.birthday}" /></td>
                        <td><c:out value="${rows.sex}" /></td>
                        <td><c:out value="${rows.age}" /></td>
                        <td><c:out value="${rows.religion}" /></td>
                        <td><c:out value="${rows.year}" /></td>
                        <td><c:out value="${rows.height}" /></td>
                        <td><c:out value="${rows.weight}" /></td>
                        <td><c:out value="${rows.chest_size}" /></td>
                        <td><c:out value="${rows.waist_size}" /></td>
                        <td><c:out value="${rows.congenital_diseases}" /></td>
                        <td><c:out value="${rows.allergies}" /></td>



                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
