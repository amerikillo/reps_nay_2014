<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="pag_man.html" session = "true" %>

<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String vali="", user="";



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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<% 
Class.forName("org.gjt.mm.mysql.Driver"); 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
Statement stmt_200 = null;
Statement stmt_201 = null;
Statement stmt_20 = null;
Statement stmt_date = null;
Statement stmt_d = null;
Statement stmt_day = null;
Statement stmt_2 = null;

Connection conexion=null;
    String mensaje="";
   /*parametros para la conexion*/
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
    String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
    conexion = DriverManager.getConnection(url,usuario,pass);
     stmt_200 = conexion.createStatement();
	 stmt_201 = conexion.createStatement();
	 stmt_20 = conexion.createStatement();
	 stmt_date = conexion.createStatement();
	 stmt_d = conexion.createStatement();
	 stmt_day = conexion.createStatement();
	 stmt_2 = conexion.createStatement();
	 
	 
         /*guardando la conexion en la session*/
        session.setAttribute("conexion",conexion);
       } catch (Exception ex){
        mensaje=ex.toString();
    }
    mensaje="conectado";
    if(conexion.isClosed()){
        mensaje="desconectado";
    }
//out.print(mensaje);

int ban=0,ban_cur=0;
String totPzs="",mpio2_jv="",mpio1_jv="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
String fecha_1= "";
String fecha_2= "";
String unidad_jv="";
String suma="",suma_monto="";
int valor=0,valor_total=0;
double valor_monto=0.0,valor_total_2=0.0;
//variable que sirven para mostrar con formato indicado para las cantidades
int total_pzs=0,total_medi=0,total_cura=0;
//variables para dar formato de 0.00
double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;
String ixt_cad="",ixt_cad2="";
int cant_pzs=0, ixt_uni=0;
double cant_totMon=0.0,ixt_costo=0.0;
	try {
		unidad_jv = request.getParameter("id_cs");       			   
} catch (Exception e) { }

String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}

				  String min="",min1="";
String max="",max1="";
//variables para las fechas minimas y maximas calendario
String anio1_jv="",mes1_jv="",dia1_jv="",anio2_jv="",mes2_jv="",dia2_jv="",fecha_t1="",fecha_t2="";

ResultSet rset_201 = stmt_201.executeQuery("select min(fec_sur),max(fec_sur),YEAR(min(fec_sur)) AS anio1,MONTH(Min(fec_sur)) AS mes1 ,DAY(Min(fec_sur)) AS dia1,YEAR(MAX(fec_sur)) AS anio2,MONTH(MAX(fec_sur)) AS mes2 ,DAY(MAX(fec_sur)) AS dia2 from juris_mpio_fecha where cla_jur=1;");
				  
				   while (rset_201.next()) 
                  {
				  min=rset_201.getString("min(fec_sur)");
				  max=rset_201.getString("max(fec_sur)");
				  min1=rset_201.getString("min(fec_sur)");
				  max1=rset_201.getString("max(fec_sur)");
				   anio1_jv=rset_201.getString("anio1");
				  mes1_jv=rset_201.getString("mes1");
				  dia1_jv=rset_201.getString("dia1");
				  anio2_jv=rset_201.getString("anio2");
				  mes2_jv=rset_201.getString("mes2");
				  dia2_jv=rset_201.getString("dia2");
				  fecha_t1=dia1_jv+"/"+mes1_jv+"/"+anio1_jv;
				  fecha_t2=dia2_jv+"/"+mes2_jv+"/"+anio2_jv;
				  
				  ResultSet rset_date = stmt_date.executeQuery("SELECT DATE_FORMAT('"+min+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset_date.next())
					
                    min= rset_date.getString("DATE_FORMAT('"+min+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
				  rset_date = stmt_date.executeQuery("SELECT DATE_FORMAT('"+max+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset_date.next())
					
                    max= rset_date.getString("DATE_FORMAT('"+max+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
				  
				  }
  				  ResultSet rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio where cla_jur=1 and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';");
				
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  
				  }
				
if(but.equals("Por Fechas"))
      {try{
           fecha_1= df.format(df2.parse(request.getParameter("txtf_caduc")));
		   fecha_2= df.format(df2.parse(request.getParameter("txtf_caduci")));
		} catch (Exception e) {
			%>
            <script>alert("Seleccione un rango de fechas válido")</script>
            <%
		}
	   	   	
	   }
if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio_fecha where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_jur=1 and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  
				  }
				  
				  
%>

<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<script language="javascript" src="../../js/list02.js"></script>
<title>Bienvenido :: SISTEMA DE REPORTES WEB ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../css/mm_entertainment.css" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 18px}
.style3 {color: #FF0000; font-weight: bold; }
.style4 {color: #000000}
.style5 {color: #000066}
.style6 {color: #000066; font-weight: bold; }
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<p>
  <script src="../../js/scw.js" type="text/javascript"> </script>
  <form action="ixt1.jsp?id_cs=<%=unidad_jv%>" method="post" name="form">
</p>
<table width="1059" border="0" cellpadding="2">
  <tr>
    <td width="1051"><div align="left"><span class="pageName style1">Bienvenido (a) <%//=session.getAttribute("username") %>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="pageName">PIEZAS ENTREGADAS POR JURISDICCI&Oacute;N</span></div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  

 
   <tr>
    <td colspan="8"><img src="mm_spacer.gif" alt="" width="1" height="2" border="0" /></td>
  </tr>

   <tr>
    <td colspan="8" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>

  
  <tr>
    <td width="155" height="370" valign="top" bgcolor="#FFFFFF">
	<table border="0" cellspacing="0" cellpadding="0" width="175" id="navigation">
        <tr>
          <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="infor.jsp" class="style4 style4">Regresar a Menú</a></td>
        </tr>
        <tr>
          <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><!--a href="totales2.jsp">Menú  Hospitales </a--></td>
        </tr>
    </table></td>
    <td width="1" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
    <td width="50"><img src="mm_spacer.gif" alt="" width="50" height="1" border="0" /></td>
    <td colspan="3" valign="top"><img src="mm_spacer.gif" alt="" width="304" height="1" border="0" /><br />
	<table border="1" cellspacing="0" cellpadding="0" width="690">
        <tr>
          <td height="41" colspan="2" bgcolor="#FFFFFF" class="pageName style1"><%=unidad_jv%></td>
		 <%
		  if (!(but.equals("Por Fechas")))
		  {
		    %>
			  
			  <td width="161" height="41" bgcolor="#FFFFFF" class="pageName style1"><a href="gnr_jurisXmuni_ixt.jsp?fecha_1_vi=<%=min1%>&fecha_2_vi=<%=max1%>&juri=1&id_cs=<%=unidad_jv%>"><img src="../../imagen/icono_excel.gif" border="0"/></a></td>
			  <%}else{%>
			  <td width="161" height="41" bgcolor="#FFFFFF" class="pageName style1"><a href="gnr_jurisXmuni_ixt.jsp?fecha_1_vi=<%=fecha_1%>&fecha_2_vi=<%=fecha_2%>&juri=1&id_cs=<%=unidad_jv%>"><img src="../../imagen/icono_excel.gif" border="0"/></a></td>
			  <%}%>
        </tr>
       
        <%total_pzs=Integer.parseInt(totPzs);%>
		<tr>
          <td width="428" bgcolor="#FFFFFF" class="bodyText style4">Total de Piezas: </td>
          <td width="95" bgcolor="#FFFFFF" class="bodyText"><span class="style4"><strong>&nbsp;<%=nf1.format(total_pzs)%></strong></span></td>
          <td bgcolor="#FFFFFF" class="bodyText"><input type="submit" value="<<Valores Iniciales>>" />
          &nbsp;</td>
		</tr>
        <tr>
          <td bgcolor="#FFFFFF" class="bodyText" colspan="3"><span class="style4"><strong>Rango de fechas</strong></span>: 
            <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa">
        </label> &nbsp;&nbsp;&nbsp;&nbsp;<label>
         <span class="style4">al&nbsp;</span>&nbsp;<input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa">
        </label>
		<%
		String fechaa1_jv="";
		String fechaa2_jv="";
		      	  
		      			 ResultSet rset_day = stmt_day.executeQuery("SELECT DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_day.next())
		      	        	   fechaa1_jv= rset_day.getString("DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')");
						rset_day = stmt_day.executeQuery("SELECT DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_day.next())
		      	        	   fechaa2_jv= rset_day.getString("DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')");
							   
							   %>
         <input type="submit" name="Submit" value="Por Fechas"/><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br />
        <span class="style4">&nbsp;
        <%=!(fecha_1.equals(""))?"Rango desde "+fechaa1_jv+" hasta "+fechaa2_jv:""%></span><!--a href="totales2.jsp">Total  Hospitales</a--></td>
        </tr>
        <tr>
          <td colspan="3" bgcolor="#FFFFFF" class="bodyText style4">&nbsp;<%=unidad_jv%>&nbsp;&nbsp;Periodo del <%=min%>&nbsp;a 
            <%=max%></td>
        </tr>
        <tr>
          <td height="16" colspan="3" class="bodyText"><table width="678" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              <td width="505" height="17" bgcolor="#FFFFFF">&nbsp;</td>
              <td width="101" bgcolor="#FFFFFF" class="style3"><div align="center">Piezas</div>                <div align="center"></div></td>
              </tr>
			<%				  				  
				  
				 
				  ResultSet rset_2 = rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=1 and M.cla_jur=1 and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=1 and M.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
				  }
  				  while (rset_2.next()) 
                  { 
						ixt_cad=rset_2.getString("sum(total_sur)");
						ixt_uni = Integer.parseInt(ixt_cad);
					mpio2_jv=rset_2.getString("des_mun");
					mpio1_jv=mpio2_jv.replaceAll(" ", "");
						
				  %>
											
			<tr height="17">
              <td height="17" bgcolor="#FFFFFF">
			  <a onClick="showHideItems('item7',1);"><img src="../../imagen/buscar.gif" alt="Muestra / Oculta Unidades - Centros de Salud" width="23" height="25" />Mostrar Unidades de:</a>&nbsp;<a href="atla2.jsp?mpio=1&juris=<%=rset_2.getString("des_jur")%>&id_cs=DEL NAYAR" class="style6"><%=rset_2.getString("des_mun")%></a></td>
              <td bgcolor="#FFFFFF" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                <div align="center"></div></td>
              </tr>
			<% } %>
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" colspan="2">
			   <div id="item7" style="display:none" align="justify" >
			   
			  <table width="607" cellpadding="0" cellspacing="0" border="1">
                <col width="462" />
                <col width="80" />
				<%
				ResultSet rset_200 =  rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=1  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010'  group by U.cla_uni;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio_fecha TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'   and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
	}
				
				suma="";
				suma_monto="";
				while (rset_200.next()) 
                {
					
					ixt_cad=rset_200.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
									 
				%>
                	<tr height="17">
					<td width="336" bgcolor="#E0E0E0"><a href="atla3.jsp?id_cs=<%=rset_200.getString("des_uni")%>&cv_u=<%=rset_200.getString("cla_uni")%>&juris=<%=rset_200.getString("des_jur")%>&mpio=DEL NAYAR" ><%=rset_200.getString("des_uni")%></a></td>
                  <td height="17" bgcolor="#E0E0E0" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                    <div align="center"></div></td>
                  </tr>
				<%   
				//rutina para obtener la suma de las unidades
				suma=rset_200.getString("sum(total_sur)");
				valor=Integer.parseInt(suma);
				valor_total=valor_total+valor;
				//---------@
				
				}  %>
                
                <tr height="17">
                  <td height="17"><div align="right"><strong>TOTAL DEL NAYAR</strong><img src="../../imagen/flecha.gif" /></div></td>
                  <td class="style3"><div align="center"><%=nf1.format(valor_total)%></div>                    <div align="center"></div></td>
                  </tr>
              </table>
			  </div>			  </td>
			  <td width="71">&nbsp;			  </td>
              </tr>
             
			  <%
			 rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=2 and M.cla_jur=1  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
			 
			 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=2 and M.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun  ;");
				  }
				  while (rset_2.next()) 
                  {
									  
					ixt_cad=rset_2.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
					mpio2_jv=rset_2.getString("des_mun");
					mpio1_jv=mpio2_jv.replaceAll(" ", "");
				
			 %>
			   <tr height="17">
              <td height="17" bgcolor="#FFFFFF"><a onClick="showHideItems('item4',1);"><img src="../../imagen/buscar.gif" alt="Muestra / Oculta Unidades - Centros de Salud" width="23" height="25" />Mostrar Unidades de:</a>&nbsp;<a href="atla2.jsp?mpio=2&juris=<%=rset_2.getString("des_jur")%>&id_cs=LA YESCA" class="style6"><%=rset_2.getString("des_mun")%></a></td>
              <td bgcolor="#FFFFFF" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                <div align="center" class="style6"></div></td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
            </tr>
			<%  } %>
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" colspan="2">
			   <div id="item4" style="display:none" align="justify" >
			  <table width="607" cellpadding="0" cellspacing="0" border="1">
                <col width="462" />
                <col width="80" />
				<%
				rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=2  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010'  group by U.cla_uni;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio_fecha TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=2 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'   and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
	}
				
			
				suma="";
				suma_monto="";
				valor=0;
				valor_total=0;
				valor_total_2=0;
				while (rset_200.next()) 
                {
										 
						ixt_cad=rset_200.getString("sum(total_sur)");
						ixt_uni = Integer.parseInt(ixt_cad);
										 
				%>
                	<tr height="17">
					<td width="336" bgcolor="#E0E0E0"><a href="atla3.jsp?id_cs=<%=rset_200.getString("des_uni")%>&cv_u=<%=rset_200.getString("cla_uni")%>&juris=<%=rset_200.getString("des_jur")%>&mpio=LA YESCA" ><%=rset_200.getString("des_uni")%></a></td>
                  <td height="17" bgcolor="#E0E0E0" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                    <div align="center"></div></td>
                  </tr>
				<%   
				//rutina para obtener la suma de las unidades
				
				suma=rset_200.getString("sum(total_sur)");
				valor=Integer.parseInt(suma);
				valor_total=valor_total+valor;
				//---------@
				
				}  %>
           
                <tr height="17">
                  <td height="17"><div align="right"><strong>TOTAL LA YESCA</strong><img src="../../imagen/flecha.gif" /></div></td>
                  <td class="style3"><div align="center"><%=nf1.format(valor_total)%></div>                    <div align="center"></div></td>
                  </tr>
              </table>
			  </div>			  </td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
              </tr>
                         
            
            
			  <%
			 rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=3 and M.cla_jur=1  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
			 
			 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=3 and M.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
				  }
				  if (rset_2.next()) 
                  {
						ixt_cad=rset_2.getString("sum(total_sur)");
						ixt_uni = Integer.parseInt(ixt_cad);
					mpio2_jv=rset_2.getString("des_mun");
					mpio1_jv=mpio2_jv.replaceAll(" ", "");
					
						
			 %>
			  <tr height="17">
              <td height="17" bgcolor="#FFFFFF"><a onClick="showHideItems('item9',1);"><img src="../../imagen/buscar.gif" alt="Muestra / Oculta Unidades - Centros de Salud" width="23" height="25" />Mostrar Unidades de:</a>&nbsp;<a href="atla2.jsp?mpio=3&juris=<%=rset_2.getString("des_jur")%>&id_cs=SAN BLAS" class="style6"><%=rset_2.getString("des_mun")%></a></td>
              <td bgcolor="#FFFFFF" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                <div align="center" class="style6"></div></td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
            </tr>
			<% } %>
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" colspan="2">
			   <div id="item9" style="display:none" align="justify" >
			  <table width="607" cellpadding="0" cellspacing="0" border="1">
                <col width="462" />
                <col width="80" />
				<%
				rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=3  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio_fecha TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=3 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
	}
			
				suma="";
				suma_monto="";
				valor=0;
				valor_total=0;
				valor_total_2=0;
				while (rset_200.next()) 
                {
					ixt_cad=rset_200.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
									 
				%>
                	<tr height="17">
					<td width="336" bgcolor="#E0E0E0"><a href="atla3.jsp?id_cs=<%=rset_200.getString("des_uni")%>&cv_u=<%=rset_200.getString("cla_uni")%>&juris=<%=rset_200.getString("des_jur")%>&mpio=SAN BLAS" ><%=rset_200.getString("des_uni")%></a></td>
                  <td height="17" bgcolor="#E0E0E0" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                    <div align="center"></div></td>
                  </tr>
				<%   
				//rutina para obtener la suma de las unidades
				
				suma=rset_200.getString("sum(total_sur)");
				valor=Integer.parseInt(suma);
				valor_total=valor_total+valor;
				//---------@
					
				}  %>
                <tr height="17">
                  <td height="17"><div align="right"><strong>TOTAL SAN BLAS</strong><img src="../../imagen/flecha.gif" /></div></td>
                  <td class="style3"><div align="center"><%=nf1.format(valor_total)%></div>                    <div align="center"></div></td>
                  </tr>
              </table>
			  </div>			  </td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
              </tr>
              <%
			 rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=4 and M.cla_jur=1  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
			 
			 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=4 and M.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun ;");
				  }
				  while (rset_2.next()) 
                  {
						ixt_cad=rset_2.getString("sum(total_sur)");
						ixt_uni = Integer.parseInt(ixt_cad);
					mpio2_jv=rset_2.getString("des_mun");
					mpio1_jv=mpio2_jv.replaceAll(" ", "");
						
			 %>
			  <tr height="17">
              <td height="17" bgcolor="#FFFFFF"><a onClick="showHideItems('item8',1);"><img src="../../imagen/buscar.gif" alt="Muestra / Oculta Unidades - Centros de Salud" width="23" height="25" />Mostrar Unidades de:</a>&nbsp;<a href="atla2.jsp?mpio=4&juris=<%=rset_2.getString("des_jur")%>&id_cs=SANTA MARIA DEL ORO" class="style6"><%=rset_2.getString("des_mun")%></a></td>
              <td bgcolor="#FFFFFF" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                <div align="center" class="style6"></div></td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
            </tr>
			<% } %>
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" colspan="2">
			   <div id="item8" style="display:none" align="justify" >
			  <table width="607" cellpadding="0" cellspacing="0" border="1">
                <col width="462" />
                <col width="80" />
				<%
				rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=4  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio_fecha TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=4 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
	}
			
				suma="";
				suma_monto="";
				valor=0;
				valor_total=0;
				valor_total_2=0;
				while (rset_200.next()) 
                {
					ixt_cad=rset_200.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
									 
				%>
                	<tr height="17">
					<td width="336" bgcolor="#E0E0E0"><a href="atla3.jsp?id_cs=<%=rset_200.getString("des_uni")%>&cv_u=<%=rset_200.getString("cla_uni")%>&juris=<%=rset_200.getString("des_jur")%>&mpio=SANTA MARIA DEL ORO" ><%=rset_200.getString("des_uni")%></a></td>
                  <td height="17" bgcolor="#E0E0E0" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                    <div align="center"></div></td>
                  </tr>
				<%   
				//rutina para obtener la suma de las unidades
				
				suma=rset_200.getString("sum(total_sur)");
				valor=Integer.parseInt(suma);
				valor_total=valor_total+valor;
				//---------@
					
				}  %>
                <tr height="17">
                  <td height="17"><div align="right"><strong>TOTAL SANTA MARIA DEL ORO</strong><img src="../../imagen/flecha.gif" /></div></td>
                  <td class="style3"><div align="center"><%=nf1.format(valor_total)%></div>                    <div align="center"></div></td>
                  </tr>
              </table>
			  </div>			  </td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
              </tr>
<%
			 rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=5 and M.cla_jur=1  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun;");
			 
			 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=5 and M.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun ;");
				  }
				  while (rset_2.next()) 
                  {
						ixt_cad=rset_2.getString("sum(total_sur)");
						ixt_uni = Integer.parseInt(ixt_cad);
					mpio2_jv=rset_2.getString("des_mun");
					mpio1_jv=mpio2_jv.replaceAll(" ", "");
						
			 %>
			  <tr height="17">
              <td height="17" bgcolor="#FFFFFF"><a onClick="showHideItems('item6',1);"><img src="../../imagen/buscar.gif" alt="Muestra / Oculta Unidades - Centros de Salud" width="23" height="25" />Mostrar Unidades de:</a>&nbsp;<a href="atla2.jsp?mpio=5&juris=<%=rset_2.getString("des_jur")%>&id_cs=TEPIC" class="style6"><%=rset_2.getString("des_mun")%></a></td>
              <td bgcolor="#FFFFFF" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                <div align="center" class="style6"></div></td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
            </tr>
			<% } %>
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" colspan="2">
			   <div id="item6" style="display:none" align="justify" >
			  <table width="607" cellpadding="0" cellspacing="0" border="1">
                <col width="462" />
                <col width="80" />
				<%
				rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=5  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio_fecha TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=5 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
	}
			
				suma="";
				suma_monto="";
				valor=0;
				valor_total=0;
				valor_total_2=0;
				while (rset_200.next()) 
                {
					ixt_cad=rset_200.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
									 
				%>
                	<tr height="17">
					<td width="336" bgcolor="#E0E0E0"><a href="atla3.jsp?id_cs=<%=rset_200.getString("des_uni")%>&cv_u=<%=rset_200.getString("cla_uni")%>&juris=<%=rset_200.getString("des_jur")%>&mpio=TEPIC" ><%=rset_200.getString("des_uni")%></a></td>
                  <td height="17" bgcolor="#E0E0E0" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                    <div align="center"></div></td>
                  </tr>
				<%   
				//rutina para obtener la suma de las unidades
				
				suma=rset_200.getString("sum(total_sur)");
				valor=Integer.parseInt(suma);
				valor_total=valor_total+valor;
				//---------@
					
				}  %>
                <tr height="17">
                  <td height="17"><div align="right"><strong>TOTAL TEPIC</strong><img src="../../imagen/flecha.gif" /></div></td>
                  <td class="style3"><div align="center"><%=nf1.format(valor_total)%></div>                    <div align="center"></div></td>
                  </tr>
              </table>
			  </div>			  </td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
              </tr>

			  <%
			 rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=6 and M.cla_jur=1  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun");
			
			 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,des_mun,sum(total_sur),cla_uni from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where M.cla_mun=6 and M.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by M.cla_mun ;");
				  }
				  while (rset_2.next()) 
                  {
						ixt_cad=rset_2.getString("sum(total_sur)");
						ixt_uni = Integer.parseInt(ixt_cad);
					mpio2_jv=rset_2.getString("des_mun");
					mpio1_jv=mpio2_jv.replaceAll(" ", "");
					
			 %>
			  <tr height="17">
              <td height="17" bgcolor="#FFFFFF"><a onClick="showHideItems('item2',1);"><img src="../../imagen/buscar.gif" alt="Muestra / Oculta Unidades - Centros de Salud" width="23" height="25" />Mostrar Unidades de:</a>&nbsp;<a href="atla2.jsp?mpio=6&juris=<%=rset_2.getString("des_jur")%>&id_cs=XALISCO" class="style6"><%=rset_2.getString("des_mun")%></a></td>
              <td bgcolor="#FFFFFF" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                <div align="center" class="style6"></div></td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
            </tr>
			<% } %>
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" colspan="2">
			   <div id="item2" style="display:none" align="justify" >
			  <table width="607" cellpadding="0" cellspacing="0" border="1">
                <col width="462" />
                <col width="80" />
				<%
				rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=6  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_200 = stmt_200.executeQuery("select des_jur,des_uni,sum(total_sur),U.cla_uni from juris_mpio_fecha TOT inner join unidades U on U.cla_uni=TOT.cla_uni inner join jurisdicciones J on J.cla_jur=TOT.cla_jur where TOT.cla_mun=6 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by U.cla_uni;");
	}
				
				suma="";
				suma_monto="";
				valor=0;
				valor_total=0;
				valor_total_2=0;
				while (rset_200.next()) 
                {
					
					ixt_cad=rset_200.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
									 
				%>
                	<tr height="17">
					<td width="336" bgcolor="#E0E0E0"><a href="atla3.jsp?id_cs=<%=rset_200.getString("des_uni")%>&cv_u=<%=rset_200.getString("cla_uni")%>&juris=<%=rset_200.getString("des_jur")%>&mpio=XALISCO" ><%=rset_200.getString("des_uni")%></a></td>
                  <td height="17" bgcolor="#E0E0E0" class="style3"><div align="center"><%=nf1.format(ixt_uni)%></div>                    <div align="center"></div></td>
                  </tr>
				<%   
				//rutina para obtener la suma de las unidades
				
				suma=rset_200.getString("sum(total_sur)");
				valor=Integer.parseInt(suma);
				valor_total=valor_total+valor;
				//---------@
				
				}  %>
                <tr height="17">
                  <td height="17"><div align="right"><strong>TOTAL XALISCO</strong><img src="../../imagen/flecha.gif" /></div></td>
                  <td class="style3"><div align="center"><%=nf1.format(valor_total)%></div>                    <div align="center"></div></td>
                  </tr>
              </table>
			  </div>			  </td>
			   <td bgcolor="#FFFFFF" class="style3">&nbsp;</td>
              </tr>
			  
			 
		
			 <tr height="17">
              <td height="17" colspan="2" bgcolor="#FFFFFF">&nbsp;</td>
              <td bgcolor="#FFFFFF" class="style3">&nbsp; </td>
            </tr>
          </table>
          <div align="center"></div></td>
        </tr>
		
		
        <tr>
          <td colspan="3" bgcolor="#FFFFFF" class="bodyText"><div align="center" class="style3">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TOTAL<img src="../../imagen/flecha.gif" width="29" height="12" /><%=nf1.format(total_pzs)%>
            </div>            </span></td>
        </tr>
      </table>    </td>
   
    <td width="245" valign="top" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="10" border="0" /><br />
     <table border="0" cellspacing="0" cellpadding="0" width="200">
        <tr>
          <td colspan="3" id="sidebarHeader" class="style1" align="center"><div align="left" class="subHeader"></div></td>
        </tr>

        <tr>
		<td width="45"><img src="mm_spacer.gif" alt="" width="40" height="1" border="0" /></td>
		<td width="110" id="sidebar" class="smallText">
			<p><img src="../../imagen/savi1.jpg" alt="SAVI"  border="0" vspace="6" /><br />
			  <a href="http://www.savi.com.mx" target="_blank">www.savi.com.mx</a><br />

			 <br />
			  &nbsp;<br />
			  &nbsp;<br />
			  &nbsp;<br />          </td>
         <td width="45">&nbsp;</td>
        </tr>
      </table>
    <br /> </td>
    <td width="221" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td width="155" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="1"></td>
    <td width="50" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="221" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="110" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="50" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="245" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="221" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <link rel="stylesheet" href="../../jq/themes/base/jquery.ui.all.css">
	<script src="../../jq/jquery-1.9.0.js"></script>
	<script src="../../jq/ui/jquery.ui.core.js"></script>
	<script src="../../jq/ui/jquery.ui.widget.js"></script>
	<script src="../../jq/ui/i18n/jquery.ui.datepicker-es.js"></script>
	<script src="../../jq/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="../../css/demos.css">
	<script>
	$(function() {
	
	var año1=<%=anio1_jv%>;
	var mes1=<%=mes1_jv%>;
	var dia1=<%=dia1_jv%>;
	var año2=<%=anio2_jv%>;
	var mes2=<%=mes2_jv%>;
	var dia2=<%=dia2_jv%>;
	var ft1=<%=dia1_jv%>+"/"+<%=mes1_jv%>+"/"+<%=anio1_jv%>;
	
	
		$( "#datepicker" ).datepicker({
			//defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../../imagen/calendar.gif",
			buttonImageOnly: true,
			//numberOfMonths: 1,
			defaultDate: ft1,
			minDate:new Date(año1, mes1 - 1, dia1),
			//maxDate: '+0m',
			maxDate:new Date(año2, mes2 - 1, dia2)
		});
		$( "#datepicker1" ).datepicker({
			//defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../../imagen/calendar.gif",
			buttonImageOnly: true,
			//numberOfMonths: 1,
			minDate:new Date(año1, mes1 - 1, dia1),
			//maxDate: '+0m',
			maxDate:new Date(año2, mes2 - 1, dia2)
		});
	});
	</script>
</table>
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
</form>