<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*"
         import="java.lang.*" import="java.util.*" import="javax.swing.*" import="java.io.*"
         import="java.text.DateFormat"
         import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar"
         import="java.util.Date" errorPage="../../pag_man.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
    // add 1 to month because Calendar's months start at 0, not 1
%>

<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
response.setContentType ("application/vnd.ms-excel"); 
response.setHeader ("Content-Disposition", "attachment;filename=\"Clave por unidad.xls\"");
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


    try {
        but = "" + request.getParameter("submit");
    } catch (Exception e) {
        System.out.print("not");
    }
String fecha_1 = "", fecha_2="";
    //out.print(but);
	try{
         fecha_1= df.format(df2.parse(request.getParameter("txtf_caduc")));
		   fecha_2= df.format(df2.parse(request.getParameter("txtf_caduci")));
    } catch (Exception e) {
	}
    /*
	String qry_sol = "SELECT id from RECETA WHERE FECHA_re BETWEEN '" + fecha1 + "' AND '" + fecha2 + "' GROUP BY FECHA_re";
    String qry_sol_colectivo = "", qry_rece = "";

    rset = stmt.executeQuery(qry_sol);
    while (rset.next()) {

        i++;

    }*/
    ancho = i * 100;
//qry_rece="select count(surtido) from receta where surtido = 'SI' and fecha_re BETWEEN '"+fecha1+"' AND '"+fecha2+"'";
//out.print(qry_rece);
%>
<html>
<head>
    <script language="javascript" src="../../js/scw.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <style type="text/css">
        body {
            background-color: #F5F5F5;
        }
    </style>
    <style type="text/css">
        <!--
        .style1 {
            font-size: 12px
        }

        body {
	background-image: url();
	background-color: #FFFFFF;
        }

        .style2 {
            font-family: Arial, Helvetica, sans-serif
        }

        a:link {
            color: #000000;
        }

        a:visited {
            color: #990000;
        }

        a:hover {
            color: #0000FF;
        }

        .style5 {
            font-size: 36px;
            font-weight: bold;
            font-family: Arial, Helvetica, sans-serif;
        }

        .style6 {
            font-size: 18px
        }

        .style7 {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
        }

        .style9 {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
            color: #990000;
            font-weight: bold;
        }

        .style10 {
            color: #EF6703
        }

        .style11 {
            color: #EF6703;
            font-weight: bold;
        }

        .style13 {
            color: #000000
        }

        -->
    </style>
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
        Seleccione las fechas de la consulta.<br/>
        Del :
        <%=request.getParameter("txtf_caduc")%>
        al
        <%=request.getParameter("txtf_caduci")%>
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
				
				String cv_cant="select sum(eu.can_sur) from entregado_trans eu, unidades u, registro_surtido rf where eu.cla_pro='"+clave+"' and rf.fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and u.cla_uni = rf.cla_uni and rf.cla_reg = eu.cla_reg and u.cla_uni = '"+unidad+"'  and u.cla_uni != '1002' and u.cla_uni != '1004' and u.cla_uni != '1008' and u.cla_uni != '1014' and u.cla_uni != '2002' and u.cla_uni != '2004' and u.cla_uni != '2006' and u.cla_uni != '2008' and u.cla_uni != '3002' and u.cla_uni != '3004' and u.cla_uni != '3006' and u.cla_uni != '3008' and u.cla_uni != '3010' group by eu.cla_pro;";
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
// ----- try que cierra la conexi�n a la base de datos
		 try{
               // Se cierra la conexi�n dentro del try
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
		// ---- fin de la conexi�n	 	  

%>
