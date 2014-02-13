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

</head>

<body>

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
    	Reporte de Ventas > Tipo: <%=tip%>
    </div>
</div>
<%
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"BackOrder_"+tip+".xls\"");
%>
	<div class="row">
    	<div class="span8">
        <h2>Ventas Totales</h2>
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
							%><%=rset.getString(1)%><%
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
      

      <div class="span4">
	  
	  <div id="grafico" name="grafico" style="min-width: 400px; height: 300px; margin: 0 auto"></div>
	  </div>
</div>
</body>
</html>