<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" session="true" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DecimalFormat format = new java.text.DecimalFormat("###,###,###,###");%>
<%java.text.DecimalFormat format2 = new java.text.DecimalFormat("###,###,###,###.##");%>
<%java.text.DateFormat sdf = new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy"); %>
<%NumberFormat forma= NumberFormat.getInstance(Locale.US); %>
<%
DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
simbolos.setDecimalSeparator('.');
simbolos.setGroupingSeparator(',');
DecimalFormat forma2= new DecimalFormat("##,###.##", simbolos);

HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String vali="", user="";



if (sesion.getAttribute("valida")!=null){
	vali=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!vali.equals("valido")){
	
	%>
<script>self.location='../../index.jsp';</script>
<%
}
%>
<%
Calendar calendar = Calendar.getInstance();
Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.HOUR_OF_DAY, -1);
String hora = "" + df4.format(calendar.getTime());
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection(""jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2"");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;


float m1=0, m2=0, m3=0, m4=0, m5=0, m6=0, m7=0, m8=0, m9=0, m10=0, m11=0, m12=0, tot=0;
String fecha1 = "", fecha2="";


rset=stmt.executeQuery("select min(fec_carga), max(fec_carga) from bitacora;");
while(rset.next()){
	fecha1=rset.getString("min(fec_carga)");
	fecha2=rset.getString("max(fec_carga)");
}

try{
	if(request.getParameter("Submit").equals("Por Fechas")){
		fecha1=df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01";
		fecha2=df.format(df2.parse(request.getParameter("txtf_caduci")))+ " 23:59:59";
	}
} catch(Exception e) {
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '1' group by id_rec, des_uni");
while(rset.next()){
	m1++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '2' group by id_rec, des_uni");
while(rset.next()){
	m2++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '3' group by id_rec, des_uni");
while(rset.next()){
	m3++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '4' group by id_rec, des_uni");
while(rset.next()){
	m4++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '5' group by id_rec, des_uni");
while(rset.next()){
	m5++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '6' group by id_rec, des_uni");
while(rset.next()){
	m6++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '7' group by id_rec, des_uni");
while(rset.next()){
	m7++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '8' group by id_rec, des_uni");
while(rset.next()){
	m8++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '9' group by id_rec, des_uni");
while(rset.next()){
	m9++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '10' group by id_rec, des_uni");
while(rset.next()){
	m1++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '11' group by id_rec, des_uni");
while(rset.next()){
	m10++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '12' group by id_rec, des_uni");
while(rset.next()){
	m11++;
}

rset=stmt.executeQuery("select id_rec from total_receta where MONTH(fec_carga) = '13' group by id_rec, des_uni");
while(rset.next()){
	m12++;
}

rset=stmt.executeQuery("select id_rec from total_receta group by id_rec, des_uni");
while(rset.next()){
	tot++;
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/dis1.css" type="text/css" />

<title>Untitled Document</title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style4 {color: #003366}
.style5 {
	color: #000000;
	font-weight: bold;
}
.style7 {font-size: 14px}
-->
</style>
</head>

<body>

<form name="form" action="diagxmes.jsp" method="post">
<table width="147" border="0" align="left">
  <tr>
    <td><a href="consultas.html">Regresar a Men&uacute; </a></td>
  </tr>
</table>
<table width="518" height="76" border="2" align="left" bordercolor="#A01B24">
  <tr>
    <th scope="col"><div align="left">
      <table width="581" border="1" cellpadding="1">
        
          <tr>
            <td height="29" colspan="4" bgcolor="#A01B24" class="dis3" ><div align="center">RECETA POR MES</div></td>
            </tr>
          <tr>
            <td colspan="4" bgcolor="#A01B24" class="dis3" align="center" >PERIODO</td>
            </tr>
          <tr>
            <td width="193" height="26"  align="center" bgcolor="#A01B24" class="dis2"><span class="dis2">MES</td>
            <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2014</td>
            
          </tr>
        
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">ENERO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m1)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">FEBRERO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m2)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">MARZO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m3)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">ABRIL</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m4)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">MAYO</td>
           <td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m5)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">JUNIO</td>
          <td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m6)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">JULIO</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m7)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">AGOSTO</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m8)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">SEPTIEMBRE</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m9)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">OCTUBRE</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m10)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">NOVIEMBRE</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m11)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">DICIEMBRE</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=format.format(m12)%></td>
            
          </tr>
          <tr>
          <td colspan="1" bgcolor="#FFFFFF" class="ver-"><div align="center">TOTAL DE RECETAS </div>            
            <div align="center"></div></td>
          <td colspan="1" bgcolor="#FFFFFF" class="ver-"><div align="center"><%=format.format(tot)%></div>            <div align="center"></div></td>
		 
		  
		  
          </tr>         
      </table>
    </div></th>
  </tr>
</table>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<table width="903" border="0">
  <tr>
    <td><div ><span class="style7">Indica el total de Recetas encontradas por mes, en el periodo 2012,2013 y 2014.</span> </div></td>
  </tr>
</table>
<p align="center">&nbsp;</p>
<table width="1011" border="0">
  
</table>
<p>&nbsp;</p>
<%    
con.close();            
%>
</form>
</body>
</html>
