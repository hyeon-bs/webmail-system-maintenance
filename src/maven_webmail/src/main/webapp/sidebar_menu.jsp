<%-- 
    Document   : sidebar_menu.jsp
    Author     : jongmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cse.maven_webmail.control.CommandType" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>웹메일 시스템 메뉴</title>
    </head>
    <body>
        <br> <br>

        <span style="color: indigo"> <b>사용자: <%= session.getAttribute("userid")%> </b> </span> <br>

        <p> <a href="main_menu.jsp"> 메일 읽기 </a> </p>
        <p> <a href="sent_menu.jsp"> 보낸 메일함 </a> </p>
        <p> <a href="write_mail.jsp"> 메일 쓰기 </a> </p>
        <p> <a href="addrbook.jsp"> 주소록 보기 </a> </p>
        <p> <a href="change_pw.jsp"> 비밀번호 변경 </a> </p>
        <p> <a href="new_delete_user.jsp"> 회원 탈퇴 </a> </p>
        <p><a href="Login.do?menu=<%= CommandType.LOGOUT%>">로그아웃</a></p>
    </body>
</html>
