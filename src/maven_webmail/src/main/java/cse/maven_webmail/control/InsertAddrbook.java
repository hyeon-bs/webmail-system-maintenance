/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cse.maven_webmail.control;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author jiwon
 */
@WebServlet(name = "InsertAddrbook", urlPatterns = {"/insert.do"})
public class InsertAddrbook extends HttpServlet {

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
 try {
            final String JdbcDriver = "com.mysql.jdbc.Driver";
            final String JdbcUrl = "jdbc:mysql://localhost:3306/webmail";
            final String User = "jdbctester";
            final String Password = "bsh7336";
            
            try {
                Class.forName(JdbcDriver);
                Connection conn = DriverManager.getConnection(JdbcUrl, User, Password);
                String sql = "INSERT INTO addrbook VALUES(?,?,?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                request.setCharacterEncoding("UTF-8"); // 한글 인식
                String email = request.getParameter("email"); // 주키(PK)
                if(!(email == null) && !email.equals("")){ // 이 경우 email이 주키이므로, NULL 이거나 빈 스트링일 경우 DB에 추가되면 안됨.
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    pstmt.setString(1, email);
                    pstmt.setString(2, name);
                    pstmt.setString(3, phone);
                    pstmt.executeUpdate(); // 실제 데이터베이스에 작업내용이 반영되어야 하므로 executeUpdate 메소드 사용
                }
                pstmt.close(); // 자원 해제
                conn.close(); // 자원 해제
                response.sendRedirect("addrbook.jsp");
                
            } catch(Exception ex){
                out.println("오류가 발생했습니다. (발생오류 : " + ex.getMessage() + ")");
                out.println("<br/><a href=\"index.jsp\">초기 화면으로 가기</a>");
              }
        }
        finally {
            out.close();
            
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
