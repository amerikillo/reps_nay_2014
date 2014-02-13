*<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" session="true"%>
<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String val="", user="";


	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition","attachment; filename=inventario"+request.getParameter("uni")+".xls");

if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!val.equals("valido")){
	
	%>
    <script>self.location='../index.jsp';</script>
    <%
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: inven.jsp
FUNCIÓN: Muestra los inventarios según la unidad que se haya escogido- nayarit 2013
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  RHW
------------------------------------------------------------------------------------------------------------------------------*/
// Conexión a la BDD ------------------------------------
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn=null;
	conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
	Statement stmt = conn.createStatement();
	ResultSet rset = null;
	ResultSet rset_date =null;
// ------------------------------------------------------
// Variables de entorno ---------------------------------
	NumberFormat nf1 = NumberFormat.getInstance(Locale.US);				  
	String juri_jv="";
	String ran1_jv="";
	String ran2_jv="";
	String ban_jv="";
	String ran1="";
	String ran2="";
	String mpio_jv="";
	String valor_jv="",piezas="",min="",max="";
	String uni_jv="",mes_jv="",name_jv="", fecha="", mensaje="",cadu="", fecha1="", hora="";
	
	int piezas2=0,piezas3=0,min2=0,min3=0,max2=0,max3=0;
	int suma_cant=0;
	int suma_min=0;
	int suma_max=0;	
// ------------------------------------------------------
// try para obtener los datos como parámtros ------------
try { 
       uni_jv=request.getParameter("uni");
	   fecha1=request.getParameter("fecha");
	   
    }catch(Exception e){System.out.print("not");}

// fin bloque try ---------------------------------------
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTARIOS ::</title>

</head>

<body>
<div align="center">
  <table width="837" cellpadding="0" cellspacing="0">
    <col width="137" />
    <col width="80" span="2" />
    <col width="107" />
    <col width="101" />
    <col width="120" />
    <col width="80" span="2" />
    <tr height="20">
      <td height="20" colspan="2"><div align="center" class="style5"><a name="arriba" id="arriba"></a>INVENTARIO POR    UNIDAD FARMACIA ACTUALES</div></td>
    </tr>
    <tr height="20">
      <td height="20" colspan="2"><div align="center" class="style5">PROYECTO RECETA ELECTRONICA NAYARIT</div></td>
    </tr>
    <tr height="20">
      <td height="20" colspan="2"><div align="left"></div></td>
    </tr>
    <%
	rset=stmt.executeQuery("SELECT p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, sum(i.cant) from unidades u, inventario i, detalle_productos dp, productos p where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro AND p.cla_pro = dp.cla_pro AND u.cla_uni = '"+uni_jv+"'   group by u.cla_uni, p.cla_pro, dp.lot_pro, dp.cad_pro ;");
	%>
    <tr height="20">
      <td width="568" height="20" class="style2"><p><span class="negritas">Unidad Seleccionada:</span>&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp; <%=uni_jv%></strong></p>
      <p>&nbsp;</p></td>
      <td width="267" height="20" align="right" class="style2">&nbsp;</td>
    </tr>
    <tr height="20">
      <td height="20" colspan="2" class="style2"><!--a href="#abajo">Ir a Totales</a--> </td>
    </tr>
  </table>
  <table width="840" height="56" border="1" cellpadding="0" cellspacing="0">
    <col width="137" />
    <col width="80" span="2" />
    <col width="107" />
    <col width="101" />
    <col width="120" />
    <col width="80" span="2" />
    
    <tr height="20">
	  <td class="style2">
      <%
rset=stmt.executeQuery("SELECT p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, sum(i.cant) as cant from unidades u, inventario i, detalle_productos dp, productos p where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro AND p.cla_pro = dp.cla_pro AND u.des_uni = '"+uni_jv+"' and cant!=0   group by u.cla_uni, p.cla_pro, dp.lot_pro, dp.cad_pro ;");
	
%>
<table width="97%" border="0" cellpadding="0" cellspacing="0" id="dataTable">
  <thead>
  <tr>
      <th colspan="5" class="FECHA" ><hr /></th>
      </tr>
    <tr>
      <th width="7%" class="FECHA" >CLAVE</th>
      <th width="51%" class="FECHA">DESCRIPCI&Oacute;N</th>
      <th width="14%" class="FECHA">LOTE</th>
      <th width="16%" class="FECHA">CADUCIDAD</th>
      <th width="12%" class="FECHA">EXISTENCIAS</th>
    </tr>
    <tr>
      <th colspan="5" class="FECHA" ><hr /></th>
      </tr>
  </thead>
  <tbody>
    <!--Loop start, you could use a repeat region here-->
  <%
  while (rset.next()) 
         { 
		    Connection conn_cadu=null;
			conn_cadu = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
	        Statement stmt_cadu = conn_cadu.createStatement();
			  suma_cant+=(suma_cant=Integer.parseInt(rset.getString("cant")));
			  %>
   <tr height="20">
      <td class="negritas" align="center"><%=rset.getString("cla_pro")%></td>
      <td class="negritas" ><%=rset.getString("des_pro")%></td>
      <td class="negritas" align="center"><%=rset.getString("lot_pro")%></td>
      <td class="negritas" align="center"><%=rset.getString("cad_pro")%></td>
      <td colspan="3" align="center" class="negritas"><%=rset.getString("cant")%></td>
    </tr>
	<%conn_cadu.close();
	} // fin de while
	
%>
    <!--Loop end-->
  </tbody>
</table>
      
      
      </td>
    </tr>
  </table>
</div>
<h5 align="center">TOTAL DE PIEZAS EN EL INVENTARIO:<span class="style5"> <%=nf1.format(suma_cant)%></span></h5>
<h6 align="center" class="gray"><strong>DERECHOS RESERVADOS GNKL/DESARROLLOS WEB ® 2009 - 2014</strong></h6>


  
<%
	// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conn.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conn!=null){
                   conn.close();
		                if(conn.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			//out.print(mensaje);
		// ---- fin de la conexión	 	  

%>
</table>
</body>
</body>
</html>
