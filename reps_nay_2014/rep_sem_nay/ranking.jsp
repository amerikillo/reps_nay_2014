<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true" import="java.util.Date" import="java.util.Calendar" import="java.text.DecimalFormat"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<% DecimalFormat forma= new DecimalFormat("##,###"); %>
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
Connection conexion2=null;
String mensaje="";
/*parametros para la conexion*/
String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
String url2 = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
String usuario = "receta_usr";
String pass = "M8KbqNjTD2";

ResultSet rset=null;
Statement stmt = null;
ResultSet rset2=null;
Statement stmt2 = null;
ResultSet rset3=null;
Statement stmt3 = null;
ResultSet rset4=null;
Statement stmt4 = null;
ResultSet rset5=null;
Statement stmt5 = null;
ResultSet rset6=null;
Statement stmt6 = null;
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
conexion2 = DriverManager.getConnection(url2,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
stmt3 = conexion.createStatement();

stmt4 = conexion2.createStatement();
stmt5 = conexion2.createStatement();
stmt6 = conexion2.createStatement();
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
rset3 = stmt3.executeQuery("select min(fec_sur) from detreceta");
while(rset3.next()){
	fecha1 = df2.format(df.parse(rset3.getString(1)));
}
String qry_fechas1 = "select max(fec_sur) from detreceta";
rset2 = stmt2.executeQuery(qry_fechas1);
while(rset2.next()){
	fecha2 = df2.format(df.parse(rset2.getString(1)));
}/*
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
*/
//-------------------------------------------

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/reporte_sem.css" rel="stylesheet" type="text/css" />
<script src="../js/scw.js" type="text/javascript"> </script>
<title>Reportes Nayarit SAVI - GNKL</title>
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"><img src="../imagen/ima_main.jpg" /></div>
<h1>REPORTE: RANKING DE CLAVES</h1> <h3>(20 Claves de alto desplazamiento)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
<a href="../reportes_nay/index_main.jsp" class="banda">Regresar</a></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:800; float:right; background-color:#FFF; padding:15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif">
    <div>
    <!--form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
    </form-->
    <a href="gnr_ranking.jsp"><img src="../imagen/exc.jpg" alt="Exportar a Excel" width="50" height="36" /></a></div>
      <table >
      	<tr>
          <td colspan="2" style="text-align:center">
            	Claves con Mayor Desplazamiento<br />
                Periodo del <%=fecha1%> al <%=fecha2%>
          </td>
        </tr>
        <tr>
          <td valign="top">
          <table width="400" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
            <tr >
              <td colspan="3"><strong><span class="tit_tablas">Almacenes y Rurales</span></strong></td>
            </tr>
            <tr>
              <td><strong><span class="tit_tablas">Clave</span></strong></td>
              <td><strong><span class="tit_tablas">Descripción</span></strong></td>
              <td><strong><span class="tit_tablas">Cant.</span></strong></td>
            </tr>
            <%
			String qry_maya="select e.cla_pro, p.des_pro, sum(e.can_sur) as suma from entregado_trans e, productos p where e.cla_pro = p.cla_pro  GROUP BY e.cla_pro order by suma desc limit 0,20;";
			rset4 = stmt4.executeQuery(qry_maya);
  			while(rset4.next()){
				String cla_pro = rset4.getString(1);
				String des_pro = rset4.getString(2);
				String cant_pro = rset4.getString(3);
			%>
            <tr>
                <td class="lista_desabasto"><%=cla_pro%></td>
                <td class="lista_desabasto"><%=des_pro%></td>
                <td class="lista_desabasto numeros"><%=forma.format(Integer.parseInt(cant_pro))%></td>
            </tr>
            <%
            }
            %>  
          </table></td>
          <td valign="top">
          <table width="400" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0" >
            <tr>
              <td colspan="3"><strong><span class="tit_tablas">Farmacias</span></strong></td>
            </tr>
            <tr>
              <td><strong><span class="tit_tablas">Clave</span></strong></td>
              <td><strong><span class="tit_tablas">Descripción</span></strong></td>
              <td><strong><span class="tit_tablas">Cant.</span></strong></td>
            </tr>
            <%
			String qry_mayf="SELECT P.cla_pro, P.des_pro, SUM(DR.cant_sur) AS SUR FROM detalle_productos DP, detreceta DR, PRODUCTOS P WHERE DR.det_pro = DP.det_pro AND DP.cla_pro = P.cla_pro  GROUP BY DP.cla_pro ORDER BY SUR DESC LIMIT 0,20; ";
			/*and dr.fec_sur between '"+fecha1+"' and '"+fecha2+"'*/
			rset = stmt.executeQuery(qry_mayf);
  			while(rset.next()){
				String cla_pro = rset.getString(1);
				String des_pro = rset.getString(2);
				String cant_pro = rset.getString(3);
			%>
            <tr>
                <td class="lista_desabasto"><%=cla_pro%></td>
                <td class="lista_desabasto"><%=des_pro%></td>
                <td class="lista_desabasto numeros"><%=forma.format(Integer.parseInt(cant_pro))%></td>
            </tr>
            <%
            }
            %>  
          </table></td>
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