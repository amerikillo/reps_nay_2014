<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../../pag_man.html" %>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 

String totPzs="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="",uni_jv="";

String unidad_jv="";
	try {
		unidad_jv = request.getParameter("id_cs");
		uni_jv = request.getParameter("cv_u");       			   
} catch (Exception e) { }
String fecha_1="";
 try {
	 fecha_1 = request.getParameter("fecha_1_vi");       			   
} catch (Exception e) { }

String fecha_2="";
 try {
	 fecha_2 = request.getParameter("fecha_2_vi");       			   
} catch (Exception e) { }


response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=UNIDAD "+unidad_jv+" PERIODO DEL "+fecha_1+" AL "+fecha_2+".xls");


Statement stmt_day = null;
 ResultSet rset_day = null;
 Statement stmt_2 = null;
 ResultSet rset_2 = null;
 Statement stmt_20 = null;
 ResultSet rset_20 = null;
 
 //--fin objetos

 /*parametros para la conexion*/	
	
	
	Connection conexion=null;
    String mensaje="";
  
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
     String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
    conexion = DriverManager.getConnection(url,usuario,pass);
     stmt_20 = conexion.createStatement();
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
//-----FIN PARAMETROS -----------	
 				  
if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"';");
				  }else{
				   rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha where cla_uni='"+uni_jv+"';");

				  }
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");

				  }
				  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"';");
				  }else{
  				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and cla_uni='"+uni_jv+"';");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzsMed=rset_20.getString("sum(total_sur)");
				  }
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"';");
				  }else{
   				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and cla_uni='"+uni_jv+"';");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzsMat=rset_20.getString("sum(total_sur)");
				  }

%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="pleaseeee_archivos/filelist.xml">
<link rel=Edit-Time-Data href="pleaseeee_archivos/editdata.mso">
<link rel=OLE-Object-Data href="pleaseeee_archivos/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author> RICARDO HERNANDEZ WENCE</o:Author>
  <o:LastAuthor> RICARDO HERNANDEZ WENCE</o:LastAuthor>
  <o:Created>2009-10-02T21:13:37Z</o:Created>
  <o:LastSaved>2009-10-02T22:00:36Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style> 
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.98in .79in .98in .79in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	color:silver;}
.xl25
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:0;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"mm\/dd\/yyyy\;\@";}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\@";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	text-align:left;}
.xl35
	{mso-style-parent:style0;
	color:white;
	font-size:14.0pt;
	text-align:center;
	border:.5pt solid windowtext;
	background:red;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:center;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.style2 {color: #FF0000}
.xl251 {mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl321 {mso-style-parent:style0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl322 {mso-style-parent:style0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Hoja1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultColWidth>10</x:DefaultColWidth>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Hoja2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultColWidth>10</x:DefaultColWidth>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Hoja3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultColWidth>10</x:DefaultColWidth>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
 
<body link=blue vlink=purple>
 
<table x:str border=0 cellpadding=0 cellspacing=0 width=1217 style='border-collapse:
 collapse;table-layout:fixed;width:913pt'>
 <col width=80 style='width:60pt'>
 <col width=293 style='mso-width-source:userset;mso-width-alt:10715;width:220pt'>
 <col width=80 style='width:60pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=80 span=3 style='width:60pt'>
 <col width=257 style='mso-width-source:userset;mso-width-alt:9398;width:193pt'>
 <col width=80 span=3 style='width:60pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl34 style2 style='height:12.75pt;
  width:280pt' style1> &nbsp;<%=unidad_jv%></td>
  <td width=171 style='width:60pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=257 style='width:193pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Informaci�n</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Cantidad de
  piezas(Medicamento)</td>
  <td class=xl27 align=right x:num><%=totPzsMed%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Cantidad de
  piezas(Material de Curaci�n)</td>
  <td class=xl27 align=right x:num><%=totPzsMat%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Total de piezas</td>
  <td class=xl27 align=right x:num><%=totPzs%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
   <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Rango de fechas
    del:</td>
   <%
		String fechaa1_jv="";
		String fechaa2_jv="";
		      	   rset_day = stmt_day.executeQuery("SELECT DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_day.next())
		      	        	   fechaa1_jv= rset_day.getString("DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')");
						rset_day = stmt_day.executeQuery("SELECT DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_day.next())
		      	        	   fechaa2_jv= rset_day.getString("DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')");
							   
							   %>
   <td class=xl29 align=right ><%=!(fecha_1.equals(""))?fechaa1_jv:"22/08/2012"%></td>
   <td>al</td>
   <td class=xl30><%=!(fecha_2.equals(""))?fechaa2_jv:"27/09/2012"%></td>
   <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td colspan=5 height=24 class=xl35 style='height:18.0pt'>Medicamento</td>
  <td></td>
  
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>Clave</td>
  <td colspan=2 class=xl25 style='border-top:none;border-left:none'>Descrpci�n</td>

  <td colspan=2 class=xl37 style='border-left:none'><span class="xl251" style="border-top:none;border-left:none">Cantidad</span></td>
  <td></td>
  
  <td></td>
 </tr>
 <%				  				  
				  rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and cla_uni='"+uni_jv+"' group by TOT.cla_pro;");
				  		  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MEDICAMENTO' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by TOT.cla_pro;");
				  }
  				  while (rset_2.next()) 
                  { 
				  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none' x:num><%=rset_2.getString("clave")%></td>
  <td colspan="2" class=xl26 style='border-top:none;border-left:none'><%=rset_2.getString("descri")%></td>
  <td colspan=2 class=xl20 x:num style='border-top:none;border-left:none' ><%=rset_2.getString("sum(total_sur)")%></td>
  <!--td colspan=2 class=xl36 x:num style='border-left:none' ><span class="xl321" style="border-top:none;border-left:none"><%=rset_2.getString("sum(total_sur)")%></span></td-->
  <td></td></tr><%}%>
  <td colspan=5 height=24 class=xl35 style='height:18.0pt'>Material de Curacion
   <%
				  
				 rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and cla_uni='"+uni_jv+"' group by TOT.cla_pro;");
				 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select TOT.cla_pro as clave,P.des_pro as descri,sum(total_sur) from total_uni_fecha TOT inner join productos P on P.cla_pro=TOT.cla_pro where P.tip_pro='MATERIAL DE CURACION' and fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni='"+uni_jv+"' group by TOT.cla_pro;");
				  }
  				  while (rset_2.next()) 
                  { 
				  %>
				  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none' x:num><%=rset_2.getString("clave")%></td>
  <td colspan="2" class=xl26 style='border-top:none;border-left:none'><%=rset_2.getString("descri")%></td>
  <td colspan=2 class=xl20 x:num style='border-top:none;border-left:none'><%=rset_2.getString("sum(total_sur)")%></td>
  <!--td colspan=2 class=xl36 style='border-left:none'><span class="xl322" style="border-top:none;border-left:none"><%=rset_2.getString("sum(total_sur)")%></span></td>
  <td></td-->
</tr>
 <%
 }
 
 %>
 <tr height=102 style='height:76.5pt;mso-xlrowspan:6'>
  <td height=102 colspan=11 style='height:76.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=80 style='width:60pt'></td>
  <td width=202 style='width:220pt'></td>
  <td width=171 style='width:60pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=257 style='width:193pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
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