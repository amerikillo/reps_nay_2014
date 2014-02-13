<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" session = "true" %>

<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DecimalFormat format = new java.text.DecimalFormat("###,###,###,###");%>
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

response.setContentType ("application/vnd.ms-excel"); 
response.setHeader ("Content-Disposition", "attachment;filename=\"Dispensado por Farmacias "+request.getParameter("id_cs")+".xls\"");

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

int total_surtido=0, cont_mun=0;
String fecha1 = "", fecha2="";
String juris = request.getParameter("id_cs");

rset=stmt.executeQuery("select min(fec_carga), max(fec_carga) from bitacora;");
while(rset.next()){
	fecha1=rset.getString("min(fec_carga)");
	fecha2=rset.getString("max(fec_carga)");
}

try{
		fecha1=df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01";
		fecha2=df.format(df2.parse(request.getParameter("txtf_caduci")))+ " 23:59:59";
} catch(Exception e) {
}

rset=stmt.executeQuery("select sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' and des_jur = '"+request.getParameter("id_cs")+"';");
while(rset.next()){
	total_surtido=Integer.parseInt(rset.getString(1));
}



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>


<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<script language="javascript" src="../../../js/list02.js"></script>
<title>Bienvenido :: SISTEMA DE REPORTES WEB ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
<!--
.style1 {font-size: 18px}
.style3 {color: #FF0000; font-weight: bold; }
.style4 {color: #000000}
.style5 {color: #000066}
.style6 {color: #000066; font-weight: bold; }
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<p>
  <script src="../../../js/scw.js" type="text/javascript"> </script>
  <form action="ixt1.jsp?id_cs=<%=request.getParameter("id_cs")%>" method="post" name="form">
</p>
<table width="1059" border="0" cellpadding="2">
  <tr>
    <td width="1051"><div align="left"><span class="pageName style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DISPENSADO FARMACIAS - <%=request.getParameter("id_cs")%></span><span class="pageName"></span></div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  

 
   <tr>
    <td colspan="8"><img src="mm_spacer.gif" alt="" width="1" height="2" border="0" /></td>
  </tr>

   <tr>
    <td colspan="8" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>

  
  <tr>
    <td width="1" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
    <td width="50">&nbsp;</td>
    <td colspan="3" valign="top"><img src="mm_spacer.gif" alt="" width="304" height="1" border="0" /><br />
	<table border="1" cellspacing="0" cellpadding="0" width="690">
        <tr>
          <td height="41" colspan="2" bgcolor="#FFFFFF" class="pageName style1">&nbsp;</td>
			  <td width="161" height="41" bgcolor="#FFFFFF" class="pageName style1">&nbsp;</td>
			 
			  <td width="161" height="41" bgcolor="#FFFFFF" class="pageName style1"></td>
			  
        </tr>
       
		<tr>
          <td width="428" bgcolor="#FFFFFF" class="bodyText style4">Total de Piezas: <%=format.format(total_surtido)%></td>
          <td width="95" bgcolor="#FFFFFF" class="bodyText"><span class="style4"><strong>&nbsp;</strong></span></td>
          <td bgcolor="#FFFFFF" class="bodyText">&nbsp;</td>
		</tr>
        <tr>
          <td bgcolor="#FFFFFF" class="bodyText" colspan="3"><span class="style4"><strong>Rango de fechas</strong></span>: 
        <%=df2.format(df3.parse(fecha1))%>
        </label> &nbsp;&nbsp;&nbsp;&nbsp;<label>
         <span class="style4">al&nbsp;</span>&nbsp;<%=df2.format(df3.parse(fecha2))%>
        </label><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br />
        <span class="style4">&nbsp;</span><!--a href="totales2.jsp">Total  Hospitales</a--></td>
        </tr>
        <tr>
          <td colspan="3" bgcolor="#FFFFFF" class="bodyText style4">
        <!------------------------------------------------------------------------------------>
        <table width="690" border="0" bgcolor="#EEEEEE" cellpadding="3">
        <tr>
        <td width="360">&nbsp;</td>
        <td width="78" class="tit_tablas">Requisición</td>
        <td width="60" class="tit_tablas">Abasto</td>
        <td width="62" class="tit_tablas">Importe</td>
        </tr>
        <%
		String qry_muni= "select des_mun, sum(can_sol) as sol, sum(cant_sur) as sur, sum(cos) as cos from total_dispensado where des_jur = '"+request.getParameter("id_cs")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' group by des_mun;";
		rset = stmt.executeQuery(qry_muni);
		while(rset.next()){
			cont_mun++;
			String muni = rset.getString("des_mun");
			String m_sol = rset.getString("sol");
			String m_sur = rset.getString("sur");
			String m_cos = rset.getString("cos");
			%>
            
            	<tr class="mun_uni">
                <td ><a onClick="showHideItems('item<%=cont_mun%>',1);" class="link_muestra_u">Mostrar Unidades de: </a><a class="link_mun" href="atla2.jsp?mun=<%=muni%>&juris=<%=request.getParameter("id_cs")%>"><%=muni%></a></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sol))%></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sur))%></td>
                <td class=" numeros">$<%=forma2.format(Float.parseFloat(m_cos))%></td>
        </tr>
                <td colspan="4">
                <div id="item<%=cont_mun%>" style="display:display" align="justify" >
                <table border="1" width="680" class="mun_uni" bgcolor="#FFFFFF" bordercolor="#EEEEEE" cellspacing="0" cellpadding="3">
				<%
				String qry_uni = "select des_uni, sum(can_sol) as sol, sum(cant_sur) as sur, sum(cos) as cos from total_dispensado where des_mun = '"+muni+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"'  group by des_uni;";
				rset2 = stmt2.executeQuery(qry_uni);
				while(rset2.next()){
					String uni = rset2.getString(1);
					String u_sol = rset2.getString(2);
					String u_sur = rset2.getString(3);
					String u_cos = rset2.getString("cos");
				%>
                	<tr>
                    	<td width="300"><a class="link_uni" href="atla3.jsp?uni=<%=uni%>&juris=<%=juris%>"><%=uni%></a></td>
                        <td width="70" class="numeros"><%=forma.format(Integer.parseInt(u_sol))%></td>
                        <td width="50" class="numeros"><%=forma.format(Integer.parseInt(u_sur))%></td>
                        <td width="46">$<%=forma2.format(Float.parseFloat(u_cos))%></td>
                    </tr>
                <%
				}
				%>
                </table>
                </div>
                </td>
            
            <%
		}
		%>
        </table>
          <!------------------------------------------------------------------------------------>
          </td>
        </tr>
        <tr>
          <td height="16" colspan="3" class="bodyText"><div align="center"></div></td>
        </tr>
		<tr>
          <td colspan="3" bgcolor="#FFFFFF" class="bodyText"><div align="center" class="style3">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></span></td>
        </tr>
      </table>    </td>
   
    <td width="245" valign="top" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="10" border="0" /><br />
    <br /> </td>
    <td width="221" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td width="155" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="1"></td>
    <td width="50" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="221" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="110" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="50" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="245" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="221" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
	
	
</table>
</body>
</html>
<%    
           con.close();
%>
</form>