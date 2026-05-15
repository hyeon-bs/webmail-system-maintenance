<%-- 
    Document   : delete_form
    Created on : 2019. 5. 30., 오후 11:33:02
    Author     : jiwon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>주소록 삭제</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <h1>주소록 삭제</h1>
        <form action="delete.do" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>이메일</td>
                        <td><input type="text" name="email" size="20 /"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                <center>
                    <input type="submit" value="삭제" />
                </center>
                </td>
                </tr>
                </tbody>
            </table>
        </form>
        <jsp:include page="footer.jsp" />
    </body>
</html>
