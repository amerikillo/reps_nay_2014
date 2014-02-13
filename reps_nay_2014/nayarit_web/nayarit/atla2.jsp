<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="pag_man.html" %>

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

<% 
Class.forName("org.gjt.mm.mysql.Driver"); 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
String totPzs="0";
String totMon="0";
String totPzsMed="0";
String totMonMed="0";
String totPzsMat="0";
String totMonMat="0";
String fecha_1= "";
String fecha_2= "";
String unidad_jv="",min="",max="";
//variables para las fechas minimas y maximas calendario
String anio1_jv="",mes1_jv="",dia1_jv="",anio2_jv="",mes2_jv="",dia2_jv="",fecha_t1="",fecha_t2="";

//variable que sirven para mostrar con formato indicado para las cantidades
int total_pzs=0,total_medi=0,total_cura=0;
//variables para dar formato de 0.00
double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;
double valor_monto=0.0,valor_total_2=0.0;
String ixt_cad="",ixt_cad2="";
int cant_pzs=0, ixt_uni=0,cont1=0;
double cant_totMon=0.0,ixt_costo=0.0;
int ban=0,ban_cur=0;

//variables for get the values from atla and we can know if is admin or juris
String user_jv="",mpio_jv="",juris_jv="";
	try {
		unidad_jv = request.getParameter("id_cs");
		mpio_jv = request.getParameter("mpio");
		juris_jv = request.getParameter("juris"); 
		user_jv   = request.getParameter("id_only");    			   
} catch (Exception e) { }

String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}
	
 		   Statement stmt_20 = null;
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
     stmt_20 = conexion.createStatement();
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


  		  
  				  ResultSet rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_mpio where cla_mun='"+mpio_jv+"'  and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010' group by cla_mun;");
				  
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  
				  }
				   rset_20 = stmt_20.executeQuery("select min(fec_sur),max(fec_sur),YEAR(min(fec_sur)) AS anio1,MONTH(Min(fec_sur)) AS mes1 ,DAY(Min(fec_sur)) AS dia1,YEAR(MAX(fec_sur)) AS anio2,MONTH(MAX(fec_sur)) AS mes2 ,DAY(MAX(fec_sur)) AS dia2 from total_mpio_fecha where cla_mun='"+mpio_jv+"';");
				  
  				  while (rset_20.next()) 
                  {
				  min=rset_20.getString("min(fec_sur)");
				  max=rset_20.getString("max(fec_sur)");
				  anio1_jv=rset_20.getString("anio1");
				  mes1_jv=rset_20.getString("mes1");
				  dia1_jv=rset_20.getString("dia1");
				  anio2_jv=rset_20.getString("anio2");
				  mes2_jv=rset_20.getString("mes2");
				  dia2_jv=rset_20.getString("dia2");
				  fecha_t1=dia1_jv+"/"+mes1_jv+"/"+anio1_jv;
				  fecha_t2=dia2_jv+"/"+mes2_jv+"/"+anio2_jv;
				  
				  }
				  
				  rset_20 = stmt_20.executeQuery("select min(fec_sur),max(fec_sur) from total_mpio_fecha where cla_mun='"+mpio_jv+"' ;");
				  
  				  while (rset_20.next()) 
                  {
				  min=rset_20.getString("min(fec_sur)");
				  max=rset_20.getString("max(fec_sur)");
				  
				  }
				  
				  
				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_mpio TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and cla_mun='"+mpio_jv+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010' group by cla_mun;");
				  
  				  while (rset_20.next()) 
                  {
				  totPzsMed=rset_20.getString("sum(total_sur)");
				  
				  }
				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_mpio TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and cla_mun='"+mpio_jv+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010' group by cla_mun;");
				  
  				  while (rset_20.next()) 
                  {
				  totPzsMat=rset_20.getString("sum(total_sur)");
				  
				  }
			
if(but.equals("Por Fechas"))
      {	try{
           fecha_1= df.format(df2.parse(request.getParameter("txtf_caduc")));
		   fecha_2= df.format(df2.parse(request.getParameter("txtf_caduci")));
		} catch (Exception e) {
			%>
            <script>alert("Seleccione un rango de fechas válido")</script>
            <%
		}
	   	   	
	   	   	
	   }
if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_mpio_fecha where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_mun='"+mpio_jv+"' group by cla_mun;");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  
				  }
				  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_mpio_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_mun='"+mpio_jv+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010' group by cla_mun;");
				  }
  				  while (rset_20.next()) 
                  {
					totPzsMed=rset_20.getString("sum(total_sur)");
				  				
				  }
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_mpio_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_mun='"+mpio_jv+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010' group by cla_mun;");
				  }
  				  while(rset_20.next()) 
                	  {
						  cont1++;
					  totPzsMat=rset_20.getString("sum(total_sur)");
					  }

				  				
				  

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<script language="javascript" src="../../js/list02.js"></script>
<title>Bienvenido :: SISTEMA DE REPORTES WEB ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../css/mm_entertainment.css" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 18px}
.style2 {color: #FF0000}
.style3 {color: #FF0000; font-weight: bold; }
.style6 {color: #000066; font-weight: bold; }
.style7 {
	color: #FFFFFF;
	font-weight: bold;
}
.Estilo2 {color: #FF0000; font-size: 12px; }
.Estilo3 {color: #FFFFFF}
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<script src="../../js/scw.js" type="text/javascript"> </script>
<form action="atla2.jsp?id_cs=<%=unidad_jv%>&mpio=<%=mpio_jv%>&juris=<%=juris_jv%>" method="post" name="form">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  
  <tr bgcolor="FFFFFF">
    <td height="57" colspan="3" valign="top" nowrap="nowrap" bgcolor="#FFFFFF" id="tagline">Bienvenido(a) <%//=session.getAttribute("username") %></td>
	<td width="821" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
 

   <tr>
    <td colspan="8"><img src="mm_spacer.gif" alt="" width="1" height="2" border="0" /></td>
  </tr>

   <tr>
    <td colspan="8" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>

  
  <tr>
    <td width="175" height="370" valign="top" bgcolor="#FFFFFF">
	<table border="0" cellspacing="0" cellpadding="0" width="175" id="navigation">
        <tr>
          
 
<%
  if (juris_jv.equals("JURISDICCION SANITARIA I"))
  {
  %>
          <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="ixt1.jsp?id_cs=JURISDICCION SANITARIA I&id_only=<%=user_jv%>">Regresar a Menú</a>
   <%}%>
  
  
   <%
  if (juris_jv.equals("JURISDICCION SANITARIA II"))
  {
  %>
          <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="tenang.jsp?id_cs=JURISDICCION SANITARIA II&id_only=<%=user_jv%>">Regresar a Menú</a>
   <%}%>
 
<%
  if (juris_jv.equals("JURISDICCION SANITARIA III"))
  {
  %>
          <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="tenanc.jsp?id_cs=JURISDICCION SANITARIA III&id_only=<%=user_jv%>">Regresar a Menú</a>
   <%}%>
  
        </tr>
        
    </table></td>
    <td width="1" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
    
    <td colspan="2" valign="top"><img src="mm_spacer.gif" alt="" width="304" height="1" border="0" /><br />
	<table width="875" border="1" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td height="41" colspan="2" bgcolor="#FFFFFF"><table width="1247" border="0" cellpadding="2">
            <tr>
              <td><div align="center"><span class="pageName style1">&nbsp;</span><span class="pageName">PIEZAS ENTREGADAS POR MUNICIPIO</span> </div></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="41" colspan="2" bgcolor="#FFFFFF"><span class="pez2">JURISDICCIÓN:</span> <span class="pez"><%=juris_jv%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="pez2"><span class="style7"><a name="ancla2" id="ancla2"></a></span>MUNICIPIO:</span><span class="pez"><%=unidad_jv%></span>&nbsp;&nbsp;&nbsp;
            <%
		  if (!(but.equals("Por Fechas")))
		  {
		  %>
		  <a href="gnr_municipio.jsp?fecha_1_vi=<%=min%>&fecha_2_vi=<%=max%>&id_cs=<%=unidad_jv%>&mpio=<%=mpio_jv%>">
		  <%}else{%>
	      <a href="gnr_municipio.jsp?fecha_1_vi=<%=fecha_1%>&fecha_2_vi=<%=fecha_2%>&id_cs=<%=unidad_jv%>&mpio=<%=mpio_jv%>"><%}%><img src="../../imagen/icono_excel.gif" border="0"/></a></td>
	    </tr>
          <%total_medi=Integer.parseInt(totPzsMed);%>
        <tr>
          <td width="823" bgcolor="#FFFFFF" class="bodyText">Cantidad de piezas (Medicamento)</td>
          <td width="375" bgcolor="#FFFFFF" class="bodyText"><strong><%=nf1.format(total_medi)%></strong></td>
        </tr>
		<%total_cura=Integer.parseInt(totPzsMat);%>
        <tr>
          <td bgcolor="#FFFFFF" class="bodyText">Cantidad de piezas (Material de Curaci&oacute;n)</td>
          <td bgcolor="#FFFFFF" class="bodyText" colspan=2><strong> <%=nf1.format(total_cura)%></strong></td>
        </tr>
        <tr> <%total_pzs=Integer.parseInt(totPzs);%>
          <td bgcolor="#FFFFFF" class="bodyText">Total de Piezas: </td>
          <td bgcolor="#FFFFFF" class="bodyText" colspan=2><strong> <%=nf1.format(total_pzs)%></strong></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="bodyText" colspan="2"><strong>Rango de fechas</strong>: <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa">
        </label>        &nbsp;&nbsp;&nbsp;&nbsp;<label>
         al&nbsp;&nbsp;<input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa">
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
		<input type="submit" name="Submit" value="Por Fechas"/>  <%=!(fecha_1.equals(""))?"Rango desde "+fechaa1_jv+" hasta "+fechaa2_jv:""%>
        <label><input type="submit" class="bodyText" value="<<Valores Iniciales>>"/>
        </label></td>
        </tr>
		<%
		ResultSet rset_date = stmt_day.executeQuery("SELECT DATE_FORMAT('"+min+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset_date.next())
					
                    min= rset_date.getString("DATE_FORMAT('"+min+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
				  rset_date = stmt_day.executeQuery("SELECT DATE_FORMAT('"+max+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset_date.next())
					
                    max= rset_date.getString("DATE_FORMAT('"+max+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
				  
				  
		
		
		%>
		        <tr>
		<td colspan="2"><span class="Estilo2">Periodo Valido del&nbsp;&nbsp;<%=min%> al &nbsp;&nbsp;<%=max%></span></td>
		</tr>
		<tr>
          <td height="16" colspan="2" class="bodyText"><table width="867" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              <td height="17" bgcolor="#FFFFFF"><div align="center"></div>                <div align="center"></div></td>
            </tr>
			
            <tr bgcolor="#FFFFFF" height="17">
              <td height="127" colspan="2">
			  
			  <table width="600" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              
              <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
			</tr>
			
			
            <tr bgcolor="#FFFFFF" height="17" valign="top">
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
                   <td height="17" colspan="2" bgcolor="#990000"><div align="center" class="style7">MEDICAMENTO</div></td>
                   </tr>

                <tr height="17">
				
                  <td width="85" height="17" bgcolor="#CCCCCC">Clave</td>
                  <td width="409" bgcolor="#CCCCCC"><div align="left">Descripci&oacute;n</div></td>
                  <td width="86" bgcolor="#CCCCCC"><div align="center"><span class="style3">Cantidad</span></div>                    <div align="center"></div></td>
                  </tr>
				  <%				  				  
				  ResultSet rset_2 = rset_2 = stmt_2.executeQuery("select TOT.cla_pro,P.des_pro as descri,sum(total_sur) from total_mpio TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and TOT.cla_mun='"+mpio_jv+"' and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by TOT.cla_pro order by tot.cla_pro+0;");
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select TOT.cla_pro,P.des_pro as descri,sum(total_sur) from total_mpio_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and TOT.cla_mun='"+mpio_jv+"' and TOT.fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010'  group by TOT.cla_pro order by tot.cla_pro+0;");
				  }
  				  while (rset_2.next()) 
                  { 
					ixt_cad=rset_2.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
								  
				  %>
                <tr height="17">
                  <td height="17" align="right" width="85"><div align="center"><%=rset_2.getString("cla_pro")%></div></td>
                  <td width="409"><div align="left"><%=rset_2.getString("descri")%></div></td>
                  <td align="right"><div align="center" class="style3"><%=nf1.format(ixt_uni)%></div>                    
                  <div align="center" class="style6"></div></td>
                  </tr>
				<%
				}
				%>
                
<tr height="17">
                  <td height="17" valign="top"><a href="#ancla2">Ir Arriba</a> </td>
                  <td><div align="center">TOTAL MEDICAMENTO </div></td>
                  <td align="right"><a name="ancla1" id="ancla1"></a>
                    <div align="center" class="style2"><strong><%=nf1.format(total_medi)%></strong></div></td>
                  </tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
              </table>
                <div align="center"></div></td>
              <td width="4" valign="top">&nbsp;			  </td>
              </tr>
          </table>
          <div align="center"></div></td>
		  <td valign="top"><table width="600" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              
              <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
			</tr>
			
			
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" valign="bottom">
			  <table width="593" border="1" cellpadding="0" cellspacing="0">
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
                   <td height="17" colspan="2" bgcolor="#990000"><div align="center" class="style7">MATERIAL DE CURACION </div></td>
                   </tr>

                <tr height="17">
				
                  <td width="80" height="17" bgcolor="#CCCCCC">Clave</td>
                  <td width="433" bgcolor="#CCCCCC"><div align="left">Descripci&oacute;n</div></td>
                  <td width="72" bgcolor="#CCCCCC"><div align="center"><span class="style3">Cantidad</span></div>                    <div align="center"></div></td>
                  </tr>
				  <%				  
				 rset_2 = stmt_2.executeQuery("select TOT.cla_pro,P.des_pro as descri,sum(total_sur) from total_mpio TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and TOT.cla_mun='"+mpio_jv+" 'group by TOT.cla_pro  order by tot.cla_pro+0;");
				 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select TOT.cla_pro,P.des_pro as descri,sum(total_sur) from total_mpio_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and TOT.cla_mun='"+mpio_jv+" 'and TOT.fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  group by TOT.cla_pro  order by tot.cla_pro+0;");
				  }
  				  while (rset_2.next()) 
                  { 
					ixt_cad=rset_2.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
										  
				  %>
                <tr height="17">
                  <td height="17" align="right" width="80"><div align="center"><%=rset_2.getString("cla_pro")%></div></td>
                  <td width="433"><div align="left"><%=rset_2.getString("descri")%></div></td>
                  <td align="right"><div align="center" class="style3"><%=nf1.format(ixt_uni)%></div>                    
                  <div align="center" class="style6"></div></td>
                  </tr>
				<%
				}
				%>
                
<tr height="17">
                  <td height="17" align="right"><a href="#ancla2">Ir Arriba</a></td>
                  <td>&nbsp;
                    <div align="center">TOTAL MATERIAL DE CURACION </div></td>
                  <td align="right"><div align="center" class="style2"><strong><a name="ancla3" id="ancla3"></a><%=nf1.format(total_cura)%></strong></div>  
                    <div align="center"></div></td>
                  </tr>
              </table>
                <div align="center"></div></td>
              <td width="4">&nbsp;			  </td>
              </tr>
          </table></td>
        </tr>
      </table>    </td>
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