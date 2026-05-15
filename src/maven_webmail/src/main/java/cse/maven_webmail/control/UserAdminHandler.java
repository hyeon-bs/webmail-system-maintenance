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

/**
 *
 * @author jongmin
 */
public class UserAdminHandler extends HttpServlet {

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
//        if (userid == null || !userid.equals("admin")) {
//            out = response.getWriter();
//            out.println("현재 사용자(" + userid + ")의 권한으로 수행 불가합니다.");
//            out.println("<a href=/WebMailSystem/> 초기 화면으로 이동 </a>");
//            out.close();
//            return;
//        }
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

    private void addUser(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        String server = "127.0.0.1";
        int port = 4555; // 프로토콜 4555 제임스 서버 원격 관리
        try {

            UserAdminAgent agent = new UserAdminAgent(server, port);
            String userid = request.getParameter("id");
            String password = request.getParameter("password");
            String username = request.getParameter("name");
            String usergender = request.getParameter("gender");
            String useraddress = request.getParameter("address");
            String userdate = request.getParameter("date");
            String useremail1 = request.getParameter("email1");
            String useremail2 = request.getParameter("email2");
            String telephone1 = request.getParameter("telephone1");
            String telephone2 = request.getParameter("telephone2");
            String cellphone1 = request.getParameter("cellphone1");
            String cellphone2 = request.getParameter("cellphone2");
            out.println("userid = " + userid + "<br>");
            out.println("password = " + password + "<br>");
            out.println("name = " + username + "<br>");
            out.println("gender = " + usergender + "<br>");
            out.println("date = " + userdate + "<br>");
            out.println("email = " + useremail1 + "@" + useremail2 + "<br>");
            out.println("telephoneber = " + telephone1 + telephone2 + "<br>");
            out.println("phoneber = " + cellphone1 + cellphone2 + "<br>");
            out.flush();
            if (agent.addUser(userid, password)) {             // if (addUser successful)  사용자 등록 성공 팝업창
                out.println(getUserRegistrationSuccessPopUp());
            } else {             // else 사용자 등록 실패 팝업창
                out.println(getUserRegistrationFailurePopUp());
            }
            out.flush();
        } catch (Exception ex) {
            out.println("시스템 접속에 실패했습니다.");
        }
    }

    private String getUserRegistrationSuccessPopUp() {
        String alertMessage = "사용자 등록이 성공했습니다.";
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
        successPopUp.append("window.location = \"admin_menu.jsp\"; ");
        successPopUp.append("}  </script>");
        successPopUp.append("</body></html>");
        return successPopUp.toString();
    }

    private String getUserRegistrationFailurePopUp() {
        String alertMessage = "사용자 등록에 실패했습니다.";
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
        successPopUp.append("window.location = \"admin_menu.jsp\"; ");
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
            response.sendRedirect("admin_menu.jsp");
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
            response.sendRedirect("admin_menu.jsp");
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
