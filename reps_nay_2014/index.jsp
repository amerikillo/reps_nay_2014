<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error_pag.html" session="true" %>

<%
HttpSession sesion= request.getSession();
//out.print("Id de sesion: "+sesion.getId());
%>
<%
response.sendRedirect("reportes_nay/index.jsp");
%>