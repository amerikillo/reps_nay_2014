<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="" session = "true"%>
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


int total_surtido=0, tot_jur1=0, tot_jur2=0, tot_jur3=0;
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
rset=stmt.executeQuery("select sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"';");
while(rset.next()){
	total_surtido=Integer.parseInt(rset.getString(1));
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>Text</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/mm_health_nutr.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
//--------------- LOCALIZEABLE GLOBALS ---------------
var d=new Date();
var monthname=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
//Ensure correct for language. English is "January 1, 2004"
var TODAY = monthname[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear();
//---------------   END LOCALIZEABLE   ---------------

</script>
<!-- Codigo contadorvisitas.com ver. 4.3 -->
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function GetCookie (name) { 
var arg = name + "="; 
var alen = arg.length; 
var clen = document.cookie.length; 
var i = 0; 
while (i < clen) {
var j = i + alen; 
if (document.cookie.substring(i, j) == arg) 
return getCookieVal (j); 
i = document.cookie.indexOf(" ", i) + 1; 
if (i == 0) break; 
} 
return null;
}
function SetCookie (name, value) { 
var argv = SetCookie.arguments; 
var argc = SetCookie.arguments.length; 
var expires = (argc > 2) ? argv[2] : null; 
var path = (argc > 3) ? argv[3] : null; 
var domain = (argc > 4) ? argv[4] : null; 
var secure = (argc > 5) ? argv[5] : false; 
document.cookie = name + "=" + escape (value) + 
((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + 
((path == null) ? "" : ("; path=" + path)) + 
((domain == null) ? "" : ("; domain=" + domain)) + 
((secure == true) ? "; secure" : "");
}
function DeleteCookie (name) { 
var exp = new Date(); 
exp.setTime (exp.getTime() - 1); 
var cval = GetCookie (name); 
document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString();
}
var expDays = 30;
var exp = new Date(); 
exp.setTime(exp.getTime() + (expDays*24*60*60*1000));
function amt(){
var count = GetCookie('count')
if(count == null) {
SetCookie('count','1')
return 1
}
else {
var newcount = parseInt(count) + 1;
DeleteCookie('count')
SetCookie('count',newcount,exp)
return count
}
}
function getCookieVal(offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}
// End -->
</SCRIPT>
<!-- FIN Codigo contadorvisitas.com -->
                    
<style type="text/css">
<!--
.style1 {font-weight: bold}
.style3 {font-weight: bold}
.style5 {font-weight: bold; font-size: 24px; }
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<script src="../../../js/scw.js" type="text/javascript"> </script>
<a href="../../index.jsp" style="font-family:Verdana, Geneva, sans-serif; font-size:14px">Regresar a Men&uacute; </a>
<form action="infor.jsp" method="post" name="form">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td> </tr>
 <tr>
   <td width="382">&nbsp;</td>
    <td width="382"><table border="0" cellspacing="0" cellpadding="0" width="495">
      <tr>
        <td width="6">&nbsp;&nbsp;</td>
        <td width="489"><table border="1" cellspacing="0" cellpadding="0" width="507">
            <tr>
              <td height="47" colspan="2" class="pageName style1"><div align="center">
                <p><span class="ROJO">Dispensado en Farmacias</span><span class="ROJO"> <br />
                ENERO 2014</span>.</p>
              </div></td>
            </tr>
            <tr>
              <td width="236" class="bodyText">Cantidad de piezas: <%=format.format(total_surtido)%></td>
              
              <td width="265" class="style3"><div align="center" class="subHeader"></div></td>
            </tr>
            <tr>
              <td colspan="2" class="bodyText"><div align="right">Exportar:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../../imagen/exc.jpg" width="37" height="29" border="0" usemap="#Map2"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input name="Submit2" type="submit" class="bodyText" value="<<Valores Iniciales>>" />
              </div></td>
            </tr>
            <tr>
              <td bgcolor="#FFFFFF" class="bodyText" colspan="2">Rango de fechas del:&nbsp;&nbsp;
                  <label>
                  <input name="txtf_caduc" type="text" id="txtf_date1" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha1))%>">
                  </label>                  &nbsp;&nbsp;&nbsp;&nbsp;
                  <label> al&nbsp;&nbsp;
                  <input name="txtf_caduci" type="text" id="txtf_date2" size="10" readonly title="dd/mm/aaaa" value="<%=df2.format(df3.parse(fecha2))%>">
                  </label>
                  <input type="submit" name="Submit" value="Por Fechas"/>
                  <label></label>
                &nbsp;&nbsp;&nbsp;&nbsp;
                
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="../receta/receta_elec.jsp">Receta Electr&oacute;nica</a></td>
            </tr>
            <tr>
              <td bgcolor="#DDDDDD" class="subHeader">Por Jurisdicci&oacute;n </td>
              <td bgcolor="#DDDDDD" class="subHeader"><div align="center">Piezas</div>
                  <div align="center"></div></td>
            </tr>
            <%
			rset=stmt.executeQuery("select des_jur, sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' AND DES_JUR='JURISDICCION SANITARIA I'  group by des_jur;");
			while(rset.next()){
				tot_jur1=Integer.parseInt(rset.getString(2));
			%>
            <tr>
              <td class="bodyText"><div class="subHeader"><a href="ixt1.jsp?id_cs=JURISDICCION SANITARIA I"><%=rset.getString("des_jur")%></a></div></td>
              <td class="bodyText"><div align="center" class="subHeader"><%=format.format(Integer.parseInt(rset.getString(2)))%></div></td>
            </tr>
            <%
			}
			%>
            <%
			rset=stmt.executeQuery("select des_jur, sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' AND DES_JUR='JURISDICCION SANITARIA II' group by des_jur;");
			while(rset.next()){
				tot_jur2=Integer.parseInt(rset.getString(2));
			%>
            <tr>
              <td class="bodyText"><div class="subHeader"><a href="ixt1.jsp?id_cs=JURISDICCION SANITARIA II"><%=rset.getString("des_jur")%></a></div></td>
              <td class="bodyText"><div align="center" class="subHeader"><%=format.format(Integer.parseInt(rset.getString(2)))%></div></td>
            </tr>
            <%
			}
			%>
            <%
			rset=stmt.executeQuery("select des_jur, sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' AND DES_JUR='JURISDICCION SANITARIA IiI'  group by des_jur;");
			while(rset.next()){
				tot_jur3=Integer.parseInt(rset.getString(2));
			%>
            <tr>
              <td class="bodyText"><div class="subHeader"><a href="ixt1.jsp?id_cs=JURISDICCION SANITARIA III"><%=rset.getString("des_jur")%></a></div></td>
              <td class="bodyText"><div align="center" class="subHeader"><%=format.format(Integer.parseInt(rset.getString(2)))%></div></td>
            </tr>
            <%
			}
			%>
            <tr>
              <td class="bodyText"><div align="center" class="subHeader"><!--a href="totales2.jsp"-->TOTAL DISPENSADO<!--/a--></div></td>
              <td class="style3"><div align="center" class="subHeader"><%=format.format(total_surtido)%></div></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
    <td width="382">&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="637"><div align="center">
    
      <p><span class="style5"><p class="style5"><script type="text/javascript" src="../../../jq/jquery.min.js"></script>
		<script type="text/javascript">
function addCommas(nStr)
   {
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
   }

$(function () {




    var chart;
	var atl=<%=tot_jur1%>;
	var atl2=addCommas(atl);
	var ixtl=<%=tot_jur2%>;
	var ixtl2=addCommas(ixtl);	
	var jilo=<%=tot_jur3%>;
	var jilo2=addCommas(jilo);
	var tngo=0;
	var tngo2=addCommas(tngo);
	var tolu=0;
	var tolu2=addCommas(tolu);
	var xona=0;
	var xona2=addCommas(xona);
	var teju=0;
	var teju2=addCommas(teju);
	var tenc=0;
	var tenc2=addCommas(tenc);
	var vall=0;
	var vall2=addCommas(vall);
	
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'PIEZAS DISPENSADAS'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 2
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name ;
                        }
                    }
                }
            },

            series: [{
                type: 'pie',
                name: 'Porcentaje',
                data: [
                    
                    ['JURISDICCION SANITARIA I'+'</b>: '+ atl2,       atl],
					
					
                    {
                        name: 'JURISDICCION SANITARIA II'+'</b>: '+ ixtl2,
                        y: ixtl,
                        sliced: true,
                        selected: true
                    },
                   
                    ['JURISDICCION SANITARIA III'+'</b>: '+ jilo2,     jilo]
                    
                ]
            }]
        });
    });
    
}); 
		</script>
	</head>
	<body>
<script src="../../../js/highcharts.js"></script>
<script src="../../../js/modules/exporting.js"></script>

<link rel="stylesheet" href="../../../jq/themes/base/jquery.ui.all.css">
	<script src="../../../jq/jquery-1.9.0.js"></script>
	<script src="../../../jq/ui/jquery.ui.core.js"></script>
	<script src="../../../jq/ui/jquery.ui.widget.js"></script>
	<script src="../../../jq/ui/i18n/jquery.ui.datepicker-es.js"></script>
	<script src="../../../jq/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="../../../css/demos.css">
	<script>
    $(function() {
        $("#txtf_date1").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	$(function() {
        $("#txtf_date2").datepicker({dateFormat: "dd/mm/yy"}).val()
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
<div id="container" style="min-width: 800px; height: 400px; margin: 0 auto"></div>

	</body></p><br />
          <br />
      </span></p>
    </div>    </td>
	<td width="100%">&nbsp;</td>  </tr>
  <tr>
    <td>&nbsp;</td>
  <td>
  <table border="0" cellspacing="0" cellpadding="0" width="507">
        <tr>
          <td width="507" colspan="2" align="center" class="sidebarHeader" id="sidebarHeader">&nbsp;</td>        </tr>

        <!--tr>
		<td>**Informaci&oacute;n generada y validada del per&iacute;odo del 10/Marzo/2009 al 31/Julio/2012</td>		
        </tr-->
		<tr>
  <td>&nbsp; </td>		
		</tr></table></td>
<td>&nbsp;</td>
<td>
<table border="0" cellspacing="0" cellpadding="0" width="460">
       

        <tr>
		<td width="131">&nbsp;</td>
		<td width="329" class="smallText" id="sidebar">
Visitante No.&nbsp;&nbsp;

</SCRIPT>		  </td></tr></table></td></tr></table>

<map name="Map2" id="Map2"><area shape="rect" coords="4,3,31,29" href="gnr_infor2.jsp?txtf_caduc=<%=fecha1%>&txtf_caduci=<%=fecha2%>" />
</map>
</body>
</html>

</form>
<%
con.close();
%>