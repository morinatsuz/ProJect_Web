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
        <% request.setCharacterEncoding("UTF-8"); %>
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
                        <a class="navbar-brand" href="/presentation.html">Activist Finder</a>
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
                        </div>
                        <div class="row">
                            <div class="col-md-6 ml-auto mr-auto">
                                <div class="profile-tabs">
                                    <ul class="nav nav-pills nav-pills-icons justify-content-center" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" href="#studio" role="tab" data-toggle="tab">
                                                <i class="material-icons">camera</i> Studio
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#works" role="tab" data-toggle="tab">
                                                <i class="material-icons">palette</i> Work
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="#favorite" role="tab" data-toggle="tab">
                                                <i class="material-icons">favorite</i> Favorite
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content tab-space">
                            <div class="tab-pane active text-center gallery" id="studio">
                                <div class="row">
                                    <div class="col-md-3 ml-auto">
                                        <img src="../assets/img/kit/free/examples/studio-1.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/studio-2.jpg" class="rounded">
                                    </div>
                                    <div class="col-md-3 mr-auto">
                                        <img src="../assets/img/kit/free/examples/studio-5.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/studio-4.jpg" class="rounded">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane text-center gallery" id="works">
                                <div class="row">
                                    <div class="col-md-3 ml-auto">
                                        <img src="../assets/img/kit/free/examples/olu-eletu.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/clem-onojeghuo.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/cynthia-del-rio.jpg" class="rounded">
                                    </div>
                                    <div class="col-md-3 mr-auto">
                                        <img src="../assets/img/kit/free/examples/mariya-georgieva.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/clem-onojegaw.jpg" class="rounded">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane text-center gallery" id="favorite">
                                <div class="row">
                                    <div class="col-md-3 ml-auto">
                                        <img src="../assets/img/kit/free/examples/mariya-georgieva.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/studio-3.jpg" class="rounded">
                                    </div>
                                    <div class="col-md-3 mr-auto">
                                        <img src="../assets/img/kit/free/examples/clem-onojeghuo.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/olu-eletu.jpg" class="rounded">
                                        <img src="../assets/img/kit/free/examples/studio-1.jpg" class="rounded">
                                    </div>
                                </div>
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

