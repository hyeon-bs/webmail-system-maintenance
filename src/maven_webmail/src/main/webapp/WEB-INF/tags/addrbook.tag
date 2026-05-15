<%-- 
    Document   : addrbook
    Created on : 2019. 5. 27., 오후 4:50:43
    Author     : jiwon
--%>

<%@tag description="JSTL" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%-- The list of normal or fragment attributes can be specified here: --%>

<%@attribute name="user" required="true"%>
<%@attribute name="password" required="true"%>
<%@attribute name="schema" required="true"%>
<%@attribute name="table" required="true"%>
<%-- any content can be specified here e.g.: --%>

<sql:setDataSource var="dataSrc"
                   url="jdbc:mysql://localhost:3306/${schema}"
                   driver="com.mysql.jdbc.Driver"
                   user="${user}" password="${password}" />

<sql:query var="rs" dataSource="${dataSrc}">
    SELECT email, name, phone FROM ${table}
</sql:query>

    <table border="1">
     <thead>
         <tr>
             <th>이름</th>
             <th>이메일</th>
             <th>전화번호</th>
         </tr>
     </thead>
     <tbody>
         <c:forEach var="row" items="${rs.rows}">
             <tr>
                 <td>${row.name}</td>
                 <td>${row.email}</td>
                 <td>${row.phone}</td>
             </tr>
         </c:forEach>
     </tbody>
    </table>
