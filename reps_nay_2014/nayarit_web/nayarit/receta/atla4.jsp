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

//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection(""jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2"");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;


int tot_rec=0, tot_sol=0, tot_sur=0;
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

rset=stmt.executeQuery("select id_rec from total_receta where cedula = '"+request.getParameter("cedula")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' group by id_rec;");
while(rset.next()){
	tot_rec++;
}

rset=stmt.executeQuery("select sum(can_sol) from total_receta where cedula = '"+request.getParameter("cedula")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59';");
while(rset.next()){
	tot_sol=Integer.parseInt(rset.getString(1));
}

rset=stmt.executeQuery("select sum(cant_sur) from total_receta where cedula = '"+request.getParameter("cedula")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59';");
while(rset.next()){
	tot_sur=Integer.parseInt(rset.getString(1));
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
<link rel="stylesheet" href="../../../css/mm_entertainment.css" type="text/css" />
<link href="../../../css/dis1.css" rel="stylesheet" type="text/css" />
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
	color: #FFFFFF
}
-->
</style>
</head>

<body bgcolor="#FFFFFF">
<script src="../../../js/scw.js" type="text/javascript"> </script>
<form action="atla4.jsp?uni=<%=request.getParameter("uni")%>&juris=<%=request.getParameter("juris")%>&cedula=<%=request.getParameter("cedula")%>" method="post" name="form">
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
      <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="atla3.jsp?uni=<%=request.getParameter("uni")%>&juris=<%=request.getParameter("juris")%>&">Regresar a Menú</a></td>
    </tr>
    <tr>
      <td colspan="2" valign="top"><img src="mm_spacer.gif" alt="" width="304" height="1" border="0" /><br />
        <table border="1" cellspacing="0" cellpadding="0" width="1019">
          <tr>
            <td width="951" height="41" bgcolor="#FFFFFF" class="pageName style1">&nbsp;</td>
            <td width="62" height="41" bgcolor="#FFFFFF" class="pageName style1"><a href="gnr_uniaten_dif.jsp?"><!--img src="icono_excel.gif" border="0"/--></a>&nbsp;</td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="bodyText">Cantidad de Recetas Expedidas : </td>
            <td bgcolor="#FFFFFF" class="bodyText" align="center" ><%=tot_rec%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="bodyText">Cantidad de Medicamento Solicitado: </td>
            <td bgcolor="#FFFFFF" class="bodyText" align="center"><%=tot_sol%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="bodyText">Cantidad de Medicamento Surtido: </td>
            <td bgcolor="#FFFFFF" class="bodyText" align="center"><%=tot_sur%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="bodyText">Nivel de Servicio: </td>
            <td bgcolor="#FFFFFF" class="bodyText"><%=forma2.format((tot_sur)*100/tot_sol)%> %</td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="bodyText" colspan="2">Rango de fechas del:&nbsp;&nbsp;
              <label>
                <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha1))%>">
              </label>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <label> al&nbsp;&nbsp;
                <input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha2))%>">
              </label>
              <input type="submit" name="Submit" value="Por Fechas"/>
              <label></label>
              <input name="submit" type="submit" value="<<Valores Iniciales>>" /></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="bodyText" colspan="2">Rango Val&iacute;do del  al </td>
          </tr>
          <tr>
            <td height="16"  valign="top" class="bodyText"><table width="914" cellpadding="0" cellspacing="0" border="0">
                <col width="80" span="2" />
                <tr height="17">
                  <td width="876" bgcolor="#FFFFFF" class="style3" valign="top"></td>
                </tr>
                <tr bgcolor="#FFFFFF" height="17">
                  <td height="17" valign="top"><table width="951" border="1" cellpadding="0" cellspacing="0">
                      <col width="70" />
                      <col width="336" />
                      <col width="71" />
                      <col width="82" />
                      <col width="23" />
                      <col width="80" />
                      <col width="330" />
                      <col width="80" span="2" />
                      <tr height="17">
                        <td height="23" colspan="5" background="../../../imagen/fon3.jpg" bgcolor="#660000" class="dis3"><div align="left" class="style7" >
                            <div align="center">RECETAS ELABORADAS</div>
                          </div></td>
                      </tr>
                      <tr class="style6" height="17">
                        <td width="84" height="17" bgcolor="#CCCCCC" class="dis2 style7">Folio de la Receta </td>
                        <td width="90" bgcolor="#CCCCCC" class="dis2"><div align="center" class="style7">Cantidad Solicitada </div></td>
                        <td width="76" bgcolor="#CCCCCC" class="dis2"><div align="center" class="style7">Cantidad Surtida</div></td>
                        <td width="76" bgcolor="#CCCCCC" class="dis2"><div align="center" class="style7">Nivel de Servicio</div></td>
                        <td width="84" bgcolor="#CCCCCC" class="dis2"><div align="center">Recetas</div></td>
                      </tr>
                      <%
				try{
							rset=stmt.executeQuery("select fol_rec, sum(can_sol), sum(cant_sur) from total_receta WHERE  cedula = '"+request.getParameter("cedula")+"' and fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' GROUP BY fol_rec ORDER BY fol_rec+0;");
							while(rset.next()){
				%>
                      <tr height="17">
                        <td height="17" align="right" class="ver"><%=rset.getString(1)%></td>
                        <td class="ver"><div align="center"><%=rset.getString(2)%></div></td>
                        <td class="ver"><div align="center"><%=rset.getString(3)%></div></td>
                        <td class="ver"><div align="center"><span class="style6"><%=forma2.format(Integer.parseInt(rset.getString(3))*100/Integer.parseInt(rset.getString(2)))%> %</span></div></td>
                        <td class="ver"><div align="center"><a href="ticket.jsp?fol_rec=<%=rset.getString(1)%>&uni=<%=request.getParameter("uni")%>&juris=<%=request.getParameter("juris")%>&cedula=<%=request.getParameter("cedula")%>">Ver Receta</a></div></td>
                      </tr>
                      <%
							}
						} catch(Exception e) {}
						%>
                    </table>
                    <div align="center"></div></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
      <td width="4" valign="top" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="10" border="0" /><br />
        <br /></td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
    <tr>
      <td width="175" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="1"></td>
      <td width="50" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="821" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="54" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
      <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
    <link rel="stylesheet" href="../../../jq/themes/base/jquery.ui.all.css">
    <script src="../../../jq/jquery-1.9.0.js"></script> 
    <script src="../../../jq/ui/jquery.ui.core.js"></script> 
    <script src="../../../jq/ui/jquery.ui.widget.js"></script> 
    <script src="../../../jq/ui/i18n/jquery.ui.datepicker-es.js"></script> 
    <script src="../../../jq/ui/jquery.ui.datepicker.js"></script>
    <link rel="stylesheet" href="../../../css/demos.css">
    <script>
    $(function() {
        $("#datepicker").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	$(function() {
        $("#datepicker1").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	// Traducción al español
$(function($){
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: '<Ant',
        nextText: 'Sig>',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
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
  </table>
</form>
</body>
</html>
<%
con.close();
%>