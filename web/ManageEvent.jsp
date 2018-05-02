<%-- 
    Document   : ManageEvent
    Created on : Apr 25, 2018, 9:25:26 AM
    Author     : Boom
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1><a href="event.jsp">HOME</a></h1>
        <% String event_id = request.getParameter("event_id"); %>
        <% String event_action = request.getParameter("event_action"); %>
        <c:set var="event_id" value="${requestScope.event_id}"/>
        <c:set var="event_action" value="${requestScope.event_action}"/>
        <c:set var="etid" value="requestScope.events_type_tid"/>
        <c:if test="${event_action == 'create'}" >
            <h1>Create Event</h1>
        </c:if>
        <c:if test="${event_action == 'edit'}" >
            <h1>Edit Event</h1>
        </c:if> 
        <!--<form action="https://httpbin.org/post" method="POST">-->
        <form action="ManageEventServlet" method="POST">
            #Event ID:<input type="text" name="event_id" value="${requestScope.event_id}" readonly="readonly" /><br>
            #Event type ID:<input type="text" name="events_type_tid" value="${requestScope.events_type_tid}" readonly="readonly" /><br>
            #Event type name:<input type="text" name="" value="${requestScope.event_type_name}" readonly="readonly" /><br>
            #Creator ID:<input type="text" name="admins_aid" value="${requestScope.admins_aid}" readonly="readonly" /><br>
            #Creator name: <input type="text" name="" value="${requestScope.fullname}" readonly="readonly"/><br>
            #Registered Now:<input type="text" name="registered_no" value="${requestScope.registered_no}" readonly="readonly" /><br>
            Title:<input type="text" name="title" value="${requestScope.title}" /><br>
            Description:<br>
            <textarea name="descript" rows="4" cols="20">${requestScope.descript}</textarea><br>
            Registered limit:<input type="text" name="received_no" value="${requestScope.received_no}" /><br>
            Location:<br>
            <textarea name="location" rows="4" cols="20">${requestScope.location}</textarea><br>
            Start:<input type="text" name="start_date" value="${requestScope.start_date}" />
            Time<input type="text" name="start_time" value="${requestScope.start_time}" /><br>
            End:<input type="text" name="end_date" value="${requestScope.end_date}" />
            Time:<input type="text" name="end_time" value="${requestScope.end_time}" /><br>
            Closed date<input type="text" name="expired_date" value="${requestScope.expired_date}" />
            Time: <input type="text" name="expired_time" value="${requestScope.expired_time}" /><br>
            Google Maps URL:<input type="text" name="gmap_url" value="${requestScope.gmap_url}" /><br>
            Event Type:
            <c:set var="count" value="0" scope="page" />
            <select name="event_type_tid">
                <c:forEach var="type" items="${requestScope.event_types}">
                    <c:set var="count" value="${count + 1}" scope="page"/>
                    <option value="${count}">${count}. ${type}</option>
                </c:forEach> 
            </select><br>
            Picture URL: <input type="text" name="pic_url" value="${requestScope.pic_url}" />
            <br><br>
            <c:if test="${event_action == 'create'}" >
                <button type="submit" name="event_action" value="Create" >Confirm </button>
            </c:if>
            <c:if test="${event_action == 'edit'}" >
                <input type="submit" name="event_action" value="Save" />
                <input type="submit" name="event_action" value="Delete" />
            </c:if> 
        </form>
    </body>
</html>
