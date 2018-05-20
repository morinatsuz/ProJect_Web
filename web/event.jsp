<%-- 
    Document   : event
    Created on : Apr 17, 2018, 3:50:25 PM
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
    <body class="landing-page">
        <% request.setCharacterEncoding("UTF-8");%>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://rmtrs.itforge.io:3306/3waydb"
                           user="root"  password="iamsosexy123"/>
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM events
        </sql:query>

        <% String adminCheck = (String) session.getAttribute("type");%>
        <c:set scope="session" var="adminCheck" value="<%= adminCheck%>" ></c:set>
        <% int num2 = (int) session.getAttribute("sid");%>
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
                                    <a class="dropdown-item" href="#">                                            <form action="CheckServlet" method="POST">
                                            <button class="btn btn-warning" type="submit" name="view" value="manage">จัดการกิจกรรม</button>
                                        </form></a>

                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="ViewUser.jsp">จัดการสมาชิก</a>
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




        <div class="page-header header-filter" data-parallax="true" style=" background-image: url('static/img/itkmitl-panorama-1.jpg'); ">
            <div class="container">
                <h1>ค้นหากิจกรรมของคุณง่ายๆแค่ปลายนิ้ว</h1>
                </br>
                <p> ทำให้การเข้าร่วมกิจกรรมเป็นเรื่องง่าย เพียงลงชื่อเข้าใช้ด้วยรหัสนักศึกษาของคุณ และเลือกลงทะเบียนกับกิจกรรมมากมายที่รอคุณอยู่</p>
                <p>
                    <br>
                <form action="search.jsp" method="POST">
                    <div class="row">
                        <div class="col-10">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="material-icons">search</i>
                                    </span>
                                </div>
                                <input type="text" name="searchText" class="form-control" placeholder="เช่น กิจกรรมคณะไอที...">&nbsp;&nbsp;&nbsp;
                                <button type="submit" name="search" value="searched" class="btn btn-white btn-raised btn-fab btn-fab-mini btn-round">
                                    <i class="material-icons">trending_flat</i>
                                </button>
                            </div>                     
                        </div>
                    </div>
                </form>
            </div>

        </div>


        <div class="main main-raised">


            <div class="container">
                <div class="row">
                    <c:forEach var="rows" items="${db.rows}">
                        <sql:query var="db2" dataSource="mysql" >
                            SELECT * FROM student_event WHERE student_sid = <%= num2%> AND event_eid = <c:out value="${rows.eid}"/>
                        </sql:query>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">

                                
<!--                                    <img class="card-img-top" data-src="${rows.pic_url}" alt="Card image cap">-->
                                
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${db2.rowCount == 0}">
                                            <span class="badge badge-pill badge-danger">ยังไม่สมัคร</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-pill badge-success">สมัครแล้ว</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <h4 class="card-text"><b>${rows.title}</b></h4>
                                    <h6 class="card-text">จัดที่ ${rows.location} | สมัครแล้ว ${rows.registered_no}/${rows.received_no} คน</h6>                                  
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <form action="CheckServlet">
                                                <button type="submit" name="view" class="btn btn-sm btn-outline-secondary" value="${rows.eid}">ดูรายละเอียด</button>
                                            </form>
                                        </div>
                                        <small class="text-muted">${rows.end_date}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
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
