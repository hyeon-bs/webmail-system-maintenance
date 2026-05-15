<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="cse.maven_webmail.control.CommandType"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>암호변경</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    </head>
    <body>
        <%@include file="header.jspf"%>
        <div id="main">
            현재 자신의 ID와 암호를 입력하고 변경할 암호를 입력하시오. <br> <br>

            <form method="POST" action="pwchange.jsp">
                <table border="0" align="center">
                    <tr>
                        <td>ID</td>
                        <td> <input type="text" name="userid" value="" size="20" />  </td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td> <input type="password" name="password" value="" size="20"/> </td>
                    </tr>
                    <tr>
                        <td>변경 할 비밀번호</td>
                        <td><input type="password" name="change_pw" value="" size="20"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="변경" name="change" />
                            <input type="reset" value="초기화" name="reset" />
                        </td>
                    </tr>
                </table>

            </form>
        </div>

        <!--초기화면으로 되돌아갈 페이지 설정.-->
        <div id="back"></div>
        <a href="sidebar_menu.jsp" title="되돌아가기">되돌아가기</a>을 선택해 주세요.
    </div>

    <%@include file="footer.jspf"%>

</body>
</html>
