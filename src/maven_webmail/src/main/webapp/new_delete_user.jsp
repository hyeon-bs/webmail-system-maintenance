<%-- 
    Document   : delete_user.jsp
    Author     : jongmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cse.maven_webmail.control.CommandType" %>
<%@page import="cse.maven_webmail.model.UserAdminAgent" %>

<!DOCTYPE html>

<script type="text/javascript">
    <!--
    function getConfirmResult() {
        var result = confirm("정말로 탈퇴하시겠습니까?");
        return result;
    }
-->
</script>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>사용자 제거 화면</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div id="sidebar">
            <%-- 사용자 추가때와 동일하므로 같은 메뉴 사용함. --%>
            <jsp:include page="sidebar_admin_previous_menu.jsp" />
        </div>

        <div id="main">
            <h2> <%= session.getAttribute("userid")%>님, 체크 후 탈퇴를 눌러주세요. </h2> <br>

            <!-- 아래 코드는 위와 같이 Java Beans와 JSTL을 이용하는 코드로 바꾸어져야 함 -->
            <%
                UserAdminAgent agent = new UserAdminAgent("localhost", 4555);
            %>
            <form name="DeleteUser" action="UserAdmin_test.do?menu=<%=CommandType.DELETE_USER_COMMAND%>"
                  method="POST">
                <%

                    out.print("<input type=checkbox name=\"selectedUsers\" value=\"" + session.getAttribute("userid") + "\" required/>");
                    out.println(session.getAttribute("userid") + " <br>");

                %>
                <br>
                <input type="submit" value="탈퇴" name="delete_command" onClick ="return getConfirmResult() % >"/>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>
