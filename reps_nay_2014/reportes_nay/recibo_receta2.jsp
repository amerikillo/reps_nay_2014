<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../pag_man.html"" %>

<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
String val_sesion="", us_sesion="";



if (sesion.getAttribute("valida")!=null){
	val_sesion=(String)sesion.getAttribute("valida");
	us_sesion=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!val_sesion.equals("valido")){
	
	%>
    <script>self.location='index.jsp';</script>
    <%
}
%>
<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: recibo_receta2.jsp
FUNCIÓN: Menú de Opciones para el Reporte 2 y 4, depende de la opción del Usuario
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  IVA, ARD, RHW
ARCHIVOS JS    :  list02.js
------------------------------------------------------------------------------------------------------------------------------*/
// Conexión a la BDD
				  Class.forName("org.gjt.mm.mysql.Driver");
				  Connection conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/rweb_nay","receta_usr","M8KbqNjTD2");
                  Statement stmt = conn.createStatement();
				  Statement stmt1 = conn.createStatement();
				  Statement stmt3 = conn.createStatement();
				  ResultSet rset = null;
				  ResultSet rset1 = null;
				  ResultSet rset3 = null;
				  ResultSet rset4 = null;
				  
// Variables de entorno				  
String folio_re="",afiliado_jv="",receta1="",encar_jv="",nom_unidad="",no_jur="",juris_jv="",clave_jv="";
String cv_dgo_jv="",cv_uni_jv="",cv_mpio_jv="",id_med_jv="",part_jv="",ban="",uni="",ran1="",ran2="",prog="",receta="",serv="",mensaje="";
String bd_jv="";

try{
        folio_re=request.getParameter("folio");
		receta1=request.getParameter("receta");
		nom_unidad=request.getParameter("uni");
		no_jur=request.getParameter("juris");
		encar_jv=request.getParameter("encar");
		juris_jv=request.getParameter("juris1");
		clave_jv=request.getParameter("clave_uni");
		cv_dgo_jv=request.getParameter("cv_dgo");
		cv_uni_jv=request.getParameter("cv_uni");
		cv_mpio_jv=request.getParameter("cv_mpio");
		part_jv=request.getParameter("part");
		id_med_jv=request.getParameter("id_med");
		ban=request.getParameter("ban");
	    uni=request.getParameter("uni");
	    ran1=request.getParameter("rango1");
	    ran2=request.getParameter("rango2");
  	    prog=request.getParameter("programa");
	    serv=request.getParameter("servicio");
	    receta=request.getParameter("receta");
        bd_jv=request.getParameter("bd");
		
	 }catch(Exception e){ System.out.print("Doesn't make the altaOK"); }

%>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>TICKET</title>
<style type="text/css">
<!--
.style5 {font-family: Arial, Helvetica, sans-serif; font-size: 12; }
.style6 {font-size: 12}
.style7 {	font-size: 12px;
	font-weight: bold;
}
.style8 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<form id="form" name="form" method="post" action="recibo_receta2.jsp">

<table width="384" height="490"  border="3" align="left" cellpadding="2">
  <tr>
    <td width="372" height="92"><table width="370" border="0" cellpadding="2">
      <tr>
        <td class="style7"><a href="5_rep_det_folreci_pag.jsp?rango1=<%=ran1%>&rango2=<%=ran2%>&programa=<%=prog%>&servicio=<%=serv%>&uni=<%=uni%>&receta=<%=receta%>&ban=<%=ban%>&bd=<%=bd_jv%>">Regresar a Men&uacute;</a> </td>
      </tr>
      <tr>
        <td width="362" class="style7"><div align="center"><strong><span class="style5">SAVI DISTRIBUCIONES  S.A DE C.V.* </span></strong></div></td>
      </tr>
      <tr>
        <td class="style7"><div align="center"><strong><span class="style5">AV. MAGNOCENTRO No. 11, PISO 5<br /> COL. CENTRO URBANO HUIXQUILUCAN</span></strong><strong><span class="style5"></span></strong></div></td>
      </tr>
      <tr>
        <td class="style7"><div align="center">ESTADO DE M&Eacute;XICO, C.P. 52760 </div></td>
      </tr>
      
      <tr>
        <td class="style7"><div align="center"><%=nom_unidad%> <br /></div>
         <%
		  if(receta.equals("RF"))
		   {
		  %>
          <br />
        <center>TICKET DE RECETA FARMACIA</center>
          <%
		   }
			else
			  {
		  %>
          <br />
           <center> TICKET DE RECETA COLECTIVA 
           <br />
           SERVICIO:<%=serv%>
           
           </center>          
          <%
								  
		   	  }
		 %>
        
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="254"><table width="370" border="0" cellpadding="2">
      <tr>
        <td width="364"><div align="right" class="style6 style8">FECHA DE VENTA:&nbsp;&nbsp; &nbsp;  </div></td>
      </tr>
	  <%
	  rset=stmt.executeQuery("select * from "+bd_jv+" where folio_re='"+folio_re+"' group by folio_re");
 
   while(rset.next()) 
                  { 
				  afiliado_jv=rset.getString("afiliado");
				  if (afiliado_jv.equals("SP"))
				  {
				  afiliado_jv="SEGURO POPULAR";
				  }else if (afiliado_jv.equals("PA"))
				  {
				  afiliado_jv="POBLACION ABIERTA";
				  } else if (afiliado_jv.equals("OP"))
				  {
				  afiliado_jv="OPORTUNIDADES";
				  }
	  %>
      <tr>
        <td><table width="364" border="0" cellpadding="2">
          <tr>
            <td width="196" class="style8">FOLIO:
              <%=receta1%>&nbsp;-&nbsp;<%=rset.getString("clave_uni")%>&nbsp;-&nbsp;<%=rset.getString("folio_re")%></td>
            <td width="77" class="style8"><%=rset.getString("fecha")%></td>
            <td width="71" class="style8">
              <%=rset.getString("hora")%></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><span class="style8">CLIENTE:
           <%=afiliado_jv%></span></td>
      </tr>
      <tr>
        <td class="style8">SUB-CLIENTE: 
          SERVICIOS DE SALUD DE NAYARIT</td>
      </tr>
      
      <tr>
        <td class="style8"><table width="352" border="0" cellpadding="2">
          <tr>
            <td width="89" class="style8">BENEFICIARIO:</td>
            <td width="249" class="style8">
            <%
								   if(receta.equals("RF"))
								    {
								%>
								<%=rset.getString("nombre_pac")%>
                                <%
									}
								   else
								    {
								%>
                                <%=rset.getString("servicio")%>
                                <%
								  
									}
								 %>

            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">FOLIO REFERENCIA: 
              <%=rset.getString("folio_sp")%></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">RECETA: 
              <%=rset.getString("folio_re")%></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">FECHA DE RECETA: 
              <%=rset.getString("fecha")%></td>
          </tr>
		   <%
		 }
		 rset4=stmt.executeQuery("select * from "+bd_jv+" where folio_re='"+folio_re+"' group by fuente");
 
   while(rset4.next()) 
                  { 
				  %>
          <tr>
            <td class="style8">PROGRAMA:</td>
            <td class="style8"><%=rset4.getString("fuente")%></td>
          </tr>
          <tr>
            <td class="style8">SUB-PROGRAMA:</td>
            <td class="style8"><%=rset4.getString("fuente")%></td>
          </tr>
		  <%}%>
        </table></td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td height="25"><table width="375" border="0" cellpadding="2">
      <tr>
        <td width="263" class="style8">DESCRIPCION</td>
        <td width="52" class="style8"><div align="center">CANTIDAD</div></td>
        <td width="40" class="style8"><div align="center">ORIGEN</div></td>
      </tr>
	  <%
	  rset1=stmt1.executeQuery("select * from "+bd_jv+" where folio_re='"+folio_re+"' ");
 
   while(rset1.next()) 
                  { 
	  %>
      <tr>
        <td height="21" class="style8"><%=rset1.getString("clave")%> - <%=rset1.getString("descri")%></td>
        <td class="style8" align="center"><%=rset1.getString("uni")%></td>
        <td height="21" class="style8" align="center"><%=rset1.getString("partida")%></td>
      </tr>
      <%}%>

    </table></td>
  </tr>
  
  <tr>
    <td height="77"><table width="369" border="0" cellpadding="2">
      <tr>
        <td width="361"></td>
      </tr>
      <tr>
        <td class="style8"><div align="center">FIRMA DE RECIBIDO </div></td>
      </tr>
      <%
	  rset3=stmt.executeQuery("select * from "+bd_jv+" where folio_re='"+folio_re+"' group by folio_re");
 
   while(rset3.next()) 
                  { 
				  
	  %>
      
      <tr>
        <td class="style8">ENCARGADO(A): 
          <%=rset3.getString("encargado")%></td>
      </tr>
      <tr>
        <td class="style8">FECHA DE IMPRESION: 
          <%=rset3.getString("fecha")%>&nbsp;-&nbsp;<%=rset3.getString("hora")%></td>
      </tr>
	  <%}
	  
	    try{
// aquí van los queries utilizando objetos de las Clases Statement y ResultSet
            conn.close();
			       
    }catch (Exception e) {
	  mensaje=e.toString();
	}
 finally { 
if (conn!=null ) {
 conn.close();
  
	 if(conn.isClosed()){

        mensaje="desconectado";}

 
      }
}	  
	  
	  %>
    </table></td>
  </tr>
  
</table>
</body>
</html>
