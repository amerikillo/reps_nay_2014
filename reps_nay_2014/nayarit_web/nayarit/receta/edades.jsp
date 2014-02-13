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


float tot_2=0, tot_5=0, tot_12=0, tot_18=0, tot_28=0, tot_44=0, tot_65=0, tot_o=0, tot=0;
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

rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta group by num_afi;");
while(rset.next()){
	tot++;
}

rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) <='2' group by  num_afi;");
while(rset.next()){
	tot_2++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) between '3' and '5' group by  num_afi;");
while(rset.next()){
	tot_5++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) between '6' and '12' group by  num_afi;");
while(rset.next()){
	tot_12++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) between '13' and '18' group by  num_afi;");
while(rset.next()){
	tot_18++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) between '19' and '28' group by  num_afi;");
while(rset.next()){
	tot_28++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) between '29' and '44' group by  num_afi;");
while(rset.next()){
	tot_44++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) between '45' and '65' group by  num_afi;");
while(rset.next()){
	tot_65++;
}
rset=stmt.executeQuery("select ((YEAR(CURDATE())-YEAR(FEC_NAC))) AS edad from total_receta where ((YEAR(CURDATE())-YEAR(FEC_NAC))) > '65' group by  num_afi;");
while(rset.next()){
	tot_o++;
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
.style7 {font-size: 14px}
.style12 {color: #333333; font-weight: bold; }
-->
</style>
</head>

<body>

<form name="form" action="edades.jsp" method="post">
<table width="147" border="0" align="left">
  <tr>
    <td><a href="consultas.html">Regresar a Men&uacute; </a></td>
  </tr>
</table>
<table width="518" height="76" border="2" align="left" bordercolor="#A01B24">
  <tr>
    <th scope="col"><div align="left">
      <table width="510" cellpadding="1">
        <tr>
          <td width="225" bgcolor="#A01B24" class="dis2" ><span class="style2">Rango de edad </td>
          <td width="130" height="29" align="center" bgcolor="#A01B24" class="dis2" >Cantidad</td>
          <td width="139" height="29" align="center" bgcolor="#A01B24" class="dis2" >Proporci&oacute;n</td>
          </tr>
        
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Reci&eacute;n Nacidos de <!--a href="diagtt0A2isem.jsp"-->0 A 2  Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_2)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_2/tot))%></div></td>
          </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Preescolar de<!--a href="diagtt3a5isem.jsp"--> 3 A 5 Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_5)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_5/tot))%></div></td>
          </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Escolares de <!--a href="diagtt6a12isem.jsp"-->6 A 12 Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_12)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_12/tot))%></div></td>
           </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Adolecentes <!--a href="diagtt13a18isem.jsp"-->13 A 18 Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_18)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_18/tot))%></div></td>
          </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Adulto Joven <!--a href="diagtt19a28isem.jsp"-->19 A 28 Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_28)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_28/tot))%></div></td>
          </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Adulto Medio de<!--a href="diagtt29a44isem.jsp"--> 29 A 44  Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_44)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_44/tot))%></div></td>
          </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Adulto Mayor de <!--a href="diagtt45a65isem.jsp"-->45 A 65  Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_65)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_65/tot))%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"></div></td>
          </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><span class="style12">Tercera Edad Mayor de <!--a href="diagtt66isem.jsp"-->65  Años<!--/a--></span></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=format.format(tot_o)%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><%=forma2.format((float)(tot_o/tot))%></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"></div></td>
        </tr>
        <tr class="ver">
          <td bgcolor="#FFFFFF" class="ver"><div align="right" class="style12">TOTAL EDAD </div></td>

  
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><strong><%=format.format(tot)%></strong></div></td>
          <td bgcolor="#FFFFFF" class="ver"><div align="center"><strong>1</strong></div></td>
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
<table width="699" border="0">
  <tr>
    <td><div align="left" class="ver"><span class="ver">Indica el n&uacute;mero total de pacientes atendidos por  rango de edades y la proporci&oacute;n en ambas unidades de atenci&oacute;n.</span></div></td>
  </tr>
</table>
<p align="left">&nbsp;</p>
<p>&nbsp;</p>
<%
con.close();
%>

</form>
</body>
</html>
