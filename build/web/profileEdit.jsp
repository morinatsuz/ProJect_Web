<%-- 
    Document   : profileEdit
    Created on : Apr 27, 2018, 9:34:32 PM
    Author     : Amp
--%>

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
                    <div class="col-md-10 ml-auto mr-auto">
                        <div class="card card-signup">
                            <h2 class="card-title text-center">แก้ไขโปรไฟล์</h2>
                            <h5 class="text-center">โปรไฟล์ของนักศึกษารหัส <%= num2%></h5>
                            <hr/>
                            <div class="card-body">
                                <div class="row">
                                    <div class='col md-auto'>
                                        <sql:query var="db" dataSource="mysql">
                                            SELECT * FROM students s JOIN users u ON (s.user_uid = u.uid) WHERE s.sid = <%= num2%>
                                        </sql:query>
                                        <c:forEach var="rows" items="${db.rows}">
                                            <form action="ProfileUpdateServlet" method="POST" >
                                                
                                                <label for="age">รหัสนักศึกษา</label><br> <c:out value="${rows.sid}" />
                                                <br><br>
                                                <label for="age">ชื่อจริง</label><br> <c:out value="${rows.fname} ${rows.lname}" />
                                                <br><br>
                                                <label for="age">วันเกิด</label><br> 
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
                                                <br><br>
                                                <label for="age">เพศ</label><br>
                                                <c:choose>
                                                    <c:when test="${rows.sex == 'Female'}">
                                                        <input type="radio" name="sex" value="Male"/> ชาย <input type="radio" name="sex" value="Female" checked="checked"/> หญิง
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="radio" name="sex" value="Male" checked="checked"/> ชาย <input type="radio" name="sex" value="Female"/> หญิง
                                                    </c:otherwise>
                                                </c:choose><br><br>
                                                        

                                                <div class="form-group">
                                                    <label for="age">อายุ</label>
                                                    <input type="text" class="form-control" name="age" value="${rows.age}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="religion">ศาสนา</label>
                                                    <select class="form-control" name="religion">
           <option value="Buddhism">Buddhism</option>
                    <option value="Christianity">Christianity</option>
                    <option value="Islam">Islam</option>
                    <option value="None">None</option>
                    <option value="Other">Other</option>
                                                    </select>
                                                </div>


                                                <div class="form-group">
                                                    <label for="year">ชั้นปี</label>
                                                    <select class="form-control" name="year">
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">ส่วนสูง</label>
                                                    <input type="text" class="form-control" name="height" value="${rows.height}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">น้ำหนัก</label>
                                                    <input type="text" class="form-control" name="weight" value="${rows.weight}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">รอบอก</label>
                                                    <input type="text" class="form-control" name="chest" value="${rows.chest_size}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">รอบเอว</label>
                                                    <input type="text" class="form-control" name="waist" value="${rows.waist_size}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">โรคประจำตัว</label>
                                                    <input type="text" class="form-control" name="disease" value="${rows.congenital_diseases}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">สิ่งที่แพ้</label>
                                                    <input type="text" class="form-control" name="allergy" value="${rows.allergies}">
                                                </div>

                                                <div class="form-group">
                                                    <label for="height">อื่นๆ</label>
                                                    <input type="text" class="form-control" name="other" value="${rows.others}">
                                                </div>

                                                <div class="text-center">
                                                    <button type="submit" name="update" value="updateP" class="btn btn-round btn-outline-success">บันทึกข้อมูล</button>
                                                </div>
                                            </form> 
                                        </c:forEach>
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
