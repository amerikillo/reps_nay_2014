<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*"
         import="java.lang.*" import="java.util.*" import="javax.swing.*" import="java.io.*"
         import="java.text.DateFormat"
         import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar"
         import="java.util.Date" errorPage="" %>
<%
response.setContentType ("application/vnd.ms-excel"); 
response.setHeader ("Content-Disposition", "attachment;filename=\"ClavexUnidad.xls\"");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
    // add 1 to month because Calendar's months start at 0, not 1
%>
<%

    //declaracion de variables-------------------------------------------------------------------------------------------------------------------
    String cant_sol = "0", cant_sur = "0", cant_nosur = "0", recetas_tot = "0", recetas_par = "0", porcentaje = "0", fecha = "", mensaje = "";
    String cant_sol_col = "0", cant_sur_col = "0", cant_nosur_col = "0", recetas_tot_col = "0", recetas_par_col = "0", porcentaje_col = "0", fecha_col = "", unidad="", clave="",cant_clave="0";
    int sol = 0, sur = 0, dif = 0, sol_col = 0, sur_col = 0, dif_col = 0, total_sol = 0, total_sur = 0, i = 1, ancho = 0;
//-------------------------------------------------------------------------------------------------------------------------------------------

    Statement stmt = null;
    ResultSet rset = null;
    stmt = conn.createStatement();

    Statement stmt2 = null;
    ResultSet rset2 = null;
    stmt2 = conn.createStatement();
	
	Statement stmt3 = null;
    ResultSet rset3 = null;
    stmt3 = conn.createStatement();


    String fecha1 = "2013-01-01", fecha2 = df.format(new java.util.Date()), but = "";


    
        String t1_jv = request.getParameter("f1");
        String t2_jv = request.getParameter("f2");
        //out.print(t2_jv);
        rset = stmt.executeQuery("SELECT STR_TO_DATE('" + t1_jv + "', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
        while (rset.next()) {
            fecha1 = rset.getString("STR_TO_DATE('" + t1_jv + "', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
            //out.print(fecha2);
        }

        rset2 = stmt2.executeQuery("SELECT STR_TO_DATE('" + t2_jv + "', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
        while (rset2.next()) {
            fecha2 = rset2.getString("STR_TO_DATE('" + t2_jv + "', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
            //out.print(t2_jv);
            //out.print(fecha2);
        }
        //out.print("Hola");
   
    ancho = i * 100;
//qry_rece="select count(surtido) from receta where surtido = 'SI' and fecha_re BETWEEN '"+fecha1+"' AND '"+fecha2+"'";
//out.print(qry_rece);
%>
<html>
<head>
    <script language="javascript" src="receta/scw.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
     <style>
.Rotate-90
{
  -webkit-transform: rotate(-90deg);
  -moz-transform: rotate(-90deg);
  -ms-transform: rotate(-90deg);
  -o-transform: rotate(-90deg);
  transform: rotate(-90deg);
 
  -webkit-transform-origin: 50% 50%;
  -moz-transform-origin: 50% 50%;
  -ms-transform-origin: 50% 50%;
  -o-transform-origin: 50% 50%;
  transform-origin: 50% 50%;
 
  font-size: 16px;
  width: 200px;
  height:100px;
  /*top: 50px;*/
}
    </style>
</head>
<body>
<div>
    <table bgcolor="#FFFFFF" bordercolor="#CCCCCC" border="1">
        <tr>
            <td>&nbsp;</td>
            <td><h1>Clave por Unidad</h1>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>


</div>
<div>
</div>
<div style="background-color:#FFFFFF; padding:10px; width:800; margin:auto">
    <form action="unidadxclave.jsp" method="post">
        Rango de fechas de la consulta. <br/>
        Del : <%=t1_jv%>
        al <%=t2_jv%>
    </form>
    </form>
    
    <table border="1">
    	<tr>
        	<td ></td>
        	<%
        	String qry_claves = "select des_uni, cla_uni from unidades  where cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';";
            rset2 = stmt2.executeQuery(qry_claves);
            while (rset2.next()) {
                clave=rset2.getString("cla_uni");
				String nombre=rset2.getString("des_uni");
                out.print("<td height='220' >");
                out.print("<div class='Rotate-90'>"+nombre+"</div>");
                out.print("</td>");
            }
			%>
        </tr>
        <%
        String qry_unidades = "select cla_pro from productos group by cla_pro order by cla_pro+0";
        rset = stmt.executeQuery(qry_unidades);
        while (rset.next()) {
            clave=rset.getString("cla_pro");
            out.print("<tr>");
            out.print("<td>"+clave+"</td>");
            
            qry_claves = "select cla_uni from unidades where cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010'";
            rset2 = stmt2.executeQuery(qry_claves);
            while (rset2.next()) {
                unidad=rset2.getString("cla_uni");
				
				String cv_cant="select sum(eu.can_sur) from entregado_por_unidad eu, unidades u, registro_por_fecha rf where eu.cla_pro='"+clave+"' and rf.fec_sur between '"+t1_jv+"' and '"+t2_jv+"' and u.cla_uni = rf.cla_uni and rf.cla_reg = eu.cla_reg and u.cla_uni = '"+unidad+"'  and u.cla_uni != '1002' and u.cla_uni != '1004' and u.cla_uni != '1008' and u.cla_uni != '1014' and u.cla_uni != '2002' and u.cla_uni != '2004' and u.cla_uni != '2006' and u.cla_uni != '2008' and u.cla_uni != '3002' and u.cla_uni != '3004' and u.cla_uni != '3006' and u.cla_uni != '3008' and u.cla_uni != '3010' group by eu.cla_pro;";
				rset3 = stmt3.executeQuery(cv_cant);
				while (rset3.next()) {
					cant_clave=rset3.getString("sum(eu.can_sur)");
				}
				if (cant_clave==null){
					cant_clave="0";
				}
                out.print("<td>");
                out.print(cant_clave);
                out.print("</td>");
				cant_clave="0";
            }
            out.print("</tr>");
        }
        %>
    </table>
             

</div>
</body>
    <%
// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conn.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conn!=null){
                   conn.close();
		                if(conn.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			 //out.print(mensaje);
		// ---- fin de la conexión	 	  

%>
