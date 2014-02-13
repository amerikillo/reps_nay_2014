<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../pag_man.html" session="true" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: menu_dgo_569.jsp
FUNCIÓN: Menú de Opciones para el Reporte 5,6 y 9, depende de la opción del Usuario
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  IVA, ARD, RHW
ARCHIVOS JS    :  list02.js
------------------------------------------------------------------------------------------------------------------------------*/
    //objeto de la Clase Connection, nos sirve para hacer la conexión a la base correspondiente
Connection conexion=null;
Statement stmt = null;
ResultSet rset = null;
String mensaje="";

   /*parametros para la conexion*/

    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/rweb_nay";
    String usuario = "receta_usr";
    String clave = "M8KbqNjTD2";
    
  /*procedimiento de la conexion*/

    try{
         Class.forName(driver);
         conexion = DriverManager.getConnection(url,usuario,clave);

         /*guardando la conexion en la session*/

         //session.setAttribute("conexion",conexion);
       } catch (Exception ex){mensaje=ex.toString();}

    mensaje="conectado";

    if(conexion.isClosed()){mensaje="desconectado";}
        //out.print(mensaje);
%>


<%
 //variables para tomar la unidad a enviar
String id_uni="";
String nom_uni=""; 
String juris_jv="";
String unis_jv="";
String unis1_jv="";
int altaOK=0;
String but="r";
    String clave_jv= "";
String mpio2_jv= "";
String uni2_jv=  "";
    String lote_jv= "";
String jur_jv= "";
String exis_jv= "";
String costo_jv= "";
String encar3_jv="";
String pssw_jv="";
String caduc_jv="";
String caduci_jv="";
String medico_jv="";
String programa_jv="";
String reporte_jv="",semana_jv="",mes_jv="";
//String beneficiario_jv="";
String rep_jv="4";
String tipo_jv="";//arenas
String receta_jv="";//arenas
String servicio_jv="";
String fecha1_jv="",fecha2_jv="",fechaa1_jv="",fechaa2_jv="",fecha11_jv="",fecha22_jv="",fechaa11_jv="",fechaa22_jv="",caduc1_jv="",caduci1_jv="";

String nomb="REPORTE DETALLADO POR BENEFICIARIO";

//Para el proceso de BDD por mes para Farm. Seg. Popular Dgo
String fecha_mes1="",fecha_mes2="";


try { 
     nomb=request.getParameter("nom");
    }catch(Exception e){System.out.print("not");}

try { 


       rep_jv=request.getParameter("rep");
        
    }catch(Exception e){System.out.print("not");}

// Arreglo que toma los valores de la tabla consolidado medicos
String med[]=new String[10000];
 int tamPro=0;

try{
        altaOK=Integer.parseInt(request.getParameter("altaok"));   
       }catch(Exception e){ System.out.print("Doesn't make the altaOK"); }
   
   try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}




//*****************************************POR UNIDAD
if(but.equals("POR UNIDAD"))
{
  //out.print("");

  unis1_jv= request.getParameter("SubCat2");
  caduc_jv= request.getParameter("txtf_caduc");
  caduci_jv= request.getParameter("txtf_caduci");
  programa_jv= request.getParameter("slct_programa");
  servicio_jv= request.getParameter("slct_servicio");
  caduc1_jv= request.getParameter("txtf_caduc");
  caduci1_jv= request.getParameter("txtf_caduci");
  semana_jv=request.getParameter("semana");
  mes_jv=request.getParameter("mes");
  receta_jv= request.getParameter("slct_receta");
    
//try para hacer la conexión y realizar conversión de fechas

 //se crea el objeto stmt que nos servirá árar realizar queries
              stmt = conexion.createStatement();
          rset = stmt.executeQuery("SELECT STR_TO_DATE('"+caduc1_jv+"', '%d/%m/%Y')"); 
                       if(rset.next()){
                       caduc1_jv= rset.getString("STR_TO_DATE('"+caduc1_jv+"', '%d/%m/%Y')");
 }
              rset = stmt.executeQuery("SELECT STR_TO_DATE('"+caduci1_jv+"', '%d/%m/%Y')"); 
                       if(rset.next()){
                          caduci1_jv= rset.getString("STR_TO_DATE('"+caduci1_jv+"', '%d/%m/%Y')"); 
  }

   out.print(request.getParameter("txtf_caduc"));
      if (rep_jv.equals("4"))
  {
   if (unis1_jv.equals("-- Seleccione --"))
  
                         {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA UNIDAD DE ATENCIÓN")
   </script>
<%
   }else
     if (unis1_jv.equals("--ESCOJA CENTRO DE SALUD--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA UNIDAD DE ATENCIÓN")
   </script>
<%
   }else
   if (programa_jv.equals("-- Seleccione Programa--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN PROGRAMA")
   </script>
   <%
   }else
   if (receta_jv.equals("-- Seleccione Un Tipo de Receta--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN TIPO DE RECETA")
   </script>
   <%
   }else
   if (tipo_jv.equals("Receta Colectiva"))
   {
   if (servicio_jv.equals("-- Seleccione Servicio --"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN SERVICIO")
   </script>
   <%
   }}else{
  
 
  rset=stmt.executeQuery("select * from unidades_ where id_unidad='"+unis1_jv+"'");
          while (rset.next()) 
                  { 
                      id_uni=rset.getString("id_unidad");
                      nom_uni=rset.getString("unidad");
                   }
   
   // Si es la FSPD y si es por meses se irá a su correspondiente base
   
   if(unis1_jv.equals("u1144") )
   {
     if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/01/2013") ){
    response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_ene&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
}
 else if(caduc_jv.equals("01/02/2013") && caduci_jv.equals("29/02/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_feb&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/03/2013") && caduci_jv.equals("31/03/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_mar&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/04/2013") && caduci_jv.equals("30/04/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_abr&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }

else if(caduc_jv.equals("01/05/2013") && caduci_jv.equals("31/05/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_may&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

else if(caduc_jv.equals("01/06/2013") && caduci_jv.equals("30/06/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_jun&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
else if(caduc_jv.equals("01/07/2013") && caduci_jv.equals("31/07/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_jul&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  

 else if(caduc_jv.equals("01/08/2013") && caduci_jv.equals("31/08/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_ago&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
 else if(caduc_jv.equals("01/09/2013") && caduci_jv.equals("31/09/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_sep&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
 else if(caduc_jv.equals("01/10/2013") && caduci_jv.equals("31/10/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_oct&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
 else if(caduc_jv.equals("01/11/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144_nov&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 else if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
  
 else
 {response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1144&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");}
    
                  }// fin de if unis_jv
 /* 
//si no se va a la base u1145 
  else if(unis1_jv.equals("u1145") )
   {
     if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/01/2013") ){
    response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_ene&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
}
 else if(caduc_jv.equals("01/02/2013") && caduci_jv.equals("29/02/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_feb&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/03/2013") && caduci_jv.equals("31/03/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_mar&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/04/2013") && caduci_jv.equals("30/04/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_abr&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }

else if(caduc_jv.equals("01/05/2013") && caduci_jv.equals("31/05/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_may&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

else if(caduc_jv.equals("01/06/2013") && caduci_jv.equals("30/06/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_jun&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
else if(caduc_jv.equals("01/07/2013") && caduci_jv.equals("31/07/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_jul&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/08/2013") && caduci_jv.equals("31/08/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_ago&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
 else if(caduc_jv.equals("01/09/2013") && caduci_jv.equals("31/09/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_sep&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
 else if(caduc_jv.equals("01/10/2013") && caduci_jv.equals("31/10/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_oct&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
 else if(caduc_jv.equals("01/11/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145_nov&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 else if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
 
else{
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1145&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
 
                  }// fin de if unis_jv  
  // para la Unidad CSN 2
   else if(unis1_jv.equals("u1146") )
   {
     if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/01/2013") ){
    response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_ene&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
}
 else if(caduc_jv.equals("01/02/2013") && caduci_jv.equals("29/02/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_feb&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/03/2013") && caduci_jv.equals("31/03/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_mar&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/04/2013") && caduci_jv.equals("30/04/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_abr&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }

else if(caduc_jv.equals("01/05/2013") && caduci_jv.equals("31/05/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_may&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

else if(caduc_jv.equals("01/06/2013") && caduci_jv.equals("30/06/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_jun&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
else if(caduc_jv.equals("01/07/2013") && caduci_jv.equals("31/07/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_jul&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/08/2013") && caduci_jv.equals("31/08/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_ago&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }   
else if(caduc_jv.equals("01/09/2013") && caduci_jv.equals("31/09/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_sep&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }   
else if(caduc_jv.equals("01/10/2013") && caduci_jv.equals("31/10/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_oct&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
else if(caduc_jv.equals("01/11/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146_nov&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
else{
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd=u1146&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
                  }// fin de if unis_jv  
   
   else  {*/
     response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
         //}
//response.sendRedirect("5_rep_det_folreci_pag.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");   

  /* if(unis1_jv.equals("u1144") || unis1_jv.equals("u1145") )
       response.sendRedirect("5_rep_det_folreci_2.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
   else  
     response.sendRedirect("5_rep_det_folreci.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");*/

   }

  }
 if (rep_jv.equals("6"))
 {
  if (unis1_jv.equals("-- Seleccione --"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA UNIDAD DE ATENCIÓN")
   </script>
<%
   }else
     if (unis1_jv.equals("--ESCOJA CENTRO DE SALUD--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA UNIDAD DE ATENCIÓN")
   </script>
<%
   }
   else
   if (semana_jv.equals("-- Seleccione --"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA SEMANA")
   </script>
   
   <%
   }
   else
   if (programa_jv.equals("-- Seleccione Programa--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN PROGRAMA")
   </script>
   <%
   }else
   if (tipo_jv.equals("-- Seleccione Un Tipo de Receta--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN TIPO DE RECETA")
   </script>
   <%
   }else
   if (tipo_jv.equals("Receta Colectiva"))
   {
   if (servicio_jv.equals("-- Seleccione Servicio --"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN SERVICIO")
   </script>
   <%
   }
   
   }else
   {
    rset=stmt.executeQuery("select * from unidades_ where id_unidad='"+unis1_jv+"'");
          while (rset.next()) 
                  { 
                      id_uni=rset.getString("id_unidad");
                      nom_uni=rset.getString("unidad");
                   }

    response.sendRedirect("6_rep_det_semax.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3&semana="+semana_jv+"&mes="+mes_jv+"");
 }

   
 }
if (rep_jv.equals("9"))
{
 if (unis1_jv.equals("-- Seleccione --"))
  
                   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA UNIDAD DE ATENCIÓN")
   </script>
<%
   }else
     if (unis1_jv.equals("--ESCOJA CENTRO DE SALUD--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UNA UNIDAD DE ATENCIÓN")
   </script>
<%
   }else
   if (programa_jv.equals("-- Seleccione Programa--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN PROGRAMA")
   </script>
   <%
   }else
   if (tipo_jv.equals("-- Seleccione Un Tipo de Receta--"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN TIPO DE RECETA")
   </script>
   <%
   }else
   if (tipo_jv.equals("Receta Colectiva"))
   { 
   if (servicio_jv.equals("-- Seleccione Servicio --"))
  
   {
   %>
       <script>
   alert ("FAVOR DE SELECCIONAR UN SERVICIO")
   </script>
   <%
   }
   
   }else
  
    {
//out.print("entro al else");

 rset=stmt.executeQuery("select * from unidades_ where id_unidad='"+unis1_jv+"'");
          while (rset.next()) 
                  { 
                      id_uni=rset.getString("id_unidad");
                      nom_uni=rset.getString("unidad");
                   }
   
    if(unis1_jv.equals("u1144") )
   {
     if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/01/2013") ){
    response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_ene&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
}
 else if(caduc_jv.equals("01/02/2013") && caduci_jv.equals("29/02/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_feb&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/03/2013") && caduci_jv.equals("31/03/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_mar&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/04/2013") && caduci_jv.equals("30/04/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_abr&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }

else if(caduc_jv.equals("01/05/2013") && caduci_jv.equals("31/05/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_may&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

else if(caduc_jv.equals("01/06/2013") && caduci_jv.equals("30/06/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_jun&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
else if(caduc_jv.equals("01/07/2013") && caduci_jv.equals("31/07/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_jul&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
else if(caduc_jv.equals("01/08/2013") && caduci_jv.equals("31/08/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_ago&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
else if(caduc_jv.equals("01/09/2013") && caduci_jv.equals("31/09/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_sep&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
else if(caduc_jv.equals("01/10/2013") && caduci_jv.equals("31/10/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_oct&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
else if(caduc_jv.equals("01/11/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144_nov&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

 else
 {response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1144&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");}
    
                  }// fin de if unis_jv
  
//si no se va a la base u1145 
  else if(unis1_jv.equals("u1145") )
   {
     if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/01/2013") ){
    response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_ene&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
}
 else if(caduc_jv.equals("01/02/2013") && caduci_jv.equals("29/02/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_feb&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/03/2013") && caduci_jv.equals("31/03/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_mar&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/04/2013") && caduci_jv.equals("30/04/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_abr&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }

else if(caduc_jv.equals("01/05/2013") && caduci_jv.equals("31/05/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_may&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

else if(caduc_jv.equals("01/06/2013") && caduci_jv.equals("30/06/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_jun&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
else if(caduc_jv.equals("01/07/2013") && caduci_jv.equals("31/07/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_jul&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/08/2013") && caduci_jv.equals("31/08/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_ago&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
else if(caduc_jv.equals("01/09/2013") && caduci_jv.equals("31/09/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_sep&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
else if(caduc_jv.equals("01/10/2013") && caduci_jv.equals("31/10/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_oct&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
else if(caduc_jv.equals("01/11/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145_nov&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
else{
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1145&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
 
                  }// fin de if unis_jv  
  // para la Unidad CSN 2
   else if(unis1_jv.equals("u1146") )
   {
     if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/01/2013") ){
    response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_ene&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
}
 else if(caduc_jv.equals("01/02/2013") && caduci_jv.equals("29/02/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_feb&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/03/2013") && caduci_jv.equals("31/03/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_mar&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
  else if(caduc_jv.equals("01/04/2013") && caduci_jv.equals("30/04/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_abr&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }

else if(caduc_jv.equals("01/05/2013") && caduci_jv.equals("31/05/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_may&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 

else if(caduc_jv.equals("01/06/2013") && caduci_jv.equals("30/06/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_jun&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
 
else if(caduc_jv.equals("01/07/2013") && caduci_jv.equals("31/07/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_jul&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/08/2013") && caduci_jv.equals("31/08/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_ago&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/09/2013") && caduci_jv.equals("31/09/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_sep&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/10/2013") && caduci_jv.equals("31/10/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_oct&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }  
else if(caduc_jv.equals("01/11/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146_nov&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }   
else if(caduc_jv.equals("01/01/2013") && caduci_jv.equals("31/11/2013") )
 {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 }
else{
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd=u1146&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3"); 
 } 
                  }// fin de if unis_jv  
   
   else  {
     response.sendRedirect("5_rep_det_folreci_pag9.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
         }
    
   
/*--------------- a cortar según pruebas
 if(unis1_jv.equals("u1144") || unis1_jv.equals("u1145") )
       response.sendRedirect("59_rep_det_folreci_2.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
   else  
     response.sendRedirect("59_rep_det_folreci.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");
//---------------------------------------*/
//response.sendRedirect("9_rep_rece.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3");


//5_rep_det_folreci.jsp?uni="+nom_uni+"&bd="+id_uni+"&rango1="+caduc_jv+"&rango2="+caduci_jv+"&programa="+programa_jv+"&servicio="+servicio_jv+"&receta="+receta_jv+"&ban=3

}
   }
}
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="javascript" src="list02.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../css/ver1.css" type="text/css" />

<title>REPORTE DETALLADO FOLIO RECIBO</title>
<style type="text/css">
<!--
body {
background-color: #FFF;
}
.style1 {color: #0000FF}
-->
</style></head>

<body onLoad="fillCategory_J()">
<script src="scw.js" type="text/javascript"> </script>
<form id="form" name="form" method="post" action="">

  <table width="700" border="1" align="center" cellpadding="2">
    <tr>
      <td width="712"><table width="700" border="0" cellpadding="2" class="ver">
        <tr>
          <td colspan="4"><div align="center" class="tit"><strong>BIENVENIDOS AL SISTEMA REPORTEADOR</strong></div></td>
          </tr>
        <tr>
<tr>
          <td colspan="4"><div align="center"><strong><%=nomb%></strong></div></td>
          </tr>
        <tr>
         <td colspan="4"><div align="center" class="tit"><strong>SELECCIONE LOS DATOS </strong></div></td>
        </tr>
        <tr>
          <td colspan="4"><div align="right"><a href="index_main.jsp">Regresar a Menú</a></div></td>
          </tr>
        <tr>
          <td  width="54" class="boton">&nbsp;</td>
          <td colspan="4"><strong class="tit">Ingrese Unidad de Atenci&oacute;n</strong></td>
          <!--td>&nbsp;</td-->
          </tr>
        <tr>
          <!--td>&nbsp;</td-->
          <td colspan="2"><div align="right" class="tit">Jurisdicci&oacute;n: </div></td>
          <td colspan="2" align="left"><select name="Category" class="tit" onChange="SelectSubCat_J();"  >
            <option selected="selected">-- Seleccione --</option>
          </select></div><%//=fecha11_jv%></td>
          <!--td>&nbsp;</td-->
          </tr>
        <tr>
          <!--td width="53">&nbsp;</td-->
          <td colspan="2"><div align="right" class="tit">Municipio:</div></td>
          <td colspan="2" align="left"><select name="SubCat_MUN" class="tit" onChange="SelectSubCat_UNI();">
            <option>-- Seleccione --</option>
          </select></td>
          <!--td>&nbsp;</td-->
          </tr>
        <tr>
          <!--td>&nbsp;</td-->
          <td colspan="2"><div align="right" class="tit">Unidad de Atenci&oacute;n:</div></td>
          <td colspan="2" align="left"><select name="SubCat2" class="tit" onChange="slctServicios();">
            <option>-- Seleccione --</option>
          </select></td>
          <!--td>&nbsp;</td-->
          </tr>
        <tr>
          <td  width="54" class="boton">&nbsp;</td>
          <td colspan="4" class="boton">Ingrese el Rango de Fecha </td>
          <!--td class="boton">&nbsp;</td-->
          </tr>
  <%
 if (rep_jv.equals("6"))
  {
  %>
        <tr>
          <td>&nbsp;</td>
          <td width="273" class="tit">Seleccione Semana </td>
          <td width="333"><select name="semana" class="tit">
            <option>-- Seleccione --</option>
            <option value="1">1 2013-01-01 al 2013-01-06</option>
            <option value="2">2 2013-01-07 al 2013-01-13</option>
            <option value="3">3 2013-01-14 al 2013-01-20</option>
            <option value="4">4 2013-01-21 al 2013-01-27</option>
	    <option value="5">5 2013-01-28 al 2013-02-03</option>
            <option value="6">6 2013-02-05 al 2013-02-11</option>
            <option value="7">7 2013-02-12 al 2013-02-18</option>
            <option value="8">8 2013-02-19 al 2013-02-25</option>
            <option value="9">9 2013-02-26 al 2013-03-03</option>
            <option value="10">10 2013-03-04 al  2013-03-10</option>
			<option value="11">11 2013-03-11 al  2013-03-17</option>
			<option value="12">12 2013-03-18 al  2013-03-24</option>
			<option value="13">13 2013-03-25 al  2013-03-31</option>
			<!--option value="14">14 2013-04-01 al  2013-04-07</option>
			<option value="15">15 2013-04-08 al  2013-04-14</option>
			<option value="16">16 2013-04-15 al  2013-04-21</option>
			<option value="17">17 2013-04-22 al  2013-04-28</option>
			<option value="18">18 2013-04-29 al  2013-05-05</option>
			<option value="19">19 2013-05-06 al  2013-05-12</option>
			<option value="20">20 2013-05-13 al  2013-05-19</option>
			<option value="21">21 2013-05-20 al  2013-05-26</option>
			<option value="22">22 2013-05-27 al  2013-06-02</option>
			<option value="23">23 2013-06-03 al  2013-06-09</option>
			<option value="24">24 2013-06-10 al  2013-06-16</option>
			<option value="25">25 2013-06-17 al  2013-06-23</option>
			<option value="26">26 2013-06-24 al  2013-06-30</option>
			<option value="27">27 2013-07-01 al  2013-07-07</option>
			<option value="28">28 2013-07-08 al  2013-07-14</option>
			<option value="29">29 2013-07-15 al  2013-07-21</option>
			<option value="30">30 2013-07-22 al  2013-07-28</option>
			<option value="31">31 2013-07-29 al  2013-08-04</option>
			<option value="32">32 2013-08-05 al  2013-08-11</option>
			<option value="33">33 2013-08-12 al  2013-08-18</option>
			<option value="34">34 2013-08-19 al  2013-08-25</option>
			<option value="35">35 2013-08-26 al  2013-09-01</option>
			<option value="36">36 2013-09-02 al  2013-09-08</option>
			<option value="37">37 2013-09-09 al  2013-09-15</option>
			<option value="38">38 2013-09-16 al  2013-09-22</option>
			<option value="39">39 2013-09-23 al  2013-09-29</option>
			<option value="40">40 2013-09-30 al  2013-10-06</option>
			<option value="41">41 2013-10-07 al  2013-10-13</option>
			<option value="42">42 2013-10-14 al  2013-10-20</option>
			<option value="43">43 2013-10-21 al  2013-10-27</option>
			<option value="44">44 2013-10-28 al  2013-11-03</option>
			<option value="44">45 2013-11-04 al  2013-11-10</option>
			<option value="44">45 2013-11-11 al  2013-11-17</option>
			<option value="44">45 2013-11-18 al  2013-11-24</option>
			<option value="44">45 2013-11-25 al  2013-12-01</option-->


          </select>
         
          <td width="7">&nbsp;</td>
        </tr>
<%}else{%>
        <tr>
          <!--td>&nbsp;&nbsp;
              <label></label>&nbsp;&nbsp;&nbsp;&nbsp;</td-->
          <td colspan="4" align="center"><span class="tit">Rango de fechas:
              <label>del</label>
          </span>
            <label>
              <input name='txtf_caduc' type='text' class="tit" id='txtf_caduc' title='DD/MM/AAAA' size='10' maxlength='10' />
      </label>
            <img src="../imagen/calendar2.jpg" width="27" height="26" border="0" onClick="scwShow(scwID('txtf_caduc'),event);"/>
            <span class="tit">
            <label> al</label>
            </span>
            <label>&nbsp;&nbsp;
            <input name='txtf_caduci' type='text' class="tit" id='txtf_caduci' title='DD/MM/AAAA' size='10' maxlength='10'  />
            </label>
            <img src="../imagen/calendar2.jpg" width="27" height="26" border="0" onClick="scwShow(scwID('txtf_caduci'),event);"/></td>
          <!--td>&nbsp;</td-->
          </tr>
		  
  <tr><td  width="54" class="boton">&nbsp;</td><td colspan="0" class="boton" align="center"><div align="center"><a href="#">
  <div onClick="mes_abril();"><br><br><div align="left">RANGO DE FECHAS DE ABRIL</div></div></a> </div><br />
 <div align="center"><a href="#"><div onClick="mes_mayo();"><div align="left">RANGO DE FECHAS DE MAYO</div></div></a></div> <br />
 <div align="center"><a href="#"><div onClick="mes_junio();"><div align="left">RANGO DE FECHAS DE JUNIO</div></div></a></div><br />
 <div align="center"><a href="#"><div onClick="mes_julio();"><div align="left">RANGO DE FECHAS DE JULIO</div></div></a></div><br />
 <div align="center"><a href="#"><div onClick="mes_TODOS();"><div align="left">TODAS</div></div></a> </div>
 <!--div align="center"><a href="#"><div onclick="mes_abril();"><div align="left">RANGO DE FECHAS DE ABRIL</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_mayo();"><div align="left">RANGO DE FECHAS DE MAYO</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_junio();"><div align="left">RANGO DE FECHAS DE JUNIO</div></div></a></div><br />
 
 </td>
 <td colspan="2" class="boton" align="center">
 <div align="center"><a href="#"><div onclick="mes_julio();"><div align="left">RANGO DE FECHAS DE JULIO</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_agosto();"><div align="left">RANGO DE FECHAS DE AGOSTO</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_septiembre();"><div align="left">RANGO DE FECHAS DE SEPTIEMBRE</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_octubre();"><div align="left">RANGO DE FECHAS DE OCTUBRE</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_noviembre();"><div align="left">RANGO DE FECHAS DE NOVIEMBRE</div></div></a></div><br />
 <div align="center"><a href="#"><div onclick="mes_TODOS();"><div align="left">TODAS</div></div></a> </div-->  
  </td><td><img src="../imagen/logo2.png" width="215" height="74" /></td></tr>
          <%
  
                  /*stmt = conne_1.createStatement();
  rset = stmt.executeQuery("SELECT DATE_FORMAT('"+fecha1_jv+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    if(rset.next())

                    fecha1_jv= rset.getString("DATE_FORMAT('"+fecha1_jv+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')

                  rset = stmt.executeQuery("SELECT DATE_FORMAT('"+fecha2_jv+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset.next())
      fecha2_jv= rset.getString("DATE_FORMAT('"+fecha2_jv+"', '%d/%m/%Y')");*/ 
   
   
   %>
       <%
   if (rep_jv.equals("6"))
   {
  
/*  rset = stmt.executeQuery("SELECT DATE_FORMAT('"+fecha11_jv+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset.next())

                    fecha11_jv= rset.getString("DATE_FORMAT('"+fecha11_jv+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')

rset = stmt.executeQuery("SELECT DATE_FORMAT('"+fecha22_jv+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
                    while(rset.next())
      fecha22_jv= rset.getString("DATE_FORMAT('"+fecha22_jv+"', '%d/%m/%Y')"); */
   
   
   %>
        <tr>
          <!--td class="boton">&nbsp;</td-->
          <td colspan="4" class="boton" align="center">Rango V&aacute;lido del Periodo:&nbsp;&nbsp;01/01/2013<%//=fecha11_jv%>
          &nbsp;&nbsp; al &nbsp;&nbsp; 31/03/2013
          <%//=fecha22_jv%></td>
          <!--td class="boton">&nbsp;</td-->
        </tr>
        <%
   }else{
%>
        <tr>
          <!--td class="boton">&nbsp;</td-->
          <td colspan="4" class="boton" align="center">Rango V&aacute;lido del Periodo:&nbsp;&nbsp;01/01/2013<%//=fecha1_jv%>
          &nbsp;&nbsp; al &nbsp;&nbsp;31/03/2013 
          <%//=fecha2_jv%></td> 
          <!--td class="boton">&nbsp;</td-->
        </tr>
        <%}


}%>
        <tr>
          <td  width="54" class="boton">&nbsp;</td>
          <td class="tit">Ingrese un Programa </td>
          <td class="tit">&nbsp;</td>
          <td class="tit">&nbsp;</td>
          <td width="1" class="tit">&nbsp;</td>
          <!--td class="boton">&nbsp;</td-->
          <!--td class="boton">&nbsp;</td-->
          </tr>
        <tr>
          <!--td>&nbsp;</td-->
          <td colspan="2"><div align="right" class="tit">Programa: </div></td>
          <td colspan="2" align="left"><select name="slct_programa" class="tit">
              <option>-- Seleccione Programa--</option>
              <option value="SP">Seguro Popular</option>
              <option value="PA">Poblaci&oacute;n Abierta</option>
              <option value="OP">Oportunidades</option>
  <option value="Todos">Todos</option>
            </select></td>
          <!--td>&nbsp;</td-->
          </tr>
        <tr>
          <td  width="54" class="boton">&nbsp;</td>
          <td class="boton">Elija un Tipo de Receta </td>
          <td class="boton">&nbsp;</td>
          <td class="boton">&nbsp;</td>
          <td class="boton">&nbsp;</td>
          <!--td class="boton">&nbsp;</td-->
          <!--td class="boton">&nbsp;</td-->
          </tr>
        <tr>
          <!--td>&nbsp;</td-->
          <td colspan="2"><div align="right" class="tit">Tipo de Receta: </div></td>
          <td colspan="2" align="left" class="tit"><!--select name="slct_receta" class="tit">
              <option>-- Seleccione Un Tipo de Receta--</option>
              <!--option value="RF" onClick="javascript:cerrar();">Receta Farmacia</option>
              <option value="RC" onClick="javascript:mostrardiv();">Receta Colectiva</option>
  <!--option value="AMBAS" onclick="javascript:cerrar();">Ambas</option-->
            <!--/select-->  
            	<label>
      <input type="radio" name="slct_receta" value="RF" id="RadioGroup1_0" onClick="javascript:cerrar();" checked="checked" />
      Receta Farmacia</label>
    <br />
    <label>
      <input type="radio" name="slct_receta" value="RC" id="RadioGroup1_1" onClick="javascript:mostrardiv();" />
      Receta Colectiva</label>
                    </td>
          <!--td>&nbsp;</td-->
          </tr>
  
          <tr>
              <td colspan="4">&nbsp;</td>
          </tr> 
  <script>

function mostrardiv() {

div = document.getElementById('flotante');

div.style.display = '';
div = document.getElementById('flotante2');

div.style.display = '';
div = document.getElementById('flotante3');

div.style.display = '';

}

function cerrar() {

div = document.getElementById('flotante');

div.style.display='none';

div = document.getElementById('flotante2');

div.style.display='none';

div = document.getElementById('flotante3');

div.style.display='none';

}

</script>

<tr>
  <td  width="54" class="boton" align="left">&nbsp;</td>
  <td colspan="4"class="boton" align="left"><div id="flotante" style="display:block;">  Ingrese Servicio</div> </td>
  <!--td class="boton">&nbsp;</td-->
  <!--td class="boton">&nbsp;</td-->
</tr>
<tr>
  <!--td class="boton">&nbsp;</td-->
  <td colspan="2" class="boton" align="left"  ><div align="right"><div id="flotante2" style="display:block;"> Servicio:</div></div></td>
  <td colspan="2" class="boton" align="left"><label><div id="flotante3" style="display:block;">
<select name="slct_servicio" class="tit">
  <option>-- Seleccione Servicio --</option>
  <option value="URGENCIAS">URGENCIAS</option>
<option value="ULTRASONIDO">ULTRASONIDO</option>
<option value="QUIROFANO">QUIROFANO</option>
<option value="TOCOCIRUGIA">TOCOCIRUGIA</option>
<option value="NEONATOS">NEONATOS</option>
<option value="UTIP">UTIP</option>
  <option value="UTIA">UTIA</option>
<option value="PEDIATRIA">PEDIATRIA</option>
<option value="CIRUGIA">CIRUGIA</option>
<option value="ORTOPEDIA">ORTOPEDIA</option>
<option value="MEDICINA INTERNA">MEDICINA INTERNA</option>
<option value="UNIDAD CORONARIA">UNIDAD CORONARIA</option>
<option value="GINECOLOGIA">GINECOLOGIA</option>
<option value="CONSULTA EXTERNA">CONSULTA EXTERNA</option>
<option value="INHALOTERAPIA">INHALOTERAPIA</option>
<option value="ANTIALACRAN">ANTIALACRAN</option>
<option value="HEMODINAMIA">HEMODINAMIA</option>
<option value="CENTRAL DE MEZCLAS">CENTRAL DE MEZCLAS</option>
<option value="ENDOSCOPIA">ENDOSCOPIA</option>
<option value="LAPAROSCOPIA">LAPAROSCOPIA</option>
<option value="PATOLOGIA">PATOLOGIA</option>
  <option value="LAVANDERIA">LAVANDERIA</option>
  <option value="TRANSPLANTES">TRANSPLANTES</option>
  <option value="HEMODIALISIS">HEMODIALISIS</option>
  <option value="QUIRIFANO DE OFTALMO">QUIRIFANO DE OFTALMO</option>
  <option value="INGENIERIA BIOMEDICA">INGENIERIA BIOMEDICA</option>
  <option value="YESOS Y CURACIONES">YESOS Y CURACIONES</option>
  <option value="CEYE">CEYE</option>
  <option value="RX SOTANO">RX SOTANO</option>
  <option value="RESONANCIA MAGNETICA">RESONANCIA MAGNETICA</option>
  <option value="REHABILITACION">REHABILITACION</option>
<option value="SUBDIRECCION ADMINISTRATIVA">SUBDIRECCION ADMINISTRATIVA</option>
<option value="SUBDIRECCION MEDICA">SUBDIRECCION MEDICA</option>
<option value="LABORATORIO DE MICROBIOLOGIA">LABORATORIO DE MICROBIOLOGIA</option>
<option value="LABORATORIO DE ANALISIS CLINICOS">LABORATORIO DE ANALISIS CLINICOS</option>
<option value="CURACIONES">CURACIONES</option>
<option value="SUPERVISION DE ENFERMERAS">SUPERVISION DE ENFERMERAS</option>
<option value="ELECTROENCEFALOGRAFIA">ELECTROENCEFALOGRAFIA</option>
<option value="TOMOGRAFIA">TOMOGRAFIA</option>
  <option value="CLINICA DE DISPLASIAS">CLINICA DE DISPLASIAS</option>
 <option value="CLINICA DE MAMA">CLINICA DE MAMA</option>
 <option value="TRANSFUNCION SANGUINEA">TRANSFUNCION SANGUINEA</option>
  <option value="DIETETICA">DIETETICA</option>
  <option value="URGENCIAS PEDIATRICAS">URGENCIAS PEDIATRICAS</option>
<option value="CLINICA DE CATETER ADULTO">CLINICA DE CATETER ADULTO</option>
<option value="CLINICA DE CATETER PEDIATRICO">CLINICA DE CATETER PEDIATRICO</option>
<option value="CONSULTA">CONSULTA</option>
<option value="QUIROFANO">QUIROFANO</option>
<option value="PROCEDIMIENTOS">PROCEDIMIENTOS</option>
<option value="PEDIATRIA">PEDIATRIA</option>
<option value="MASTOGRAFIA">MASTOGRAFIA</option>
<option value="QUIMIOTERAPIA">QUIMIOTERAPIA</option>
<option value="ULTRASONIDO">ULTRASONIDO</option>
<option value="RADIOTERAPIA">RADIOTERAPIA</option>
<option value="CONSULTORIO 1">CONSULTORIO 1</option>
<option value="CONSULTORIO 2">CONSULTORIO 2</option>
<option value="CONSULTORIO 3">CONSULTORIO 3</option>
<option value="COCINA">COCINA</option>
<option value="URGENCIAS">URGENCIAS</option>
<option value="BRAQUITERAPIA">BRAQUITERAPIA</option>
<option value="INMUNOHISTOQUIMICA">INMUNOHISTOQUIMICA</option>
<option value="LABORATORIO">LABORATORIO</option>
<option value="HOSPITALIZACION">HOSPITALIZACION</option>
<option value="TODOS">TODOS</option>
</select></div>
  </label></td>
  <!--td class="boton">&nbsp;</td-->
</tr>


        <tr>
          <!--td class="boton">&nbsp;</td-->
          <td colspan="4" class="boton">&nbsp;</td>
          <!--td class="boton">&nbsp;</td>
          <td width="46" class="boton">&nbsp;</td-->
          </tr>
       
        <tr>
          <td colspan="4"><div align="center">
<p>
  <!--input name="Submit" type="submit" class="boton" value="POR JURISDICCION" /-->
  <!--input name="Submit" type="submit" class="boton" value="POR MUNICIPIO" /-->
      <input name="Submit" type="submit" class="boton" value="POR UNIDAD" />
</p>
</div></td>
          </tr>
        
      </table></td>
    </tr>
  </table>
  <p align="center">&nbsp;</p>
  <h5 align="center">DERECHOS RESERVADOS GNKL/DESARROLLOS WEB©2013, PARA USO EXCLUSIVO DE SAVI/SSN<br />VERSION 1.2.1</h5>

  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <%
  //Cerrando la conexión abierta
    try{
// aquí van los queries utilizando objetos de las Clases Statement y ResultSet
         
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
 //out.print(mensaje);

    /*  conne_1.close();
      stmt.close();
  rset.close();
*/
  %>
</form>
</body>
</html>
