<%-- 
    Document   : event
    Created on : Apr 17, 2018, 3:50:25 PM
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
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM events
        </sql:query>
        <% String adminCheck = (String) session.getAttribute("type");%>
        <c:set scope="session" var="adminCheck" value="<%= adminCheck%>" ></c:set>
        <%! int count = 1;%>
        <a href="event.jsp"><button type="submit">Home</button></a> 
        <a href="LogoutServlet"><button type="submit">Logout</button></a>
        <a href="ProfileServlet"><button type="submit">Profile</button></a>
        <br>
        <form action="search.jsp" method="POST">
            Search : <input type="text" name="searchText" value="" />

            <button type="submit" name="search" value="searched" >Search</button>
        </form> <br>
        <c:if test="${adminCheck == 'admin'}">
            <form action="CheckServlet" method="POST">
                <button type="submit" name="view" value="manage">Manage Event</button>
                <button type="submit" name="view" value="result">View User</button>
            </form>
        </c:if>
        <table border="1">
            <thead>
                <tr>
                    <th>ชื่อกิจกรรม</th>
                    <th>รายละเอียดกิจกรรม</th>
                    <th>จำนวนคนที่รับสมัคร</th>
                    
                    <th>สถานที่</th>
                    <th>วันที่เริ่มกิจกรรม</th>
                    <th>วันที่จบกิจกรรม</th>
                    <th>เวลาที่ปิดรับสมัคร</th>

                </tr>
            </thead>
            <tbody>

                <c:forEach var="rows" items="${db.rows}">

                    <tr>
                        <td><c:out value="${rows.title}"/> </td>
                        <td><c:out value="${rows.descript}"/> </td>
                        <td><c:out value="${rows.received_no}"/> </td>
                        <td><c:out value="${rows.location}"/></td>
                        <td><c:out value="${rows.start_date}"/></td>
                        <td><c:out value="${rows.end_date}"/> </td>
                        <td><c:out value="${rows.expired_date}"/> </td>
                        <td><form action="CheckServlet">
                                <button type="submit" name="view" value="${rows.eid}">View</button>
                            </form>
                        </td>
                        
                                <td>
                            <c:if test="${adminCheck == 'admin'}">
                                <form action="ViewRegistered.jsp">
                                <button type="submit" name="regis" value="${rows.eid}">View Registered</button>
                                    </form>
                                </c:if>
                            
                                    </td>
                    </tr>          

                </c:forEach>  
            </tbody>
        </table>


    </body>

</html>
