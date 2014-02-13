<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true" import="java.util.Calendar" import="java.util.Date" import="java.text.DateFormat" import="java.text.DecimalFormat"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<% DecimalFormat forma= new DecimalFormat("##,###"); %>
<% DecimalFormat forma2= new DecimalFormat("##,###.##"); %>
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
    <script>self.location='../../reportes_nay/index.jsp';</script>
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
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
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
calendar.add(Calendar.DATE, -7);
String fecha1 = "" + df.format(calendar.getTime());
String fecha2 = "" + df.format(calendar2.getTime());
String d = "0";
int dias = 0;

//fecha1= "2013-03-27";



if(boton.equals("Filtrar")){
	f1_cr=""+request.getParameter("fecha1");
	f2_cr=""+request.getParameter("fecha2");
	
	fecha1 = "" + df.format(df2.parse(f1_cr));
	fecha2 = "" + df.format(df2.parse(f2_cr));
}

f1_mos = "" + df2.format(df.parse(fecha1));
f2_mos = "" + df2.format(df.parse(fecha2));

//-------------------------------------------String muni = request.getParameter("mun");
String juris = request.getParameter("juris");
//-------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit SAVI - GNKL</title>
<link href="../../css/reporte_sem.css" rel="stylesheet" type="text/css" />
<script src="../../js/scw.js" type="text/javascript"> </script>
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"></div>
<div style="float:right"><img src="../../imagen/ima_main.jpg" /></div>
<h1>REPORTE: RECETAS SURTIDAS</h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
MUNICIPIO <%=muni%></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    <!--p><a href="../index.jsp">SOLICITADO / ENTREGADO</a></p-->
        <p>RECETAS SURTIDAS</p>
        <p><a href="../cla_des.jsp">CLAVES EN DESABASTO</a></p>
        <p><a href="../ranking.jsp">RANKING DE CLAVES</a></p>
        <!--p><a href="../../censos/menu_inven.jsp">INVENTARIOS</a></p-->
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif">
     <div class="tit_tablas">
    <form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     </form>
    </div>
   	  <p><a class="regresa" href="det_jur_sol.jsp?juris=<%=juris%>">Regresar</a></p>
   	  <div>
   	    <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
      <td>Requisicion</td>
      <td>Abasto</td>
      <td>Adeudo</td>
      <td>Porcentaje</td>
    </tr>
    <%
			rset = stmt.executeQuery("SELECT m.des_mun, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur, SUM(dr.can_sol-dr.cant_sur) as dif, j.cla_jur from detreceta dr, receta r, unidades u, municipios m, jurisdicciones j where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec AND dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and m.des_mun='"+muni+"' group by m.cla_mun");
			while(rset.next()){
				
			%>
    <tr class="numeros">
      <td style="text-align:left"><%=rset.getString(1)%></td>
      <td><%=forma.format(Integer.parseInt(rset.getString(2)))%></td>
      <td><%=forma.format(Integer.parseInt(rset.getString(3)))%></td>
      <td><%=forma.format(Integer.parseInt(rset.getString(4)))%></td>
      <td><%=forma2.format((Integer.parseInt(rset.getString(3))*100)/(Integer.parseInt(rset.getString(2))))%> %</td>
    </tr>
    <%
			}
			%>
  </table>
  <br />
  <table border="1" width="693">
      <tr>
          <td width="40">Clave</td>
          <td width="376">Descricpion</td>
          <td width="61">Req.</td>
          <td width="63">Abasto</td>
          <td width="61">Adeudo</td>
          <td width="52">%</td>
      </tr>
      <%
	  String qry_meds="select dp.cla_pro as med, prod.des_pro as descr,SUM(dr.can_sol) as sol, sum(dr.cant_sur) as sur,sum(dr.can_sol-dr.cant_sur) as dif, sum(dr.cos_tot) as cant_costo from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod where  j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = r.cla_uni and p.cla_pac = r.cla_pac and r.id_rec = dr.id_rec and dr.det_pro = dp.det_pro and dp.cla_pro = prod.cla_pro and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and m.des_mun = '"+muni+"' group by dp.cla_pro order by cast(dp.cla_pro as signed) ;";
	  rset = stmt.executeQuery(qry_meds);
	  while(rset.next()){
	  %>
      <tr class="numeros">
      	<td style="text-align: left" ><%=rset.getString(1)%></td>
        <td style="text-align: left"><%=rset.getString(2)%></td>
        <td><%=forma.format(Integer.parseInt(rset.getString(3)))%></td>
        <td><%=forma.format(Integer.parseInt(rset.getString(4)))%></td>
        <td><%=forma.format(Integer.parseInt(rset.getString(5)))%></td>
        <td><%=((Integer.parseInt(rset.getString(4))*100)/(Integer.parseInt(rset.getString(3))))%> %</td>
      </tr>
      <%
	  }
	  %>
  </table>
   	  </div>
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