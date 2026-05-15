<%-- 
    Document   : add_user.jsp
    Author     : jongmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cse.maven_webmail.control.CommandType" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>사용자 추가 화면</title>
        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
        <script  type="text/javascript">
            function isSame() {
            if (pw.length < 1 || pw.length > 16) {
            document.getElementById('pw').value=document.getElementById('pwCheck').value='';
            document.getElementById('same').innerHTML='';
            }
            if(document.getElementById('pw').value!='' && document.getElementById('pwCheck').value!='') {
            if(document.getElementById('pw').value==document.getElementById('pwCheck').value) {
            document.getElementById('same').innerHTML='비밀번호가 일치합니다.';
            document.getElementById('same').style.color='blue';
            }
            else {
            document.getElementById('same').innerHTML='비밀번호가 일치하지 않습니다. 다시 확인해주세요.';
            document.getElementById('same').style.color='red';
            }
            }
            }
        </script>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div id="sidebar">
            <jsp:include page="sidebar_admin_previous_menu.jsp" />
        </div>

        <div id="main">
            추가로 등록할 사용자 ID와 암호를 입력해 주시기 바랍니다. <br> <br>

            <form name="AddUser" action="UserAdmin.do?menu=<%= CommandType.ADD_USER_COMMAND%>"
                  method="POST" onsubmit="return isSame();">
                <table border="0" align="left">
                    <tr>
                        <td>사용자 ID</td>
                        <td> <input type="text" name="id" value="" size="20" />  </td>
                    </tr>
                    <tr>
                        <td>암호 </td>
                        <td> <input type="password" name="password" value="" id="pw" onchange="isSame()"/> </td>
                    </tr>
                    <tr>
                        <td>암호 재확인</td>						
                        <td> <input type="password" value="" id="pwCheck" onchange="isSame()"/> 
                            <br> <span id="same"></span> </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="등록" name="register" />
                            <input type="reset" value="초기화" name="reset" />
                        </td>
                    </tr>
                </table>

            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>
