*<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" session="true"%>
<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String val="", user="";



if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!val.equals("valido")){
	
	%>
    <script>self.location='../index.jsp';</script>
    <%
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: menu_inven.jsp
FUNCIÓN: Menú de Opciones de inventarios por Unidad, en el cual se puede filtrar por meses y muestra los inventarios tomados en         fecha determinada.
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  RHW
ARCHIVOS JS    :  list02.js
------------------------------------------------------------------------------------------------------------------------------*/
// Conexión a la BDD -----------------------
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn=null;
	conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
	Statement stmt = null;
	ResultSet rset = null;
	stmt=conn.createStatement();
// -----------------------------------------  

// variables de entorno
String but="r";
String mensaje="",unidad="";
String censo[]=new String[1000];
String juris_n[]=new String[1000];
int tam = 0, tam2=0;
String j_u="";
int c_j1=0,c_j2=0,c_j3=0;
//--------------------- 				  
try { 
        but=""+request.getParameter("Submit");
    }catch(Exception e){System.out.print("not");}
	// fin del bloque de try
	
//*****************************************POR UNIDAD

// rutina para obtener los Unidades ya realizadas

// ----------------------------------------------


if(but.equals("Por Unidad"))
{
 unidad=request.getParameter("SubCat2");	
 //response.sendRedirect("inventarios.jsp?uni="+unidad+"");
}// fin de if UNIDAD

if(but.equals("Mostrar"))
{
 unidad=request.getParameter("slct_censo");	
 response.sendRedirect("inven_farmacias.jsp?uni="+unidad+"");
}// fin de if UNIDAD
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="javascript" src="../js/list03.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../css/ver2.css" type="text/css" />

<title>:: INVENTARIOS ::</title>
<style type="text/css">
<!--
body {
	background-color: #FFF;
}
.style1 {
	color: #900
}
-->
</style></head>

<body onLoad="fillCategory2()">
<script src="../js/scw.js" type="text/javascript"> </script>
<form id="form" name="form" method="post" action="">

  <table width="880" border="1" align="center" cellpadding="2">
    <tr>
      <td width="712"><table width="869" border="0" cellpadding="2" class="ver">
        <tr>
          <td colspan="2"><div align="center"><span class="style1"><strong>INVENTARIOS TOMADOS EN LAS FARMACIAS - NAYARIT  2014</strong></span><strong><BR />
          </strong></div></td>
          </tr>
        <tr>
          <td colspan="2"><div align="center" class="style1"><strong>SELECCIONE LOS DATOS </strong></div></td>
        </tr>
        <tr>
          <td colspan="2"><div align="left"><a href="../reportes_nay/index_main.jsp">Regresar a Menú</a></div></td>
          </tr>
          <tr>
          <td colspan="2"><hr /></td>
          </tr>
        <tr style="text-align:center">
          <td width="4">&nbsp;</td>
          <td><strong>Inventarios Actualizados</strong></td>
          </tr>
        <tr style="text-align:center">
          <td>&nbsp;</td>
          <td>Seleccione Unidad</td>
          </tr>
        <tr style="text-align:center">
          <td>&nbsp;</td>
          <td>Unidad de Atenci&oacute;n:
            <select name="slct_censo" class="ver" id="slct_censo">
              <option>-- SELECCIONA UNIDAD --</option>
              
              <%
			  String qry_unidades = "select des_uni from unidades where tip_uni = 'f'";
			  rset=stmt.executeQuery(qry_unidades);
          	  while (rset.next()){
				  String uni=rset.getString(1);
				  out.print("<option value = '"+uni+"' >"+uni+"</option>");
			  }
			  %>
              
            </select></td>
          </tr>
        <tr>
          <td class="boton"></td>
          <td  >&nbsp;</td>
          </tr>
          <tr style="text-align:center">
            <td class="boton">&nbsp;</td><td class="boton"><input name="Submit" type="submit" class="boton" value="Mostrar" /></td>
          </tr>
          <tr>
          <td colspan="2"><hr /></td>
          </tr>
          <tr>
          <td colspan="2" style="text-align:center">&nbsp;</td>
          </tr>
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
  </table>
  </td>
  </tr>
  </table>
  <p align="center"><img src="../imagen/logo2.png"  /></p>
  <h5 align="center"></h5>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</form>
</body>
</html>
