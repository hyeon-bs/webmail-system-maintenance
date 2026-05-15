<%-- 
    Document   : PwChange
    Created on : 2019. 5. 27., 오후 11:55:04
    Author     : 소현
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 한글처리
    request.setCharacterEncoding("utf-8");
    // id passwd name가져오기
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");
    String change_pw = request.getParameter("change_pw");

    ResultSet rs = null;

    Connection con = null;
    String url = "jdbc:mysql://localhost:3306/webmail";
    String user = "jdbctester";
    String pwd = "bsh7336";

    PreparedStatement pstmt = null;
    try {
        // 1단계 드라이버로더
        Class.forName("com.mysql.jdbc.Driver");
        // 2단계 디비연결
        con = DriverManager.getConnection(url, user, pwd);
        // 3단계 : id에 해당하는 passwd를 가져오는 sql(sql 생성)
        String sql = "SELECT userid, password FROM users WHERE userid = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, userid);
        // 4단계 실행 => rs저장
        rs = pstmt.executeQuery();
        // 5단계 rs 데이터있으면 id있음
        //   폼비밀번호 rs비밀번호 비교 맞으면 => 수정
        //                     틀리면 => 비밀번호틀림
        //            없으면 id없음
        if (rs.next()) {
            //id있음
//     rs.getString(1); 
            String dbPass = rs.getString("password");
            String dbId = rs.getString("userid");
            String dbChange = request.getParameter("password");
            
            if (password.equals(dbPass) && userid.equals(dbId)) {
                //비밀번호 맞음 수정
                sql = "UPDATE users SET password = ? where userid = ? and password=? ";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, change_pw);
                pstmt.setString(2, userid);
                pstmt.setString(3, password);

                // 4단계 실행
                pstmt.executeUpdate(); //insert,update,delete
                %>
                <script type="text/javascript">
                    alert("변경 성공!");
                    location.href="index.jsp";
                    </script>
            <%
                } else {
%>
<script type="text/javascript">
                    alert("비밀번호 틀렸습니다ㅠ 다시 입력해 주세요!");
                    location.href="change_pw.jsp";
                    </script>
                <%
            }
        } else {
%>
<script type="text/javascript">
                    alert("아이디가 존재 하지 않습니다ㅠ 다시 입력해주세요!");
                    location.href="change_pw.jsp";
                    </script>
                    
<%
            }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        //rs!=null : 기억장소가 확보되어 있다는 뜻
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ex) {
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException ex) {
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
            }
        }
    }
%>
