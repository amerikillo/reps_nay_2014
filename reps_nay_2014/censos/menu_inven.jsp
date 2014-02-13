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
rset=stmt.executeQuery("select DISTINCT u.des_uni, j.des_jur  from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m,  receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni group by u.cla_uni,i.fec_ela;");
while (rset.next()) 
{ 
	/*if(rset.getString("j.des_jur").equals("JURISDICCION SANITARIA I"))
		 {c_j1++;j_u=c_j1+")"+" J1 - "+rset.getString("u.des_uni");}
	if(rset.getString("j.des_jur").equals("JURISDICCION SANITARIA II"))
		 {c_j2++;j_u=c_j2+")"+" J2 - "+rset.getString("u.des_uni");}
	if(rset.getString("j.des_jur").equals("JURISDICCION SANITARIA III"))
		 {c_j3++;j_u=c_j3+")"+" J3 - "+rset.getString("u.des_uni");}	
		*/
	juris_n[tam2]=j_u;
	
	censo[tam2]=rset.getString("u.des_uni");
	tam++;
}

rset=stmt.executeQuery("select  u.des_uni, j.des_jur  from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m,  receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni group by u.cla_uni,i.fec_ela ;");
while (rset.next()) 
{ 
	if(rset.getString("j.des_jur").equals("JURISDICCION SANITARIA I"))
		 {c_j1++;j_u=c_j1+")"+" J1 - "+rset.getString("u.des_uni");}
	if(rset.getString("j.des_jur").equals("JURISDICCION SANITARIA II"))
		 {c_j2++;j_u=c_j2+")"+" J2 - "+rset.getString("u.des_uni");}
	if(rset.getString("j.des_jur").equals("JURISDICCION SANITARIA III"))
		 {c_j3++;j_u=c_j3+")"+" J3 - "+rset.getString("u.des_uni");}
		 
	tam2++;	
}
// ----------------------------------------------


if(but.equals("Por Unidad"))
{
 unidad=request.getParameter("SubCat2");	
 //response.sendRedirect("inventarios.jsp?uni="+unidad+"");
}// fin de if UNIDAD

if(but.equals("Mostrar"))
{
 unidad=request.getParameter("slct_censo");	
 //response.sendRedirect("inventarios.jsp?uni="+unidad+"");
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
          <td colspan="5"><div align="center"><span class="style1"><strong>INVENTARIOS TOMADOS EN LAS UNIDADES - NAYARIT  2014</strong></span><strong><BR />
          </strong></div></td>
          </tr>
        <tr>
          <td colspan="5"><div align="center" class="style1"><strong>SELECCIONE LOS DATOS </strong></div></td>
        </tr>
        <tr>
          <td colspan="5"><div align="left"><a href="../reportes_nay/index_main.jsp">Regresar a Menú</a></div></td>
          </tr>
          <tr>
          <td colspan="5"><hr /></td>
          </tr>
        <tr>
          <td width="4">&nbsp;</td>
          <td colspan="2"><strong>Ingrese Unidad de Atenci&oacute;n</strong></td>
          </tr>
        <tr>
          <td>&nbsp;</td>
          <td width="108"><div align="right">Jurisdicci&oacute;n: </div></td>
          <td width="346"><select name="Category" class="ver" onChange="SelectSubCat_J();" >
              <option>---------------- JURISDICCIÓN SANITARIA ----------------</option>
              <%/*
			  String qry_juris = "SELECT  J.DES_JUR, M.MUNICIPIO,  FROM JURIS J, MUNICIPIOS M, UNIDADES U, INVENTARIOS_RURALES I WHERE J.CLA_JUR = M.CLA_JUR AND M.CLA_MUN = U.CLA_MUN AND U.CLA_UNI = U.CLA_UNI";
			  rset=stmt.executeQuery(qry_juris);
          	  while (rset.next()){
				  String juris=rset.getString(1);
				  String cla_jur=rset.getString(2);
				  out.print("<option value = '"+cla_jur+"' >"+juris+"</option>");
			  }*/
			  %>
            </select></td>
          </tr>
        <tr>
          <td>&nbsp;</td>
          <td><div align="right">Seleccione Municipio</div></td>
          <td><select name="SubCat_MUN" class="ver" onChange="SelectSubCat_UNI()" >
            <option>-- SELECCIONA UNIDAD --</option>
            </select></td>
        </tr>
        <tr>
          <td class="boton"></td>
          <td  ><div align="right">Unidad de Atenci&oacute;n:</div></td>
          <td  class="boton"><select name="SubCat2" id="SubCat2" class="ver" >
            <option>-- Seleccione --</option>
            </select></td>
          <td colspan="2" class="ver3">N&uacute;mero de Unidades visitadas: <%=tam%><br />Jurisdicci&oacute;n 1:<span class="style1"><strong>&nbsp;<%=c_j1%></strong></span>&nbsp;Jurisdicci&oacute;n 2:&nbsp;<span class="style1"><strong><%=c_j2%></strong></span>&nbsp;Jurisdicci&oacute;n 3:<span class="blues"><strong><span class="style1">&nbsp;<%=c_j3%><br>No. de inventarios Realizados:&nbsp;<span class="style1"><strong><%=tam2%></strong></span></td>
        </tr>
          <tr>
            <td class="boton">&nbsp;</td><td class="boton">&nbsp;</td><td class="boton"><input name="Submit" type="submit" class="boton" value="Por Unidad" /></td>
          </tr>
          <tr>
          <td colspan="5"><hr /></td>
          </tr>
          <tr>
          <td colspan="5" style="text-align:center">
		   <%
		   String fecha="";
		  if(but.equals("Por Unidad"))
			{
				
				String qry_unidad="select u.des_uni from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m, receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni AND i.cla_uni = LTRIM('"+unidad+"') group by i.cla_uni";
				
				rset=stmt.executeQuery(qry_unidad);
				while (rset.next()) {
			   fecha=rset.getString(1);
			   out.print("<div class='ver3'>Unidad: "+fecha+"<br></div>");
			}
				out.print("Seleccione la fecha del inventario para la unidad "+unidad+": <br>");
			 //unidad=request.getParameter("slct_censo");	
			  String qry_fecha="select fec_ela from inventarios_rurales where cla_uni = '"+unidad+"' group by fec_ela order by fec_ela asc";
			  //out.print(qry_fecha);
			 rset=stmt.executeQuery(qry_fecha);
          while (rset.next()) {
			   fecha=rset.getString(1);
			   %><a href="inventarios.jsp?uni=<%=unidad%>&fecha=<%=fecha%>"><%=fecha%></a><br /><%
			}
			if (fecha==null){
				%><script>alert("La unidad <%=fecha%> aun no tiene inventarios capturados")</script><%
			}
			 //response.sendRedirect("inventarios.jsp?uni="+unidad+"");
			}// fin de if UNIDAD
			
			if(but.equals("Mostrar"))
			{
				
				String qry_unidad="select u.des_uni from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m, receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni AND i.cla_uni = '"+unidad+"' group by i.cla_uni ;";
				rset=stmt.executeQuery(qry_unidad);
				while (rset.next()) {
			   fecha=rset.getString(1);
			   out.print("<div class='ver3'>Unidad: "+fecha+"<br></div>");
			}
				out.print("Seleccione la fecha del inventario para la unidad "+unidad+": <br>");
			 unidad=request.getParameter("slct_censo");	
			  String qry_fecha="select fec_ela from inventarios_rurales where cla_uni = '"+unidad+"' group by fec_ela order by fec_ela asc";
			 rset=stmt.executeQuery(qry_fecha);
          while (rset.next()) {
			   fecha=rset.getString(1);
			   %><a href="inventarios.jsp?uni=<%=unidad%>&fecha=<%=fecha%>"><%=fecha%></a><br /><%
			}
			if (fecha==null){
				%><script>alert("La unidad <%=fecha%> aun no tiene inventarios capturados")</script><%
			}
			 //response.sendRedirect("inventarios.jsp?uni="+unidad+"");
			}// fin de if UNIDAD
		  %>
          </td>
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
