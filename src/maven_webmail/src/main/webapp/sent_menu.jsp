<%-- 
    Document   : main_menu.jsp
    Author     : jongmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<jsp:useBean id="send" scope="page" class="cse.maven_webmail.model.SentAgent" />
<%
            //String pageno = (String) request.getParameter("pageno");
            //if (pageno != null) {
            //    session.setAttribute("pageno", pageno);
            //}
            send.setHost((String) session.getAttribute("host"));
            send.setUserid((String) session.getAttribute("userid"));
            send.setPassword((String) session.getAttribute("password"));
            //pop3.setPageno((int)Integer.parseInt((String)session.getAttribute("pageno")));
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>보낸 메일함</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div id="sidebar">
            <jsp:include page="sidebar_menu.jsp" />
        </div>

        <div id="main">
            <%= send.getMessageList() %>
        </div>

        <jsp:include page="footer.jsp" />

    </body>
</html>
