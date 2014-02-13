<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="" session = "true"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DecimalFormat format = new java.text.DecimalFormat("###,###,###,###");%>
<%java.text.DateFormat sdf = new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy"); %>
<%NumberFormat forma= NumberFormat.getInstance(Locale.US); %>
<%

response.setContentType ("application/vnd.ms-excel"); 
response.setHeader ("Content-Disposition", "attachment;filename=\"Dispensado por Farmacias del "+request.getParameter("txtf_caduc")+" al "+request.getParameter("txtf_caduci")+".xls\"");
DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
simbolos.setDecimalSeparator('.');
simbolos.setGroupingSeparator(',');
DecimalFormat forma2= new DecimalFormat("##,###.##", simbolos);

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


int total_surtido=0, tot_jur1=0, tot_jur2=0, tot_jur3=0;
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

rset=stmt.executeQuery("select sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"';");
while(rset.next()){
	total_surtido=Integer.parseInt(rset.getString(1));
}


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

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
   <td width="382">&nbsp;</td>
    <td width="382"><table border="0" cellspacing="0" cellpadding="0" width="495">
      <tr>
        <td width="6">&nbsp;&nbsp;</td>
        <td width="489"><table border="1" cellspacing="0" cellpadding="0" width="507">
            <tr>
              <td height="47" colspan="2" class="pageName style1"><div align="center">
                <p><span class="ROJO">Dispensado en Farmacias</span><span class="ROJO"> <br />
                ENERO 2014</span>.</p>
              </div></td>
            </tr>
            <tr>
              <td width="236" class="bodyText">Cantidad de piezas: <%=format.format(total_surtido)%></td>
              
              <td width="265" class="style3"><div align="center" class="subHeader"></div></td>
            </tr>
            <tr>
              <td colspan="2" class="bodyText"><div align="right">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
            </tr>
            <tr>
              <td bgcolor="#FFFFFF" class="bodyText" colspan="2">Rango de fechas del:&nbsp;&nbsp;
                  <label>
                  <%=df2.format(df3.parse(fecha1))%>
                  </label>                  &nbsp;&nbsp;&nbsp;&nbsp;
                <label> al&nbsp;&nbsp;
                  <%=df2.format(df3.parse(fecha2))%>
                  </label>
                <label></label>
                &nbsp;&nbsp;&nbsp;&nbsp;
                
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
              <td bgcolor="#DDDDDD" class="subHeader">Por Jurisdicci&oacute;n </td>
              <td bgcolor="#DDDDDD" class="subHeader"><div align="center">Piezas</div>
                  <div align="center"></div></td>
            </tr>
            <%
			rset=stmt.executeQuery("select des_jur, sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' AND DES_JUR='JURISDICCION SANITARIA I'  group by des_jur;");
			while(rset.next()){
				tot_jur1=Integer.parseInt(rset.getString(2));
			%>
            <tr>
              <td class="bodyText"><div class="subHeader"><%=rset.getString("des_jur")%></div></td>
              <td class="bodyText"><div align="center" class="subHeader"><%=format.format(Integer.parseInt(rset.getString(2)))%></div></td>
            </tr>
            <%
			}
			%>
            <%
			rset=stmt.executeQuery("select des_jur, sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' AND DES_JUR='JURISDICCION SANITARIA II' group by des_jur;");
			while(rset.next()){
				tot_jur2=Integer.parseInt(rset.getString(2));
			%>
            <tr>
              <td class="bodyText"><div class="subHeader"><%=rset.getString("des_jur")%></div></td>
              <td class="bodyText"><div align="center" class="subHeader"><%=format.format(Integer.parseInt(rset.getString(2)))%></div></td>
            </tr>
            <%
			}
			%>
            <%
			rset=stmt.executeQuery("select des_jur, sum(cant_sur) from total_dispensado where fec_carga between '"+fecha1+"' and '"+fecha2+"' AND DES_JUR='JURISDICCION SANITARIA IiI'  group by des_jur;");
			while(rset.next()){
				tot_jur3=Integer.parseInt(rset.getString(2));
			%>
            <tr>
              <td class="bodyText"><div class="subHeader"><%=rset.getString("des_jur")%></div></td>
              <td class="bodyText"><div align="center" class="subHeader"><%=format.format(Integer.parseInt(rset.getString(2)))%></div></td>
            </tr>
            <%
			}
			%>
            <tr>
              <td class="bodyText"><div align="center" class="subHeader"><!--a href="totales2.jsp"-->TOTAL DISPENSADO<!--/a--></div></td>
              <td class="style3"><div align="center" class="subHeader"><%=format.format(total_surtido)%></div></td>
            </tr>
        </table></td>
      </tr>
    </table>

</body>

</html>
<%
con.close();
%>