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



Calendar calendar = Calendar.getInstance();
Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.HOUR_OF_DAY, -1);
String hora = "" + df4.format(calendar.getTime());

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

//  Conexi�n a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection(""jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2"");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;


int total_surtido=0, tot_med=0, tot_mat=0;
float imp_tot=0, imp_med=0, imp_mat=0;
String fecha1 = "", fecha2="";


rset=stmt.executeQuery("select min(fec_carga), max(fec_carga) from bitacora;");
while(rset.next()){
	fecha1=rset.getString("min(fec_carga)");
	fecha2=rset.getString("max(fec_carga)");
}

try{
	if(request.getParameter("Submit").equals("Por Fechas")){
		fecha1=df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01";
		fecha2=df.format(df2.parse(request.getParameter("txtf_caduci")))+ " "+hora;
	}
} catch(Exception e) {
}

try{
	rset=stmt.executeQuery("select sum(cant_sur) as sur, sum(cos) as cos from total_dispensado where des_uni = '"+request.getParameter("uni")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and tip_pro = 'MEDICAMENTO';");
	while(rset.next()){
		tot_med=Integer.parseInt(rset.getString("sur"));
		imp_med=Float.parseFloat(rset.getString("cos"));
	}
} catch(Exception e) {tot_mat=0;}

try{
	rset=stmt.executeQuery("select sum(cant_sur), sum(cos)  from total_dispensado where des_uni = '"+request.getParameter("uni")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59';");
	while(rset.next()){
		total_surtido=Integer.parseInt(rset.getString(1));
		imp_tot=Float.parseFloat(rset.getString(2));
	}
} catch(Exception e) {total_surtido=0;}

try{
	rset=stmt.executeQuery("select sum(cant_sur), sum(cos)  from total_dispensado where des_uni = '"+request.getParameter("uni")+"'and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and tip_pro = 'MATERIAL DE CURACION';");
	while(rset.next()){
		tot_mat=Integer.parseInt(rset.getString(1));
		imp_mat=Float.parseFloat(rset.getString(2));
	}
} catch(Exception e) {tot_mat=0;}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<script language="javascript" src="list02.js"></script>
<title>Bienvenido :: SISTEMA DE REPORTES WEB ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/mm_entertainment.css" type="text/css" />
<style type="text/css">
<!--
.style1 {
	font-size: 18px
}
.style2 {
	color: #FF0000
}
.style3 {
	color: #FF0000;
	font-weight: bold;
}
.style6 {
	color: #000066;
	font-weight: bold;
}
.style7 {
	color: #FFFFFF;
	font-weight: bold;
}
.Estilo2 {
	color: #FF0000;
	font-size: 12px;
}
.Estilo3 {
	color: #FFFFFF
}
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<script src="scw.js" type="text/javascript"> </script>
<form action="atla3.jsp?uni=<%=request.getParameter("uni")%>&juris=<%=request.getParameter("juris")%>" method="post" name="form">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr bgcolor="FFFFFF">
  <td height="57" colspan="3" valign="top" nowrap="nowrap" bgcolor="#FFFFFF" id="tagline">Bienvenido(a) </td>
  <td width="821" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
  <td colspan="8"><img src="mm_spacer.gif" alt="" width="1" height="2" border="0" /></td>
</tr>
<tr>
  <td colspan="8" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
</tr>
<tr>
  <td width="175" height="370" valign="top" bgcolor="#FFFFFF"><table border="0" cellspacing="0" cellpadding="0" width="175" id="navigation">
      <tr>
        <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="ixt1.jsp?id_cs=<%=request.getParameter("juris")%>&id_only=">Regresar a Men�</a>
      </tr>
    </table></td>
  <td width="1" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  <td colspan="2" valign="top"><img src="mm_spacer.gif" alt="" width="304" height="1" border="0" /><br />
    <table width="875" border="1" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <td height="41" colspan="3" bgcolor="#FFFFFF"><table width="1247" border="0" cellpadding="2">
            <tr>
              <td><div align="center"><span class="pageName style1">&nbsp;</span><span class="pageName style1">DISPENSADO FARMACIAS - UNIDAD</span></div></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td height="41" colspan="3" bgcolor="#FFFFFF"><span class="pez2">JURISDICCI�N:</span>&nbsp;<%=request.getParameter("juris")%>&nbsp;&nbsp;&nbsp;&nbsp;<span class="pez2"><span class="style7"><a name="ancla2" id="ancla2"></a></span>Unidad:<%=request.getParameter("uni")%></span>&nbsp;&nbsp;&nbsp;<a href="gnr_municipio.jsp?fecha_1_vi=&fecha_2_vi=&id_cs=&mpio="><a href="gnr_municipio.jsp?fecha_1_vi=&fecha_2_vi=&id_cs=&mpio="></a></td>
      </tr>
      <tr>
        <td width="" bgcolor="#FFFFFF" class="bodyText" colspan="0">Cantidad de piezas (Medicamento)</td>
        <td width="" bgcolor="#FFFFFF" class="bodyText"><%=format.format(tot_med)%></td>
        <td width="" bgcolor="#FFFFFF" class="bodyText">$ <%=format2.format(imp_med)%></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" class="bodyText">Cantidad de piezas (Material de Curaci&oacute;n)</td>
        <td bgcolor="#FFFFFF" class="bodyText" ><%=format.format(tot_mat)%></td>
        <td width="" bgcolor="#FFFFFF" class="bodyText">$ <%=format2.format(imp_mat)%></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" class="bodyText">Total de Piezas: </td>
        <td bgcolor="#FFFFFF" class="bodyText"><%=format.format(total_surtido)%></td>
        <td width="" bgcolor="#FFFFFF" class="bodyText">$ <%=format2.format(imp_tot)%></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" class="bodyText" colspan="3"><strong>Rango de fechas</strong>:
          <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha1))%>">
          </label>
          &nbsp;&nbsp;&nbsp;&nbsp;
          <label> al&nbsp;&nbsp;
            <input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha2))%>">
          </label>
          <input type="submit" name="Submit" value="Por Fechas"/>
          <label>
            <input type="submit" class="bodyText" value="<<Valores Iniciales>>"/>
          </label></td>
      </tr>
      <tr>
        <td colspan="3"><span class="Estilo2">&nbsp;&nbsp;</span></td>
      </tr>
      <tr>
        <td height="16" colspan="3" class="bodyText">
        <table width="80%" cellpadding="0" cellspacing="0" border="0">
            <tr bgcolor="#FFFFFF" height="17">
              <td height="127" colspan="2"><div align="center">
              <table width="80%" cellpadding="0" cellspacing="0" border="1">
              	<tr bgcolor="#CCCCCC">
                	<td>Cedula</td>
                    <td>Nombre del Medico</td>
                    <td>Solicitado</td>
                    <td>Surtido</td>
                    <td>Nivel de Servicio</td>
                    <td>Importe</td>
                </tr>
                <%
				try{
							rset=stmt.executeQuery("select cedula, nom_med, sum(can_sol) as sol, sum(cant_sur) as sur, sum(cos) as cos from total_receta WHERE  des_uni = '"+request.getParameter("uni")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' GROUP BY cedula ORDER BY cedula+0;");
							while(rset.next()){
				%>
                <tr>
               		<td><div  align="center" ><%=rset.getString(1)%></div></td>
                    <td><a href="atla4.jsp?uni=<%=request.getParameter("uni")%>&cedula=<%=rset.getString(1)%>&juris=<%=request.getParameter("juris")%>"><%=rset.getString(2)%></a></td>
                    <td><div  align="center" ><%=format.format(Integer.parseInt(rset.getString(3)))%></div></td>
                    <td><div  align="center" ><%=format.format(Integer.parseInt(rset.getString(4)))%></div></td>
                    <td><div  align="center" ><%=forma2.format(Integer.parseInt(rset.getString(4))*100/Integer.parseInt(rset.getString(3)))%> %</div></td>
                    <td><div  align="right"  class="style3">$ <%=forma2.format(Float.parseFloat(rset.getString(5)))%></div></td>
                </tr>
                 <%
							}
						} catch(Exception e) {}
						%>
              </table>
              </div></td>
            </tr>
          </table></td>
      </tr>
      <link rel="stylesheet" href="../../../jq/themes/base/jquery.ui.all.css">
      <script src="../../../jq/jquery-1.9.0.js"></script> 
      <script src="../../../jq/ui/jquery.ui.core.js"></script> 
      <script src="../../../jq/ui/jquery.ui.widget.js"></script> 
      <script src="../../../jq/ui/i18n/jquery.ui.datepicker-es.js"></script> 
      <script src="../../../jq/ui/jquery.ui.datepicker.js"></script> 
      <script>
    $(function() {
        $("#datepicker").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	$(function() {
        $("#datepicker1").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	// Traducci�n al espa�ol
$(function($){
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: '<Ant',
        nextText: 'Sig>',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Mi�rcoles', 'Jueves', 'Viernes', 'S�bado'],
        dayNamesShort: ['Dom','Lun','Mar','Mi�','Juv','Vie','S�b'],
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','S�'],
        weekHeader: 'Sm',
        dateFormat: 'dd/mm/yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['es']);
});
</script>
      <link rel="stylesheet" href="../../../css/demos.css">
    </table>
</body>
</html>
</form>