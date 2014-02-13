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
<h1>REPORTE: CLAVES EN DESABASTO</h1>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
<a href="../reportes_nay/index_main.jsp" class="banda">Regresar</a></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
	<div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    	<!--p><a href="index.jsp">SOLICITADO / ENTREGADO</a></p-->
        <p><a href="rec_sur.jsp">RECETAS SURTIDAS</a></p>
        <p>CLAVES EN DESABASTO</p>
        <p><a href="ranking.jsp">RANKING DE CLAVES</a></p>
        <!--p><a href="../censos/menu_inven.jsp">INVENTARIOS</a></p-->
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif">
    <div class="tit_tablas">
    <form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
    </form>
    </div>
 <table>
 <tr><td valign="top">
  <!--table width="340" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
  <tr class="tit_tablas">
    <td colspan="3"><strong>Hospitales</strong></td>
    </tr>
  <tr class="tit_tablas">
    <td><strong>Clave</strong></td>
    <td><strong>Descripción</strong></td>
    <td><strong>Cant.</strong></td>
  </tr>
  <%
  String qry_desa_a = "select bsol.cla_pro as clave, pr.des_pro as des, (-(sum(bsol.can_sol)-SUM(bsur.can_sur)) + inv.cant ) as rest from back_solicitado bsol, back_surtido bsur, inven_cedis inv, productos pr where bsol.cla_pro = bsur.cla_pro AND bsol.fol_bac = bsur.fol_bac AND bsol.cla_pro = inv.cla_pro AND pr.cla_pro = bsol.cla_pro and bsur.fec_sur between '"+fecha1+"' and '"+fecha2+"' GROUP BY bsol.cla_pro order by rest asc";
  rset = stmt.executeQuery(qry_desa_a);
  while(rset.next()){
	String cla_pro = rset.getString(1);
	String des_pro = rset.getString(2);
	String cant_pro = rset.getString(3);
	int can = Integer.parseInt(cant_pro);
	if (can <0 ){
  %>
  <tr  >
    <td class="lista_desabasto"><%=cla_pro%></td>
    <td class="lista_desabasto"><%=des_pro%></td>
    <td class="lista_desabasto numeros"><%=forma.format(-can)%></td>
  </tr>
  <%
	}
  }
  %>
</table-->
</td><td valign="top">
  <table width="340" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
  <tr class="tit_tablas">
    <td colspan="3"><strong>Famacias</strong></td>
    </tr>
  <tr class="tit_tablas">
    <td><strong>Clave</strong></td>
    <td><strong>Descripción</strong></td>
    <td><strong>Cant.</strong></td>
  </tr>
  <%String qry_desa_f="select p.cla_pro, p.des_pro, sum(dr.can_sol) as sol from detreceta dr, detalle_productos dp, productos p where dr.cant_sur = '0' and p.cla_pro = dp.cla_pro and  dp.det_pro = dr.det_pro and dr.fec_sur between '"+fecha1 +"' and '"+fecha2+"' group by dp.det_pro  order by sol desc;"; 

  rset = stmt.executeQuery(qry_desa_f);
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
</table>
</td></tr>
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