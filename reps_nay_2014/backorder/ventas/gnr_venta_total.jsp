<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="../../pag_man.html" session = "true"%>
<%
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"BackOrder_Total.xls\"");
%>
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
	<div></div>
</div>
	<div class="row">
    	<div class="span6">
        <h2>Ventas Totales&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2>
		<div>
        <table border="0" class="table table-bordered table-striped table-hover" style="font-size:12px;">
          <tr>
            <td>&nbsp;</td>
            <td>Pzs. Solicitadas</td>
            <td>Pzs. Entregadas</td>
            <td>Pzs. Faltantes</td>
            <td>Nivel de Servicio</td>
            </tr>
          <tr>
            <td><a href="det_venta.jsp?tipo=F">Total Farmacias</a></td>
            <%
			int solf=0, surf=0, falf=0, nivf=0;
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='F' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				solf=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				solf=0;
			}
			%>
             <%
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='F' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				surf=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				surf=0;
			}
			try{
			falf=solf-surf;
			nivf=(surf*100)/solf;
			} catch (Exception e) {falf=0;nivf=0;}
			%>
            
            <td><%=forma.format(falf)%></td>
            <td><%=forma2.format(nivf)%>%</td>
            </tr>
          <tr>
            <td><a href="det_venta.jsp?tipo=A">Total Almacenes</a></td>
            <%
			int sola=0, sura=0, fala=0, niva=0;
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='A' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				sola=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				sola=0;
			}
			%>
             <%
			try{
			rset = stmt.executeQuery("select sum(b.can_sur) from unidades u, folio_back f, back_surtido b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='A' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				sura=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				sura=0;
			}
			try{
			fala=sola-sura;
			niva=(sura*100)/sola;
			} catch (Exception e) {fala=0;niva=0;}
			%>
            
            <td><%=forma.format(fala)%></td>
            <td><%=forma2.format(niva)%>%</td>
          </tr>
          <tr>
            <td><a href="det_venta.jsp?tipo=1">Total Primer Nivel</a></td>
            <%
			int sol1=0, sur1=0, fal1=0, niv1=0;
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='1' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				sol1=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				sol1=0;
			}
			%>
             <%
			try{
			rset = stmt.executeQuery("select sum(b.can_sur) from unidades u, folio_back f, back_surtido b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='1' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				sur1=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				sur1=0;
			}
			try{
			fal1=sol1-sur1;
			niv1=(sur1*100)/sol1;
			} catch (Exception e) {fal1=0;niv1=0;}
			%>
            
            <td><%=forma.format(fal1)%></td>
            <td><%=forma2.format(niv1)%>%</td>
          </tr>
          <tr>
            <td><a href="det_venta.jsp?tipo=P">Programas</a></td>
            <%
			int solp=0, surp=0, falp=0, nivp=0;
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='P' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				solp=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				solp=0;
			}
			%>
             <%
			try{
			rset = stmt.executeQuery("select sum(b.can_sur) from unidades u, folio_back f, back_surtido b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='P' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				surp=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				surp=0;
			}
			try{
			falp=solp-surp;
			nivp=(surp*100)/solp;
			} catch (Exception e) {falp=0;nivp=0;}
			%>
            
            <td><%=forma.format(falp)%></td>
            <td><%=forma2.format(nivp)%>%</td>
            </tr>
          <tr>
            <td><a href="det_venta.jsp?tipo=PE">Pedidos Extraordinarios</a></td>
            <%
			int solpe=0, surpe=0, falpe=0, nivpe=0;
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='PE' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				solpe=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				solpe=0;
			}
			%>
             <%
			try{
			rset = stmt.executeQuery("select sum(b.can_sur) from unidades u, folio_back f, back_surtido b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='PE' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				surpe=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				surpe=0;
			}
			try{
			falpe=solpe-surpe;
			nivpe=(surpe*100)/solpe;
			} catch (Exception e) {falpe=0;nivpe=0;}
			%>
            
            <td><%=forma.format(falpe)%></td>
            <td><%=forma2.format(nivpe)%>%</td>
            </tr>
          <tr>
            <td><a href="det_venta.jsp?tipo=C">Controlados</a></td>
            <%
			int solc=0, surc=0, falc=0, nivc=0;
			try{
			rset = stmt.executeQuery("select sum(b.can_sol) from unidades u, folio_back f, back_solicitado b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='C' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				solc=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				solc=0;
			}
			%>
             <%
			try{
			rset = stmt.executeQuery("select sum(b.can_sur) from unidades u, folio_back f, back_surtido b  where  u.cla_uni = f.cla_uni and f.fol_bac = b.fol_bac AND u.tip_uni='C' ;");
			while (rset.next()) {
				out.print("<td>"+forma.format(Integer.parseInt(rset.getString(1)))+"</td>");
				surc=Integer.parseInt(rset.getString(1));
			}
			}catch (Exception e) {
				out.print("<td>0</td>");
				surc=0;
			}
			try{
			falc=solc-surc;
			nivc=(surc*100)/solc;
			} catch (Exception e) {falc=0;nivc=0;}
			%>
            
            <td><%=forma.format(falc)%></td>
            <td><%=forma2.format(nivc)%>%</td>
            </tr>
        </table></div>
      </div>
      
	  <div id="grafico" name="grafico" style="min-width: 600px; height: 400px; margin: 0 auto"></div>
	  </div>
</div>
<div class="navbar navbar-fixed-bottom">
</div>
</body>
</html>