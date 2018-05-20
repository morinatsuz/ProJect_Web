<%-- 
    Document   : SearchUser
    Created on : Apr 29, 2018, 6:02:09 AM
    Author     : Amp
--%>

<%@page import="utils.Validator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix='sql' uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <!-- Favicons -->
        <link rel="apple-touch-icon" href="../assets/img/kit/free/apple-icon.png">
        <link rel="icon" href="../assets/img/kit/free/favicon.png">
        <title>
            Signup &#45; Material Kit by Creative Tim
        </title>
        <!--     Fonts and icons     -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
        <link rel="stylesheet" href="static/css/material-kit.css?v=2.0.2">
        <!-- Documentation extras -->
        <!-- iframe removal -->
    </head>

    <body class="signup-page ">
        <% 
            if (!Validator.authorize(request, "admin")) {
                response.sendError(403);
                return;
            }
        %>
        <% request.setCharacterEncoding("UTF-8");%>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://rmtrs.itforge.io:3306/3waydb"
                           user="root"  password="iamsosexy123"/>
        <% String regis = request.getParameter("regis");%>
        <% request.setCharacterEncoding("UTF-8"); %>
        <% String checked = request.getParameter("type"); %>
        <% String keyword = request.getParameter("searchText");%>
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid)
        </sql:query>
        <% String adminCheck = (String) session.getAttribute("type");%>
        <c:set scope="session" var="adminCheck" value="<%= adminCheck%>" ></c:set>
        <% int num2 = (int) session.getAttribute("sid");%>
        
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
        <nav class="navbar navbar-color-on-scroll fixed-top  navbar-expand-lg " color-on-scroll="100" bg-warning">
             <div class="container">
                <div class="navbar-translate">
                    <a class="navbar-brand" href="event.jsp">Activist Finder</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        <span class="navbar-toggler-icon"></span>
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse">

                    <ul class="navbar-nav ml-auto">

                        <c:if test="${adminCheck == 'admin'}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="material-icons">dashboard</i>
                                    แผงควบคุม
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="#">สร้างกิจกรรม</a>
                                    <a class="dropdown-item" href="#">จัดการกิจกรรม</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">จัดการสมาชิก</a>
                                </div>
                            </li>
                        </c:if>


                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="material-icons">account_circle</i>
                                สวัสดี, <%= num2%>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                <a class="dropdown-item" href="profile.jsp">ดูโปรไฟล์</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="LogoutServlet">ออกจากระบบ</a>
                            </div>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>
        <div class="page-header header-filter" filter-color="purple" style="background-image: url('static/img/itkmitl-panorama-1.jpg'); background-size: cover; background-position: top center;">
            <div class="container">
                <div class="row">
                    <div class="col-md-14 ml-auto mr-auto">
                        <div class="card card-signup">



                            <div class="card-body">
                                <h2 class="card-title">จัดการสมาชิก</h2>
                                <h4> ผลการค้นหา | <a href="ViewUser.jsp">แสดงรายชื่อทั้งหมด</a></h4>
                                <br>
                                <form action="SearchUser.jsp" method="POST">
                                   

                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="material-icons">search</i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" name="searchText" placeholder="ค้นหาผู้ใช้">
                                        <button type="submit" name="search" value="searched" class="btn btn-warning btn-sm" >ค้นหา</button>
                                    </div>
                                    <br>
                                    
                                    <b>ฟิลเตอร์</b> &nbsp;&nbsp;&nbsp;&nbsp;

                                    <input type="radio" name="type" value="sid" checked="checked"/> รหัสนักศึกษา&nbsp;
                                    <input type="radio" name="type" value="name" /> ชื่อ นามสกุล&nbsp;
                                    <input type="radio" name="type" value="birthday" /> วันเกิด&nbsp;
                                    <input type="radio" name="type" value="sex" /> เพศ&nbsp;
                                    <input type="radio" name="type" value="age" /> อายุ &nbsp;
                                    <input type="radio" name="type" value="religion" /> ศาสนา&nbsp;
                                    <input type="radio" name="type" value="year" /> ชั้นปี &nbsp;
                                    
                                </form>

                                <br>
                                <br>

                                <div class="row">
                                    <div class='col align-middle'>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col">รหัสนักศึกษา</th>
                                                    <th scope="col">ชื่อ</th>
                                                    <th scope="col">วันเกิด</th>
                                                    <th scope="col">เพศ</th>
                                                    <th scope="col">อายุ</th>
                                                    <th scope="col">ศาสนา</th>
                                                    <th scope="col">ชั้นปี</th>
                                                    <th scope="col">ส่วนสูง</th>
                                                    <th scope="col">น้ำหนัก</th>
                                                    <th scope="col">รอบอก</th>
                                                    <th scope="col">รอบเอว</th>
                                                    <th scope="col">โรคประจำตัว</th>
                                                    <th scope="col">สิ่งที่แพ้</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="rows" items="${db.rows}">
                                                    <tr>
                                                        <th scope="row">${rows.sid}</th>

                                                        <td>${rows.fname} ${rows.lname}</td>
                                                        <td>${rows.birthday}</td>
                                                        <td>${rows.sex}</td>
                                                        <td>${rows.age}</td>
                                                        <td>${rows.religion}</td>
                                                        <td>${rows.year}</td>
                                                        <td>${rows.height}</td>
                                                        <td>${rows.weight}</td>
                                                        <td>${rows.chest_size}</td>
                                                        <td>${rows.waist_size}</td>
                                                        <td>${rows.congenital_diseases}</td>
                                                        <td>${rows.allergies}</td>
                                                    </tr>
                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--   Core JS Files   -->
        <script src="static/js/core/jquery.min.js"></script>
        <script src="static/js/core/popper.min.js"></script>
        <script src="static/js/bootstrap-material-design.js"></script>
        <!--  Plugin for Date Time Picker and Full Calendar Plugin  -->
        <script src="static/js/plugins/moment.min.js"></script>
        <!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
        <script src="static/js/plugins/bootstrap-datetimepicker.min.js"></script>
        <!--	Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
        <script src="static/js/plugins/nouislider.min.js"></script>
        <!-- Material Kit Core initialisations of plugins and Bootstrap Material Design Library -->
        <script src="static/js/material-kit.js?v=2.0.2"></script>
        <!-- Fixed Sidebar Nav - js With initialisations For Demo Purpose, Don't Include it in your project -->
        <script src="static/assets-for-demo/js/material-kit-demo.js"></script>
    </body>

</html>
