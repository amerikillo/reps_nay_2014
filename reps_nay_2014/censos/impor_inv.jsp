<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: inven.jsp
FUNCIÓN: Muestra los inventarios según la unidad que se haya escogido- nayarit 2013
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  RHW
------------------------------------------------------------------------------------------------------------------------------*/
// Conexión a la BDD ------------------------------------
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn=null;
	conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
	Statement stmt = conn.createStatement();
	ResultSet rset = null;
	Statement stmt2 = conn.createStatement();
	ResultSet rset2 = null;
	ResultSet rset_date =null;
// ------------------------------------------------------

// Variables de entorno ---------------------------------
	NumberFormat nf1 = NumberFormat.getInstance(Locale.US);				  
	String juri_jv="";
	String ran1_jv="";
	String ran2_jv="";
	String ban_jv="";
	String ran1="";
	String ran2="";
	String mpio_jv="";
	String valor_jv="",piezas="",min="",max="";
	String uni_jv="",mes_jv="",name_jv="", fecha="", mensaje="",cadu="", fecha1="";
	
	int piezas2=0,piezas3=0,min2=0,min3=0,max2=0,max3=0;
	int suma_cant=0;
	int suma_min=0;
	int suma_max=0;	
// ------------------------------------------------------
// try para obtener los datos como parámtros ------------
try { 
       uni_jv=request.getParameter("uni");
	   fecha1=request.getParameter("fecha");
    }catch(Exception e){System.out.print("not");}
	//out.print("para"+uni_jv);
	// Convierte a Excel
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition","attachment; filename=inventario"+uni_jv+".xls");
// ------------------------------------------------------"select cv_med,descrip,sum(cant) as total,f_elabo,lote,caducidad from inventarios where unidad='"+uni_jv+"' group by lote order by cv_med+0 ;"
 rset=stmt.executeQuery("select dp.cla_pro as cv_med, p.des_pro as descrip, sum(i.cant) as total, i.fec_ela as f_elabo, dp.lot_pro as lote, dp.cad_pro as caducidad from receta_electronica.jurisdicciones as j, receta_electronica.municipios as m,  receta_electronica.unidades as u, receta_electronica.inventarios_rurales as i, receta_electronica.detalle_productos as dp, receta_electronica.productos as p where   j.cla_jur = m.cla_jur AND m.cla_mun = u.cla_mun AND u.cla_uni = i.cla_uni AND p.cla_pro = dp.cla_pro AND dp.det_pro = i.det_pro AND i.cla_uni = '"+uni_jv+"'  and i.fec_ela = '"+fecha1+"' group by cv_med, lote order by cv_med+0 ;");
 
// fin bloque try ---------------------------------------
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTARIOS ::</title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style2 {
	font-size: 11px;
	font-family: Arial, Helvetica, sans-serif;
	text-align: center;
}
.style4 {color: #FFFFFF; font-size: 11px; font-family: Arial, Helvetica, sans-serif; }
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	color: #006;
	font-weight: bold;
}
.FECHA {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #900;
}
.neg2 {
	color: #000000;
}
-->
</style>
</head>

<body>
<div align="center">
  <table width="837" cellpadding="0" cellspacing="0">
    <col width="137" />
    <col width="80" span="2" />
    <col width="107" />
    <col width="101" />
    <col width="120" />
    <col width="80" span="2" />
    <tr height="20">
      <td width="208" height="20"><div align="center" class="style5"></div></td>
      <td width="331" class="style2">INVENTARIO POR UNIDAD </td>
      <td width="296">&nbsp;</td>
    </tr>
    <tr height="20">
      <td height="20"><div align="center" class="style5"></div></td>
      <td height="20" class="style2">PROYECTO CENSOS NAYARIT</td>
      <td height="20">&nbsp;</td>
    </tr>
  <%
  String des_uni = "";
		 rset2 = stmt2.executeQuery("select des_uni from unidades where cla_uni = '"+uni_jv+"'");
		 while(rset2.next()){
			 des_uni = rset2.getString("des_uni");
		 }
  %>
    <tr height="20">
      <td height="20" class="style2">Unidad Seleccionada:&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp; <%=des_uni%></strong></td>
      <td height="20" class="style2">&nbsp;</td>
      <td height="20" class="style2">&nbsp;</td>
    </tr>
    <tr height="20">
      <td height="20" class="style2"><a href="#abajo">&nbsp;</a> </td>
      <td height="20" class="style2">&nbsp;</td>
      <td height="20" class="style2">&nbsp;</td>
    </tr>
  </table>
  <table width="840" height="56" border="1" cellpadding="0" cellspacing="0">
    <col width="137" />
    <col width="80" span="2" />
    <col width="107" />
    <col width="101" />
    <col width="120" />
    <col width="80" span="2" />
    <tr class="neg2">
      <td width="42"  ><div align="center" class="style2">CLAVE</div></td>
      <td width="369" ><div align="center" class="style2">DESCRIPCI&Oacute;N</div></td>
      <td width="110" ><div align="center" class="style2">
      <span class="style2">LOTE</span></td>
      <td width="119" ><div align="center" class="style2">
      <span class="style2">CADUCIDAD</span></td>
      <td width="188" ><div align="center" class="style2">EXISTENCIAS</div></td>
    </tr>
    <%
	// obtiene los totales y muestra los valore en la tabla
	while (rset.next()) 
         { 
		    Connection conn_cadu=null;
			conn_cadu = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
	        Statement stmt_cadu = conn_cadu.createStatement();
			  suma_cant+=(suma_cant=Integer.parseInt(rset.getString("total")));
			  fecha= rset.getString("f_elabo"); 
			  cadu= rset.getString("caducidad"); 
			  if (!cadu.equals("-")){
			   rset_date = stmt_cadu.executeQuery("SELECT DATE_FORMAT('"+cadu+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    if(rset_date.next())
					{
                    cadu= rset_date.getString("DATE_FORMAT('"+cadu+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
					}
			  }
	%>
	
	<tr height="20">
      <td class="style2" align="center"><%=rset.getString("cv_med")%></td>
      <td class="style2" ><%=rset.getString("descrip")%></td>
      <td class="style2" align="center"><%=rset.getString("lote")%></td>
      <td class="style2" align="center"><%=cadu%></td>
      <td colspan="3" align="center" class="style2"><%=rset.getString("total")%></td>
    </tr>
	<%conn_cadu.close();
	} // fin de while
	
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
      <tr height="20">
	  <td class="style2">&nbsp;</td>
	  <td class="style2">&nbsp;</td>
	  <td class="style2" style="color: #003"><span class="style2" style="color: #003"><strong><%//=suma_min%></strong></span></td>
	  <td class="style2" style="color: #003"><span class="style2" style="color: #003"><strong><div align="right"><strong><a name="abajo" id="abajo"></a>TOTAL DE PIEZAS </strong></div></strong></span></td>
	  <td colspan="3" class="style2" style="color: #003" align="center"><strong><%=nf1.format(suma_cant)%></strong></td>
    </tr>
  </table>
</div>
<h5 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FECHA DE TOMA DE INVENTARIO AL:<span class="FECHA">&nbsp;&nbsp;&nbsp;<%=fecha%> (AAAA/MM/DD)</span></h5>
<h5 align="center">&nbsp;</h5>
</body>
</body>
</html>
