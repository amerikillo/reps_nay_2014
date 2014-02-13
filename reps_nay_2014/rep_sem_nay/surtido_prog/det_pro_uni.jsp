<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true" import="java.util.Calendar" import="java.util.Date" import="java.text.DateFormat" import="java.text.DecimalFormat"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
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
//-------------------------------------------
 Calendar calendar = Calendar.getInstance();
 Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.DATE, -70);
String fecha1 = "" + df.format(calendar.getTime());
String fecha2 = "" + df.format(calendar2.getTime());
String d = "0";
int dias = 0;
//-------------------------------------------
String uni = request.getParameter("uni");
String juris = request.getParameter("juris");
//-------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="../../css/reporte_sem.css" rel="stylesheet" type="text/css" />
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"><img src="../../imagen/ima_main.jpg" /></div>
<h1>REPORTE: NIVEL DE SERVICIO EN PROGRAMAS</h1> <h3>(Solicitado vs Entregado)</h3>
</div>
<div class="banda">
&nbsp;
UNIDAD <%=uni%></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    <p>SOLICITADO / ENTREGADO</p>
        <p><a href="../rec_sur.jsp">RECETAS SURTIDAS</a></p>
        <p><a href="../cla_des.jsp">CLAVES EN DESABASTO</a></p>
        <p><a href="../ranking.jsp">RANKING DE CLAVES</a></p>
        <p><a href="../../censos/menu_inven.jsp">INVENTARIOS</a></p>
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif">
   	  <p><a class="regresa" href="det_pri_jur.jsp?juris=<%=juris%>">Regresar</a></p>
   	  <div>
   	    <table width="690" border="1"  bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr class="tit_tablas">
      <td>&nbsp;</td>
      <td><strong>Requisicion</strong></td>
      <td><strong>Abasto</strong></td>
      <td><strong>Adeudo</strong></td>
      <td><strong>Porcentaje</strong></td>
    </tr>
    <%
	String total_abas="", total_req="";	
	int m_por = 0;
	String totales ="select j.des_jur, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'P' and u.des_uni = '"+uni+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY m.des_mun ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_req = rset.getString(2);
	}
	
    totales ="select j.des_jur, sum(bsur.can_sur) FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'P' and j.cla_jur = m.cla_jur and u.des_uni = '"+uni+"' and m.cla_mun = u.cla_mun and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.cla_uni = bsur.cla_uni GROUP BY m.des_mun ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_abas = rset.getString(2);
	}
	if (total_req == null || total_req.equals("")) {
		total_req="0";
	}
	 if (total_abas == null || total_abas.equals("")) {
		total_abas="0";
	}
	try{
	if (total_req=="0"){
	m_por = 0;
	}else{
	   m_por = (Integer.parseInt(total_abas)*100)/(Integer.parseInt(total_req));
	}
	} catch (Exception e){m_por=0;}
	%>
    <tr class="numeros">
      <td class="tit_tablas" style="text-align:left"><strong><%=uni%></strong></td>
      <td><%=forma.format(Integer.parseInt(total_req))%></td>
      <td><%=forma.format(Integer.parseInt(total_abas))%></td>
      <td><%=forma.format( (Integer.parseInt(total_req))-(Integer.parseInt(total_abas)) )%></td>
      <td><%=m_por%> %</td>
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
      </tr>
      <%
	  String qry_meds="select p.cla_pro as med, p.des_pro as descr, SUM(bsol.can_sol) as sol from jurisdicciones j, municipios m, unidades u, productos p, back_solicitado bsol  where  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni and  bsol.cla_pro = p.cla_pro and  bsol.FEC_sol between '"+fecha1+"' and '"+fecha2+"' and  u.des_uni = '"+uni+"' and u.tip_uni = 'P' group by p.cla_pro  order by p.cla_pro+0  ;";
	  rset = stmt.executeQuery(qry_meds);
	  while(rset.next()){
		  String cla = rset.getString(1);
		  String descr = rset.getString(2);
		  String sol = rset.getString(3);
		  String sur = "0";
		  int por = 0;
		  String qry_msur= "select p.cla_pro as med, p.des_pro as descr, SUM(bsur.can_sur) as sur from jurisdicciones j, municipios m, unidades u, productos p, back_surtido bsur  where  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsur.cla_uni and  bsur.cla_pro = p.cla_pro and  bsur.FEC_sur between '"+fecha1+"' and '"+fecha2+"' and  u.des_uni = '"+uni+"' and p.cla_pro = '"+cla+"' and u.tip_uni = 'P' group by p.cla_pro  order by p.cla_pro+0  ;";
		  //out.print(qry_msur + "<br>");
		  rset2 = stmt2.executeQuery(qry_msur);
		  while(rset2.next()){
			  sur = rset2.getString(3);
		  }
		  if (sol == null || sol.equals("")) {
			  sol="0";
		  }
		  if (sur == null || sur.equals("")) {
			  sur="0";
		  }
		  try{
		  if (sol=="0"){
		  por = 0;
		  }else{
			 por = (Integer.parseInt(sur)*100)/(Integer.parseInt(sol));
		  }
		  } catch (Exception e){por=0;}
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