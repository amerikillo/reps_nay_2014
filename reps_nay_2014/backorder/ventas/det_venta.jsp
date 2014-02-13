<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="../../pag_man.html" session = "true"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat sdf = new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy"); %>
<%NumberFormat forma= NumberFormat.getInstance(Locale.US); %>
<%
DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
simbolos.setDecimalSeparator('.');
simbolos.setGroupingSeparator(',');
DecimalFormat forma2= new DecimalFormat("##,###.##", simbolos);
%>

<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String val="", user="", rol="";



if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
	rol=(String)sesion.getAttribute("rol");
}

//out.print(user);
if(!val.equals("valido")){
	
	%>
    <script>self.location='../index.jsp';</script>
    <%
}

%>
<%
Class.forName("org.gjt.mm.mysql.Driver");
Connection conexion=null;
String mensaje="";
/*parametros para la conexion*/
String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
String usuario = "receta_usr";
String pass = "M8KbqNjTD2";

ResultSet rset=null;
Statement stmt = null;
ResultSet rset2=null;
Statement stmt2 = null;
ResultSet rset3=null;
Statement stmt3 = null;
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
stmt3 = conexion.createStatement();
/*guardando la conexion en la session*/
} catch (Exception ex){
	mensaje=ex.toString();
}
mensaje="conectado";
if(conexion.isClosed()){
	mensaje="desconectado";
}
//--------------OBTENCION DEL BOTON-----------------
String boton="";
try { 
     boton=""+request.getParameter("Submit");
}catch(Exception e){}

//---------PROCESO DE FECHAS----------------------------------
String f1_cr="", f2_cr="";
String f1_mos="";
String f2_mos="";
 Calendar calendar = Calendar.getInstance();
 Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.DATE, -15);
String fecha1 = "" + df.format(calendar.getTime());
String fecha2 = "" + df.format(calendar2.getTime());
String d = "0";
int dias = 0;

//fecha1= "2013-03-27";

String qry_fechas1 = "select max(fec_sur) from detreceta group by fec_sur order by fec_sur asc";
rset2 = stmt2.executeQuery(qry_fechas1);
while(rset2.next()){
	fecha2 = rset2.getString(1);
}
calendar.setTime(df.parse(fecha2));
calendar.add(Calendar.DATE, -7);
//fecha1 = "" + df.format(calendar.getTime());
fecha1 = "2013-04-01";

if(boton.equals("Filtrar")){
	f1_cr=""+request.getParameter("fecha1");
	f2_cr=""+request.getParameter("fecha2");
	
	fecha1 = "" + df.format(df2.parse(f1_cr));
	fecha2 = "" + df.format(df2.parse(f2_cr));
}

f1_mos = "" + df2.format(df.parse(fecha1));
f2_mos = "" + df2.format(df.parse(fecha2));

//---PROCESO DE FARMACIAS----------------------------------------
String tipo = request.getParameter("tipo");
//-------------------------------------------
String totales[] = {"0","0","0"};
int cont=0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<link rel="stylesheet" href="../css/bootstrap-responsive.css" />

<!--link rel="stylesheet" href="css/custom.css" /-->
<style type="text/css">
.neg {font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #666;
}
body {
	background-color: #FFFFFF;
}
</style>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script language="javascript" src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../jq/themes/base/jquery.ui.all.css">
</head>

<body>
<!-- Navigation Bar -->

<div class="navbar navbar-inverse">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="../index.jsp">Reportes Web Nayarit - BackOrders</a>
          <!--div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="../main_menu.jsp">Reporte de Ventas</a></li>
              <li><a href="../transferencias.jsp">Reporte de Transferencias</a></li>
              <li><a href="../existencias.jsp">Reporte de Existencias</a></li>
               <li><a href="#contact">Reporte de Censos</a></li>
            </ul>
            <p class="navbar-text pull-right">Usuario: <a href="#"><%=user%></a></p>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
<!------------->
<div class="container">
<div class="row">
	<div>
    <%
		String tip="";
		if(request.getParameter("tipo").equals("F")){
			tip="Farmacia";
		}
		if(request.getParameter("tipo").equals("A")){
			tip="Almacenes";
		}
		if(request.getParameter("tipo").equals("1")){
			tip="Primer Nivel";
		}
		if(request.getParameter("tipo").equals("P")){
			tip="Programas";
		}
		if(request.getParameter("tipo").equals("PE")){
			tip="Pedidos Extraordinarios";
		}
		if(request.getParameter("tipo").equals("C")){
			tip="Controlados";
		}
	%>
    	<a href="venta_total.jsp">Reporte de Ventas</a> > Tipo: <%=tip%>
    </div>
</div>
	<div class="row">
    	<div class="span8">
        <h2>Ventas Totales&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="gnr_det_venta.jsp?tipo=<%=request.getParameter("tipo")%>"><img src="../../imagen/Excel-2013.png" alt="Exportar a Excel" width="40" height="40" /></a></h2>
		<div>
        <table border="0" class="table table-bordered table-striped table-hover" style="font-size:12px;">
          <tr>
            <td>&nbsp;</td>
            <td>Pzs. Solicitadas</td>
            <td>Pzs. Entregadas</td>
            <td>Pzs. Faltantes</td>
            <td>Nivel de Servicio</td>
            </tr>
            <%
			int sol=0, sur=0, fal=0;
			float niv=0;
			int vsur[]=new int[3];
			int cont_j=0;
			rset = stmt.executeQuery("SELECT j.des_jur, sum(b.can_sol), j.cla_jur from jurisdicciones j, municipios m, unidades u, folio_back f, back_solicitado b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and  u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND  u.tip_uni = '"+request.getParameter("tipo")+"' GROUP BY j.cla_jur ;");
			while (rset.next()) {
				sol=0; sur=0; fal=0;
				try{
					
					out.println("<tr>");
						out.println("<td>");
							%><a href="detalle_juris.jsp?juris=<%=rset.getString(3)%>&tipo=<%=request.getParameter("tipo")%>"><%=rset.getString(1)%></a><%
						out.println("</td>");
						out.println("<td>");
							out.println(rset.getString(2));
							sol = Integer.parseInt(rset.getString(2));
						out.println("</td>");
						rset2 = stmt2.executeQuery("SELECT j.des_jur, sum(b.can_sur) from jurisdicciones j, municipios m, unidades u, folio_back f, back_surtido b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and  u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND  u.tip_uni = '"+request.getParameter("tipo")+"' and j.des_jur= '"+rset.getString(1)+"'  GROUP BY j.cla_jur ;");
						out.println("<td>");
							while (rset2.next()) {
								out.println(rset2.getString(2));
								sur = Integer.parseInt(rset2.getString(2));
							}
						out.println("</td>");
						out.println("<td>");
							out.println(forma.format(sol-sur));
						out.println("</td>");
						niv = ((sur*100)/sol);
						out.println("<td>");
							out.println(niv+"%");
						out.println("</td>");
					out.println("</tr>");
					
				}catch (Exception e) {
					out.println(e.getMessage());
				}
				vsur[cont_j]=sur;
				cont_j++;
			}
			%>
        </table>
        <!--a href="inventario_cedis.jsp">Inventario en el Cedis </a--></div>
      </div>
      
<script type="text/javascript">
$(function () {
	Highcharts.setOptions({
     colors: ['#FA5858', '#81F781', '#F4FA58', '#24CBE5', '#64E572', '#FF9655', '#FFF263',      '#6AF9C4']
    });
    $('#grafico').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Piezas Entregadas, 2013'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Porcentaje',
            data: [
                ['Juris 1',   <%=vsur[0]%>],
                ['Juris 2',  <%=vsur[1]%>],
				['Juris 3',  <%=vsur[2]%>]
            ]
        }]
    });
});
</script>
      <div class="span4">
	  <script src="../js/highcharts.js"></script>
	  <script src="../js/modules/exporting.js"></script>
	  
	  <div id="grafico" name="grafico" style="min-width: 400px; height: 300px; margin: 0 auto"></div>
	  </div>
</div>
<div class="navbar navbar-fixed-bottom">
        <div class="modal-footer">
            DERECHOS RESERVADOS GNKL/DESARROLLOS WEB &reg; 2009 - 2013
        </div>
</div>
</body>
</html>