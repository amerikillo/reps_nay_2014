<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="../../pag_man.html" session = "true"%>
<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String val="", user="", rol="";



if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
	rol=(String)sesion.getAttribute("rol");
}

//out.print(user);
if(!val.equals("valido")){
	
	%>
    <script>self.location='../index.jsp';</script>
    <%
}

%>
<%
Class.forName("org.gjt.mm.mysql.Driver");
Connection conexion=null;
String mensaje="";
/*parametros para la conexion*/
String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
String usuario = "receta_usr";
String pass = "M8KbqNjTD2";

ResultSet rset=null;
Statement stmt = null;
ResultSet rset2=null;
Statement stmt2 = null;
ResultSet rset3=null;
Statement stmt3 = null;
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
stmt3 = conexion.createStatement();
/*guardando la conexion en la session*/
} catch (Exception ex){
	mensaje=ex.toString();
}
mensaje="conectado";
if(conexion.isClosed()){
	mensaje="desconectado";
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<link rel="stylesheet" href="../css/bootstrap-responsive.css" />

<!--link rel="stylesheet" href="css/custom.css" /-->
<style type="text/css">
.neg {font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #666;
}
body {
	background-color: #FFFFFF;
}
</style>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script language="javascript" src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../jq/themes/base/jquery.ui.all.css">
</head>

<body>
<!-- Navigation Bar -->

<div class="navbar navbar-inverse">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="../index.jsp">Reportes Web Nayarit - BackOrders</a>
          <!--div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="../main_menu.jsp">Reporte de Ventas</a></li>
              <li><a href="../transferencias.jsp">Reporte de Transferencias</a></li>
              <li><a href="../existencias.jsp">Reporte de Existencias</a></li>
               <li><a href="#contact">Reporte de Censos</a></li>
            </ul>
            <p class="navbar-text pull-right">Usuario: <a href="#"><%=user%></a></p>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
<!------------->
<div class="container">
<div class="row">
	<div>
    	<a href="venta_total.jsp">Reporte de Ventas</a> &gt; Inventrario en el Cedis</div>
</div>
	<div class="row">
    	<div class="span12">
        <h2>Inventario en el Cedis</h2>
   	  </div>
      <div class="row">
    	<div class="span12">
   	      <table width="200" border="1" class="table table-bordered table-striped table-hover" >
   	        <tr>
   	          <td rowspan="2"><strong>Clave</strong></td>
   	          <td rowspan="2"><strong>Descripcion</strong></td>
   	          <td colspan="4"><strong>Total Global</strong></td>
   	          <td rowspan="2"><strong>Existencias GNKL Tepic</strong></td>
   	          <td rowspan="2"><strong>Cantidad Adicional Requerida</strong></td>
   	          <td rowspan="2"><strong>Precio</strong></td>
   	          <td rowspan="2"><strong>Importe</strong></td>
            </tr>
   	        <tr>
   	          <td><strong>Requerimento</strong></td>
   	          <td><strong>Abasto</strong></td>
   	          <td><strong>Aduedo</strong></td>
   	          <td><strong>%</strong></td>
            </tr>
            <tr>
   	          <td>&nbsp;</td>
   	          <td><strong>Totales</strong></td>
   	          <td><strong> 734,467.00 </strong></td>
   	          <td><strong> 561,453.00 </strong></td>
   	          <td><strong> 173,014.00</strong></td>
   	          <td><strong>76%</strong></td>
   	          <td><strong> 1,336,037.00 </strong></td>
   	          <td><strong> 126,577.00 </strong></td>
   	          <td colspan="2"><strong> $38,927,823.70 	</strong></td>
            </tr>
            <%
			rset = stmt.executeQuery("SELECT * from inventario_cedis");
			while(rset.next()){
			%>
   	        <tr>
   	          <td><%=rset.getString(1)%></td>
   	          <td><%=rset.getString(2)%></td>
   	          <td><%=rset.getString(3)%></td>
   	          <td><%=rset.getString(4)%></td>
   	          <td><%=rset.getString(5)%></td>
   	          <td><%=rset.getString(6)%></td>
   	          <td><%=rset.getString(7)%></td>
   	          <td><%=rset.getString(8)%></td>
   	          <td><%=rset.getString(9)%></td>
   	          <td><%=rset.getString(10)%></td>
            </tr>
            <%
			}
			%>
   	        <tr>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
   	          <td>&nbsp;</td>
            </tr>
          </table>
          <br /><br /><br />
    	</div>
      
</div>
<div class="navbar navbar-fixed-bottom">
        <div class="modal-footer">
            DERECHOS RESERVADOS GNKL/DESARROLLOS WEB &reg; 2009 - 2013
        </div>
</div>
</body>
</html>