<%-- 
    Document   : schedule
    Created on : Jun 30, 2022, 9:27:33 PM
    Author     : HAICAO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Schedule</title>
        <script>
            function Submit() {
                let form = document.getElementById("schedule_form");
                form.submit();
            }
        </script>
        <link href="css/viewTemplate.css" rel="stylesheet" type="text/css"/>
        <link href="css/nav_template.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <div class="hero">
            <nav>
                <ul>
                    <li><a href="schedule">Home</a></li>
                    <li><a href="list_group">View Classes</a></li>
                    <li>
                        <c:if test="${sessionScope.account ne null}">
                            <a href="logout">Logout</a>
                        </c:if>
                        <c:if test="${sessionScope.account eq null}">
                            <a href="login">Login</a>
                        </c:if>
                    </li>
                </ul>
            </nav> 
        </div>
        <form action="schedule" method="POST" id="schedule_form">
            <div class="table-users">
                <div class="header">Schedule</div>
                <table>
                    <tr>
                        <td>
                            Year: 2022 <br/>
                            Week:
                            <select onchange="Submit()" id="week" name="week_index">
                                <c:forEach items="${sessionScope.weeks}" var="w">
                                    <option  value="${sessionScope.weeks.indexOf(w)}"
                                             <c:forEach var="i" begin="0" end="6">
                                                 <c:if test="${requestScope.date eq w.startDate.plusDays(i)}">
                                                     selected = "selected";
                                                 </c:if>
                                             </c:forEach> >
                                        ${w.startDate.getDayOfMonth()}/${w.startDate.getMonthValue()} To ${w.endDate.getDayOfMonth()}/${w.endDate.getMonthValue()}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>Mon</td>
                        <td>Tue</td>
                        <td>Wed</td>
                        <td>Thu</td>
                        <td>Fri</td>
                        <td>Sat</td>
                        <td>Sun</td>
                    </tr>

                    <tr>
                        <td></td>
                        <c:forEach var="j" begin="0" end="6">
                            <td>${requestScope.week.startDate.plusDays(j).getDayOfMonth()}/${requestScope.week.startDate.plusDays(j).getMonthValue()}</td>
                        </c:forEach>
                    </tr
                    <c:forEach items="${requestScope.slots}" var="slot">
                        <tr>
                            <td>Slot ${slot.slot} </td>
                            <c:forEach var="i" begin="0" end="6">
                                <td>
                                    <c:forEach items="${requestScope.sessions}" var="s">
                                        <c:if test="${s.slot.slot eq slot.slot and requestScope.week.startDate.plusDays(i) eq s.date.toLocalDate()}">
                                            <a 
                                                <c:if test="${s.status ne true}">
                                                    href="attend?sessionID=${s.id}"
                                                </c:if>
                                                <c:if test="${s.status eq true}">
                                                    href="view?sessionID=${s.id}"
                                                </c:if>
                                                >${s.group.subject}</a>  <br/> at ${s.room} <br/> 
                                            <c:if test="${s.status ne true}">
                                                (not yet)
                                            </c:if>
                                            <c:if test="${s.status eq true}">
                                                (attended)
                                            </c:if>
                                        </c:if>
                                    </c:forEach> 
                                </td>

                            </c:forEach>  
                        </tr>
                    </c:forEach>
                </table>
            </div>

        </form>
    </body>

</html>
