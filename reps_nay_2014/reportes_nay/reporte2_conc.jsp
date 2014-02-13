<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../pag_man.html" %>
<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: 2_concetrado_salidas.jsp
FUNCIÓN: Reporte que muestra las salidas de insumos por Unidad previamente escogido por el Usuario, los campos que se muestran son: Clave, Descripción, Presentación, Cantidad, Precio Unitario e Importe, estos se muestras por origen 1 para la SSD y 2 para Soriana, se muestra también el Total de Medicamento, Total de Material de Curación, Insumos Desplazados y Total General.
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  IVA, ARD, RHW
ARCHIVOS JS    :  list02.js
------------------------------------------------------------------------------------------------------------------------------*/
//objeto de la Clase Connection, nos sirve para hacer la conexión a la base correspondiente
	Connection conexion=null;
	Statement stmt = null;
	ResultSet rset = null;
	String mensaje="",mensajes_try="";

   /*parametros para la conexion*/

    String driver = "org.gjt.mm.mysql.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/22_reporte_web";
    String usuario = "receta_usr";
    String clave = "";
    
	response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=REPORTE N° 5.xls");

	
  /*procedimiento de la conexion*/

    try{
         Class.forName(driver);
         conexion = DriverManager.getConnection(url);

         /*guardando la conexion en la session*/

         session.setAttribute("conexion",conexion); 
		 stmt=conexion.createStatement(); 
		 mensaje="conectado";
       } catch (Exception ex){mensaje=ex.toString();}

  if(conexion.isClosed())
        {mensaje="desconectado";}

  //por eliminar out.print(mensaje); 

//Clases para dar formato a las variables con vista numéricas
NumberFormat nf1 = NumberFormat.getInstance(Locale.US);
DecimalFormat formateador = new DecimalFormat("##,###.00");
DecimalFormat formateador2 = new DecimalFormat("##,###.000");

//Serie de objetos de las Clases Statement y ResultSet para crear queries
        Statement stmt_001 = conexion.createStatement();
		Statement stmt_002 = conexion.createStatement();
		Statement stmt_003 = conexion.createStatement();
        ResultSet rset_001=null;
		ResultSet rset_002=null;
		ResultSet rset_003=null;

%>
<%

// ----------------- Variables de entorno
int ingreso=0;
int cont=1;
String juris="";
String uni="";
String muni="";
String ran1="";
String ran2="";
String prog="";
String medi="";
String rep="",ban="",costo1="";
String ixt_cad2="",ixt_cad3="",ixt_cad3total="",ixt_cad3total2="",unitario="",unitariototal="",unitariototal2="",ixt_cad3mat="0",unitariomat="";
int ixt_uni=0,ixt_unitotal=0,ixt_unimat=0,ban_jv=0,ixt_unitotal2=0,ixt_uni2=0,ixt_uni3=0;
String ixt_cad="",ixt_cadmat="",ixt_cadtotal="",ixt_cadtotal2="";
double ixt_costo=0.0,ixt_costo2total=0.0,ixt_costo2total2=0.0,ixt_costo2=0.0,unitario1=0.0,ixt_costo2mat=0.0,unitario1mat=0.0,unitario1total=0.0,unitario1total2=0.0,costo2=0.0;
double unitario1_1=0.0;
// -----------------------------------

//variables para hacer la suma de piezas ori 1 y 2
int suma_ori1=0,suma_ori2=0,suma_totales=0;
String total_ori1="",total_ori2="";

// Variable para recibir la base de datos que se manda como parámetro
String bd_jv="";
try { 
       ban=request.getParameter("ban");//recibe la variable ban como parametro via URL
	   ban_jv=Integer.parseInt(ban);
       juris=request.getParameter("juri");
	   uni=request.getParameter("uni");//recibe la nomen de la Unidad
	   muni=request.getParameter("mpio");
	   ran1=request.getParameter("rango1");//recibe la fecha 1
	   ran2=request.getParameter("rango2");//receibe la fecha 2
  	   prog=request.getParameter("programa");//recibe el programa sp,oportunidades, etc
	   medi=request.getParameter("medico");
	   rep=request.getParameter("reporte");
	   bd_jv=request.getParameter("bd");
	//out.print("but ="+bd_jv+prog);
        
    }catch(Exception e){System.out.print("not");}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.:Concentrado de Salidas:.</title>
<style type="text/css">
<!--
.style19 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; }
.style9 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; }
.Style8 {color: #FFFFFF}
.style21 {font-family: Arial, Helvetica, sans-serif; font-size: 11px; }
.style22 {font-family: Arial, Helvetica, sans-serif; font-size: 11px; color: #FFFFFF; }
.style24 {font-size: 18px; font-family: Arial, Helvetica, sans-serif; }
.style26 {
	color: #990000;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.style27 {color: #000099; font-family: Arial, Helvetica, sans-serif; font-size: 11px; }
.style30 {color: #000099; font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold; }
.style31 {
	color: #000066;
	font-weight: bold;
}
.style32 {
	color: #003366;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<div align="center">
  <table width="802" border="0" cellpadding="2">
    <tr>
      <td><table width="787" align="center" cellpadding="0" cellspacing="0">
        <col width="155" />
        <col width="322" />
        <col width="156" />
        <col width="126" />
        <col width="112" />
        <col width="1
	" />
        <tr height="28">
          <td colspan="6" height="28"><div align="center" class="style24">
              <p>REPORTE NO. 5- SALIDAS Y CONSUMOS POR PROGRAMA DE ATENCI&Oacute;N</p>
              <p>SALIDA DE MEDICAMENTO Y MATERIAL DE CURACI&Oacute;N</p>
          </div></td>
        </tr>
        <tr height="25">
          <td colspan="6" height="25"><div class="style26">
           
          </div></td>
        </tr>
        <tr height="25">
          <td colspan="6" height="25"><div align="center" class="style19">
              <div align="left" class="style21"> DEL <span class="style27"><span class="style30"></span>&nbsp;&nbsp;<%=ran1%></span> AL <span class="style30">&nbsp;<%=ran2%></span></div>
          </div></td>
        </tr>
        <tr height="20">
          <td width="200" class="style21"><div align="left"><span class="style9"><span class="style21">NOMBRE    DE LA UNIDAD: </span></span></div></td>
          <td height="20" colspan="3"><div align="left"><span class="style30">&nbsp;&nbsp;<%=uni%> </span></div>            <div align="left"></div>            <div align="left"></div></td>
          <td width="8" height="20"><div align="left"></div></td>
          <td width="68" height="20"><div align="left"></div></td>
        </tr>
        <tr class="style21" height="20">
          <td height="20" class="style21"><div align="left">PROGRAMA: </div></td>
          <td width="284" height="20" class="style30"><div align="left"><%=prog%></div></td>
          <td width="125"><div align="left" class="style27"></div></td>
          <td width="100"><div align="left"></div></td>
          <td width="8"><div align="left"></div></td>
          <td width="68"><div align="left"></div></td>
        </tr>
        <tr height="20">
          <td height="20"></td>
          <td class="style30">&nbsp;
          <td></td>
          <td width="100"></td>
          <td width="8"></td>
          <td width="68"></td>
        </tr>
      </table>
        <table width="788" height="173" border="1" align="center" cellpadding="0" cellspacing="0">
          <col width="155" />
          <col width="322" />
          <col width="156" />
          <col width="126" />
          <col width="112" />
          <col width="7" />
<%

				

//------------------ si la bandera mandada como parámtero es 4
if(ban_jv ==  4)
{
if(prog.equals("Todos"))
{
//out.print("ingresa a todos 11");
rset_003=stmt_003.executeQuery("select clave,descri,present,sum(uni),costo_u,sum(costo),sum(costo_u) from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"'  group by uni_ate order by (clave+0)");
out.print("hello world");
}else{
//out.print("ingresa else a todos 11");
rset_003=stmt_003.executeQuery("select clave,descri,present,sum(uni),costo_u,sum(costo),sum(costo_u) from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"' and afiliado='"+prog+"' group by uni_ate order by (clave+0)");

}


while (rset_003.next()) 
                  {
			  ixt_cadtotal2=rset_003.getString("sum(uni)");
			  ixt_unitotal2 = Integer.parseInt(ixt_cadtotal2);
			  
			ixt_cad3total2=rset_003.getString("sum(costo)");
			ixt_costo2total2= Double.parseDouble(ixt_cad3total2);
			
			unitariototal2=rset_003.getString("sum(costo_u)");
		   unitario1total2= Double.parseDouble(unitariototal2);
			
				  }

}
// --------------------------------------------------------------

// ------------------------- Si la bandera es 3
if(ban_jv ==  3)
   {
     // Si el parámetro es Todos los programas y el insumo es Medicamento
     if(prog.equals("Todos")){
        rset_001=stmt_001.executeQuery("select clave,descri,present,sum(uni),costo_u,sum(costo) from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"' and partida='1' group by clave order by (clave+0)");
		out.print("hello world");
       rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MEDICAMENTO'  and fecha between '"+ran1+"' and '"+ran2+"' and partida='1' group by uni_ate");
}else{
//si no, se escogió alguno de los otros dos programas lo tiene la variable dura de java prog 
rset_001=stmt_001.executeQuery("select clave,descri,present,sum(uni),costo_u,sum(costo) from "+bd_jv+" where afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='1' group by clave order by (clave+0)");
		
       rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MEDICAMENTO' and afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='1' group by uni_ate");
}		
		  // si rset_002 tiene datos hace los acumuladores
		  while (rset_002.next()) 
                  {
				  out.print("hello world sumas");
					  ixt_cad=rset_002.getString("sum(uni)");
			          ixt_uni = Integer.parseInt(ixt_cad);
			     	  ixt_cad3=rset_002.getString("sum(costo)");
					  ixt_costo2= Double.parseDouble(ixt_cad3);
					  unitario=rset_002.getString("sum(costo_u)");
					  unitario1= Double.parseDouble(unitario);
					  unitario1_1=unitario1_1+unitario1;
				  }
// Si el parámetro es Todos los programas y el insumo es Material de Curación
	if(prog.equals("Todos")){	
 	rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MATERIAL DE CURACION'  and fecha between '"+ran1+"' and '"+ran2+"' and partida='1' group by uni_ate");
}else{
//out.print("ingresa a else todos 2");  
	rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MATERIAL DE CURACION' and afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='1' group by uni_ate");
	}		
		  // si rset_002 tiene datos hace los acumuladores
		  while (rset_002.next()) 
                  {
						ixt_cadmat=rset_002.getString("sum(uni)");
					  	ixt_unimat = Integer.parseInt(ixt_cadmat);
					  	ixt_cad3mat=rset_002.getString("sum(costo)");
						ixt_costo2mat= Double.parseDouble(ixt_cad3mat);
						unitariomat=rset_002.getString("sum(costo_u)");
				   		unitario1mat= Double.parseDouble(unitariomat);
				  }	
}// fin del if


%>

		  <tr height="20">
            <td height="30" colspan="6" background="fndo3.jpg" class="style22"><div align="center" class="style21"><a name="ir_ssd_arr" id="ir_ssd_arr"></a>ORIGEN &quot;SSN&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#ir_ssd_ab">Ver totales</a> </div>              
              <div align="center"></div>              <div align="center"></div>              <div align="center"></div>              <div align="center"></div>              <div align="center"></div></td>
          </tr>
<tr height="20">
            <td height="30" background="fndo3.jpg" class="style22"><div align="center" class="style21">CLAVE DE CUADRO B&Aacute;SICO</div></td>
            <td width="231" background="fndo3.jpg" class="style22"><div align="center">DESCRIPCI&Oacute;N</div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">PRESENTACI&Oacute;N</div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">CANTIDAD</div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">PRECIO UNITARIO (TRES D&Iacute;GITOS) </div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">IMPORTE</div></td>
          </tr>
          <%
		  // si rset_001 tiene datos hace los acumuladores muestra los datos en la tabla HTML
		  while (rset_001.next()) 
                  { 
					ingreso=1;
				   	ixt_cad2=rset_001.getString("sum(costo)");
					ixt_costo= Double.parseDouble(ixt_cad2);
					costo1=rset_001.getString("costo_u");
					costo2=Double.parseDouble(costo1);
		  %>
            <td height="20" width="166"><span class="style21"><%=rset_001.getString("clave")%></span></td>
            <td><span class="style21"><%=rset_001.getString("descri")%></span></td>
            <td width="86"><span class="style21"><%=rset_001.getString("present")%></span></td>
            <td width="68"><span class="style21"><%=rset_001.getString("sum(uni)")%></span></td>
            <td width="115"><div align="right"><span class="style21">$0.000</span></div></td>
            <td width="107"><div align="right"><span class="style21">$0.00</span></div></td>
          </tr>
          <%
				 }//fin del while
		  %>
           
          <tr height="20">
            <td rowspan="4"><div align="center"></div></td>
            <td background="fndo3.jpg" bgcolor="#1C3466" class="style21"><div align="left"><span class="Style8"><span class="style21"><span class="style21">TOTAL DE    MEDICAMENTO</span></span></span></div></td>
            <td height="28">&nbsp;</td>
            <td height="28" align="right"><span class="style21"><span class="style31"><a name="ir_ssd_ab" id="ir_ssd_ab"></a></span><%=nf1.format(ixt_uni)%></span></td>
            <td height="28" align="right">&nbsp;</td>
            <td height="28" align="right"><span class="style21">$0.00</span></td>
          </tr>
          <tr height="20">
            <td background="fndo3.jpg" bgcolor="#1C3466" class="style21"><div align="left"><span class="Style8"><span class="style21"><span class="style21">TOTAL DE    MATERIAL DEL CURACION </span></span></span></div></td>
            <td height="29">&nbsp;</td>
            <td height="29" align="right"><span class="style21"><%=nf1.format(ixt_unimat)%></span></td>
            <td height="29" align="right">&nbsp;</td>
            <td height="29" align="right"><span class="style21">$0.00</span></td>
          </tr>
          <tr height="20">
            <td background="fndo3.jpg" bgcolor="#1C3466" class="style21"><div align="left"><span class="Style8"><span class="style21">TOTAL OTROS (INSUMOS SOLO DESPLAZADOS) </span></span></div></td>
            <td height="28">&nbsp;</td>
            <td height="28" align="right"><span class="style21">0</span></td>
            <td height="28" align="right">&nbsp;</td>
            <td height="28" align="right"><span class="style21">$0.00</span></td>
          </tr>
            <%ixt_uni2=ixt_uni+ixt_unimat;// para tomar el total de Material de Curación%>
          <tr height="20">
            <td height="26" background="fndo3.jpg"><div align="center" class="style22">
              <div align="left" class="style21">TOTAL GENERAL: </div>
            </div></td>
            <td height="26">&nbsp;</td>
            <td height="26" align="right"><span class="style21"><%=nf1.format(ixt_uni2)%></span></td>
            <td height="26" align="right">&nbsp;</td>
            <td height="26" align="right"><span class="style21">$0.00</span></td>
          </tr>
		  <tr height="20">
            <td height="30" colspan="6" class="style22"><div align="center" class="style31"><a href="#ir_ssd_arr">Ir arriba SSN</a></div>              
              <div align="center"></div>              <div align="center"></div>              <div align="center"></div>              <div align="center"></div></td>
          </tr>
		  <tr height="20">
            <td height="30" colspan="6" background="fndo3.jpg" class="style22"><div align="center" class="style21"><a name="ir_arr_sor" id="ir_arr_sor"></a>ORIGEN &quot;SAVI&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#ir_aba_sor">Ver Totales</a> </div>              
           </td>
          </tr>
<%
 //Bandera que se manda como parámetro desde menu_dgo_24.jsp, su valor es 3
if(ban_jv ==  3)
  {//inicio de if ban_jv
  // si se escogió Todos los programas, el valor lo tiene la variable prog
     if(prog.equals("Todos")){
             rset_001=stmt_001.executeQuery("select clave,descri,present,sum(uni),costo_u,sum(costo) from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by clave order by (clave+0)");
		
       rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MEDICAMENTO'  and fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by uni_ate");
}else{
	   rset_001=stmt_001.executeQuery("select clave,descri,present,sum(uni),costo_u,sum(costo) from "+bd_jv+" where afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by clave order by (clave+0)");
		
       rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MEDICAMENTO' and afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by uni_ate");
}		
    //mientras haya valores que apunte rset_002
		  while (rset_002.next()) 
                  {
					ixt_cad=rset_002.getString("sum(uni)");
					ixt_uni3 = Integer.parseInt(ixt_cad);
					ixt_cad3=rset_002.getString("sum(costo)");
					ixt_costo2= Double.parseDouble(ixt_cad3);
					unitario=rset_002.getString("sum(costo_u)");
				   	unitario1= Double.parseDouble(unitario);
			
				  }
if(prog.equals("Todos"))
   {//inicio del if	 
	rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MATERIAL DE CURACION'  and fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by uni_ate");
}else{
//out.print("ingresa a else todos MC 2");
	rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where id_med='MATERIAL DE CURACION' and afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by uni_ate");
	}		
		  while (rset_002.next()) 
                  {
					ixt_cadmat=rset_002.getString("sum(uni)");
					ixt_unimat = Integer.parseInt(ixt_cadmat);
					ixt_cad3mat=rset_002.getString("sum(costo)");
					ixt_costo2mat= Double.parseDouble(ixt_cad3mat);
					unitariomat=rset_002.getString("sum(costo_u)");
				   	unitario1mat= Double.parseDouble(unitariomat);
				  }	
				 
if(prog.equals("Todos")){ 
	rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by uni_ate");
		}else{
	rset_002=stmt_002.executeQuery("select sum(uni),sum(costo),sum(costo_u) from "+bd_jv+" where afiliado='"+prog+"' and fecha between '"+ran1+"' and '"+ran2+"' and partida='2' group by uni_ate");
}
		  while (rset_002.next()) 
                  {
					ixt_cadtotal=rset_002.getString("sum(uni)");
					ixt_unitotal = Integer.parseInt(ixt_cadtotal);
					ixt_cad3total=rset_002.getString("sum(costo)");
					ixt_costo2total= Double.parseDouble(ixt_cad3total);
					unitariototal=rset_002.getString("sum(costo_u)");
				   	unitario1total= Double.parseDouble(unitariototal);
				  }		  
               
}// fin del if
%>
<tr height="20">
            <td height="30" background="fndo3.jpg" class="style22"><div align="center" class="style21">CLAVE DE CUADRO B&Aacute;SICO</div></td>
            <td width="231" background="fndo3.jpg" class="style22"><div align="center">DESCRIPCI&Oacute;N</div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">PRESENTACI&Oacute;N</div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">CANTIDAD</div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">PRECIO UNITARIO (TRES D&Iacute;GITOS) </div></td>
            <td background="fndo3.jpg" class="style22"><div align="center">IMPORTE</div></td>
          </tr>
          <%
		  // mientras haya datos se muestran los datos en la tabla HTML
		  while (rset_001.next()) 
                  { // inicio del while
					ixt_cad2=rset_001.getString("sum(costo)");
					ixt_costo= Double.parseDouble(ixt_cad2);
					costo1=rset_001.getString("costo_u");
					costo2=Double.parseDouble(costo1);
					unitario1_1 +=costo2;
		  %>
            <td height="20" width="166"><span class="style21"><%=rset_001.getString("clave")%></span></td>
            <td><span class="style21"><%=rset_001.getString("descri")%></span></td>
            <td width="86"><span class="style21"><%=rset_001.getString("present")%></span></td>
            <td width="68"><span class="style21"><%=rset_001.getString("sum(uni)")%></span></td>
            <td width="115"><div align="right"><span class="style21">$<%=formateador2.format(costo2)%></span></div></td>
            <td width="107"><div align="right"><span class="style21">$<%=formateador.format(ixt_costo)%></span></div></td>
          </tr>
          <% }// fin del while%>
           
          <tr height="20">
            <td rowspan="4"><div align="center"></div></td>
            <td background="fndo3.jpg" bgcolor="#1C3466" class="style21"><div align="left"><span class="Style8"><span class="style21"><span class="style21">TOTAL DE    MEDICAMENTO</span></span></span></div></td>
            <td height="28">&nbsp;</td>
            <td height="28" align="right"><span class="style21"><a name="ir_aba_sor" id="ir_aba_sor"></a><%=nf1.format(ixt_uni3)%></span></td>
            <td height="28" align="right"><span class="style21">
             &nbsp; <%//=formateador.format(unitario1_1)%>
            </span></td>
            <td height="28" align="right"><span class="style21">$<%=formateador.format(ixt_costo2)%></span></td>
          </tr>
          <tr height="20">
            <td background="fndo3.jpg" bgcolor="#1C3466" class="style21"><div align="left"><span class="Style8"><span class="style21"><span class="style21">TOTAL DE    MATERIAL DEL CURACION </span></span></span></div></td>
            <td height="29">&nbsp;</td>
            <td height="29" align="right"><span class="style21"><%=nf1.format(ixt_unimat)%></span></td>
            <td height="29" align="right">&nbsp;<span class="style21"><%//=nf1.format(unitario1mat)%></span></td>
            <td height="29" align="right"><span class="style21">$<%=formateador.format(ixt_costo2mat)%></span></td>
          </tr>
          <tr height="20">
            <td background="fndo3.jpg" bgcolor="#1C3466" class="style21"><div align="left"><span class="Style8"><span class="style21">TOTAL OTROS (INSUMOS SOLO DESPLAZADOS) </span></span></div></td>
            <td height="28">&nbsp;</td>
            <td height="28" align="right"><span class="style21">0</span></td>
            <td height="28" align="right">&nbsp;</td>
            <td height="28" align="right"><span class="style21">$0.00</span></td>
          </tr>

          <tr height="20">
            <td height="26" background="fndo3.jpg"><div align="center" class="style22">
              <div align="left" class="style21">TOTAL GENERAL: </div>
            </div></td>
            <td height="26">&nbsp;</td>
            <td height="26" align="right"><span class="style21"><%=nf1.format(ixt_unitotal)%></span></td>
            <td height="26" align="right">&nbsp;<span class="style21"><%//=formateador.format(unitario1_1)%></span></td>
            <td height="26" align="right"><span class="style21">$<%=formateador.format(ixt_costo2total)%></span></td>
          </tr>
		  <tr height="20">
            <td height="30" colspan="6" class="style22"><div align="center" class="style32"><a href="#ir_arr_sor" accesskey="m">Ir arriba SAVI</a></div>              
          </td>
          </tr>
		  <tr height="20">
            <td height="30" background="fndo3.jpg" class="style22">
            <td height="30" background="fndo3.jpg" ><div align="center" class="style21">TOTAL DE PIEZAS (SSN+SAVI) </div></td>
            <td height="30" background="fndo3.jpg" >&nbsp;</td>
			<%suma_totales=ixt_uni2+ixt_unitotal;// suma los totales%>
            <td height="30" background="fndo3.jpg" ><%=nf1.format(suma_totales)%></td>
            <td height="30" background="fndo3.jpg" ><%//=formateador.format(unitario1_1)%></td>
            <td height="30" background="fndo3.jpg" >$<%=formateador.format(ixt_costo2total)%></td>
		  </tr>
        </table>
      <p>&nbsp;</p></td>
    </tr>
  </table>
    <%
	// Rutina para saber si no hubo coincidencia con la Unidad que el Usuario escogió
			   if(ingreso==0)
			    { // inicio if 1
				   if(prog.equals("PA"))
				   { //incio if 2
			%>
			<script>
			   alert("NO HUBO COINCIDENCIAS EN LA CONSULTA PARA POBLACIÓN ABIERTA\n\n DE CLIC EN REGRESAR A MENÚ PARA REALIZAR OTRA CONSULTA");
			</script>
			 <%
			 }//fin if 2
			   else
			      if(prog.equals("OP"))
				  {
			%>
          <script>
			   alert("NO HUBO COINCIDENCIAS EN LA CONSULTA PARA OPORTUNIDADES\n\n DE CLIC EN REGRESAR A MENÚ PARA REALIZAR OTRA CONSULTA");
			</script>
			 <%
			 }
			 else
			   if(prog.equals("PA") || prog.equals("OP") || prog.equals("Todos") || prog.equals("SP"))
			   {
			   %>
			   <script>
			       alert("UNIDAD EN PROCESO DE VALIDACIÓN DE PIEZAS\n\n DE CLIC EN REGRESAR A MENÚ PARA REALIZAR OTRA CONSULTA");
			   </script>
			<%
			  }
			   
		} // fin de rutina que checa si no hubo coincidencias
		
		// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conexion.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conexion!=null){
                   conexion.close();
		                if(conexion.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			 //out.print(mensaje);
		// ---- fin de la conexión	 	  
	%>		  

</div>
<h5 align="center">&nbsp;
  DERECHOS RESERVADOS GNKL/DESARROLLOS WEB©2013, PARA USO EXCLUSIVO DE SAVI/SSN<br />
  VERSION 1.2 </h5>
<p align="center"><br /></p>
&nbsp;
</body>
</html>
