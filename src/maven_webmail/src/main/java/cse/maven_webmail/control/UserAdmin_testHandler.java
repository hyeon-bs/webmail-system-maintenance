/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cse.maven_webmail.control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import cse.maven_webmail.model.UserAdminAgent;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author jongmin
 */
public class UserAdmin_testHandler extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        PrintWriter out = null;
//        RequestDispatcher view = request.getRequestDispatcher("main_menu.jsp");
        // Validate if userid == "admin"
        HttpSession session = request.getSession();
        String userid = (String) session.getAttribute("userid");

        try {
            request.setCharacterEncoding("UTF-8");
            int select = Integer.parseInt((String) request.getParameter("menu"));

            switch (select) {
                case CommandType.ADD_USER_COMMAND:
                    out = response.getWriter();
                    addUser(request, response, out);
                    break;

                case CommandType.DELETE_USER_COMMAND:
                    out = response.getWriter();
                    deleteUser(request, response, out);
                    break;

                case CommandType.FIX_USER_COMMAND:
                    out = response.getWriter();
                    deleteUser(request, response, out);
                    break;

                default:
                    out = response.getWriter();
                    out.println("없는 메뉴를 선택하셨습니다. 어떻게 이 곳에 들어오셨나요?");
                    break;
            }
        } catch (Exception ex) {
            out.println(ex.toString());
        } finally {
            out.close();
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response, PrintWriter out) throws UnsupportedEncodingException {
        String server = "127.0.0.1";
        int port = 4555; // 프로토콜 4555 제임스 서버 원격 관리

        try {
            final String url = "jdbc:mysql://localhost:3306/webmail";
            final String User = "jdbctester";
            final String Password = "bsh7336";

            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, User, Password);
                String sql = "SELECT userid, password, name, gender, address, date, email1, email2, telephone1, telephone2, cellphone1, cellphone2 FROM webmail.join ";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                request.setCharacterEncoding("UTF-8"); // 한글 인식
                
                 rs = pstmt.executeQuery();

                if (rs.next()) {
                    sql = "INSERT INTO webmail.join VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
                    String userid = request.getParameter("userid");
                    String password = request.getParameter("password");
                    String name = request.getParameter("name");
                    String gender = request.getParameter("gender");
                    String address = request.getParameter("address");
                    String date = request.getParameter("date");
                    String email1 = request.getParameter("email1");
                    String email2 = request.getParameter("email2");
                    String telephone1 = request.getParameter("telephone1");
                    String telephone2 = request.getParameter("telephone2");
                    String cellphone1 = request.getParameter("cellphone1");
                    String cellphone2 = request.getParameter("cellphone2");

                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, userid);
                    pstmt.setString(2, password);
                    pstmt.setString(3, name);
                    pstmt.setString(4, gender);
                    pstmt.setString(5, address);
                    pstmt.setString(6, date);
                    pstmt.setString(7, email1);
                    pstmt.setString(8, email2);
                    pstmt.setString(9, telephone1);
                    pstmt.setString(10, telephone2);
                    pstmt.setString(11, cellphone1);
                    pstmt.setString(12, cellphone2);
                    pstmt.executeUpdate(); // 실제 데이터베이스에 작업내용이 반영되어야 하므로 executeUpdate 메소드 사용
                }
                pstmt.close(); // 자원 해제
                conn.close(); // 자원 해제
                response.sendRedirect("index.jsp");

            } catch (Exception ex) {
                out.println("오류가 발생했습니다. (발생오류 : " + ex.getMessage() + ")");
                out.println("<br/><a href=\"index.jsp\">초기 화면으로 가기</a>");
            }
        } finally {
            out.close();

        }
    }

    private String getUserRegistrationSuccessPopUp() {
        String alertMessage = "사용자 등록이 성공했습니다. 로그인 창으로 돌아갑니다.";
        StringBuilder successPopUp = new StringBuilder();
        successPopUp.append("<html>");
        successPopUp.append("<head>");

        successPopUp.append("<title>메일 전송 결과</title>");
        successPopUp.append("<link type=\"text/css\" rel=\"stylesheet\" href=\"css/main_style.css\" />");
        successPopUp.append("</head>");
        successPopUp.append("<body onload=\"goMainMenu()\">");
        successPopUp.append("<script type=\"text/javascript\">");
        successPopUp.append("function goMainMenu() {");
        successPopUp.append("alert(\"");
        successPopUp.append(alertMessage);
        successPopUp.append("\"); ");
        successPopUp.append("window.location = \"index.jsp\"; ");
        successPopUp.append("}  </script>");
        successPopUp.append("</body></html>");
        return successPopUp.toString();
    }

    private String getUserRegistrationFailurePopUp() {
        String alertMessage = "사용자 등록에 실패했습니다. 다시 시도해 주십시오. 로그인 창으로 돌아갑니다.";
        StringBuilder successPopUp = new StringBuilder();
        successPopUp.append("<html>");
        successPopUp.append("<head>");

        successPopUp.append("<title>메일 전송 결과</title>");
        successPopUp.append("<link type=\"text/css\" rel=\"stylesheet\" href=\"css/main_style.css\" />");
        successPopUp.append("</head>");
        successPopUp.append("<body onload=\"goMainMenu()\">");
        successPopUp.append("<script type=\"text/javascript\">");
        successPopUp.append("function goMainMenu() {");
        successPopUp.append("alert(\"");
        successPopUp.append(alertMessage);
        successPopUp.append("\"); ");
        successPopUp.append("window.location = \"index.jsp\"; ");
        successPopUp.append("}  </script>");
        successPopUp.append("</body></html>");
        return successPopUp.toString();
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        String server = "127.0.0.1";
        int port = 4555;
        try {
            UserAdminAgent agent = new UserAdminAgent(server, port);
            String[] deleteUserList = request.getParameterValues("selectedUsers");
            agent.deleteUsers(deleteUserList);
            response.sendRedirect("index.jsp");
        } catch (Exception ex) {
            System.out.println(" UserAdminHandler.deleteUser : exception = " + ex);
        }
    }

    private void fixUser(HttpServletRequest request, HttpServletResponse response, PrintWriter out) { // 유저 정보 수정용
        String server = "127.0.0.1";
        int port = 4555;
        try {
            UserAdminAgent agent = new UserAdminAgent(server, port);
            String[] fixUserList = request.getParameterValues("selectedUsers");
            agent.deleteUsers(fixUserList);
            response.sendRedirect("index.jsp");
        } catch (Exception ex) {
            System.out.println(" UserAdminHandler.fixUser : exception = " + ex);
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
