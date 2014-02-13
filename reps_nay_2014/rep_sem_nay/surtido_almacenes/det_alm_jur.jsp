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
String juris = request.getParameter("juris");
int cont_mun=0;
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
<h1>REPORTE: NIVEL DE SERVICIO EN ALMACENES </h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
JURISDICCION <%=juris%>
</div>
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
    <input name="juris" value="<%=juris%>" style="display:none" />
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     <a href="recetas_surtidas/gnr_rec_sur.jsp?fecha1=<%=f1_mos%>&fecha2=<%=f2_mos%>&Submit=Filtrar" target="_blank"><img src="../../imagen/exc.jpg" width="69" height="50" alt="Exportar a Excel" /></a>
    </form>
    </div>
   	  <p><a class="regresa" href="../sol_detalle.jsp?tipo=ALMACENES">Regresar</a></p>
   	  <div>
   	    <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
      <td class="tit_tablas"><strong>Requisicion</strong></td>
      <td class="tit_tablas"><strong>Abasto</strong></td>
      <td class="tit_tablas"><strong>Adeudo</strong></td>
      <td class="tit_tablas"><strong>Porcentaje</strong></td>
      <td class="tit_tablas"><strong>Importe</strong></td>
    </tr>
    <%
	String total_abas="", total_req="", cos_tot="";	
	String totales ="select j.des_jur, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'A' and j.cla_jur = '"+juris+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY j.cla_jur ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_req = rset.getString(2);
	}
	
    totales ="select j.des_jur, sum(bsur.can_sur), sum(bsur.cos_tot) as cos FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'A' and j.cla_jur = m.cla_jur and j.cla_jur='"+juris+"' and m.cla_mun = u.cla_mun and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_abas = rset.getString(2);
		cos_tot = rset.getString("cos");
	}
	try{
	%>
    <tr class="numeros">
      <td class="tit_tablas" style="text-align:left"><strong>JURISDICCION SANITARIA <%=juris%></strong></td>
      <td><%=forma.format(Integer.parseInt(total_req))%></td>
      <td><%=forma.format(Integer.parseInt(total_abas))%></td>
      <td><%=forma.format( (Integer.parseInt(total_req))-(Integer.parseInt(total_abas)) )%></td>
      <td><%=forma2.format((Integer.parseInt(total_abas)*100)/(Integer.parseInt(total_req)))%> %</td>
      <td><%=forma2.format(Float.parseFloat(cos_tot))%> %</td>
    </tr>
  </table>
  <%
	} catch (Exception e) {}
  %>
  <br />
   	  </div>
   	  <table width="680" border="0" bgcolor="#EEEEEE" cellpadding="3">
        <tr>
        <td>&nbsp;</td>
        <td width="89" class="tit_tablas">Requisicion</td>
        <td width="60" class="tit_tablas">Abasto</td>
        <td width="62" class="tit_tablas">Adeudo</td>
        <td width="62" class="tit_tablas">%</td>
        <td width="62" class="tit_tablas">Imp</td>
        </tr>
        <%
		String qry_msol= "select m.des_mun, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'A' and j.cla_jur = '"+juris+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY m.des_mun;";
		rset = stmt.executeQuery(qry_msol);
		while(rset.next()){
			cont_mun++;
			String muni = rset.getString(1);
			String m_sol = rset.getString(2);
			String m_sur = "0";
			String m_cos="";
			String qry_msur= "select m.des_mun, sum(bsur.can_sur), sum(bsur.cos_tot) as cos FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'A' and m.des_mun = '"+muni+"' and  bsur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsur.cla_uni  GROUP BY m.des_mun;";
			rset2 = stmt2.executeQuery(qry_msur);
			while(rset2.next()){
				m_sur = rset2.getString(2);
				m_cos = rset2.getString("cos");
			}
			if (m_sol == null || m_sol.equals("")) {
				m_sol="0";
			}
			if (m_sur == null || m_sur.equals("")) {
				m_sur="0";
			}
			if (m_cos == null || m_cos.equals("")) {
				m_cos="0";
			}
			%>
            
            	<tr class="mun_uni">
                <td width="451"><a onClick="showHideItems('item<%=cont_mun%>',1);" class="link_muestra_u">Mostrar Unidades de: </a><a class="link_mun" href="det_alm_mun.jsp?mun=<%=muni%>&juris=<%=juris%>"><%=muni%></a></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sol))%></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sur))%></td>
                <td class="numeros"><%=forma.format( Integer.parseInt(m_sol) - Integer.parseInt(m_sur) )%></td>
                <td class="numeros"><%=( (Integer.parseInt(m_sur))*100/ (Integer.parseInt(m_sol)))%> %</td>
                <td class="numeros">$<%=forma2.format(Float.parseFloat(m_cos))%></td>
        </tr>
                <td colspan="6">
                <div id="item<%=cont_mun%>" style="display:none" align="justify" >
                <table border="1" width="694" class="mun_uni" bgcolor="#FFFFFF" bordercolor="#EEEEEE" cellspacing="0" cellpadding="3">
				<%
				String qry_uni = "select u.des_uni, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'A' and m.des_mun='"+muni+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY u.des_uni;";
				rset2 = stmt2.executeQuery(qry_uni);
				while(rset2.next()){
					String uni = rset2.getString(1);
					String u_sol = rset2.getString(2);
					String u_sur = "0";
					String u_cos="";
					String qry_usur= "select u.des_uni, sum(bsur.can_sur) , sum(bsur.cos_tot) as cos FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j  where u.tip_uni = 'A' and u.des_uni = '"+uni+"' and  bsur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsur.cla_uni  GROUP BY u.des_uni;";
					rset3 = stmt3.executeQuery(qry_usur);
					while(rset3.next()){
						u_sur = rset3.getString(2);
						u_cos = rset3.getString("cos");
					}
					
					if (u_sol == null || u_sol.equals("")) {
						u_sol="0";
					}
					if (u_sur == null || u_sur.equals("")) {
						u_sur="0";
					}
					if (u_cos == null || u_cos.equals("")) {
						u_cos="0";
					}
					%>
                	<tr>
                    	<td width="374"><a class="link_uni" href="det_alm_uni.jsp?uni=<%=uni%>&juris=<%=juris%>"><%=uni%></a></td>
                        <td width="68" class="numeros"><%=forma.format(Integer.parseInt(u_sol))%></td>
                        <td width="58" class="numeros"><%=forma.format(Integer.parseInt(u_sur))%></td>
                        <td width="44" class="numeros"><%=forma.format( Integer.parseInt(u_sol) - Integer.parseInt(u_sur) )%></td>
                        <td width="47" class="numeros"><%=( (Integer.parseInt(u_sur))*100/ (Integer.parseInt(u_sol)))%> %</td>
                        <td width="53" class="numeros">$<%=forma2.format(Float.parseFloat(u_cos))%></td>
                    </tr>
                <%
				}
				%>
                </table>
                </div>
                </td>
            
            <%
		}
		%>
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