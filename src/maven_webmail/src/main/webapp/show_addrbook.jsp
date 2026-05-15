<%-- 
    Document   : show_addrbook
    Created on : 2019. 6. 3., 오후 1:34:33
    Author     : jiwon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib tagdir="/WEB-INF/tags/" prefix="mytags"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />

    </head>
    <a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)"> 
    ※주소록 보기
    <body>
        </a><div style="DISPLAY: none">
        <c:catch var="errorReason">
            <mytags:addrbook user="jdbctester" password="bsh7336" schema="webmail" table="addrbook"/>
        </c:catch>
        ${empty errorReason ?"<noerror/>" : errorReason}<!--오류 원인 출력 -->        
        <br/>
        </div>
    </body>
</html>