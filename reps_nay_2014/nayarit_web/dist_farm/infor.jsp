*<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="pag_man.html" session = "true"%>
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
    <script>self.location='../index.jsp';</script>
    <%
}
%>

<% 
Class.forName("org.gjt.mm.mysql.Driver"); 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
DecimalFormat formateador= new DecimalFormat("##,###.00");

ResultSet rset_2=null;
ResultSet rset_20=null;//Para obtener los datos de forma global
ResultSet rset_day = null;
ResultSet rset_200=null;

String totPzs="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
String fecha_1= "2014-01-01";
String fecha_2= "2014-01-30";
String unidad_jv="";
int ban=0,ban_cur=0;

//variables para las fechas minimas y maximas calendario
String anio1_jv="",mes1_jv="",dia1_jv="",anio2_jv="",mes2_jv="",dia2_jv="",fecha_t1="",fecha_t2="";


Statement stmt_20 = null;
Statement stmt_d = null;
Statement stmt_day = null;
Statement stmt_2 = null;
Statement stmt_min_max=null;

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
	 stmt_min_max= conexion.createStatement();
	 
	 
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

int atla=0,ixt=0,jil=0,tng=0,tol=0,xon=0,tej=0,tnc=0,val=0;

double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;//variables para dar formato de 0.00
int total_medi=0,total_cura=0;


int cant_pzs=0, ixt_uni=0;
double cant_totMon=0.0,ixt_costo=0.0;
String ixt_cad="",ixt_cad2="";
	try {
		unidad_jv = request.getParameter("id_cs");       			   
} catch (Exception e) { }

String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}


 rset_200 = stmt_min_max.executeQuery("SELECT YEAR(min(fec_sur)) AS anio1,MONTH(Min(fec_sur)) AS mes1 ,DAY(Min(fec_sur)) AS dia1,YEAR(MAX(fec_sur)) AS anio2,MONTH(MAX(fec_sur)) AS mes2 ,DAY(MAX(fec_sur)) AS dia2 FROM registro_surtido;");
	  
	  while(rset_200.next())
	  {
	  anio1_jv=rset_200.getString("anio1");
	  mes1_jv=rset_200.getString("mes1");
	  dia1_jv=rset_200.getString("dia1");
	  anio2_jv=rset_200.getString("anio2");
	  mes2_jv=rset_200.getString("mes2");
	  dia2_jv=rset_200.getString("dia2");
	  fecha_t1=dia1_jv+"/"+mes1_jv+"/"+anio1_jv;
	  fecha_t2=dia2_jv+"/"+mes2_jv+"/"+anio2_jv;
	  }
	  
	  int totax=0;
  				
			if(but.equals("null"))
			  {
				  rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio ;");
				  
				 
								  
  				  while (rset_20.next()) 
                  {
					totax=rset_20.getInt("sum(total_sur)");  
					  
				  /*totPzs=rset_20.getString("sum(uni)");
				  cant_pzs=Integer.parseInt(totPzs);
				  */}
				  
			  }//fin del if but
			  
			 
			 
			  
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
if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
					
				  	rset_20 = stmt_20.executeQuery("select sum(total_sur) from juris_mpio_fecha  where fec_sur between '"+fecha_1+"' and '"+fecha_2+"' and  cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
				  }
  				  while (rset_20.next()) 
                  {
				 totax=rset_20.getInt("sum(total_sur)");
				  }
				  
				 

String fecha_1_jv= "";
String fecha_2_jv= "";
	 	   
%>
<%! public int customerId=0;
    public int customerId2=0;
	Connection conn = null;
    Statement stmt = null;
    ResultSet rset=null;
  public int regulaCont()
      {
		  
		  /*---------parametros para la conexion*/
Connection conexion=null;
    String mensaje="";
   /*parametros para la conexion*/
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";    String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
    conexion = DriverManager.getConnection(url,usuario,pass);
     
	stmt = conexion.createStatement();    
	 
	 
         /*guardando la conexion en la session*/
       // session.setAttribute("conexion",conexion);
       } catch (Exception ex){
        mensaje=ex.toString();
    }
    mensaje="conectado";
   
//-----FIN PARAMETROS -----------
          //customerId2=0;            
             try { 
                     
				  stmt.execute("insert into ip values(null,'morelia')");     
                  rset = stmt.executeQuery("select no_receipt from ip");
                  while(rset.next())
                       customerId = rset.getInt("no_receipt");
                  
                 System.out.print("halo");           
                } catch (Exception e)
                     {  
                       System.out.print("haloja");  
                     }
				finally {
	  try {
                conn.close();
              }
            catch (Exception e) {}
        }
		 return customerId;

 
     }   


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>Text</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../css/mm_health_nutr.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
//--------------- LOCALIZEABLE GLOBALS ---------------
var d=new Date();
var monthname=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
//Ensure correct for language. English is "January 1, 2004"
var TODAY = monthname[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear();
//---------------   END LOCALIZEABLE   ---------------

</script>
<!-- Codigo contadorvisitas.com ver. 4.3 -->
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function GetCookie (name) { 
var arg = name + "="; 
var alen = arg.length; 
var clen = document.cookie.length; 
var i = 0; 
while (i < clen) {
var j = i + alen; 
if (document.cookie.substring(i, j) == arg) 
return getCookieVal (j); 
i = document.cookie.indexOf(" ", i) + 1; 
if (i == 0) break; 
} 
return null;
}
function SetCookie (name, value) { 
var argv = SetCookie.arguments; 
var argc = SetCookie.arguments.length; 
var expires = (argc > 2) ? argv[2] : null; 
var path = (argc > 3) ? argv[3] : null; 
var domain = (argc > 4) ? argv[4] : null; 
var secure = (argc > 5) ? argv[5] : false; 
document.cookie = name + "=" + escape (value) + 
((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + 
((path == null) ? "" : ("; path=" + path)) + 
((domain == null) ? "" : ("; domain=" + domain)) + 
((secure == true) ? "; secure" : "");
}
function DeleteCookie (name) { 
var exp = new Date(); 
exp.setTime (exp.getTime() - 1); 
var cval = GetCookie (name); 
document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString();
}
var expDays = 30;
var exp = new Date(); 
exp.setTime(exp.getTime() + (expDays*24*60*60*1000));
function amt(){
var count = GetCookie('count')
if(count == null) {
SetCookie('count','1')
return 1
}
else {
var newcount = parseInt(count) + 1;
DeleteCookie('count')
SetCookie('count',newcount,exp)
return count
}
}
function getCookieVal(offset) {
var endstr = document.cookie.indexOf (";", offset);
if (endstr == -1)
endstr = document.cookie.length;
return unescape(document.cookie.substring(offset, endstr));
}
// End -->
</SCRIPT>
<!-- FIN Codigo contadorvisitas.com -->
                    
<style type="text/css">
<!--
.style1 {font-weight: bold}
.style3 {font-weight: bold}
.style5 {font-weight: bold; font-size: 24px; }
-->
</style>
</head>
<body bgcolor="#FFFFFF">
<a href="../index.jsp" style="font-family:Verdana, Geneva, sans-serif; font-size:14px"> Regresar a Men&uacute; </a></td>
<script src="../../js/scw.js" type="text/javascript"> </script>
<form action="infor.jsp" method="post" name="form">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
   <td>&nbsp;</td> </tr>
 <tr>
   <td width="382">&nbsp;</td>
    <td width="382"><table border="0" cellspacing="0" cellpadding="0" width="495">
      <tr>
        <td width="6">&nbsp;&nbsp;</td>
        <td width="489"><table border="1" cellspacing="0" cellpadding="0" width="507">
            <tr>
              <td height="47" colspan="2" class="pageName style1"><div align="center">
                <p><span class="ROJO">PIEZAS ENTREGADAS A FARMACIAS</span><span class="ROJO"> <br />
                ENERO 2014</span>.</p>
              </div></td>
            </tr>
            <tr>
              <td width="236" class="bodyText">Cantidad de piezas:*</td>
              
              <td width="265" class="style3"><div align="center" class="subHeader"><%=nf1.format(totax)%></div></td>
            </tr>
            <tr>
              <td colspan="2" class="bodyText"><div align="right">Exportar:  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../imagen/exc.jpg" width="37" height="29" border="0" usemap="#Map2"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input name="Submit2" type="submit" class="bodyText" value="<<Valores Iniciales>>" />
              </div></td>
            </tr>
            <tr>
              <td bgcolor="#FFFFFF" class="bodyText" colspan="2">Rango de fechas del:&nbsp;&nbsp;
                  <label>
                  <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa">
                  </label>                  &nbsp;&nbsp;&nbsp;&nbsp;
                  <label> al&nbsp;&nbsp;
                  <input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa">
                  </label>
                  <input type="submit" name="Submit" value="Por Fechas"/>
                  <label></label>
                &nbsp;&nbsp;&nbsp;&nbsp;
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
                <%=!(fecha_1.equals(""))?"Rango desde "+fechaa1_jv+" hasta "+fechaa2_jv:"Período del 03/08/2012 al 11/03/2013"%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</tr>
            <tr>
              <td bgcolor="#DDDDDD" class="subHeader">Por Jurisdicci&oacute;n </td>
              <td bgcolor="#DDDDDD" class="subHeader"><div align="center">Piezas</div>
                  <div align="center"></div></td>
            </tr>
          
            <%  
		 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio_fecha TOT inner join jurisdicciones JUR on jur.cla_jur=TOT.cla_jur where JUR.cla_jur=1 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and  tot.cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
				  }
				else  
				  rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio TOT inner join jurisdicciones JUR on jur.cla_jur=TOT.cla_jur where JUR.cla_jur=1  and tot.cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
			try {
				  while (rset_2.next()) 
                  {
			 %>
            <tr>
              <td class="bodyText"><a href="ixt1.jsp?id_cs=JURISDICCION SANITARIA I"><%=rset_2.getString("des_jur")%></a></td>
              <%
		   ixt_cad=rset_2.getString("sum(total_sur)");
		   ixt_uni = Integer.parseInt(ixt_cad);
		   ixt= Integer.parseInt(ixt_cad);
		   
		  %>
              <td height="17" align="center"><%=nf1.format(ixt_uni)%></td>
            </tr>
           
            <% } } catch (Exception e) {}
		  
		 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio_fecha TOT inner join jurisdicciones JUR on jur.cla_jur=TOT.cla_jur where JUR.cla_jur=2 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and tot.cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
				  }
				  else
				  rset_2 = rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio TOT inner join jurisdicciones JUR on jur.cla_jur=TOT.cla_jur where JUR.cla_jur=2  and tot.cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
			try {
				  while (rset_2.next()) 
                  {
				   ixt_cad=rset_2.getString("sum(total_sur)");
				   ixt_uni = Integer.parseInt(ixt_cad);
				   tng= Integer.parseInt(ixt_cad);
				  
			 %>
            <tr>
              <td class="bodyText"><a href="tenang.jsp?id_cs=JURISDICCION SANITARIA II"><%=rset_2.getString("des_jur")%></a></td>
              <td height="17" align="center"><%=nf1.format(ixt_uni)%></td>
            </tr>
           
            <% } } catch (Exception e) {}
		if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio_fecha TOT inner join jurisdicciones JUR on jur.cla_jur=TOT.cla_jur where JUR.cla_jur=3 and fec_sur between '"+fecha_1+"' and '"+fecha_2+"'  and tot.cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
				  }else 
		rset_2 = stmt_2.executeQuery("select des_jur,sum(total_sur) from juris_mpio TOT inner join jurisdicciones JUR on jur.cla_jur=TOT.cla_jur where JUR.cla_jur=3  and tot.cla_uni in ('1002', '1004','1008','1014','2002','2004','2006','2008','3002','3004','3006','3008','3010')");
			 try {
				  while (rset_2.next()) 
                  {
				     ixt_cad=rset_2.getString("sum(total_sur)");
					 ixt_uni = Integer.parseInt(ixt_cad);
					 tnc= Integer.parseInt(ixt_cad);
					 
			 %>
            <tr>
              <td class="bodyText"><a href="tenanc.jsp?id_cs=JURISDICCION SANITARIA III"><%=rset_2.getString("des_jur")%></a></td>
              <td height="17" align="center"><%=nf1.format(ixt_uni)%> </td>
            </tr>
          
            <%  }} catch (Exception e) {} %>
            <tr>
              <td class="bodyText">&nbsp;</td>
              <td class="bodyText">&nbsp;</td>
            </tr>
            <tr>
              <td class="bodyText"><div align="center" class="subHeader"><!--a href="totales2.jsp"-->TOTAL PIEZAS ENTREGADAS<!--/a--></div></td>
              <td class="style3"><div align="center" class="subHeader"><%=nf1.format(totax)%></div></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
    <td width="382">&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="637"><div align="center">
    
      <p><span class="style5"><p class="style5"><script type="text/javascript" src="../../jq/jquery.min.js"></script>
		<script type="text/javascript">
function addCommas(nStr)
   {
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
   }

$(function () {




    var chart;
	var atl=<%=atla%>;
	var atl2=addCommas(atl);
	var ixtl=<%=ixt%>;
	var ixtl2=addCommas(ixtl);	
	var jilo=<%=jil%>;
	var jilo2=addCommas(jilo);
	var tngo=<%=tng%>;
	var tngo2=addCommas(tngo);
	var tolu=<%=tol%>;
	var tolu2=addCommas(tolu);
	var xona=<%=xon%>;
	var xona2=addCommas(xona);
	var teju=<%=tej%>;
	var teju2=addCommas(teju);
	var tenc=<%=tnc%>;
	var tenc2=addCommas(tenc);
	var vall=<%=val%>;
	var vall2=addCommas(vall);
	
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'PIEZAS TRANSFERIDAS'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 2
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name ;
                        }
                    }
                }
            },

            series: [{
                type: 'pie',
                name: 'Porcentaje',
                data: [
                    
                    ['JURISDICCION SANITARIA I'+'</b>: '+ ixtl2,       ixtl],
					
					
                    {
                        name: 'JURISDICCION SANITARIA II'+'</b>: '+ tngo2,
                        y: tngo,
                        sliced: true,
                        selected: true
                    },
                   
                    ['JURISDICCION SANITARIA III'+'</b>: '+ tenc2,     tenc]
                    
                ]
            }]
        });
    });
    
}); 
		</script>
	</head>
	<body>
<script src="../../js/highcharts.js"></script>
<script src="../../js/modules/exporting.js"></script>

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
			maxDate:new Date(año2, mes2 - 1, dia2),
			//beforeShowDay: unavailable // dias que no se van a visualizar
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
			maxDate:new Date(año2, mes2 - 1, dia2),
			//beforeShowDay: unavailable  // dias que no se van a visualizar
		});
	});
	</script>
<div id="container" style="min-width: 800px; height: 400px; margin: 0 auto"></div>

	</body></p><br />
          <br />
      </span></p>
    </div>    </td>
	<td width="100%">&nbsp;</td>  </tr>
  <tr>
    <td>&nbsp;</td>
  <td>
  <table border="0" cellspacing="0" cellpadding="0" width="507">
        <tr>
          <td width="507" colspan="2" align="center" class="sidebarHeader" id="sidebarHeader">&nbsp;</td>        </tr>

        <!--tr>
		<td>**Informaci&oacute;n generada y validada del per&iacute;odo del 10/Marzo/2009 al 31/Julio/2012</td>		
        </tr-->
		<tr>
  <td>&nbsp; </td>		
		</tr></table></td>
<td>&nbsp;</td>
<td>
<table border="0" cellspacing="0" cellpadding="0" width="460">
       

        <tr>
		<td width="131">&nbsp;</td>
		<td width="329" class="smallText" id="sidebar">
Visitante No.&nbsp;<%=regulaCont()%>&nbsp;

</SCRIPT>		  </td></tr></table></td></tr></table>

<map name="Map2" id="Map2"><area shape="rect" coords="4,3,31,29" href="gnr_infor2.jsp?fecha_1_vi=<%=fecha_1%>&fecha_2_vi=<%=fecha_2%>" />
</map>
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