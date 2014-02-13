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
String muni = request.getParameter("mun");
String juris = request.getParameter("juris");
//-------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit SAVI - GNKL</title>
<link href="../../css/reporte_sem.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../../js/list02.js"></script>
<script src="../../js/scw.js" type="text/javascript"> </script>
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"><img src="../../imagen/ima_main.jpg" /></div>
<h1>REPORTE: NIVEL DE SERVICIO EN ALMACENES</h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
MUNICIPIO <%=muni%></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    <p>SOLICITADO / ENTREGADO</p>
        <p><a href="../rec_sur.jsp">RECETAS SURTIDAS</a></p>
        <p><a href="../cla_des.jsp">CLAVES EN DESABASTO</a></p>
        <p><a href="../ranking.jsp">RANKING DE CLAVES</a></p>
        <p><a href="../../censos/menu_inven.jsp">INVENTARIOS</a></p>
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif">
    <div class="tit_tablas">
    <form name="form1" action="">
    <input name="mun" id="mun" value="<%=muni%>" style="display:none"/>
    <input name="juris" id="juris" value="<%=juris%>"  style="display:none"/>
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     <a href="recetas_surtidas/gnr_rec_sur.jsp?fecha1=<%=f1_mos%>&fecha2=<%=f2_mos%>&Submit=Filtrar" target="_blank"><img src="../../imagen/exc.jpg" width="69" height="50" alt="Exportar a Excel" /></a>
    </form>
    </div>
   	  <p><a class="regresa" href="det_alm_jur.jsp?juris=<%=juris%>">Regresar</a></p>
   	  <div>
   	    <table width="690" border="1"  bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
      <td class="tit_tablas"><strong>Requisicion</strong></td>
      <td class="tit_tablas"><strong>Abasto</strong></td>
      <td class="tit_tablas"><strong>Adeudo</strong></td>
      <td class="tit_tablas"><strong>Porcentaje</strong></td>
      <td class="tit_tablas"><strong>Importe</strong></td>
    </tr>
    <%
	String total_abas="", total_req="", tot_cos="";
	float tot=0;	
	String totales ="select j.des_jur, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'A' and m.des_mun = '"+muni+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY m.des_mun ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_req = rset.getString(2);
	}
	
    totales ="select j.des_jur, sum(bsur.can_sur), sum(bsur.cos_tot) as cos FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'A' and j.cla_jur = m.cla_jur and m.des_mun = '"+muni+"' and m.cla_mun = u.cla_mun and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.cla_uni = bsur.cla_uni GROUP BY m.des_mun ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_abas = rset.getString(2);
		tot_cos = rset.getString("cos");
	}
	if (total_req == null || total_req.equals("")) {
		total_req="0";
	}
	 if (total_abas == null || total_abas.equals("")) {
		total_abas="0";
	}
	if (tot_cos == null || tot_cos.equals("")) {
		tot_cos="0";
	}
	try{
		tot=(Integer.parseInt(total_abas)*100)/(Integer.parseInt(total_req));
	} catch (Exception e){
		tot =0;
	}
	%>
    <tr class="numeros">
      <td style="text-align:left"><strong><%=muni%></strong></td>
      <td><%=forma.format(Integer.parseInt(total_req))%></td>
      <td><%=forma.format(Integer.parseInt(total_abas))%></td>
      <td><%=forma.format( (Integer.parseInt(total_req))-(Integer.parseInt(total_abas)) )%></td>
      <td><%=forma2.format(tot)%> %</td>
      <td>$<%=forma2.format(Float.parseFloat(tot_cos))%></td>
    </tr>
  </table>
  <br />
  <table border="1" width="693"  bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
      <tr class="tit_tablas">
          <td width="40"><strong>Clave</strong></td>
          <td width="376"><strong>Descricpion</strong></td>
          <td width="61"><strong>Req.</strong></td>
          <td width="63"><strong>Abasto</strong></td>
          <td width="61"><strong>Adeudo</strong></td>
          <td width="52"><strong>%</strong></td>
          <td width="52"><strong>Importe</strong></td>
      </tr>
      <%
	  String qry_meds="select p.cla_pro as med, p.des_pro as descr, SUM(bsol.can_sol) as sol from jurisdicciones j, municipios m, unidades u, productos p, back_solicitado bsol  where  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni and  bsol.cla_pro = p.cla_pro and  bsol.FEC_sol between '"+fecha1+"' and '"+fecha2+"' and  m.des_mun = '"+muni+"' and u.tip_uni = 'A' group by p.cla_pro  order by p.cla_pro+0  ;";
	  rset = stmt.executeQuery(qry_meds);
	  while(rset.next()){
		  String cla = rset.getString(1);
		  String descr = rset.getString(2);
		  String sol = rset.getString(3);
		  String sur = rset.getString("0");
		  
		  int por = 0;
		  String qry_msur= "select p.cla_pro as med, p.des_pro as descr, SUM(bsur.can_sur) as sur, sum(bsur.cos_tot) as cos from jurisdicciones j, municipios m, unidades u, productos p, back_surtido bsur  where  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsur.cla_uni and  bsur.cla_pro = p.cla_pro and  bsur.FEC_sur between '"+fecha1+"' and '"+fecha2+"' and  m.des_mun = '"+muni+"' and p.cla_pro = '"+cla+"' and u.tip_uni = 'A' group by p.cla_pro  order by p.cla_pro+0  ;";
		  //out.print(qry_msur + "<br>");
		  rset2 = stmt2.executeQuery(qry_msur);
		  while(rset2.next()){
			  sur = rset2.getString(3);
			  String cos=rset2.getString("cos");
		  }
		  if (sol == null || sol.equals("")) {
			  sol="0";
		  }
		  if (sur == null || sur.equals("")) {
			  sur="0";
		  }
		  
		  if (sol=="0"){
		  por = 0;
		  }else{
			 por = (Integer.parseInt(sur)*100)/(Integer.parseInt(sol));
		  }
		  
	  %>
      <tr class="numeros">
      	<td style="text-align: left" ><%=cla%></td>
        <td style="text-align: left"><%=descr%></td>
        <td><%=forma.format(Integer.parseInt(sol))%></td>
        <td><%=forma.format(Integer.parseInt(sur))%></td>
        <td class="numeros"><%=forma.format( Integer.parseInt(sol) - Integer.parseInt(sur) )%></td>
        <td><%=por%> %</td>
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