<%-- 
    Document   : addrbook
    Created on : 2019. 5. 25., 오후 11:24:11
    Author     : jiwon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib tagdir="/WEB-INF/tags/" prefix="mytags"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>주소록</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <h1>주소록 관리</h1>                
        <a href="main_menu.jsp"><img src="home.png">home</a>

            
        <br/>
        <c:catch var="errorReason">
            <mytags:addrbook user="jdbctester" password="bsh7336" schema="webmail" table="addrbook"/>
        </c:catch>
        ${empty errorReason ?"<noerror/>" : errorReason}<!--오류 원인 출력 -->        
        <br/>
        <a href="insert_form.jsp">주소록 추가</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="delete_form.jsp">주소록 삭제</a>
        <jsp:include page="footer.jsp" />
    </body>
</html>