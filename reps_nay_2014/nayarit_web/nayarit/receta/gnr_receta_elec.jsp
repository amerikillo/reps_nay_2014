<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" session="true" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DecimalFormat format = new java.text.DecimalFormat("###,###,###,###");%>
<%java.text.DecimalFormat format2 = new java.text.DecimalFormat("###,###,###,###.##");%>
<%java.text.DateFormat sdf = new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy"); %>
<%NumberFormat forma= NumberFormat.getInstance(Locale.US); %>
<%
DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
simbolos.setDecimalSeparator('.');
simbolos.setGroupingSeparator(',');
DecimalFormat forma2= new DecimalFormat("##,###.##", simbolos);

HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String vali="", user="";



response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=Reporte Consolidado.xls");

if (sesion.getAttribute("valida")!=null){
	vali=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!vali.equals("valido")){
	
	%>
<script>self.location='../../index.jsp';</script>
<%
}
%>
<%
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection(""jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2"");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;

Calendar calendar = Calendar.getInstance();
Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.HOUR_OF_DAY, -1);
String hora = "" + df4.format(calendar.getTime());

int total_surtido=0, total_solicitado=0, tot_rec=0, tot_rec_f=0, tot_rec_c=0;
int tot_pzs_sol=0;
int tot_pzs_sur=0;
float niv_serv=0;
String fecha1 = "", fecha2="";


rset=stmt.executeQuery("select min(fec_carga), max(fec_carga) from bitacora;");
while(rset.next()){
	fecha1=rset.getString("min(fec_carga)");
	fecha2=rset.getString("max(fec_carga)");
}

try{
		fecha1=df.format(df3.parse(fecha1))+" 00:00:01";
		fecha2=df.format(df3.parse(fecha2))+" "+hora;
} catch(Exception e) {
}

rset2=stmt2.executeQuery("select sum(can_sol) from total_receta  where fec_carga between '"+fecha1+"' and '"+fecha2+"' ;");
while(rset2.next()){
	tot_pzs_sol=rset2.getInt(1);
}
rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta  where fec_carga between '"+fecha1+"' and '"+fecha2+"' ;");
while(rset2.next()){
	tot_pzs_sur=rset2.getInt(1);
}


rset=stmt.executeQuery("select id_rec from total_receta where fec_carga between '"+fecha1+"' and '"+fecha2+"' group by id_rec;");
while(rset.next()){
	tot_rec++;
}

rset=stmt.executeQuery("select id_rec from total_receta where id_tip = '1' and fec_carga between '"+fecha1+"' and '"+fecha2+"' group by id_rec;");
while(rset.next()){
	tot_rec_f++;
}

rset=stmt.executeQuery("select id_rec from total_receta where id_tip = '2' and fec_carga between '"+fecha1+"' and '"+fecha2+"' group by id_rec;");
while(rset.next()){
	tot_rec_c++;
}

try{
	niv_serv = (tot_pzs_sur*100)/tot_pzs_sol;
} catch(Exception e){niv_serv=0;}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>RE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<!-- Codigo contadorvisitas.com ver. 4.3 -->

<style type="text/css">
<!--
.style1 {
	font-weight: bold
}
.style3 {
	font-weight: bold
}
.style5 {
	font-weight: bold;
	font-size: 24px;
}
.Estilo1 {
	color: #993300
}
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<script src="scw.js" type="text/javascript"> </script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="382"><table border="0" cellspacing="0" cellpadding="0" width="495">
        <tr>
          <td width="6">&nbsp;&nbsp;</td>
          <td width="550"><table border="1" cellspacing="0" cellpadding="0" width="990">
              <tr>
                <td height="47" colspan="9" class="pageName style1"><div align="center" class="Estilo1">*RECETA ELECTR&Oacute;NICA NAYARIT*</div></td>
              </tr>
              <tr>
                <td class="ver">No. de Recetas Elaboradas:</td>
                <td width="109" align="center" class="ver"><%=format.format(tot_rec)%></td>
                <td colspan="7" rowspan="12" class="ver" align="center"><p> Periodo del &nbsp;&nbsp;&nbsp;&nbsp;<%=df2.format(df3.parse(fecha1))%>&nbsp;&nbsp;&nbsp;&nbsp;al&nbsp;&nbsp;&nbsp;&nbsp;<%=df2.format(df3.parse(fecha2))%></p></td>
              </tr>
              <tr>
                <td class="ver">Recetas Farmacias: </td>
                <td class="ver" align="center"><%=format.format(tot_rec_f)%></td>
              </tr>
              <tr>
                <td class="ver">Recetas Colectivas: </td>
                <td class="ver" align="center"><%=format.format(tot_rec_c)%></td>
              </tr>
              <tr>
                <td width="238" class="ver">No.  de piezas Solicitadas:</td>
                <td class="ver" align="center"><%=format.format(tot_pzs_sol)%></td>
              </tr>
              <tr>
                <td class="ver">No. de Piezas Surtidas:</td>
                <td class="ver" align="center"><%=format.format(tot_pzs_sur)%></td>
              </tr>
              <tr>
                <td class="ver"><!--Sexo F:-->NIvel de Servicio</td>
                <td class="ver" align="center"><%=format2.format(niv_serv)%> %</td>
              </tr>
              <tr>
                <td class="ver">&nbsp;<!--Sexo M:--></td>
                <td class="ver" align="center">&nbsp;</td>
              </tr>
              <tr>
                <td class="ver">&nbsp;<!--Porcentaje de Abasto:--></td>
                <td class="ver" align="center">&nbsp;</td>
              </tr>
              <tr>
                <td class="ver">&nbsp;<!--Total de Unidades con Receta Electr&oacute;nica:--></td>
                <td class="ver" align="center"><!--7 de 7 --></td>
              </tr>
              <tr>
                <td class="ver">&nbsp;<!--Total de M&oacute;dulo con Receta Electr&oacute;nica:--></td>
                <td class="ver" align="center"><!--47 de 54--></td>
              </tr>
              <tr>
                <td class="ver">&nbsp;<!--Porcentaje de Receta Electr&oacute;nica Instalada:--></td>
                <td class="ver" align="center"><!--87.04%--></td>
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" class="ver" colspan="9"><p></p></td>
              </tr>
              <tr>
                <td bgcolor="#DDDDDD" class="subHeader" align="center">Por jurisdicci&oacute;n </td>
                <td bgcolor="#DDDDDD" class="subHeader" align="center">Recetas Farmacias</td>
                <td width="87" align="center" bgcolor="#DDDDDD" class="subHeader">Pzs Farmacia </td>
                <td width="112" align="center" bgcolor="#DDDDDD" class="subHeader">Recetas Colectivas</td>
                <td width="99" align="center" bgcolor="#DDDDDD" class="subHeader">Pzs Colectivas </td>
                <td width="81" align="center" bgcolor="#DDDDDD" class="subHeader">Total Recetas</td>
                <td width="98" align="center" bgcolor="#DDDDDD" class="subHeader">Pzs Solicitadas</td>
                <td width="79" bgcolor="#DDDDDD" class="subHeader"><div align="center">Pzs Surtidas</div></td>
                <td width="67" bgcolor="#DDDDDD" class="subHeader"><div align="center">%</div></td>
              </tr>
              <%
			  
				rset=stmt.executeQuery("select des_jur from jurisdicciones");
				while(rset.next()){
					int tot_rec_jc=0;	
					int tot_rec_jf=0;
					int cant_sur_jf=0;
					int cant_sur_jc=0;
					int tot_rec_jtf=0;
					int tot_rec_jtc=0;
					float niv_serv_j=0;
					%>
              <tr>
                <td class="ver"><a href="ixt1.jsp?id_cs=<%=rset.getString("des_jur")%>"><%=rset.getString("des_jur")%></a></td>
                <%
					rset2=stmt2.executeQuery("select id_rec from total_receta where id_tip = '1' and  fec_carga between '"+fecha1+"' and '"+fecha2+"'  and des_jur = '"+rset.getString("des_jur")+"' group by id_rec;");
					while(rset2.next()){
						tot_rec_jf++;
					}
					%>
                <td align="center"><%=format.format(tot_rec_jf)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta where id_tip = '1' and fec_carga between '"+fecha1+"' and '"+fecha2+"'  and des_jur = '"+rset.getString("des_jur")+"';");
					while(rset2.next()){
						cant_sur_jf=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(cant_sur_jf)%></td>
                <%
					rset2=stmt2.executeQuery("select id_rec from total_receta where id_tip = '2' and fec_carga between '"+fecha1+"' and '"+fecha2+"'  and des_jur = '"+rset.getString("des_jur")+"' group by id_rec;");
					while(rset2.next()){
						tot_rec_jc++;
					}
					%>
                <td align="center"><%=format.format(tot_rec_jc)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta where id_tip = '2' and fec_carga between '"+fecha1+"' and '"+fecha2+"'  and des_jur = '"+rset.getString("des_jur")+"';");
					while(rset2.next()){
						cant_sur_jc=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(cant_sur_jc)%></td>
                <%
					rset2=stmt2.executeQuery("select id_rec from total_receta where des_jur = '"+rset.getString("des_jur")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"'  group by id_rec;");
					while(rset2.next()){
						tot_rec_jtf++;
					}
					%>
                <td align="center"><%=format.format(tot_rec_jtf)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(can_sol) from total_receta where des_jur = '"+rset.getString("des_jur")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' ;");
					while(rset2.next()){
						tot_pzs_sol=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(tot_pzs_sol)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta where des_jur = '"+rset.getString("des_jur")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' ;");
					while(rset2.next()){
						tot_pzs_sur=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(tot_pzs_sur)%></td>
                <%
					try{
						niv_serv_j = (tot_pzs_sur*100)/tot_pzs_sol;
					} catch(Exception e){niv_serv=0;}
				%>
                <td align="center"><%=format2.format(niv_serv_j)%> %</td>
              </tr>
              <%
		
		
				}
				int tot_rec_jc=0;	
				int tot_rec_jf=0;
				int cant_sur_jf=0;
				int cant_sur_jc=0;
				int tot_rec_jtf=0;
				int tot_rec_jtc=0;
				float niv_serv_j=0;
				%>
              <tr>
              
                <td class="ver"><div align="center" class="subHeader">TOTAL</div></td>
                <%
					rset2=stmt2.executeQuery("select id_rec from total_receta where id_tip = '1' and fec_carga between '"+fecha1+"' and '"+fecha2+"' group by id_rec;");
					while(rset2.next()){
						tot_rec_jf++;
					}
					%>
                <td align="center"><%=format.format(tot_rec_jf)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta where id_tip = '1'  and fec_carga between '"+fecha1+"' and '"+fecha2+"';");
					while(rset2.next()){
						cant_sur_jf=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(cant_sur_jf)%></td>
                <%
					rset2=stmt2.executeQuery("select id_rec from total_receta where id_tip = '2' and fec_carga between '"+fecha1+"' and '"+fecha2+"' group by id_rec;");
					while(rset2.next()){
						tot_rec_jc++;
					}
					%>
                <td align="center"><%=format.format(tot_rec_jc)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta where id_tip = '2' and fec_carga between '"+fecha1+"' and '"+fecha2+"';");
					while(rset2.next()){
						cant_sur_jc=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(cant_sur_jc)%></td>
                <%
					rset2=stmt2.executeQuery("select id_rec from total_receta  where fec_carga between '"+fecha1+"' and '"+fecha2+"' group by id_rec;");
					while(rset2.next()){
						tot_rec_jtf++;
					}
					%>
                <td align="center"><%=format.format(tot_rec_jtf)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(can_sol) from total_receta  where fec_carga between '"+fecha1+"' and '"+fecha2+"' ;");
					while(rset2.next()){
						tot_pzs_sol=rset2.getInt(1);
					}
					%>
                <td align="center"><%=format.format(tot_pzs_sol)%></td>
                <%
					rset2=stmt2.executeQuery("select sum(cant_sur) from total_receta  where fec_carga between '"+fecha1+"' and '"+fecha2+"' ;");
					while(rset2.next()){
						tot_pzs_sur=rset2.getInt(1);
					}
					%>
                <td align="center"><div align="center" class="subHeader"><%=format.format(tot_pzs_sur)%></div></td>
                <%
					try{
						niv_serv_j = (tot_pzs_sur*100)/tot_pzs_sol;
					} catch(Exception e){niv_serv=0;}
				%>
                <td align="center"><div align="center" class="subHeader"><%=format2.format(niv_serv_j)%> %</div></td>
              </tr>
            </table>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
</form>

<!-- FIN Codigo contadorvisitas.com -->