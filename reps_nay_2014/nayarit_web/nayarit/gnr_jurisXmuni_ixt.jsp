<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="" %>../../pag_man.html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 


NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 


Class.forName("org.gjt.mm.mysql.Driver"); 
String totPzs="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
String fecha_1= "";
String fecha_2= "";
String unidad_jv="";
int total_pzs=0,total_medi=0,total_cura=0;
Connection conne_10=null;
Statement stmt_20=null;
ResultSet rset_20=null;
double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;
String ixt_cad="",ixt_cad2="",juris_jv="";
int cant_pzs=0, ixt_uni=0;
double cant_totMon=0.0,ixt_costo=0.0;
String only="";

	try {
		unidad_jv = request.getParameter("id_cs");
		juris_jv = request.getParameter("juri");       			   
} catch (Exception e) { }

 try {
	 fecha_1 = request.getParameter("fecha_1_vi");       			   
} catch (Exception e) { }

 try {
	 fecha_2 = request.getParameter("fecha_2_vi");       			   
} catch (Exception e) { }
String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}


response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename="+unidad_jv+" POR MUNICIPIO DEL PERIODO "+fecha_1+" al "+fecha_2+".xls");


//ingresar un try y realizar una sola conexión


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
	
	 
	 
         /*guardando la conexion en la session*/
        session.setAttribute("conexion",conexion);
       } catch (Exception ex){
        mensaje=ex.toString();
    }
    mensaje="conectado";
    if(conexion.isClosed()){
        mensaje="desconectado";
    }
	
	

				  
		
  				  			
			if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio_fecha where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_jur='"+juris_jv+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';");
				  }else{
					  rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio_fecha where cla_jur='"+juris_jv+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';");
				  }
  	

		 
		 while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  
				  }

				  
		
		  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 12">
<link id=Main-File rel=Main-File href="../Libro1.htm">
<link rel=File-List href=filelist.xml>
<!--link rel=Stylesheet href=stylesheet.css-->
<style> 
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.style1 {color: #FF0000}
-->
</style>
<![if !supportTabStrip]><script language="JavaScript"> 
<!--
function fnUpdateTabs()
 {
  if (parent.window.g_iIEVer>=4) {
   if (parent.document.readyState=="complete"
    && parent.frames['frTabs'].document.readyState=="complete")
   parent.fnSetActiveSheet(0);
  else
   window.setTimeout("fnUpdateTabs();",150);
 }
}
 
if (window.name!="frSheet")
 window.location.replace("../Libro1.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]>
</head>
 
<body link=blue vlink=purple>
 
<table border=0 cellpadding=0 cellspacing=0 width=439 style='border-collapse:
 collapse;table-layout:fixed;width:330pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=101 span=2 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan="3" ><span class="style1"><%=unidad_jv%></span></td>
  </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'>Información</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'>Total de Piezas:</td>
  <%total_pzs=Integer.parseInt(totPzs);%>
  <td class=xl72 align=right><%=totPzs%></td>
  <td  style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'>&nbsp;</td>
  <td class=xl73 align=right>&nbsp;</td>
  <td style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'>Rango de fechas<font
  class="font0">:</font></td>
  <%
		String fechaa1_jv="";
		String fechaa2_jv="";
		      	
		      			 rset_20 = stmt_20.executeQuery("SELECT DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_20.next())
		      	        	   fechaa1_jv= rset_20.getString("DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')");
						rset_20 = stmt_20.executeQuery("SELECT DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_20.next())
		      	        	   fechaa2_jv= rset_20.getString("DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')");
							   
							   %>
  <td class=xl74 align=right><%=!(fecha_1.equals(""))?fechaa1_jv:"22/08/2012"%></td>
  <td class=xl74 align=right><%=!(fecha_2.equals(""))?fechaa2_jv:"27/09/2012"%></td>
  
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <%
 			  				  
  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
    	rset_20 = stmt_20.executeQuery("select des_mun,sum(total_sur) from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and TOT.cla_jur='"+juris_jv+"' and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by TOT.cla_mun;");
	  }else{
		  rset_20 = stmt_20.executeQuery("select des_mun,sum(total_sur) from juris_mpio_fecha TOT inner join municipios M on M.cla_mun=TOT.cla_mun  where TOT.cla_jur='"+juris_jv+"' and TOT.cla_uni != '1002' and TOT.cla_uni != '1004' and TOT.cla_uni != '1008' and TOT.cla_uni != '1014' and TOT.cla_uni != '2002' and TOT.cla_uni != '2004' and TOT.cla_uni != '2006' and TOT.cla_uni != '2008' and TOT.cla_uni != '3002' and TOT.cla_uni != '3004' and TOT.cla_uni != '3006' and TOT.cla_uni != '3008' and TOT.cla_uni != '3010' group by TOT.cla_mun;");
	  }
  
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Muncipios</td>
  <td class=xl66>Total Pz</td>
  
 </tr>
 <%
  while (rset_20.next()) 
                  { 
					ixt_cad=rset_20.getString("sum(total_sur)");
					ixt_uni = Integer.parseInt(ixt_cad);
 %>
 <tr height=20 style='height:15.0pt'>
 
   <td colspan=2 height=20 class=xl75 style='height:15.0pt'><%=rset_20.getString("des_mun")%></td>
  <td class=xl68><div align="center"><%=nf1.format(ixt_uni)%></div></td>
  
 </tr>
 <% } %>


 

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=120 style='width:90pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
 </tr>
 <![endif]>
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