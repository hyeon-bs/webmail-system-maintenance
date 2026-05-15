<%--
    Document   : index.jsp
    Author     : jongmin
    Description:
        본 프로젝트의 목적은 SMTP/POP3를 사용하는 메일서버에 웹메일 인터페이스를 제공하여
        웹메일 시스템으로 사용할 수 있게 해주는데 있다.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cse.maven_webmail.control.CommandType"%>

<!DOCTYPE html>

<%
    if (session.isNew()) {
        session.setAttribute("host", "127.0.0.1");   // should be modified if you change the POP3 server
        session.setAttribute("debug", "false");
        //session.setAttribute("pageno", "1");
        //session.setMaxInactiveInterval(session.getMaxInactiveInterval() * 2);
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>로그인 화면</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />

        <script type="text/javascript">
            function checkCapsLock(e) {

                var myKeyCode = 0;
                var myShiftKey = false;
                var myMsg = 'Caps Lock를 누른 상태에서는 비밀번호를 입력하실 수 없습니다. Caps Lock을 해제해주세요.';
                if (document.all) {
                    myKeyCode = e.keyCode;
                    myShiftKey = e.shiftKey;
                    // Netscape 4
                } else if (document.layers) {
                    myKeyCode = e.which;
                    myShiftKey = (myKeyCode == 16) ? true : false;
                    // Netscape 6
                } else if (document.getElementById) {
                    myKeyCode = e.which;
                    myShiftKey = (myKeyCode == 16) ? true : false;
                }
                if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
                    alert(myMsg);
                    return false;

                } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
                    alert(myMsg);
                    return false;
                }
            }
        </script>

    </head>
    <body>
        <%-- <jsp:include page="header.jspf" /> --%>
        <%@include file="header.jspf"%>


        <div id="login_form">
            <form method="POST" action="Login.do?menu=<%= CommandType.LOGIN%>"> <!--307p--> 
                사용자: <input type="text" name="userid" size="20" required> <br />
                암&nbsp;&nbsp;&nbsp;호: <input type="password" name="passwd" size="20" required onKeyPress="return checkCapsLock(event)"> <br /> <br />



                <input type="submit" value="로그인" name="B1">&nbsp;&nbsp;&nbsp;
                <input type="reset" value="다시 입력" name="B2">

                <a href="new_user.jsp"><br>회원 가입<br></a>
            </form>
        </div>


        <%@include file="footer.jspf"%>
        <%-- <jsp:include page="footer.jspf" /> --%>

    </body>
</html>
