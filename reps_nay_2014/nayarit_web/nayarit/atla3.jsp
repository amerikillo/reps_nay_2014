<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" session="true" %>

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
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<script language="javascript" src="list02.js"></script>
<title>Bienvenido :: SISTEMA DE REPORTES WEB ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../css/mm_entertainment.css" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 18px}
.style2 {color: #FF0000}
.style3 {color: #FF0000; font-weight: bold; }
.style6 {color: #000066; font-weight: bold; }
.style7 {color: #FFFFFF}
-->
</style>
</head>
<%
NumberFormat nf1 = NumberFormat.getInstance(Locale.US);
DecimalFormat formateador = new DecimalFormat("###,###,###.##");
ResultSet rset_201 = null;
ResultSet rset_20 = null;
String totPzs="",min="",max="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
String fecha_1= "";
String fecha_2= "";
String unidad_jv="";
String solmed="",solmedcost="",solmat="",solmatcost="";
int solmed1=0,solmat1=0;
double solmedcost1=0.0,solmatcost1=0.0;
int totPzsMed1=0,totPzsMat1=0;
int total_pzs=0,total_medi=0,total_cura=0,totPzs1=0;
//variables para las fechas minimas y maximas calendario
String anio1_jv="",mes1_jv="",dia1_jv="",anio2_jv="",mes2_jv="",dia2_jv="",fecha_t1="",fecha_t2="";

//variables para dar formato de 0.00
double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;
double valor_monto=0.0,valor_total_2=0.0,totMonMed1=0.0,totMonMat1=0.0,totMon1=0.0;
String ixt_cad="",ixt_cad2="";
int cant_pzs=0, ixt_uni=0;
double cant_totMon=0.0,ixt_costo=0.0;
int ban=0,ban_cur=0;
     

Statement stmt_201 = null;
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
     stmt_201 = conexion.createStatement();
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

	  
String user_jv="",mpio="",uni_jv="",juris_jv="";
	try {
		unidad_jv = request.getParameter("id_cs");  
		user_jv= request.getParameter("id_only");
		mpio= request.getParameter("mpio");     			   
		uni_jv= request.getParameter("cv_u");
		juris_jv= request.getParameter("juris");     			   
} catch (Exception e) { }

String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}



				   rset_20 = stmt_20.executeQuery("select min(fec_sur),max(fec_sur),YEAR(min(fec_sur)) AS anio1,MONTH(Min(fec_sur)) AS mes1 ,DAY(Min(fec_sur)) AS dia1,YEAR(MAX(fec_sur)) AS anio2,MONTH(MAX(fec_sur)) AS mes2 ,DAY(MAX(fec_sur)) AS dia2 from total_uni_fecha where cla_uni='"+uni_jv+"';");
				  
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
				 
				  min=rset_20.getString("min(fec_sur)");
				  max=rset_20.getString("max(fec_sur)"); 
				  }
	  
  				  if(but.equals("Por Fechas"))
{	    
try{
           fecha_1= df.format(df2.parse(request.getParameter("txtf_caduc")));
		   fecha_2= df.format(df2.parse(request.getParameter("txtf_caduci")));
		} catch (Exception e) {
			%>
            <script>alert("Seleccione un rango de fechas válido")</script>
            <%
		}
	   	   	
	   	   	
	   }
	   
				  
	   
	   rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni  where cla_uni='"+uni_jv+"' group by cla_uni;");
				  
  				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by cla_uni;");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  totPzs1=Integer.parseInt(totPzs);
				  				  
				  }
				  

				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and cla_uni='"+uni_jv+"' group by cla_uni;");
				  
  				  				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by cla_uni;");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzsMed=rset_20.getString("sum(total_sur)");
				  totPzsMed1=Integer.parseInt(totPzsMed);
				  
				  }

				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and cla_uni='"+uni_jv+"' group by cla_uni;");
				  
  				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by cla_uni;");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzsMat=rset_20.getString("sum(total_sur)");
				  totPzsMat1=Integer.parseInt(totPzsMat);
				  }
	

				  %>
<body bgcolor="#FFFFFF">
<script src="../../js/scw.js" type="text/javascript"> </script>
<form action="atla3.jsp?id_cs=<%=unidad_jv%>&mpio=<%=mpio%>&cv_u=<%=uni_jv%>&juris=<%=juris_jv%>" method="post" name="form">
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
  
<%
  if (juris_jv.equals("JURISDICCION SANITARIA I"))
  {
  %>
          <td width="174" height="40" bordercolor="#000000" bgcolor="#FFFFFF"><a href="ixt1.jsp?id_cs=JURISDICCION SANITARIA I&id_only=<%=user_jv%>" style="font-family:Verdana, Geneva, sans-serif; font-size:14px">Regresar a Menú</a>
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
  
            <table width="1177" border="0" cellpadding="0">
              <tr>
                <td width="1187" class="pageName"><div align="center">PIEZAS ENTREGADAS POR UNIDAD</div></td>
              </tr>
            </table></td>
    
	</tr>
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
                               
   <%
   
  			   if(totPzs1==0)
					    {
					%>
					<script>
			alert("No se encontró ningún REQUERIMIENTO por CUBRIR en el RANGO DE FECHAS elegido Del: "+"<%=fechaa1_jv%>"+" al: "+"<%=fechaa2_jv%>"+"."+"\n"+" Escoja un NUEVO RANGO DE FECHA")
			</script>
			 <%
			    }
			 
   
   
   %>                            
                               
                               
	<tr>
        
    <td colspan="2" valign="top"><img src="mm_spacer.gif" alt="" width="304" height="1" border="0" /><br />
	<table border="1" cellspacing="0" cellpadding="0" width="875">
        <tr>
          <td height="41" colspan="2" bgcolor="#FFFFFF"><span class="pez1">JURISDICCIÓN:</span><span class="pez">&nbsp;&nbsp;<%=juris_jv%></span>&nbsp;&nbsp;<a name="ancla2" id="ancla2"></a><span class="pez1">MUNICIPIO:</span>&nbsp;&nbsp;<span class="pez"><%=mpio%></span>&nbsp;&nbsp;<span class="pez1">UNIDAD:</span><span class="pez"><%=unidad_jv%></span>&nbsp;&nbsp;&nbsp;&nbsp;    <%
		  if (!(but.equals("Por Fechas")))
		  {
		  %>
		  <a href="gnr_uniaten.jsp?fecha_1_vi=<%=min%>&fecha_2_vi=<%=max%>&id_cs=<%=unidad_jv%>&cv_u=<%=uni_jv%>">
		  <%}else{%>  <a href="gnr_uniaten.jsp?fecha_1_vi=<%=fecha_1%>&fecha_2_vi=<%=fecha_2%>&id_cs=<%=unidad_jv%>&cv_u=<%=uni_jv%>"><%}%><img src="../../imagen/icono_excel.gif" border="0"/></a></td>
		  </tr>
        
	<%//total_medi=Integer.parseInt(totPzsMed);%>
        <tr>
          <td bgcolor="#FFFFFF" class="bodyText">Cantidad de piezas (Medicamento)</td>
          <td bgcolor="#FFFFFF" class="bodyText"><strong><%=formateador.format(totPzsMed1)%></strong></td>
        </tr>
		<tr>
          <td bgcolor="#FFFFFF" class="bodyText">Cantidad de piezas (Material de Curaci&oacute;n)</td>
          <td bgcolor="#FFFFFF" class="bodyText"><strong><%=formateador.format(totPzsMat1)%></strong></td>
        </tr>
		 <tr>
          <td bgcolor="#FFFFFF" class="bodyText">Total de Piezas: </td>
          <td bgcolor="#FFFFFF" class="bodyText"><strong><%=formateador.format(totPzs1)%></strong></td>
        </tr>
 
        <tr>
          <td bgcolor="#FFFFFF" class="bodyText" colspan="2">Rango de fechas del:&nbsp;&nbsp;<label>
            <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa">
            </label>            &nbsp;&nbsp;&nbsp;&nbsp;<label>
              al&nbsp;&nbsp;<input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa">
              </label>
            <input type="submit" name="Submit" value="Por Fechas"/>
            
            <label> &nbsp;<%=!(fecha_1.equals(""))?"Rango desde "+fechaa1_jv+" hasta "+fechaa2_jv:""%></label><input name="submit" type="submit" value="<<Valores Iniciales>>" /></td>
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
          <td bgcolor="#FFFFFF" class="bodyText" colspan="2"><span class="Estilo2 style2">Periodo Valido del&nbsp;&nbsp;<%=min%> al &nbsp;&nbsp;<%=max%></span></td>
</tr>
        <tr>
          <td height="16"  valign="top" class="bodyText">
		  
		  <table width="600" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              
              <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
			  
              
			</tr>
			
			
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" valign="top"><table width="599" border="1" cellpadding="0" cellspacing="0">
                <col width="70" />
                <col width="336" />
                <col width="71" />
                <col width="82" />
                <col width="23" />
                <col width="80" />
                <col width="330" />
                <col width="80" span="2" />
				 <tr height="17">
                   <td bgcolor="#990000"><a href="#ancla1" class="Estilo3 style7">Ir Abajo</a></td>
                   <td height="17" colspan="2" bgcolor="#990000"><div align="center" class="style7">MEDICAMENTO</div></td>
                   
                   
                   </tr>

                <tr height="17">
				
                  <td width="80" height="17" bgcolor="#CCCCCC">Clave</td>
                  <td width="430" bgcolor="#CCCCCC"><div align="left">Descripci&oacute;n</div></td>
                  <td width="74" bgcolor="#CCCCCC"><div align="center"><span class="style3">Cantidad</span></div></td>
                  
                  </tr>
				  <%		
	
				  ResultSet rset_2 = rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and cla_uni='"+uni_jv+"' group by clave order by tot.cla_pro+0;");
				  				  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by TOT.cla_pro order by tot.cla_pro+0;");
				  }
  				  while (rset_2.next()) 
                  { 
				  solmed=rset_2.getString("sum(total_sur)");
				  solmed1=Integer.parseInt(solmed);
				  
				  %>
                <tr height="17">
                  <td height="17" align="right" width="80"><div align="center"><%=rset_2.getString("clave")%></div></td>
                  <td width="430"><div align="left"><%=rset_2.getString("descri")%></div></td>
                  <td align="right" width="74"><div align="center" class="style3"><%=formateador.format(solmed1)%></div></td>
                 
                </tr>
				<%
				}
				%>
                
<tr height="17">
                  <td height="17" valign="top"><a href="#ancla2">Ir Arriba</a> </td>
                  <td><div align="center">TOTAL MEDICAMENTO </div></td>
                  <td align="right"><a name="ancla1" id="ancla1"></a><div align="center" class="style2"><strong><%=formateador.format(totPzsMed1)%></strong></div></td>
                  
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
			  <table width="594" border="1" cellpadding="0" cellspacing="0">
                <col width="70" />
                <col width="336" />
                <col width="71" />
                <col width="82" />
                <col width="23" />
                <col width="80" />
                <col width="330" />
                <col width="80" span="2" />
				 <tr height="17">
                  <td bgcolor="#990000"><a href="#ancla3" class="Estilo3 style7">Ir Abajo</a></td>
                   <td height="17" colspan="2" bgcolor="#990000"><div align="center" class="style7">MATERIAL DE CURACION </div></td>
                  
                   </tr>

                <tr height="17">
				
                  <td width="81" height="17" bgcolor="#CCCCCC">Clave</td>
                  <td width="428" bgcolor="#CCCCCC"><div align="left">Descripci&oacute;n</div></td>
                  <td width="77" bgcolor="#CCCCCC"><div align="center"><span class="style3">Cantidad</span></div></td>
                  
                  </tr>
				  <%
				  
				 rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and cla_uni='"+uni_jv+"' group by TOT.cla_pro order by tot.cla_pro+0");
				 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by TOT.cla_pro order by tot.cla_pro+0;");
				  }
  				  while (rset_2.next()) 
                  { 
				  solmat=rset_2.getString("sum(total_sur)");
				  solmat1=Integer.parseInt(solmat);
				  
				  
				  
				  
				  %>
                <tr height="17">
                  <td height="17" align="right" width="81"><div align="center"><%=rset_2.getString("clave")%></div></td>
                  <td width="428"><div align="left"><%=rset_2.getString("descri")%></div></td>
                  <td align="right" width="77"><div align="center" class="style3"><%=formateador.format(solmat1)%></div></td>
                  
                </tr>
				<%
				}
				%>
                
<tr height="17">
                  <td height="17" align="right"><a href="#ancla2">Ir Arriba</a></td>
                  <td>&nbsp;
                    <div align="center">TOTAL MATERIAL DE CURACION </div></td>
                  <td align="right"><a name="ancla3" id="ancla3"></a><div align="center" class="style2"><strong><%=formateador.format(totPzsMat1)%></strong></div></td>
                  
                  </tr>
              </table>
                <div align="center"></div></td>
              <td width="4">&nbsp;			  </td>
              </tr>
          </table></td>
        </tr>
      </table>	
	  
    </td>
   
    <td width="4" valign="top" bgcolor="#FFFFFF"><img src="mm_spacer.gif" alt="" width="1" height="10" border="0" /><br />
    <br /> </td>
    <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td width="175" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="1"></td>
    <td width="50" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="821" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="54" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
    <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
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
</body>
</html>
