<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="../../pag_man.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
NumberFormat nf2 = NumberFormat.getInstance(Locale.US); 
String unidad_jv="",pz="";
int pz1=0;
	try {
		unidad_jv = request.getParameter("id_cs");       			   
} catch (Exception e) { }
String fecha_1="";
 try {
	 fecha_1 = request.getParameter("fecha_1_vi");       			   
} catch (Exception e) { }
String fecha_2="";
 try {
	 fecha_2 = request.getParameter("fecha_2_vi");       			   
} catch (Exception e) { }
String totPzs="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
//String fecha_1= "";
//String fecha_2= "";
//String unidad_jv="";
int totPzs_jv=0;
	try {
		unidad_jv = request.getParameter("id_cs");       			   
} catch (Exception e) { }

String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}

Statement stmt_day = null;
Statement stmt_20 = null;
Statement stmt_2 = null;
ResultSet rset_20 = null;
ResultSet rset_day = null;
ResultSet rset_2 =	null;
	

//-------fin objetos	

/*---------parametros para la conexion*/
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
	
rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio_fecha where cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';;");
				  
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  totPzs_jv=Integer.parseInt(totPzs);
				  }

if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
					
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio_fecha where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010';;");
				  }
  				  while (rset_20.next()) 
                  {
				  totPzs=rset_20.getString("sum(total_sur)");
				  totPzs_jv=Integer.parseInt(totPzs);

				  }	
				  
				  response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=Total Medicamento y Material de Curacion Entregado por Juris del "+fecha_1+" al "+fecha_2+".xls");			  				  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Libro2_archivos/filelist.xml">
<link rel=Edit-Time-Data href="Libro2_archivos/editdata.mso">
<link rel=OLE-Object-Data href="Libro2_archivos/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author> RICARDO HERNANDEZ WENCE</o:Author>
  <o:LastAuthor> RICARDO HERNANDEZ WENCE</o:LastAuthor>
  <o:Created>2009-09-22T16:49:30Z</o:Created>
  <o:LastSaved>2009-09-22T17:52:58Z</o:LastSaved>
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
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
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
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00_\)\;\[Red\]\\\(\0022$\0022\#\,\#\#0\.00\\\)";
	text-align:left;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	color:maroon;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:#CCCCFF none;}
.xl28
	{mso-style-parent:style0;
	color:maroon;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00_\)\;\[Red\]\\\(\0022$\0022\#\,\#\#0\.00\\\)";
	text-align:center;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:#99CC00;
	font-size:18.0pt;
	font-family:"Lucida Console", monospace;
	mso-font-charset:0;
	text-align:center;
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
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:QueryTable>
     <x:OverwriteCells/>
     <x:Name>DatosExternos_1</x:Name>
     <x:AutoFormatFont/>
     <x:AutoFormatPattern/>
     <x:QuerySource>
      <x:QueryType>Web</x:QueryType>
      <x:EnableRedirections/>
      <x:RefreshedInXl9/>
      <x:URLString HRef="http://162.209.67.250:8080/gnk/infor.jsp"/>
      <x:HTMLTables>
       <x:Number>3</x:Number>
      </x:HTMLTables>
      <x:VersionLastRefresh>2</x:VersionLastRefresh>
     </x:QuerySource>
    </x:QueryTable>
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
  <x:WindowHeight>9975</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>DatosExternos_1</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Hoja1!$A$1:$C$15</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=593 style='border-collapse:
 collapse;table-layout:fixed;width:445pt'>
 <col width=274 style='mso-width-source:userset;mso-width-alt:10020;width:206pt'>
 <col width=212 style='mso-width-source:userset;mso-width-alt:7753;width:159pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=2 height=46 class=xl32 width=593 style='height:34.5pt;width:445pt'><a
  name="DatosExternos_1">Total Medicamento ENTREGADO.</a></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt;border-top:none'>Cantidad de
  piezas:</td>
  <td class=xl25 style='border-top:none;border-left:none'><%=nf1.format(totPzs_jv)%></td>
 
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl24 style='height:21.0pt;border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none' >&nbsp;</td>
 
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl25 style='height:21.75pt;border-top:none'>Rango de
  fechas:</td>
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
  <td class=xl25 style='border-top:none;border-left:none'><%=!(fecha_1.equals(""))?fechaa1_jv:"22/08/2012"%> A
  <%=!(fecha_2.equals(""))?fechaa2_jv:"12/10/2012"%></td>
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 style='height:18.0pt;border-top:none'>Por
  Jurisdicción</td>
  <td class=xl27 style='border-top:none;border-left:none'>Unidades</td>
 
 </tr>
 <%				  				  
				  rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio_fecha TOT inner join jurisdicciones  J on J.cla_jur=TOT.cla_jur group by TOT.cla_jur;");
				  			  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio_fecha TOT inner join jurisdicciones  J on J.cla_jur=TOT.cla_jur where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and cla_uni != '1002' and cla_uni != '1004' and cla_uni != '1008' and cla_uni != '1014' and cla_uni != '2002' and cla_uni != '2004' and cla_uni != '2006' and cla_uni != '2008' and cla_uni != '3002' and cla_uni != '3004' and cla_uni != '3006' and cla_uni != '3008' and cla_uni != '3010' group by TOT.cla_jur;");
				  }
				  try {
  				  while (rset_2.next()) 
                  { 
				  pz=rset_2.getString("sum(total_sur)");
				  pz1=Integer.parseInt(pz);
				  %>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl28 style='height:14.25pt;border-top:none'><%=rset_2.getString("des_jur")%></td>
  <td class=xl29 x:num style='border-top:none;border-left:none'><%=nf2.format(pz1)%></td>
  
 </tr>
 <%    }} catch (Exception e){} %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'>TOTAL</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=nf2.format(totPzs_jv)%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=274 style='width:206pt'></td>
  <td width=212 style='width:159pt'></td>
  <td width=107 style='width:80pt'></td>
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