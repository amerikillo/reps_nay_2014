<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="../pag_man.html" session="true"%>
<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String val="", user="";



if (sesion.getAttribute("valida")!=null){
	val=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!val.equals("valido")){
	
	%>
<script>self.location='../reportes_nay/index.jsp';</script>
<%
}
%>
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
   // add 1 to month because Calendar's months start at 0, not 1
   int month = currDate.get(currDate.MONTH)+1;
   int day = currDate.get(currDate.DAY_OF_MONTH);
   int year = currDate.get(currDate.YEAR);
   Calendar calendario = new GregorianCalendar();
   //day-=1;
   int hora, minutos, segundos;
		
		hora =calendario.get(Calendar.HOUR_OF_DAY);
		minutos = calendario.get(Calendar.MINUTE);
		segundos = calendario.get(Calendar.SECOND);
   String date=""; 
   String res=""; 
   String mensaje="",hecho="";
   int tam_cen=0,tam_pic=0,tam_inv=0;
 if(month >=1 && month <= 9)  
 {
 res ="0"+month;
// month=Integer.parseInt(res);
   date=" "+day;
   date= date+"/"+res;
   date= date+"/"+year;  

 //out.print(""+res); 
 }
 else 
{
      date=" "+day;
      date= date+"/"+month;
      date= date+"/"+year;  
	  res+=month;
}
// Conexión a la BDD
		Class.forName("org.gjt.mm.mysql.Driver");
 		Connection conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
        Statement stmt = conn.createStatement();
		ResultSet rset = null; 
		Statement stmt_date = conn.createStatement();
		ResultSet rset_date = null;
// -----------------   
// Variables de Entorno
String reporte_jv="",but="r";
// -------------------- 
// try en donde se obtiene el nombre del botón por medio del atributo value	 
try{
	if(request.getParameter("submit").equals("Descargar BackOrder") && request.getParameter("pass").equals("852471")){
		response.sendRedirect("../Total Global 30 de Enero 2014.xlsx");
	}
} catch(Exception e){
}
   try { 
        but=""+request.getParameter("Submit");
       }catch(Exception e){System.out.print("not");}
// Se obtiene la selección por el Usuario	
  if(but.equals("Generar Reporte"))
   {//inicio if pricipal para el menú de opciones

     //Toma el valor del control de selección
     reporte_jv= request.getParameter("slct_reporte");
  
     // Serie de if´s dependiendo de la opción seleccionada se va a su respectivo if
     if (reporte_jv.equals ("1")){ 
           response.sendRedirect("menu_inven.jsp");
           }
	 if (reporte_jv.equals ("5")){
		 //sesion.setAttribute("usuario", user);
		 response.sendRedirect("../nayarit_web/index_rr.jsp");
		 
           }
	 if (reporte_jv.equals ("3")){
		 response.sendRedirect("menu_nay_2021.jsp?rep="+reporte_jv+"&nom=3- MOVIMIENTOS MINIMOS,NULOS Y CADUCOS&bot=1");
           }
	  if (reporte_jv.equals ("4")){
		 response.sendRedirect("menu_dgo_569.jsp?rep="+reporte_jv+"&nom=REPORTE DETALLADO POR BENEFICIARIO");
           }
	  if (reporte_jv.equals ("2")){
		 response.sendRedirect("menu_dgo_24.jsp?rep="+reporte_jv+"&nom=5- SALIDAS Y CONSUMOS POR PROGRAMA DE ATENCI&Oacute;N");
           }	   
      if (reporte_jv.equals ("6")){
		  response.sendRedirect("../nayarit_web/nayarit/receta/receta_elec.jsp");
           }
		    if (reporte_jv.equals ("7")){
				reporte_jv="16";
		 response.sendRedirect("menu_dgo_16.jsp?rep="+reporte_jv+"&nom=7- CONTROL DE ANTIBIOTICOS");
           }
		   if (reporte_jv.equals ("8")){
				reporte_jv="16";
		 response.sendRedirect("san.html");
           }
		   if (reporte_jv.equals ("9")){
				reporte_jv="16";
		 response.sendRedirect("trans.html");
           }
		   if (reporte_jv.equals ("10")){
				reporte_jv="-";
		 response.sendRedirect("../censos/menu_inven.jsp");
           }
		    if (reporte_jv.equals ("11")){
				reporte_jv="-";
		 response.sendRedirect("../rep_sem_nay/rec_sur.jsp");
           
		    }
		    if (reporte_jv.equals ("12")){
				reporte_jv="-";
		 response.sendRedirect("../censos/menu_inven_f.jsp");
           }
		   if (reporte_jv.equals ("13")){
				reporte_jv="-";
		 response.sendRedirect("../rep_sem_nay/ranking.jsp");
           }
		   if (reporte_jv.equals ("14")){
				reporte_jv="-";
		 response.sendRedirect("../Total Global 23 Diciembre 2013.xlsx");
           }
		    if (reporte_jv.equals ("15")){
				reporte_jv="-";
		 response.sendRedirect("http://166.78.128.202:8080/cen_nayarit/index_main.jsp");
           }
   }// fin if principal
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>:: REPORTES WEB ::</title>
<script language="javascript" src="../js/code_js.js"></script>
<script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
<link rel="stylesheet" href="../css/ver1.css" type="text/css" />
<style type="text/css">
.neg {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #666;
}
.der {
	text-align: center;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
}
.center1 {
	text-align: center;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
}
.colorin {
	color: #900;
}
</style>
</head>

<body onLoad="show5()">
<form name="form" id="form" method="post" action="index_main.jsp">
  <table width="566" height="218" border="1" align="center">
    <tr>
      <td><table width="550" border="0">
          <tr>
            <td colspan="3" align="center"><img src="../imagen/ima_main.jpg" /></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><img src="../imagen/reportes.png" height="56"  /></td>
          </tr>
          <tr>
            <td colspan="3" class="der">Fecha:&nbsp;<%=date%>&nbsp;&nbsp;&nbsp;&nbsp;Hora:<span id="liveclock"></span></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="ver">ADMINISTRACI&Oacute;N Y <br />
              CONTROL DE INVENTARIOS<br /></td>
            <td rowspan="2" colspan="2"><a href="http://166.78.128.202:8080/cen_nayarit/index_main.jsp" target="_blank"><img src="../imagen/censos.png" width="93" height="45" /></a></td>
          </tr>
          <tr>
            <td width="405" align="center" ><select name="slct_reporte" class="ver3">
                <option selected="selected">-- Seleccione Reporte --</option>
                <!--option value="1">INVENTARIOS POR UNIDAD</option-->
                <option value="5">TRANSFERENCIAS Y DISPENSACI&Oacute;N</option>
                <option value="10">INVENTARIOS DE UNIDADES DE PRIMER NIVEL</option>
                <option value="12">INVENTARIOS DE UNIDADES FARMACIAS</option>
                <option value="11">REPORTE DE NIVEL DE SERVICIO</option>
                <option value="13">RANKING DE CLAVES</option>
                <option value="15">CENSOS NAYARIT</option>
                <!--option value="14">DESCARGAR BACKORDERS</option>
                <!--option value="3">3) REPORTE DE CADUCOS</option--> 
                <!--option value="4">REPORTE DE BENEFICIARIOS POR UNIDAD</option--> 
                <!--option value="2">SALIDAS Y CONSUMOS POR PROGRAMA DE ATENCI&Oacute;N</option>
				<option value="6">REPORTES ESTAD&Iacute;STICOS</option>
				<option value="7">REPORTE ANTIBI&Oacute;TICOS Y CONTROLADOS</option>
				<!--option value="8">8) REPORTE DE REGISTROS SANITARIOS</option>
				<option value="9">9) TRANSFERENCIAS ENTRE FARMACIAS</option-->
                
              </select></td>
          </tr>
          <tr>
            <td align="center"><input name="Submit" type="submit" class="boton" value="Generar Reporte" /></td>
            <td width="111" align="center">&nbsp;</td>
            <td width="20">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
<form method="post">
          <tr>
            <td colspan="3" align="center">Contrase&ntilde;a: 
            	  <input name="pass" type="password" size="6" maxlength="6" />
                <input type="submit" name="submit" value="Descargar BackOrder" />
            </td>
  </tr>
</form>
          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3" align="center"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="166" height="133" id="FlashID" title="Proyecto Nayarit">
                <param name="movie" value="../imagen/flash_nayarit_varios.swf" />
                <param name="quality" value="high" />
                <param name="wmode" value="opaque" />
                <param name="swfversion" value="11.0.0.0" />
                <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
                <param name="expressinstall" value="Scripts/expressInstall.swf" />
                <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. --> 
                <!--[if !IE]>-->
                <object type="application/x-shockwave-flash" data="../imagen/flash_nayarit_varios.swf" width="166" height="133">
                  <!--<![endif]-->
                  <param name="quality" value="high" />
                  <param name="wmode" value="opaque" />
                  <param name="swfversion" value="11.0.0.0" />
                  <param name="expressinstall" value="Scripts/expressInstall.swf" />
                  <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
                  <div>
                    <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
                    <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
                  </div>
                  <!--[if !IE]>-->
                </object>
                <!--<![endif]-->
              </object></td>
          </tr>
          <tr>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3" align="center"><a href="index.jsp">SALIR</a></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><strong class="neg">DERECHOS RESERVADOS GNKL/DESARROLLOS PARA USO EXCLUSIVO DE SAVI/SSN WEB &reg; 2009 - 2014</strong></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
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
<script type="text/javascript">
swfobject.registerObject("FlashID");
</script>
</body>
</html>
