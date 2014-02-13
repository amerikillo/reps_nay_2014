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
<h1>REPORTE: RECETAS SURTIDAS</h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
JURISDICCION <%=juris%></div>
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
    <input name="juris" type="text" id = "juris" value="<%=juris%>" size="10" readonly style="display:none" />
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     </form>
    </div>
   	  <p><a class="regresa" href="../rec_sur.jsp?tipo=FARMACIAS">Regresar</a></p>
   	  <div>
   	    <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr class="tit_tablas">
      <td>&nbsp;</td>
      <td><strong>Rec. al 100</strong></td>
      <td><strong>Rec. Inc</strong></td>
      <td><strong>Total</strong></td>
      <td><strong>% Rec. Inc.</strong></td>
    </tr>
    <%
	//------------------------------------------------------
	int total_rec=0, inc_rec=0, tt_rec = 0 ;
	//Total de recetas--------------------------------------
	String qry_tot_rec="select j.des_jur,sum(dr.cant_sur),count(dr.id_rec) from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = r.cla_uni and p.cla_pac = r.cla_pac and r.id_rec = dr.id_rec and j.cla_jur='"+juris+"' and dr.fec_sur between '"+fecha1+"' and '"+fecha2+"' group by dr.id_rec";
	rset = stmt.executeQuery(qry_tot_rec);
	while(rset.next()){
		total_rec ++;
	}
	
	String qry_inc_rec="select count(dr.id_rec) from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec AND dr.status = '0' and j.cla_jur='"+juris+"' and dr.fec_sur between '"+fecha1+"' and '"+fecha2+"' group by dr.id_rec;";
	rset = stmt.executeQuery(qry_inc_rec);
	while(rset.next()){
		inc_rec ++;
	}
	if(total_rec==0){
		tt_rec=0;
	} else {
		tt_rec=((inc_rec)*100)/(total_rec);
	}
	
	%>
    <tr class="numeros">
      <td style="text-align:left"><strong>JURISDICCIÓN SANITARIA <%=juris%></strong></td>
      <td><%=forma.format(total_rec-inc_rec)%></td>
      <td><%=forma.format(inc_rec)%></td>
      <td><%=forma.format(total_rec)%></td>
      <td><%=forma2.format(tt_rec)%>%</td>
    </tr>
    <%
	%>
  </table>
  <br />
   	  </div>
   	  <table width="680" border="0" bgcolor="#EEEEEE" cellpadding="3">
        <tr>
        <td>&nbsp;</td>
        <td width="89" class="tit_tablas">Rec. 100</td>
        <td width="60" class="tit_tablas">Rec. Inc.</td>
        <td width="62" class="tit_tablas">Total</td>
        <td width="62" class="tit_tablas">%</td>
        </tr>
        <%
		String qry_muni= "SELECT j.des_jur, m.des_mun, count(r.id_rec) from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun AND u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec and j.cla_jur = '"+juris+"' AND dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.tip_uni = 'F' group by m.des_mun order by m.des_mun ;";
		rset = stmt.executeQuery(qry_muni);
		while(rset.next()){
			cont_mun++;
			String muni = rset.getString(2);
			int rec_c = 0;
			int rec_i = 0;
			int tt_mun = 0;
			String m_dif = "";
			
			String qry_muni_c="SELECT j.des_jur, m.des_mun, count(r.id_rec)  from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr  where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun AND  u.cla_uni = r.cla_uni AND  r.id_rec = dr.id_rec and  j.cla_jur = '"+juris+"' AND  dr.status = '1' and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and m.des_mun = '"+muni+"' and u.tip_uni = 'F' GROUP BY dr.id_rec ;";
			rset2 = stmt2.executeQuery(qry_muni_c);
			while(rset2.next()){
				rec_c++;
			}
			
			String qry_muni_i="SELECT j.des_jur, m.des_mun, count(r.id_rec)  from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr  where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun AND  u.cla_uni = r.cla_uni AND  r.id_rec = dr.id_rec and  j.cla_jur = '"+juris+"' AND  dr.status = '0' and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and m.des_mun = '"+muni+"' and u.tip_uni = 'F' GROUP BY dr.id_rec ;";
			rset2 = stmt2.executeQuery(qry_muni_i);
			while(rset2.next()){
				rec_i++;
			}
			
			if(rec_c==0){
				tt_mun=0;
			} else {
				tt_mun=( rec_i*100/ rec_c);
			}
			
			%>
            
            	<tr class="mun_uni">
                <td width="451"><a onClick="showHideItems('item<%=cont_mun%>',1);" class="link_muestra_u">Mostrar Unidades de: </a><a class="link_mun" href="#"><%=muni%></a></td>
                <td class="numeros"><%=forma.format(rec_c-rec_i)%></td>
                <td class="numeros"><%=forma.format(rec_i)%></td>
                <td class="numeros"><%=forma.format(rec_c)%></td>
                <td class="numeros"><%=(tt_mun)%> %</td>
        </tr>
                <td colspan="5">
                <div id="item<%=cont_mun%>" style="display:none" align="justify" >
                <table border="1" width="694" class="mun_uni" bgcolor="#FFFFFF" bordercolor="#EEEEEE" cellspacing="0" cellpadding="3">
				<%
				String qry_uni = "SELECT j.des_jur, m.des_mun, u.des_uni, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur, sum(dr.can_sol-dr.cant_sur) as dif from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun AND u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and m.des_mun = '"+muni+"' AND u.tip_uni = 'F' group by u.cla_uni order by m.des_mun ;";
				rset2 = stmt2.executeQuery(qry_uni);
				
				while(rset2.next()){
					String uni = rset2.getString(3);
					int urec_c = 0;
					int urec_i = 0;
					int tt_uni = 0;
					String qry_uni_c="SELECT j.des_jur, m.des_mun, count(r.id_rec)  from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr  where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun AND  u.cla_uni = r.cla_uni AND  r.id_rec = dr.id_rec and  j.cla_jur = '"+juris+"' AND  dr.status = '1' and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.des_uni = '"+uni+"' and u.tip_uni = 'F' GROUP BY dr.id_rec ;";
					rset3 = stmt3.executeQuery(qry_uni_c);
					while(rset3.next()){
						urec_c++;
					}
			
					String qry_uni_i="SELECT j.des_jur, m.des_mun, count(r.id_rec)  from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr  where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun AND  u.cla_uni = r.cla_uni AND  r.id_rec = dr.id_rec and  j.cla_jur = '"+juris+"' AND  dr.status = '0' and dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.des_uni = '"+uni+"' and u.tip_uni = 'F' GROUP BY dr.id_rec ;";
					rset3 = stmt3.executeQuery(qry_uni_i);
					while(rset3.next()){
						urec_i++;
					}
					
					if(urec_c==0){
						tt_uni=0;
					} else {
						tt_uni=( urec_i*100/ urec_c);
					}
					
					%>
                	<tr>
                    	<td width="412"><a class="link_uni" href="#"><%=uni%></a></td>
                        <td width="83" class="numeros"><%=forma.format(urec_c-urec_i)%></td>
                        <td width="57" class="numeros"><%=forma.format(urec_i)%></td>
                        <td width="55" class="numeros"><%=forma.format(urec_c)%></td>
                        <td width="53" class="numeros"><%=tt_uni%> %</td>
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