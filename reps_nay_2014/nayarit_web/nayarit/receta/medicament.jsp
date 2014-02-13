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
		fecha2=df.format(df2.parse(request.getParameter("txtf_caduci")))+ " 23:59:59";
	}
} catch(Exception e) {
}

rset=stmt.executeQuery("select sum(cant_sur) as sur from total_receta WHERE ID_TIP='1' AND fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' GROUP BY fol_rec ORDER BY sur desc limit 0,20;");
while(rset.next()){
	tot_sur=tot_sur+Integer.parseInt(rset.getString(1));
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
.style11 {
	font-weight: bold
}
.style12 {
	color: #FFFFFF
}
-->
</style>
</head>

<body>
<script src="scw.js" type="text/javascript"> </script>
<form name="form" action="medicament.jsp" method="post">
  <table width="133" border="0">
    <tr>
      <td><p><a href="consultas.html">Regresar a Men&uacute; </a></p>
        <p>&nbsp;</p></td>
    </tr>
  </table>
  <a name="ancla3" id="ancla3"></a>
  <table width="1015" border="1" cellpadding="2" bordercolor="#7D2322" class="ver">
    <tr>
      <td width="585"><table width="1005" border="1" cellpadding="0">
          <tr height="17">
            <td height="26" colspan="7" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><div align="center"><a href="#ancla1" class="style8">PRINCIPALES MEDICAMENTOS RECETADOS </a></div></td>
          </tr>
          <tr height="17">
            <td height="26" colspan="2" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0">&nbsp;</td>
            <td height="26" colspan="2" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><span class="style12"><strong>Rango de fechas</strong>:</span>
              <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha1))%>">
              &nbsp;&nbsp;&nbsp;&nbsp;
              <label> <span class="style12">al&nbsp;</span>&nbsp;
                <input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha2))%>">
              </label>
              <input type="submit" name="Submit" value="Por Fechas" />
              <span class="style12"></span></td>
            <td height="26" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><input type="submit" name="Submit" value="Valores Iniciales" /></td>
          </tr>
          <tr height="17">
            <td height="26" colspan="5" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><span class="style12">Periodo del:</span> <span class="style12"></span>&nbsp;&nbsp;<span class="style12">al</span>&nbsp;<span class="style12">&nbsp;</span></td>
          </tr>
          <tr height="17">
            <td width="51" bgcolor="#CCCCCC" class="dis2"><div align="center">N°</div></td>
            <td width="51" height="23" bgcolor="#CCCCCC" class="dis2"><div align="center">CLAVE</div></td>
            <td width="457" height="23" bgcolor="#CCCCCC" class="dis2"><div align="center">DESCRIPCION</div></td>
            <td width="117" bgcolor="#CCCCCC" class="dis2"><div align="center"><span class="style3">CANTIDAD</span></div></td>
            <!--td width="117" bgcolor="#CCCCCC" class="dis2"><div align="center">COSTO</div></td>
                           <td width="117" bgcolor="#CCCCCC" class="dis2"><div align="center">COSTO PROMEDIO </div></td-->
            <td width="118" bgcolor="#CCCCCC" class="dis2"><div align="center">PROPORCION</div></td>
          </tr>
          
           <%
		   int cont=1;
		   
				try{
							rset=stmt.executeQuery("select cla_pro, des_pro, sum(cant_sur) as sur from total_receta WHERE ID_TIP='1' AND  fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' GROUP BY fol_rec ORDER BY sur desc limit 0,20;");
							while(rset.next()){
								float prop = Float.parseFloat(rset.getString(3))/tot_sur;
				%>
          <tr height="17">
            <td align="center" width="51"><%=cont%></td>
            <td height="17" align="right" width="51"><div align="center"><%=rset.getString(1)%></div></td>
            <td width="457"><div align="left"><%=rset.getString(2)%></div></td>
            <td align="right" width="117"><div align="center"><span class="style3"></span><%=rset.getString(3)%></div></td>
            <td width="117"><div align="center"><%=prop%></div>
          </tr>
          <%
		  cont++;
							}
						} catch(Exception e) {}
						%>
          <tr height="17">
            <td valign="top">&nbsp;</td>
            <td height="17" valign="top">&nbsp;</td>
            <td><div align="left"></div>
              <a href="#ancla3">&nbsp;Ir Encabezado</a></td>
            <td align="right"><div align="center"><strong><a name="ancla1" id="ancla1"></a><%=tot_sur%></strong></div>
              <div align="center" class="style2 style11">
                <div align="center">&nbsp;</div>
              </div></td>
            <td><div align="center"><strong> 1</strong></div></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="602" border="0" cellpadding="0" cellspacing="0" bordercolor="#000033">
    <tr>
      <td width="74">&nbsp;</td>
      <td width="442"><div align="center"></div></td>
      <td width="78"><div align="center"></div></td>
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
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</form>
</body>
</html>
