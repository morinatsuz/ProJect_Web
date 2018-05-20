<%-- 
    Document   : detail
    Created on : Apr 17, 2018, 8:26:57 PM
    Author     : Amp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix='sql' uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Main - Activist Finder</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

        <!--     Fonts and icons     -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <!-- Material Kit CSS -->
        <link rel="stylesheet" href="static/css/material-kit.css">

    </head>
    <body class="profile-page">
        <% request.setCharacterEncoding("UTF-8");%>
        
        <% String adminCheck = (String) session.getAttribute("type"); %>
        <% int num = (int) session.getAttribute("view"); %>
        <% int num2 = (int) session.getAttribute("sid");%>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://rmtrs.itforge.io:3306/3waydb"
                           user="root"  password="iamsosexy123"/>
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM events WHERE eid = <%= num%>
        </sql:query>
        <c:set scope="session" var="adminCheck" value="<%= adminCheck%>" ></c:set>
            <nav class="navbar navbar-color-on-scroll navbar-transparent fixed-top  navbar-expand-lg " color-on-scroll="50" bg-warning">
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
                                <a class="dropdown-item" href="#">กิจกรรมที่เข้าร่วม</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">ดูโปรไฟล์</a>
                                <a class="dropdown-item" href="#">แก้ไขโปรไฟล์</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="LogoutServlet">ออกจากระบบ</a>
                            </div>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>




        <div class="page-header header-filter" data-parallax="true" style=" background-image: url('static/img/itkmitl-panorama-1.jpg'); ">
        </div>

        <div class="main main-raised">
            <div class="profile-content">
                <c:forEach var="rows" items="${db.rows}">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 ml-auto mr-auto">
                                <div class="profile">
                                    <div class="name">
                                        <br><br><br><br>
                                        <h2 class="title">${rows.title}</h2>
                                        <h4>จัดที่ ${rows.location}</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="description text-center">
                            <p>${rows.descript}</p>
                            <sql:query var="db2" dataSource="mysql" >
                                SELECT * FROM student_event WHERE student_sid = <%= num2%> AND event_eid = <%= num%>
                            </sql:query>
                            <c:choose>
                                <c:when test="${db2.rowCount == 0}">
                                    <sql:query var="db3" dataSource="mysql" >
                                        SELECT registered_no, received_no FROM events WHERE eid = <%= num%>
                                    </sql:query>
                                    <c:forEach var="rows" items="${db3.rows}">

                                        <c:if test="${rows.registered_no != rows.received_no}">
                                            <form action="join.jsp" method="POST">
                                                <button type="submit" name="joinValue" value="join" class="btn btn-success btn-round btn-lg"> 
                                                    <i class="material-icons">pan_tool</i>  เข้าร่วมกิจกรรม
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${rows.registered_no == rows.received_no}">
                                            <button type="button" class="btn btn-lg btn-warning btn-round" disabled>ผู้สมัครครบตามจำนวนแล้ว</button> <br> <br>
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <form action="join.jsp" method="POST">
                                        <button type="submit" name="joinValue" value="unjoin" class="btn btn-danger btn-round btn-lg" >ยกเลิกการเข้าร่วม</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>


                        <div class="container">
                            <div class="text-center">
                                <br><br>
                                <hr/>
                                <br>
                                <h3 class="title"> กระดานข้อความ </h3>
                            </div>
                            <div class="row-10">

                                <div class="card mb-10 box-shadow">
                                    <div class="card-body">
                                        <h4 class="card-text"><b>แสดงความคิดเห็นของคุณที่นี่</b></h4>
                                        <form action="CommentUpdate.jsp" method="POST">
                                            <div class="form-group">
                                                <label for="exampleInput1" class="bmd-label-floating">เขียนความเห็นของคุณ...</label>
                                                <input type="text" name="comment" class="form-control">

                                            </div>
                                            <button type="submit" name="post" class="btn btn-warning">ส่งข้อความ</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="row-10">

                                    <sql:query var="db3" dataSource="mysql" >
                                        SELECT * FROM user_event ue JOIN users u ON (u.uid = ue.user_uid)  WHERE ue.event_eid = <%= num%>
                                    </sql:query>
                                    <c:forEach var="rows" items="${db3.rows}">

                                        <div class="card mb-10 box-shadow">
                                            <div class="card-body">
                                                <h4 class="card-text">${rows.message}</h4>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <small class="text-muted">${rows.fname} ${rows.lname}</small>
                                                </div>
                                            </div>
                                        </div>

                                    </c:forEach>
                                    <br><br><br>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>


            <!--   Core JS Files   -->
            <script src="static/js/core/jquery.min.js"></script>
            <script src="static/js/core/popper.min.js"></script>
            <script src="static/js/bootstrap-material-design.js"></script>

            <!-- Plugin for Date Time Picker and Full Calendar Plugin-->
            <script src="static/js/plugins/moment.min.js"></script>

            <!-- Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select -->
            <script src="static/js/plugins/bootstrap-selectpicker.js"></script>

            <!-- Plugin for Tags, full documentation here: http://xoxco.com/projects/code/tagsinput/  -->
            <script src="static/js/plugins/bootstrap-tagsinput.js"></script>

            <!-- Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
            <script src="static/js/plugins/jasny-bootstrap.min.js"></script>

            <!-- Plugin for Small Gallery in Product Page -->
            <script src="static/js/plugins/jquery.flexisel.js"></script>

            <!-- Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
            <script src="static/js/plugins/bootstrap-datetimepicker.min.js"></script>

            <!-- Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
            <script src="static/js/plugins/nouislider.min.js"></script>

            <!-- Material Kit Core initialisations of plugins and Bootstrap Material Design Library -->
            <script src="static/js/material-kit.js?v=2.0.0"></script>

            <script src="static/js/plugins/holder.min.js"></script>

    </body >
</html>

