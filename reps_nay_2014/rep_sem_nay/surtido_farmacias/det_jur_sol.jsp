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
<h1>REPORTE: NIVEL DE SERVICIO EN FARMACIAS</h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
JURISDICCION <%=juris%></div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    <p>SOLICITADO / ENTREGADO</p>
        <p><a href="../rec_sur.jsp">RECETAS SURTIDAS</a></p>
        <p><a href="../cla_des.jsp">CLAVES EN DESABASTO</a></p>
        <p><a href="../ranking.jsp">RANKING DE CLAVES</a></p>
        <p><a href="../../censos/menu_inven.jsp">INVENTARIOS</a></p>
    </div>
    <div class="tit_tablas">
    <form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     <a href="recetas_surtidas/gnr_rec_sur.jsp?fecha1=<%=f1_mos%>&fecha2=<%=f2_mos%>&Submit=Filtrar" target="_blank"><img src="../../imagen/exc.jpg" width="69" height="50" alt="Exportar a Excel" /></a>
    </form>
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:5px; font-family:Arial, Helvetica, sans-serif">
    
   	  <p><a class="regresa" href="../sol_detalle.jsp?tipo=FARMACIAS">Regresar</a></p>
   	  <div>
   	    <table width="700" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
      <td class="tit_tablas"><strong>Requisición</strong></td>
      <td class="tit_tablas"><strong>Abasto</strong></td>
      <td class="tit_tablas"><strong>Adeudo</strong></td>
      <td class="tit_tablas"><strong>Porcentaje</strong></td>
      <td class="tit_tablas"><strong>Importe</strong></td>
    </tr>
    <%
			rset = stmt.executeQuery("SELECT j.des_jur, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur, SUM(dr.can_sol-dr.cant_sur) as dif, j.cla_jur, sum(dr.cos_tot) as cos from detreceta dr, receta r, unidades u, municipios m, jurisdicciones j where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec AND dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur='"+juris+"' group by j.cla_jur order by j.des_jur");
			while(rset.next()){
				
			%>
    <tr class="numeros">
      <td class="tit_tablas" style="text-align:left"><strong><%=rset.getString(1)%></strong></td>
      <td><%=forma.format(Integer.parseInt(rset.getString(2)))%></td>
      <td><%=forma.format(Integer.parseInt(rset.getString(3)))%></td>
      <td><%=forma.format(Integer.parseInt(rset.getString(4)))%></td>
      <td><%=forma2.format((Integer.parseInt(rset.getString(3))*100)/(Integer.parseInt(rset.getString(2))))%>%</td>
      <td><%=forma2.format(Float.parseFloat(rset.getString("cos")))%></td>
    </tr>
    <%
			}
			%>
  </table>
  <br />
   	  </div>
   	  <table width="690" border="0" bgcolor="#EEEEEE" cellpadding="3">
        <tr>
        <td width="360">&nbsp;</td>
        <td width="78" class="tit_tablas">Requisición</td>
        <td width="60" class="tit_tablas">Abasto</td>
        <td width="62" class="tit_tablas">Adeudo</td>
        <td width="62" class="tit_tablas">%</td>
        <td width="62" class="tit_tablas">Imp.</td>
        </tr>
        <%
		String qry_muni= "SELECT j.des_jur, m.des_mun, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur, sum(dr.can_sol-dr.cant_sur) as dif, sum(dr.cos_tot) as cos from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun AND u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec and j.cla_jur = '"+juris+"' AND dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.tip_uni = 'F' group by m.des_mun order by m.des_mun ;";
		rset = stmt.executeQuery(qry_muni);
		while(rset.next()){
			cont_mun++;
			String muni = rset.getString(2);
			String m_sol = rset.getString(3);
			String m_sur = rset.getString(4);
			String m_dif = rset.getString(5);
			String m_cos = rset.getString("cos");
			%>
            
            	<tr class="mun_uni">
                <td ><a onClick="showHideItems('item<%=cont_mun%>',1);" class="link_muestra_u">Mostrar Unidades de: </a><a class="link_mun" href="det_mun_sol.jsp?mun=<%=muni%>&juris=<%=juris%>"><%=muni%></a></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sol))%></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sur))%></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_dif))%></td>
                <td class="numeros"><%=( (Integer.parseInt(m_sur))*100/ (Integer.parseInt(m_sol)))%> %</td>
                <td class=" numeros">$<%=forma2.format(Float.parseFloat(m_cos))%></td>
        </tr>
                <td colspan="6">
                <div id="item<%=cont_mun%>" style="display:none" align="justify" >
                <table border="1" width="680" class="mun_uni" bgcolor="#FFFFFF" bordercolor="#EEEEEE" cellspacing="0" cellpadding="3">
				<%
				String qry_uni = "SELECT j.des_jur, m.des_mun, u.des_uni, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur, sum(dr.can_sol-dr.cant_sur) as dif, sum(dr.cos_tot) as cos from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun AND u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and m.des_mun = '"+muni+"' AND u.tip_uni = 'F' group by u.cla_uni order by m.des_mun ;";
				rset2 = stmt2.executeQuery(qry_uni);
				while(rset2.next()){
					String uni = rset2.getString(3);
					String u_sol = rset2.getString(4);
					String u_sur = rset2.getString(5);
					String u_dif = rset2.getString(6);
					String u_cos = rset2.getString("cos");
				%>
                	<tr>
                    	<td width="300"><a class="link_uni" href="des_uni_sol.jsp?uni=<%=uni%>&juris=<%=juris%>"><%=uni%></a></td>
                        <td width="70" class="numeros"><%=forma.format(Integer.parseInt(u_sol))%></td>
                        <td width="50" class="numeros"><%=forma.format(Integer.parseInt(u_sur))%></td>
                        <td width="50" class="numeros"><%=forma.format(Integer.parseInt(u_dif))%></td>
                        <td width="49" class="numeros"><%=( (Integer.parseInt(u_sur))*100/ (Integer.parseInt(u_sol)))%> %</td>
                        <td width="46">$<%=forma2.format(Float.parseFloat(u_cos))%></td>
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