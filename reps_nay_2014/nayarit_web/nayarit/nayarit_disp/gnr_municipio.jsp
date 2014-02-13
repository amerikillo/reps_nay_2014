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

response.setContentType ("application/vnd.ms-excel"); 
response.setHeader ("Content-Disposition", "attachment;filename=\"Dispensado por Farmacias "+request.getParameter("mun")+".xls\"");


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
Calendar calendar = Calendar.getInstance();
Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.HOUR_OF_DAY, -1);
String hora = "" + df4.format(calendar.getTime());
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection(""jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2"");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;


int total_surtido=0, tot_med=0, tot_mat=0;
float imp_tot=0, imp_med=0, imp_mat=0;
String fecha1 = "", fecha2="";


rset=stmt.executeQuery("select min(fec_carga), max(fec_carga) from bitacora;");
while(rset.next()){
	fecha1=rset.getString("min(fec_carga)");
	fecha2=rset.getString("max(fec_carga)");
}

try{
	if(request.getParameter("Submit").equals("Por Fechas")){
		fecha1=df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01";
		fecha2=df.format(df2.parse(request.getParameter("txtf_caduci")))+ " 23:59:59";
	}
} catch(Exception e) {
}

try{
	rset=stmt.executeQuery("select sum(cant_sur) as sur, sum(cos) as cos from total_dispensado where des_mun = '"+request.getParameter("mun")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' and tip_pro = 'MEDICAMENTO';");
	while(rset.next()){
		tot_med=Integer.parseInt(rset.getString("sur"));
		imp_med=Float.parseFloat(rset.getString("cos"));
	}
} catch(Exception e) {tot_mat=0;}
try{
	rset=stmt.executeQuery("select sum(cant_sur), sum(cos)  from total_dispensado where des_mun = '"+request.getParameter("mun")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"';");
	while(rset.next()){
		total_surtido=Integer.parseInt(rset.getString(1));
		imp_tot=Float.parseFloat(rset.getString(2));
	}
} catch(Exception e) {total_surtido=0;}

try{
	rset=stmt.executeQuery("select sum(cant_sur), sum(cos)  from total_dispensado where des_mun = '"+request.getParameter("mun")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' and tip_pro = 'MATERIAL DE CURACION';");
	while(rset.next()){
		tot_mat=Integer.parseInt(rset.getString(1));
		imp_mat=Float.parseFloat(rset.getString(2));
	}
} catch(Exception e) {tot_mat=0;}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<script language="javascript" src="list02.js"></script>
<title>Bienvenido :: SISTEMA DE REPORTES WEB ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
<!--
.style1 {
	font-size: 18px
}
.style2 {
	color: #FF0000
}
.style3 {
	color: #FF0000;
	font-weight: bold;
}
.style6 {
	color: #000066;
	font-weight: bold;
}
.style7 {
	color: #FFFFFF;
	font-weight: bold;
}
.Estilo2 {
	color: #FF0000;
	font-size: 12px;
}
.Estilo3 {
	color: #FFFFFF
}
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<script src="scw.js" type="text/javascript"> </script><br />
<tr>
  <td colspan="2" valign="top"><table width="875" border="1" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <td height="41" colspan="3" bgcolor="#FFFFFF"><table width="1247" border="0" cellpadding="2">
            <tr>
              <td><div align="center"><span class="pageName style1">&nbsp;</span><span class="pageName style1">DISPENSADO FARMACIAS - MUNICIPIO</span></div></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td height="41" colspan="3" bgcolor="#FFFFFF"><span class="pez2">JURISDICCIÓN:</span>&nbsp;<%=request.getParameter("juris")%>&nbsp;&nbsp;&nbsp;&nbsp;<span class="pez2"><span class="style7"><a name="ancla2" id="ancla2"></a></span>MUNICIPIO:<%=request.getParameter("mun")%></span>&nbsp;&nbsp;&nbsp;<a href="gnr_municipio.jsp?fecha_1_vi=&fecha_2_vi=&id_cs=&mpio="><a href="gnr_municipio.jsp?fecha_1_vi=&fecha_2_vi=&id_cs=&mpio="></a></td>
      </tr>
      <tr>
        <td width="" bgcolor="#FFFFFF" class="bodyText" colspan="0">Cantidad de piezas (Medicamento)</td>
        <td width="" bgcolor="#FFFFFF" class="bodyText"><%=format.format(tot_med)%></td>
        <td width="" bgcolor="#FFFFFF" class="bodyText">$ <%=format2.format(imp_med)%></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" class="bodyText">Cantidad de piezas (Material de Curaci&oacute;n)</td>
        <td bgcolor="#FFFFFF" class="bodyText" ><%=format.format(tot_mat)%></td>
        <td width="" bgcolor="#FFFFFF" class="bodyText">$ <%=format2.format(imp_mat)%></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" class="bodyText">Total de Piezas: </td>
        <td bgcolor="#FFFFFF" class="bodyText"><%=format.format(total_surtido)%></td>
        <td width="" bgcolor="#FFFFFF" class="bodyText">$ <%=format2.format(imp_tot)%></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF" class="bodyText" colspan="3"><strong>Rango de fechas</strong>:
          <%=df2.format(df3.parse(fecha1))%>
          </label>
          &nbsp;&nbsp;&nbsp;&nbsp;
          <label> al&nbsp;&nbsp;
            <%=df2.format(df3.parse(fecha2))%>
          </label></td>
      </tr>
      <tr>
        <td colspan="3"><span class="Estilo2">&nbsp;&nbsp;</span></td>
      </tr>
      <tr>
        <td height="16" colspan="3" class="bodyText"><table width="867" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
            <tr bgcolor="#FFFFFF" height="17">
              <td height="127" colspan="2"><table width="600" cellpadding="0" cellspacing="0" border="0">
                  <col width="80" span="2" />
                  <tr height="17">
                    <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
                  </tr>
                  <tr bgcolor="#FFFFFF" height="17">
                    <td height="17" valign="top"><table width="588" border="1" cellpadding="0" cellspacing="0">
                        <col width="70" />
                        <col width="336" />
                        <col width="71" />
                        <col width="82" />
                        <col width="23" />
                        <col width="80" />
                        <col width="330" />
                        <col width="80" span="2" />
                        <tr height="17">
                          <td bgcolor="#990000"><a href="#ancla1" class="Estilo3">Ir Abajo</a></td>
                          <td height="17" colspan="3" bgcolor="#990000"><div align="center" class="style7">MEDICAMENTO</div></td>
                        </tr>
                        <tr height="17">
                          <td width="85" height="17" bgcolor="#CCCCCC">Clave</td>
                          <td width="409" bgcolor="#CCCCCC"><div align="left">Descripci&oacute;n</div></td>
                          <td width="86" bgcolor="#CCCCCC"><div align="center"><span class="style3">Cantidad</span></div></td>
                          <td width="86" bgcolor="#CCCCCC"><div align="center"><span class="style3">Importe</span></div></td>
                        </tr>
                        <%
						try{
							rset=stmt.executeQuery("select cla_pro, des_pro, sum(cant_sur) as sur, sum(cos) as cos from total_dispensado where des_mun = '"+request.getParameter("mun")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' and tip_pro = 'MEDICAMENTO' group by cla_pro;");
							while(rset.next()){
						%>
                        <tr height="17">
                          <td height="17" align="right" width="85"><div align="center"><%=rset.getString("cla_pro")%></div></td>
                          <td width="409"><div align="left"><%=rset.getString("des_pro")%></div></td>
                          <td align="right"><div align="center" class="style3"><%=rset.getString("sur")%></div></td>
                          <td align="right"><div align="center" class="style3">$ <%=rset.getString("cos")%></div></td>
                        </tr>
                        <%
							}
						} catch(Exception e) {}
						%>
                        <tr height="17">
                          <td height="17" valign="top"><a href="#ancla2">Ir Arriba</a></td>
                          <td><div align="center">TOTAL MEDICAMENTO </div></td>
                          <td align="right"><%=format.format(tot_med)%><a name="ancla1" id="ancla1"></a></td>
                          <td align="right">$ <%=format2.format(imp_med)%><a name="ancla1" id="ancla1"></a></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                      </table>
                      <div align="center"></div></td>
                    <td width="4" valign="top">&nbsp;</td>
                  </tr>
                </table>
                <div align="center"></div></td>
              <td valign="top"><table width="600" cellpadding="0" cellspacing="0" border="0">
                  <col width="80" span="2" />
                  <tr height="17">
                    <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
                  </tr>
                  <tr bgcolor="#FFFFFF" height="17">
                    <td height="17" valign="bottom"><table width="593" border="1" cellpadding="0" cellspacing="0">
                        <col width="70" />
                        <col width="336" />
                        <col width="71" />
                        <col width="82" />
                        <col width="23" />
                        <col width="80" />
                        <col width="330" />
                        <col width="80" span="2" />
                        <tr height="17">
                          <td bgcolor="#990000"><a href="#ancla3" class="Estilo3">Ir Abajo</a></td>
                          <td height="17" colspan="3" bgcolor="#990000"><div align="center" class="style7">MATERIAL DE CURACION </div></td>
                        </tr>
                        <tr height="17">
                          <td width="85" height="17" bgcolor="#CCCCCC">Clave</td>
                          <td width="409" bgcolor="#CCCCCC"><div align="left">Descripci&oacute;n</div></td>
                          <td width="86" bgcolor="#CCCCCC"><div align="center"><span class="style3">Cantidad</span></div></td>
                          <td width="86" bgcolor="#CCCCCC"><div align="center"><span class="style3">Importe</span></div></td>
                        </tr>
                        <%
						try{
							rset=stmt.executeQuery("select cla_pro, des_pro, sum(cant_sur) as sur, sum(cos) as cos from total_dispensado where des_mun = '"+request.getParameter("mun")+"' and fec_carga between '"+fecha1+"' and '"+fecha2+"' and tip_pro = 'MATERIAL DE CURACION' group by cla_pro;");
							while(rset.next()){
						%>
                        <tr height="17">
                          <td height="17" align="right" width="85"><div align="center"><%=rset.getString("cla_pro")%></div></td>
                          <td width="409"><div align="left"><%=rset.getString("des_pro")%></div></td>
                          <td align="right"><div align="center" class="style3"><%=rset.getString("sur")%></div></td>
                          <td align="right"><div align="center" class="style3">$ <%=rset.getString("cos")%></div></td>
                        </tr>
                        <%
							}
						} catch(Exception e) {}
						%>
                        <tr height="17">
                          <td height="17" align="right"><a href="#ancla2">Ir Arriba</a></td>
                          <td>&nbsp;
                            <div align="center">TOTAL MATERIAL DE CURACION </div></td>
                          <td align="right"><div align="center" class="style2"><strong>$ <%=format.format(tot_mat)%><a name="ancla3" id="ancla3"></a></strong></div></td>
                          <td align="right">$ <%=format2.format(imp_mat)%><a name="ancla1" id="ancla1"></a></td>
                        </tr>
                      </table>
                      <div align="center"></div></td>
                    <td width="4">&nbsp;</td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
      
    </table>
</body>
</html>
</form>