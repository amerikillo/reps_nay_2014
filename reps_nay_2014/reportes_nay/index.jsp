<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" session="true" %>

<%
HttpSession sesion= request.getSession();
//out.print("Id de sesion: "+sesion.getId());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
//objeto de la Clase Connection, nos sirve para hacer la conexión a la base correspondiente
	Connection conexion=null;
	Statement stmt = null;
	ResultSet rset = null;

// Variables de entorno
	 String mensaje="",mensajes_try="";
	 String but="r";
	 String usu_jv="";
	 String pass_jv="";
	 int correct1=0;
	 String contra_jv="";
	 int contra2=0;
	
// fin variables ------------------------------------------

 /*parametros para la conexion*/
    String driver = "org.gjt.mm.mysql.Driver";
    String url = "jdbc:mysql://162.209.67.250/receta_electronica";
    String usuario = "receta_usr";
    String clave = "M8KbqNjTD2";
    
  /*procedimiento de la conexion*/
    try{
         Class.forName(driver);
         conexion = DriverManager.getConnection(url,usuario,clave);

         /*guardando la conexion en la session*/

         session.setAttribute("conexion",conexion); 
		 stmt=conexion.createStatement(); 
		 mensaje="conectado";
       } catch (Exception ex){mensaje=ex.toString();}

  if(conexion.isClosed())
        {mensaje="desconectado";}
		
// Rutina para obtener la fecha -------------------------------------------

   java.util.Calendar currDate = new java.util.GregorianCalendar();
   // add 1 to month because Calendar's months start at 0, not 1
   int month = currDate.get(currDate.MONTH)+1;
   int day = currDate.get(currDate.DAY_OF_MONTH);
   int year = currDate.get(currDate.YEAR);
   String date="",date2=""; 
   String res=""; 
 
 if(month >=1 && month <= 9)  
 {
 res ="0"+month;
// month=Integer.parseInt(res);
   date=" "+day;
   date= date+"/"+res;
   date= date+"/"+year;  
   date2=year+"/"+res+"/"+day;
 //out.print(""+res); 
 }
 else 
{
      date=" "+day;
      date= date+"/"+month;
      date= date+"/"+year;  
	  res+=month;
}
// Proceso para convertir fecha a formato MySQL ------------------------------

//out.print(""+date);
 rset = stmt.executeQuery("SELECT STR_TO_DATE('"+date+"', '%d/%m/%Y')"); 
              if(rset.next())
                    date= rset.getString("STR_TO_DATE('"+date+"', '%d/%m/%Y')");
//out.print(""+date);	fin proceso ---------------------------------------------				

// fin fecha --------------------------------------------------------------------	

//se obtiene el value de button, según sea el caso del botón oprimido
try { 
        but=""+request.getParameter("Submit");
    }catch(Exception e){System.out.print("not");}
// ------------------------------------------------------------------

// para el botón Validar Usuario
if(but.equals("Validar Usuario"))
  { // inicio de if but
    //out.print("Ingreso a Validar Usuario");
	usu_jv=request.getParameter("txtf_user");
	pass_jv=request.getParameter("txtf_pass");
	correct1=0;
	
    rset=stmt.executeQuery("select usuario,count(contra) from contra_usu_nay where usuario='"+usu_jv+"' and contra='"+pass_jv+"' group by usuario");
	 
	 while(rset.next())
				     { //inicio while rset1
                  		contra_jv=  rset.getString("count(contra)");
				  		contra2=Integer.parseInt(contra_jv);
					 } //fin while rset1
	if((contra2 == 1))
	  { // inicio de contra2
	  sesion.setAttribute("valida", "valido");
	  sesion.setAttribute("usuario", usu_jv);
%>
		<script>
			alert("DATOS CORRECTOS");
			self.location='index_main.jsp';
		</script>
<% 
        stmt.execute("insert into repor_nay values ('"+usu_jv+"','"+pass_jv+"','1','"+date+"',0)");
		} // fin de contra2
		 else{ // inicio else
%>
		<script>			
			alert("DATOS INCORRECTOS");	
		</script>
<%
		stmt.execute("insert into repor_nay values ('"+usu_jv+"','"+pass_jv+"','"+correct1+"','"+date+"',0)");		
	  }// fin else
 } // fin if but

//-------------------------------------------------

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<title>:: INGRESE CREDENCIALES ::</title>
<link rel="stylesheet" href="../css/mm_restaurant1.css" type="text/css" />
<style type="text/css">
<!--
.style4 {color: #000000}
.style5 {font-size: 16px}
.neg {	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #666;
}
-->
</style>
<script language="javascript" src="../JS/code_js.js"></script>
</head>

<body onload="setTextField(form)">
<div align="left" class="bodyText"><!--a href="index.jsp" class="style4" accesskey="w" tabindex="t">Regresar a Menú</a--></div>
<form action="index.jsp" method="post" name="form">
<table border="0" align="left">
<tr>
<th>
<table border="0" align="left">
<tr>
<td>
  
  <table width="1076" border="0" align="left">
  <tr>
    <th width="127" height="259" scope="col">&nbsp;</th>
    <th width="807" scope="col"><br /><br />
      <br /><br />
     <center> <table width="462" height="214" border="2">
        <tr>
          <th width="357" scope="col">
		  <table width="412" height="136" border="0">
          <tr>
            <th colspan="3" scope="col"><img src="../imagen/ima_main.jpg"  /></th>
          </tr>
  <tr>
    <th colspan="3" scope="col">Introduzca Credenciales V&aacute;lidas </th>
    </tr>
  <tr>
    <th width="99" scope="row"><div align="left"></div></th>
    <td width="186"><label></label></td>
    <td width="231" rowspan="5">
	<table border="0">
	<tr>
	<td class="cen" align="center"><img src="../imagen/medicina2.png" width="148" height="102" alt="" border="0"></td>
	</tr>
	</table>	</td>
  </tr>
  <tr>
    <th scope="row"><div align="rigth">Usuario:</div></th>
    <td class="izq"><input type="text" name="txtf_user" onkeypress="return handleEnter(this, event)" /></td>
  </tr>
  <tr>
    <th scope="row"><div align="rigth">Contrase&ntilde;a:</div></th>
    <td><div align="left">
      <input type="password" name="txtf_pass" onkeypress="return handleEnter(this, event)" />
    </div></td>
  </tr>
  <tr>
    <th scope="row"><div align="left"></div></th>
    <td><div align="center">
      <input name="Submit" type="submit" class="bodyText" value="Validar Usuario" />
    </div></td>
  </tr>
  <tr>
    <th scope="row"><div align="left"></div></th>
    <td><label></label></td>
    </tr>
  <tr>
    <th colspan="3" scope="row"><img src="../imagen/logo2.png" width="410" height="123" alt="CENSOS NAYARIT 2013" />
      <label>
      <div align="center"></div>
      </label></th>
    </tr>
   <tr>
    <th scope="row">&nbsp;</th>
    <td><label>
      <div align="center"></div>
    </label></td>
    <td>&nbsp;</td>
  </tr>
   <tr>
     <th colspan="3" scope="row"><strong class="neg">DERECHOS RESERVADOS GNKL/DESARROLLOS WEB &reg; 2009 - 2013</strong></th>
     </tr>
          </table>

		  
		  </th>
        </tr>
      </table>
      <br />
	
	
	</th>
    <th width="120" scope="col">&nbsp;</th>
  </tr>
</table>
</form>
<%
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
</body>

</html>
