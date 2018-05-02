<%-- 
    Document   : event
    Created on : Apr 17, 2018, 3:50:25 PM
    Author     : Amp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix='sql' uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<!doctype html>
<html lang="en">
    <head>
        <title>Hello, world!</title>
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
        <nav class="navbar navbar-color-on-scroll navbar-transparent fixed-top  navbar-expand-lg " color-on-scroll="50" bg-warning">
             <div class="container">
                <div class="navbar-translate">
                    <a class="navbar-brand" href="/presentation.html">Activist Finder</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        <span class="navbar-toggler-icon"></span>
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse">

                    <ul class="navbar-nav ml-auto">


                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="material-icons">dashboard</i>
                                จัดการ
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                <a class="dropdown-item" href="#">สร้างกิจกรรม</a>
                                <a class="dropdown-item" href="#">จัดการกิจกรรม</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">จัดการสมาชิก</a>
                            </div>
                        </li>


                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="material-icons">account_circle</i>
                                โปรไฟล์
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                <a class="dropdown-item" href="#">กิจกรรมที่เข้าร่วม</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">ดูโปรไฟล์</a>
                                <a class="dropdown-item" href="#">แก้ไขโปรไฟล์</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">ออกจากระบบ</a>
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
                <form>
                    <div class="row">
                        <div class="col-10">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="material-icons">search</i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" placeholder="เช่น กิจกรรมคณะไอที...">&nbsp;&nbsp;&nbsp;
                                <button type="submit" class="btn btn-white btn-raised btn-fab btn-fab-mini btn-round">
                                    <i class="material-icons">trending_flat</i>
                                </button>
                            </div>

                            </form>
                            </p>
                        </div>
                    </div>
            </div>

        </div>


        <div class="main main-raised">


            <div class="container">

                <div class="row">
                    <c:forEach var="event" items="${db.rows}">
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <img class="card-img-top" data-src="holder.js/100px225?theme=thumb&bg=55595c&fg=eceeef&text=Thumbnail" alt="Card image cap">
                                <div class="card-body">
                                    <h4 class="card-text">${event.title}</h4>
                                    <h6 class="card-text">จัดที่ ${event.location}</h6>
                                    <p class="card-text">${event.descript}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <form action="CheckServlet">
                                            <button type="submit" name="view" class="btn btn-sm btn-outline-secondary" value="${rows.eid}">ดูรายละเอียด</button>
                                            </form>
                                        </div>
                                        <small class="text-muted">${event.end_date}</small>
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
