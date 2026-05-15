<%-- 
    Document   : write_mail.jsp
    Author     : jongmin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cse.maven_webmail.control.CommandType" %>

<!DOCTYPE html>

<%-- @taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" --%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>메일 쓰기 화면</title>
        <!-- include libraries(jQuery, bootstrap) --> 
        <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> 
        <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
        <!-- include summernote css/js--> 
        <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.3/summernote.css" rel="stylesheet"> 
        <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.3/summernote.js"></script>
        <script type="text/javascript">
            $(function() {
            $('.summernote').summernote({
            lang: 'ko-KR',
            height: 300,         
            minHeight: null,      
            maxHeight: null,     
            focus : true
            });
          });
        </script>
    </head>
    <link type="text/css" rel="stylesheet" href="css/main_style.css" />
    <body>
        <jsp:include page="header.jsp" />
        <div id="sidebar">
            <jsp:include page="sidebar_previous_menu.jsp" />
        </div>

        <div id="main">
            <%-- <jsp:include page="mail_send_form.jsp" /> --%>
            <form enctype="multipart/form-data" method="POST"
                  action="WriteMail.do?menu=<%= CommandType.SEND_MAIL_COMMAND%>" >
                <%@ include file="show_addrbook.jsp" %>
                <table>
                    <tr>
                        <td> 수신 </td>
                        <td> <input type="text" name="to" size="80" required
                                    value=<%=request.getParameter("recv") == null ? "" : request.getParameter("recv")%>>  
                        </td>
                    </tr>
                    <tr>
                        <td>참조</td>
                        <td> <input type="text" name="cc" size="80">  </td>
                    </tr>
                        <td> 메일 제목 </td>
                        <td> <input type="text" name="subj" size="80" required>  </td>
                    </tr>
                    <tr>
                        <td colspan="2">본  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 문</td>
                    </tr>
                    <tr>  <%-- TextArea    --%>
                        <td colspan="2"> 
                            <textarea class="summernote" rows="15" name="body" cols="80"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>첨부 파일</td>
                        <td> 
                            <input multiple="multiple" type ="file" name="file1"  size="80">
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <input type="submit" value="메일 보내기">
                            <input type="reset" value="다시 입력">
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>
