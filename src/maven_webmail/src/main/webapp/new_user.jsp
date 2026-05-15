<%-- 
    Document   : add_user.jsp
    Author     : jongmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cse.maven_webmail.control.CommandType" %>

<!DOCTYPE html"> 

<html>
    <body>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>사용자 추가 화면</title>

        <link type="text/css" rel="stylesheet" href="css/main_style.css" />
       <script type="text/javascript">

            function getConfirmResult() {
                var result = confirm("위 정보로 회원가입을 하시겠습니까?");
                return result;
            }
            
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
    <jsp:include page="header.jsp" />
    <div id="sidebar">
        <jsp:include page="sidebar_admin_previous_menu.jsp" />
    </div>

    <div id="main">
        추가로 등록할 사용자 ID와 암호를 입력해 주시기 바랍니다. <br> <br>

        <form name="AddUser" action="UserAdmin_test.do?menu=<%= CommandType.ADD_USER_COMMAND%>" method="POST">
            <table border="0" align="left">
                <tr>
                    <td>사용자 ID </td>
                    <td> <input type="text" name="id" value="" size="14" placeholder="ID입력" maxlength="15" required/>@deu.ac.kr</td>

                </tr>
                <tr>
                    <td>비밀번호 </td>
                    <td> <input type="password" name="password" value="" size="25" placeholder="비밀번호(8자이상)" maxlength="20" id="pw" onchange="isSame()" required/> </td>
                </tr>
                <tr>                 
                    <td>비밀번호 확인 </td>
                    <td> <input type="password" name="password1" id="pwCheck" onchange="isSame()" value="" size="25" placeholder="비밀번호 확인" maxlength="15" required/> </td>
                    <br> <span id="same"></span> </td>
                </tr>
                <tr>
                    <td>이름 </td>
                    <td> <input type="text" name="name" value="" size="25" placeholder="이름" required/> </td>
                </tr>

                <tr>
                    <td>성별 </td>
                    <td> <input type='radio' name='gender' value='female' required />여성
                         <input type='radio' name='gender' value='male' required />남성 </td>
                </tr>
                <tr>
                    <td>주소 </td>
                    <td> <input type="text" name="address" value="" size="25" required />  </td>
                </tr>

                <tr>
                    <td>생년월일 </td>
                    <td> <input type="date" name="date" value="" size="25" required/> </td>
                </tr>
                <tr>
                    <td>이메일 </td>
                    <td> <input type="text" size="10" name="email1" required>@<input type="text" size="10" name="email2" placeholder="직접입력" required>
                    </td>
                </tr>    
                <tr>
                    <td>집 전화번호 </td>
                    <td valgn="top">
                        <select name="telephone1" size="">
                            <option value="02">02</option>
                            <option value="051">051</option>
                        </select>
                        <input type="tel" name="telephone2" value="" size="17" required/></td>
                </tr>
                <tr>
                    <td>휴대폰 번호 </td>
                    <td valgn="top">
                        <select name="cellphone1" size="">
                            <option value="010">010</option>
                            <option value="011">011</option>
                        </select>
                        <input type="tel" name="cellphone2" value="" size="17" required/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="가입신청"onClick ="return getConfirmResult()"/>
                        <input type="reset" value="초기화" name="reset" />
                    </td>

            </table>

        </form>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>
