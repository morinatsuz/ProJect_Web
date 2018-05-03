<%-- 
    Document   : profile
    Created on : Apr 27, 2018, 8:32:56 PM
    Author     : Amp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix='sql' uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Profile - Activist Finder</title>
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

        <% int num2 = (int) session.getAttribute("sid");%>
        <sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://rmtrs.itforge.io:3306/3waydb"
                           user="root"  password="iamsosexy123"/>
        <sql:query var="db" dataSource="mysql">
            SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid) WHERE s.sid = <%= num2%>
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
                                    <div class="avatar">
                                        <img src="${rows.pic_url}" alt="Circle Image" class="img-raised rounded-circle img-fluid">
                                    </div>
                                    <div class="name">
                                        <h2 class="title">${rows.fname} ${rows.lname}</h2>
                                        <h4>รหัสนักศึกษา ${rows.sid}</h4>
                                    </div>
                                    <form action="profileEdit_1.jsp" method="POST">
                                        <button type="submit" name="pEdit" value="edit" class='btn btn-warning btn-round'><i class="material-icons">build</i>แก้ไขโปรไฟล์</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <br><br>
                        <div class="text-center">
                            <table class='table'>
                                <thead>
                                    <tr>
                                        <th scope="col">ชื่อ</th>
                                        <th scope="col">รายละเอียด</th>
                                    </tr>

                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">วันเกิด</th>
                                        <td>${rows.birthday}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">เพศ</th>
                                        <td>${rows.sex}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">อายุ</th>
                                        <td>${rows.age}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">ศาสนา</th>
                                        <td>${rows.religion}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">ชั้นปี</th>
                                        <td>${rows.year}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">ส่วนสูง</th>
                                        <td>${rows.height}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">น้ำหนัก</th>
                                        <td>${rows.weight}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">รอบอก</th>
                                        <td>${rows.chest_size}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">รอบเอว</th>
                                        <td>${rows.waist_size}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">โรคประจำตัว</th>
                                        <td>${rows.congenital_diseases}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">สิ่งที่แพ้</th>
                                        <td>${rows.allergies}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">อื่นๆ</th>
                                        <td>${rows.others}</td>
                                    </tr>
                                </tbody>


                            </table>
                        </div>


                        <div class="container">
                            <div class='text-center'>
                                <br><br>
                                <hr/>
                                <br>
                                <h3 class="title"> กิจกรรมที่เคยเข้าร่วม </h3>
                            </div>
                                
                            <div>
                                
                                
                                <div class="container">
                                    <div class="row">
                                        <sql:query var="db" dataSource="mysql">
                                            SELECT * FROM events e JOIN student_event se ON (e.eid = se.event_eid) WHERE se.student_sid = <%= num2%>
                                        </sql:query>
                                        <c:forEach var="rows" items="${db.rows}">

                                            <div class="col-md-4">
                                                <div class="card mb-4 box-shadow">
                                                    <img class="card-img-top" data-src="holder.js/100px225?theme=thumb&bg=55595c&fg=eceeef&text=Thumbnail" alt="Card image cap">
                                                    <div class="card-body">

                                                        <h4 class="card-text"><b>${rows.title}</b></h4>
                                                        <h6 class="card-text">จัดที่ ${rows.location}</h6>                                  
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