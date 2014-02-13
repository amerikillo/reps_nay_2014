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
//-------------------------------------------
 Calendar calendar = Calendar.getInstance();
 Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.DATE, -100);
String fecha1 = "" + df.format(calendar.getTime());
String fecha2 = "" + df.format(calendar2.getTime());
String d = "0";
int dias = 0;
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
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"><img src="../../imagen/ima_main.jpg" /></div>
<h1>REPORTE: NIVEL DE SERVICIO EN 1er NIVEL</h1> <h3>(Solicitado vs Entregado)</h3>
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
   	  <p><a class="regresa" href="../sol_detalle.jsp?tipo=1ER NIVEL">Regresar</a></p>
   	  <div>
   	    <table width="690" border="1"  bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
      <td class="tit_tablas"><strong>Requisicion</strong></td>
      <td class="tit_tablas"><strong>Abasto</strong></td>
      <td class="tit_tablas"><strong>Adeudo</strong></td>
      <td class="tit_tablas"><strong>Porcentaje</strong></td>
    </tr>
    <%
	String total_abas="", total_req="";
	int t_por=0;	
	String totales ="select j.des_jur, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = '1' and j.cla_jur = '"+juris+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY j.cla_jur ;";
	rset = stmt.executeQuery(totales);
	while(rset.next()){	
		total_req = rset.getString(2);
	}
	
    totales ="select j.des_jur, sum(bsur.can_sur) FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = '1' and j.cla_jur = m.cla_jur and j.cla_jur='"+juris+"' and m.cla_mun = u.cla_mun and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
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
	t_por = 0;
	}else{
	   t_por = (Integer.parseInt(total_abas)*100)/(Integer.parseInt(total_req));
	}
	} catch (Exception e){t_por=0;}
	%>
    <tr class="numeros">
      <td style="text-align:left"><strong class="tit_tablas">JURISDICCIÓN SANITARIA <%=juris%></strong></td>
      <td><%=forma.format(Integer.parseInt(total_req))%></td>
      <td><%=forma.format(Integer.parseInt(total_abas))%></td>
      <td><%=forma.format( (Integer.parseInt(total_req))-(Integer.parseInt(total_abas)) )%></td>
      <td><%=t_por%> %</td>
    </tr>
  </table>
  <br />
   	  </div>
   	  <table width="680" border="0" bgcolor="#EEEEEE" cellpadding="3">
        <tr>
        <td>&nbsp;</td>
        <td width="89" class="tit_tablas">Requisición</td>
        <td width="60" class="tit_tablas">Abasto</td>
        <td width="62" class="tit_tablas">Adeudo</td>
        <td width="62" class="tit_tablas">%</td>
        </tr>
        <%
		String qry_msol= "select m.des_mun, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = '1' and j.cla_jur = '"+juris+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY m.des_mun;";
		rset = stmt.executeQuery(qry_msol);
		while(rset.next()){
			cont_mun++;
			String muni = rset.getString(1);
			String m_sol = rset.getString(2);
			String m_sur = "0";
			int m_por = 0; 
			String qry_msur= "select m.des_mun, sum(bsur.can_sur)  FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j  where u.tip_uni = '1' and m.des_mun = '"+muni+"' and  bsur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsur.cla_uni  GROUP BY m.des_mun;";
			rset2 = stmt2.executeQuery(qry_msur);
			while(rset2.next()){
				m_sur = rset2.getString(2);
			}
			if (m_sol == null || m_sol.equals("")) {
				m_sol="0";
			}
			if (m_sur == null || m_sur.equals("")) {
				m_sur="0";
			}
			try {
			if (m_sol=="0"){
			m_por = 0;
			}else{
			   m_por = (Integer.parseInt(m_sur)*100)/(Integer.parseInt(m_sol));
			}
			} catch (Exception e){m_por=0;}
			%>
            
            	<tr class="mun_uni">
                <td width="451"><a onClick="showHideItems('item<%=cont_mun%>',1);" class="link_muestra_u">Mostrar Unidades de: </a><a class="link_mun" href="det_pri_mun.jsp?mun=<%=muni%>&juris=<%=juris%>"><%=muni%></a></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sol))%></td>
                <td class="numeros"><%=forma.format(Integer.parseInt(m_sur))%></td>
                <td class="numeros"><%=forma.format( Integer.parseInt(m_sol) - Integer.parseInt(m_sur) )%></td>
                <td class="numeros"><%=m_por%> %</td>
        </tr>
                <td colspan="5">
                 <div id="item<%=cont_mun%>" style="display:none" align="justify" >
                <table border="1" width="694" class="mun_uni" bgcolor="#FFFFFF" bordercolor="#EEEEEE" cellspacing="0" cellpadding="3">
				<%
				String qry_uni = "select u.des_uni, sum(bsol.can_sol)  FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j  where u.tip_uni = '1' and m.des_mun='"+muni+"' and  bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsol.cla_uni  GROUP BY u.des_uni;";
				rset2 = stmt2.executeQuery(qry_uni);
				while(rset2.next()){
					String uni = rset2.getString(1);
					String u_sol = rset2.getString(2);
					String u_sur = "0";
					int u_por=0;
					String qry_usur= "select u.des_uni, sum(bsur.can_sur)  FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j  where u.tip_uni = '1' and u.des_uni = '"+uni+"' and  bsur.FEC_Sur between '"+fecha1+"' and '"+fecha2+"' and  j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = bsur.cla_uni  GROUP BY u.des_uni;";
					rset3 = stmt3.executeQuery(qry_usur);
					while(rset3.next()){
						u_sur = rset3.getString(2);
					}
					
					if (u_sol == null || u_sol.equals("")) {
						u_sol="0";
					}
					if (u_sur == null || u_sur.equals("")) {
						u_sur="0";
					}
					try {
					if (u_por==0){
					u_por = 0;
					}else{
					   u_por = (Integer.parseInt(u_sur)*100)/(Integer.parseInt(u_sur));
					}
					} catch (Exception e){u_por=0;}
					%>
                	<tr>
                    	<td width="414"><a class="link_uni" href="det_pri_uni.jsp?uni=<%=uni%>&juris=<%=juris%>"><%=uni%></a></td>
                        <td width="83" class="numeros"><%=forma.format(Integer.parseInt(u_sol))%></td>
                        <td width="60" class="numeros"><%=forma.format(Integer.parseInt(u_sur))%></td>
                        <td class="numeros"><%=forma.format( Integer.parseInt(u_sol) - Integer.parseInt(u_sur) )%></td>
                        <td width="49" class="numeros"><%=u_por%> %</td>
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