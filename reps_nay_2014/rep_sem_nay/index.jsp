<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true" import="java.util.Calendar" import="java.util.Date" import="java.text.DateFormat" import="java.text.DecimalFormat"import="java.util.Locale" import="java.text.NumberFormat" import="java.text.DecimalFormatSymbols"%>
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
String val="", user="";



if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!val.equals("valido")){
	
	%>
    <script>self.location='../reportes_nay/index.jsp';</script>
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
fecha1 = "" + df.format(calendar.getTime());


if(boton.equals("Filtrar")){
	f1_cr=""+request.getParameter("fecha1");
	f2_cr=""+request.getParameter("fecha2");
	
	fecha1 = "" + df.format(df2.parse(f1_cr));
	fecha2 = "" + df.format(df2.parse(f2_cr));
}

f1_mos = "" + df2.format(df.parse(fecha1));
f2_mos = "" + df2.format(df.parse(fecha2));

//---PROCESO DE FARMACIAS----------------------------------------
String sol_farm="", sur_farm="", dif_farm="";
int sol_f=0, sur_f=0, dif_f=0;
float por_f=0, cos_f=0;
rset = stmt.executeQuery("SELECT SUM(CAN_SOL) AS SOL, SUM(CANT_SUR) AS SUR, SUM(CAN_SOL - CANT_SUR) AS DIF, SUM(cos_tot) as cos FROM DETRECETA where FEC_SUR between '"+fecha1+"' and '"+fecha2+"'");

while(rset.next()){
	sol_farm=rset.getString("SOL");
	sur_farm=rset.getString("SUR");
	dif_farm=rset.getString("DIF");
	String costo = rset.getString("cos");
	if (costo == null) {
		costo = "0";
	}
	cos_f=Float.parseFloat(costo);
	
	if (sol_farm == null){
		sol_farm="0";
	}
	if (sur_farm == null){
		sur_farm="0";
	}
	if (dif_farm == null){
		dif_farm="0";
	}
	
	sol_f=Integer.parseInt(sol_farm);
	sur_f=Integer.parseInt(sur_farm);
	dif_f=Integer.parseInt(dif_farm);
	
	try{
	por_f=(sur_f*100)/sol_f;
	} catch (Exception e) {por_f = 0;} 
}
//-------------------------------------------
//---PARA ALMACENES----------------------------------------
int sol_alm=0, sur_alm = 0, dif_alm =0;
double por_alm = 0;
float cos_alm=0;
String qry_sol_alm="SELECT SUM(B_SOL.can_sol) FROM back_solicitado B_SOL, unidades u WHERE u.tip_uni = 'A' and u.cla_uni = b_sol.cla_uni and b_sol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' ;";
rset = stmt.executeQuery(qry_sol_alm);
while(rset.next()){
	String sol_a = rset.getString("SUM(B_SOL.can_sol)");
	if (sol_a == null){
		sol_a = "1";
	}
	sol_alm=Integer.parseInt(sol_a);
}
String qry_sur_alm="SELECT SUM(B_Sur.can_sur), sum(cos_tot) as cos FROM back_surtido B_Sur, unidades u WHERE u.tip_uni = 'A' and u.cla_uni = b_sur.cla_uni and b_sur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' ;";
rset = stmt.executeQuery(qry_sur_alm);
while(rset.next()){
	String bsur_can_sur=rset.getString("SUM(B_Sur.can_sur)");
	String costo = rset.getString("cos");
	if (costo == null) {
		costo = "0";
	}
	cos_alm=Float.parseFloat(costo);
	if (bsur_can_sur==null){
		bsur_can_sur="0";
	}
	sur_alm=Integer.parseInt(bsur_can_sur);
}

dif_alm=sol_alm-sur_alm;
try{
por_alm=(sur_alm*100)/sol_alm;
} catch (Exception e) {por_alm = 0;} 
//-------------------------------------------
//---Rurales----------------------------------------
int sol_r = 0, sur_r=0, dif_r=0;
float por_r=0, cos_pri=0;
String qry_sol_r="select sum(bsol.can_sol) from back_solicitado bsol, unidades u where u.tip_uni = '1' and u.cla_uni = bsol.cla_uni and bsol.FEC_sol between '"+fecha1+"' and '"+fecha2+"';";
rset = stmt.executeQuery(qry_sol_r);
while(rset.next()){
	String sol_ru = rset.getString("sum(bsol.can_sol)");
	if (sol_ru == null){
		sol_ru = "1";
	}
	sol_r=Integer.parseInt(sol_ru);
}
String qry_sur_r="select sum(bsur.can_sur), sum(cos_tot) as cos from back_surtido bsur, unidades u WHERE u.tip_uni = '1' and u.cla_uni = bsur.cla_uni and bsur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' ;";
rset = stmt.executeQuery(qry_sur_r);
while(rset.next()){
	String sur_ru = rset.getString("sum(bsur.can_sur)");
	String costo = rset.getString("cos");
	if (costo == null) {
		costo = "0";
	}
	cos_pri=Float.parseFloat(costo);
	if (sur_ru == null){
		sur_ru = "0";
	}
	sur_r=Integer.parseInt(sur_ru);
}

dif_r=sol_r-sur_r;
try{
por_r=(sur_r*100)/sol_r;
} catch (Exception e) {por_r = 0;} 
//-------------------------------------------
//---Rurales----------------------------------------
int sol_p = 0, sur_p=0, dif_p=0;
float por_p=0, cos_pro=0;
String qry_sol_p="select sum(bsol.can_sol) from back_solicitado bsol, unidades u where u.tip_uni = 'P' and u.cla_uni = bsol.cla_uni and bsol.FEC_sol between '"+fecha1+"' and '"+fecha2+"';";
rset = stmt.executeQuery(qry_sol_p);
while(rset.next()){
	String sol_pr = rset.getString("sum(bsol.can_sol)");
	if (sol_pr == null){
		sol_pr = "1";
	}
	sol_p=Integer.parseInt(sol_pr);
}
String qry_sur_pr="select sum(bsur.can_sur), sum(cos_tot) as cos from back_surtido bsur, unidades u WHERE u.tip_uni = 'P' and u.cla_uni = bsur.cla_uni and bsur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' ;";
rset = stmt.executeQuery(qry_sur_pr);
while(rset.next()){
	String sur_pr = rset.getString("sum(bsur.can_sur)");
	String costo = rset.getString("cos");
	if (costo == null) {
		costo = "0";
	}
	cos_pro=Float.parseFloat(costo);
	if (sur_pr == null){
		sur_pr = "0";
	}
	sur_p=Integer.parseInt(sur_pr);
}

dif_r=sol_p-sur_p;
try{
por_r=(sur_p*100)/sol_p;
} catch (Exception e) {por_p = 0;} 
//-------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit SAVI - GNKL</title>
<link href="../css/reporte_sem.css" rel="stylesheet" type="text/css" />
<script src="../js/scw.js" type="text/javascript"> </script>
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"><img src="../imagen/ima_main.jpg" /></div>
<h1>REPORTE: NIVEL DE SERVICIO</h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
<a href="../reportes_nay/index_main.jsp" class="banda">Regresar</a></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    <p>SOLICITADO / ENTREGADO</p>
        <p><a href="rec_sur.jsp">RECETAS SURTIDAS</a></p>
        <p><a href="cla_des.jsp">CLAVES EN DESABASTO</a></p>
        <p><a href="ranking.jsp">RANKING DE CLAVES</a></p>
        <p><a href="../censos/menu_inven.jsp">INVENTARIOS</a></p>
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif">
    <div class="tit_tablas">
    <form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     </form>
    </div>
    <br />
    <br />
  <table width="700" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
    <td class="tit_tablas"><strong><a href="sol_detalle.jsp?tipo=FARMACIAS">FARMACIAS</a></strong></td>
    <td class="tit_tablas"><strong><a href="sol_detalle.jsp?tipo=ALMACENES">ALMACENES</a></strong></td>
    <td class="tit_tablas"><strong><a href="sol_detalle.jsp?tipo=1ER NIVEL">1ER NIVEL</a></strong></td>
    <td class="tit_tablas"><strong><a href="sol_detalle.jsp?tipo=PROGRAMAS">PROGRAMAS</a></strong></td>
  </tr>
  <tr>
    <td class="tit_tablas"><strong>REQUISICIÓN</strong></td>
    <td class="numeros"><%=forma.format(sol_f)%></td>
    <td class="numeros"><%=forma.format(sol_alm)%></td>
    <td class="numeros"><%=forma.format(sol_r)%></td>
    <td class="numeros"><%=forma.format(sol_p)%></td>
  </tr>
  <tr>
    <td class="tit_tablas"><strong>ABASTO</strong></td>
    <td class="numeros"><%=forma.format(sur_f)%></td>
    <td class="numeros"><%=forma.format(sur_alm)%></td>
    <td class="numeros"><%=forma.format(sur_r)%></td>
    <td class="numeros"><%=forma.format(sur_p)%></td>
  </tr>
  <tr>
    <td class="tit_tablas"><strong>ADEUDO</strong></td>
    <td class="numeros"><%=forma.format(dif_f)%></td>
    <td class="numeros"><%=forma.format(dif_alm)%></td>
    <td class="numeros"><%=forma.format(dif_r)%></td>
    <td class="numeros"><%=forma.format(dif_p)%></td>
  </tr>
  <tr>
    <td class="tit_tablas"><strong>PORCENTAJE</strong></td>
    <td class="numeros"><%=por_f%>%</td>
    <td class="numeros"><%=por_alm%>%</td>
    <td class="numeros"><%=por_r%>%</td>
    <td class="numeros"><%=por_p%>%</td>
  </tr>
  <tr>
    <td class="tit_tablas"><strong>IMPORTE</strong></td>
    <td class="numeros">$ <%=forma2.format(cos_f)%></td>
    <td class="numeros">$ <%=forma2.format(cos_alm)%></td>
    <td class="numeros">$ <%=forma2.format(cos_pri)%></td>
    <td class="numeros">$ <%=forma2.format(cos_pro)%></td>
  </tr>
</table>

    	
    </div>
</div>
</body>
</html>
<%    
      try{

conexion.close();
   
    }catch (Exception e) {
                  mensaje=e.toString();
                }
finally { 
if (conexion!=null) {

conexion.close();
                
                 if(conexion.isClosed()){

        mensaje="desconectado";}


      }
}   
//out.print(""+mensaje);             
%>