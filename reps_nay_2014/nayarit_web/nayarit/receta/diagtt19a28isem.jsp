<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../../../pag_man.html" session="true" %>
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
NumberFormat formatter = new DecimalFormat("#0.00"); 

				ResultSet rset_200 =null;
				ResultSet rset_201 =null;
				ResultSet rset_20 =null;
				ResultSet rset_med =null;
				String cldia_jv="";
	 		
			  Statement stmt_20 = null;
			  Statement stmt_2000 = null;
              Statement stmt_200 = null;
    		  Statement stmt_d = null;
   			  Statement stmt_day = null;
		      
			  
			  Connection conexion=null;
    String mensaje="";
   /*parametros para la conexion*/
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/nay_re";    String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
    conexion = DriverManager.getConnection(url,usuario,pass);
     stmt_20 = conexion.createStatement();
	 stmt_2000 = conexion.createStatement();
	 stmt_200 = conexion.createStatement();
	 stmt_d = conexion.createStatement();
	 stmt_day = conexion.createStatement();
	 
	 
	 
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

				 
//ResultSet rset_2=null;
//ResultSet rset_20=null;//Para obtener los datos de forma global
//ResultSet rset_fol=null;
//ResultSet rset_sex=null;
//ResultSet rset_sexf=null;
//ResultSet rset_20 =null;
String totPzs="";
String totMon="";
String totMon1="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
String fecha_1= "";
String fecha_2= "";
String fecha_11= "";
String fecha_22= "";
String unidad_jv="";
//variables para definir recetas, piezas y costos
String no_rec_elb="20";
String no_pzs_sol="";
String no_pzs_sur="";
String st="10";
String sf="10";
String ixt_cad="",ixt_cad2="",ixt_cad3="";
int cant_pzs=0, ixt_uni=0;
int cont=0;
int h=0;
int cont3=0;
int cont4=0;
int cont1=0;
int cont2=0;
int cont5=0;
int cont6=0;
int cont7=0;
int cont8=0;
int cont9=0;
int cont10=0;
int cont11=0;
int cont12=0;
int cont13=0;
int cont14=0;
int cont15=0;
int cont16=0;
int cont17=0;
int cont18=0;
int cont19=0;
int cont20=0;
int cont21=0;
int cont22=0;
int cont23=0;
int cont24=0;
int cont25=0;
int cont26=0;
int x=0;

int ed=0;//variable que toma el total de edad
int edd=0;//variable que toma el valor de la consulta
double res=0.0, res2=0.0, res3=0.0, res4=0.0, promedio=0.0, promedio2=0.0, ixt_costo=0.0, ixt_costo3=0.0, res1=0.0, res_por=0.0, total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, cant_totMon=0.0, montos_res=0.0, ixt_uni1=0.0, cont261=0.0;//variables para dar formato de 0.00
int total_pzs=0,total_medi=0,total_cura=0;
int ban=0,ban_cur=0;
String but="r";
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}

   				  
				rset_200 = stmt_200.executeQuery("select max(fecha) from t_diag_princ;");
				while(rset_200.next()){
                    fecha_22=rset_200.getString("MAX(fecha)");
					}//out.print(""+fechmax);
					rset_200 = stmt_200.executeQuery("select min(fecha) from t_diag_princ;");
				while(rset_200.next()){
                    fecha_11=rset_200.getString("min(fecha)");
					}//out.print(""+fechmax);
				
										
			
	  
if(but.equals("Por Fechas"))
      {	    
	  ban=2;	 
	  ban_cur=1;
	  
// Rutina para fechas
           fecha_1= request.getParameter("txtf_caduc");
		   fecha_2= request.getParameter("txtf_caduci");
		 
		   
		 int bancom =1;  
	     if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){         
		 java.util.Calendar currDate = new java.util.GregorianCalendar();			
		 Date fecha1=new Date();
		 Date fecha2=new Date();
	 	 
		 SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		 fecha1=df.parse(fecha_1);
		 fecha2=df.parse(fecha_2);
		 
		 int month = (fecha1.getMonth())+1;
		 int month2 = (fecha2.getMonth())+1;
		 int years = (fecha1.getYear());
		 int years2 = (fecha2.getYear());
		 
		 if(years>years2){
		 	 bancom=2;
		 }
		 if(month>month2){
		    if(years>=years2)
		       bancom=2;
		 } 
		 
		 
		 //out.print("mes1:"+month+"mes2:"+month2+"año1:"+years+"año2:"+years2);
		 if( (month>=1 && (years>=114 || years<=108))  || (month2>=3 && (years2>=114 || years<=108)) )
		     {bancom=3;}
        		 
		   ResultSet rset_d = stmt_d.executeQuery("select MAX(fecha) from t_diag_princ;"); 
                    String fechmax="";
					int banexi=1;
					while(rset_d.next()){
                    fechmax=rset_d.getString("MAX(fecha)");
					}
					rset_d = stmt_d.executeQuery("select MIN(fecha) from t_diag_princ;"); 
                    String fechmin="";
					while(rset_d.next()){
                    fechmin=rset_d.getString("MIN(fecha)");
					}
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
		Date fechaMa=new Date();
		Date fechaMi=new Date();
		
		fechaMa=df2.parse(fechmax);
   	    fechaMi=df2.parse(fechmin);
 		
		int monthMa = (fechaMa.getMonth())+1;
		int monthMi = (fechaMi.getMonth())+1;
		int yearMa =  (fechaMa.getYear());
		int yearMi =  (fechaMi.getYear());
		if(monthMa < month || month < monthMi){
		 banexi=0;
		 }
		
		if(monthMa < month2 || month < monthMi){
		 banexi=0;
		 }

		   ResultSet rset_day = stmt_day.executeQuery("SELECT STR_TO_DATE('"+fecha_1+"', '%d/%m/%Y')"); 
                    while(rset_day.next()){
                    fecha_1= rset_day.getString("STR_TO_DATE('"+fecha_1+"', '%d/%m/%Y')");
					}
	       rset_day = stmt_day.executeQuery("SELECT STR_TO_DATE('"+fecha_2+"', '%d/%m/%Y')"); 
                    while(rset_day.next()){
                    fecha_2= rset_day.getString("STR_TO_DATE('"+fecha_2+"', '%d/%m/%Y')"); }
					//select sum(costo),sum(uni) from xjurisixt1 where fecha between '2009-06-10' and '2009-06-12'; 
   					  if(month2>=12 && years2==114)
						{
						  banexi=2;
						}  				
		
					    				
		   	 if(bancom==2){
		   fecha_1="";
			fecha_2="";
			
			%>
			<script>
			alert("Verifica las fechas, La primera fecha debe ser menor a la segunda, GRACIAS")
			</script>
			<%
		   }
		   
		   if(banexi==2){
		   fecha_1="";
			fecha_2="";
			%>
			<script>
			alert("El rango de fechas no se ha registrado todavía o bien ya se ha borrado, GRACIAS")
			</script>
			<%
		   }
		    if(bancom==3){
		   fecha_1="";
			fecha_2="";
			
			%>
			<script>
			alert("Verifica las fechas, ESTAN FUERA DE RANGO, GRACIAS")
			</script>
			<%
		   }
		}else{
		   //fecha_1="";
			//fecha_2="";
			%>
			<script>
			alert("Debes ingresar un rango de fechas")
			</script><%
		   }
	  
	  	
	   	   	
	   }
/*if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_20 = stmt_20.executeQuery("select cldia1,dia1,sum(diag1) as receta from t_diag_princ where fecha between '"+fecha_1+"' and '"+fecha_2+"'  group by cldia1 order by  receta desc limit 0,20;");
					
				  }*/
				 
  				 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/dis1.css" type="text/css" />

<title>Untitled Document</title>
<style type="text/css">
<!--
.style11 {font-weight: bold}
.style12 {color: #FFFFFF}
-->
</style>
</head>

<body>
<script src="scw.js" type="text/javascript"> </script>
<form name="form" action="diagtt19a28isem.jsp" method="post">
<table width="160" border="0">
  <tr>
    <td width="154"><p><a href="edades.jsp">Regresar a Men&uacute;</a><a name="ancla2" id="ancla2"></a></p></td>
  </tr>
</table>
<table width="1015" border="1" cellpadding="2" bordercolor="#7D2322" class="ver">
                     <tr>
                       <td width="585"><table width="1005" border="1" cellpadding="0">
                         
                         <tr height="17">
                           <td height="26" colspan="6" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><div align="center"><a href="#ancla1" class="style12">DIAGNÓSTICOS PRINCIPALES EDAD DE 19 A 28 A&Ntilde;OS </a></div></td>
                         </tr>
                         <!--tr height="17">
                           <td height="26" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0">&nbsp;</td>
                           <td height="26" colspan="2" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><span class="style12"><strong>Rango de fechas</strong>:</span>
                <input type='text' name='txtf_caduc' id='txtf_caduc' title='DD/MM/AAAA' size='10' maxlength='10' onclick='scwShow(this, event);' readonly/>
                  <img src="calendar.jpg" width="27" height="26" border="0" onClick="scwShow(scwID('txtf_caduc'),event);"/> &nbsp;&nbsp;&nbsp;&nbsp;
                  <label> <span class="style12">al</span>&nbsp;&nbsp;
                    <input type='text' name='txtf_caduci' id='txtf_caduci' title='DD/MM/AAAA' size='10' maxlength='10' onclick='scwShow(this, event);' readonly />
                  </label>
                  <%
		String fechaa1_jv="";
		String fechaa2_jv="";
		      	  
		      			 ResultSet rset_day = stmt_day.executeQuery("SELECT DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_day.next())
		      	        	   fechaa1_jv= rset_day.getString("DATE_FORMAT('"+fecha_1+"', '%d/%m/%Y')");
						rset_day = stmt_day.executeQuery("SELECT DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		      	           while(rset_day.next())
		      	        	   fechaa2_jv= rset_day.getString("DATE_FORMAT('"+fecha_2+"', '%d/%m/%Y')");
							   
							   %>
                  <img src="calendar.jpg" width="27" height="26" border="0" onClick="scwShow(scwID('txtf_caduci'),event);"/>
                  <input type="submit" name="Submit" value="Por Fechas" />
               
                  <span class="style12"><%=!(fecha_1.equals(""))?"Rango desde "+fechaa1_jv+" hasta "+fechaa2_jv:""%></span></td>
                           <td height="26" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><input type="submit" name="Submit" value="Valores Iniciales" /></td>
                         </tr-->
                         <tr height="17">
                           <td height="26" colspan="4" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><span class="style12">Periodo del:</span> <span class="style12"><%=fecha_11%></span>&nbsp;&nbsp;<span class="style12">al</span>&nbsp;<span class="style12">&nbsp;<%=fecha_22%></span></td>
                         </tr>
                         <tr height="17">
                           <td width="51" height="23" bgcolor="#CCCCCC" class="dis2"><div align="center">CIE-10</div></td>
                           <td width="457" height="23" bgcolor="#CCCCCC" class="dis2"><div align="center">DESCRIPCION</div></td>
                           <td width="117" bgcolor="#CCCCCC" class="dis2"><div align="center"><span class="style3">CANTIDAD</span></div></td>
                           <!--td width="117" bgcolor="#CCCCCC" class="dis2"><div align="center">COSTO</div></td>
                           <td width="117" bgcolor="#CCCCCC" class="dis2"><div align="center">COSTO PROMEDIO </div></td-->
                           <td width="118" bgcolor="#CCCCCC" class="dis2"><div align="center">PROPORCION</div></td>
                         </tr>
                         <%
				 rset_200 = stmt_200.executeQuery("select cldia1,sum(cant_costo),sum(diag1) from t_diag_princ where edad in (19,20,21,22,23,24,25,26,27,28) group by cedis;");
if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_200 = stmt_200.executeQuery("select cldia1,sum(cant_costo),sum(diag1) from t_diag_princ where fecha between '"+fecha_1+"' and '"+fecha_2+"' and edad in (19,20,21,22,23,24,25,26,27,28) group by cedis;");
					
				  }
				while (rset_200.next()) 
                  {
					  cont26=Integer.parseInt(rset_200.getString("sum(diag1)"));
				  cont261=cont26;
				
				  }
				  
				  rset_201 = stmt_200.executeQuery("select sum(cant_costo),sum(diag1) from t_diag_princ where edad in (19,20,21,22,23,24,25,26,27,28);");
if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_201 = stmt_200.executeQuery("select sum(cant_costo),sum(diag1) from t_diag_princ where fecha between '"+fecha_1+"' and '"+fecha_2+"' and edad in (19,20,21,22,23,24,25,26,27,28);");
					
				  }
				while (rset_201.next()) 
                  {
				totMon=rset_201.getString("sum(cant_costo)");
				cant_totMon=Double.parseDouble(totMon);
				
				  }
				  
				  res=cont26;
					res1=cant_totMon;
					res_por=(res1/res);
					/* promedio2=((res2/res)); 
				  
	 			*/
				  
				  
				%>
                         <%
						 rset_20 =  rset_20 = stmt_200.executeQuery("select cldia1,dia1,sum(diag1) as receta ,sum(cant_costo),sum(diag1) from t_diag_princ where edad in (19,20,21,22,23,24,25,26,27,28) group by cldia1 order by  receta desc ;");
						 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 rset_20 = stmt_20.executeQuery("select cldia1,dia1,sum(diag1) as receta ,sum(cant_costo),sum(diag1) from t_diag_princ where fecha between '"+fecha_1+"' and '"+fecha_2+"' and edad in (19,20,21,22,23,24,25,26,27,28) group by cldia1 order by  receta desc limit 0,20  ;");
	}
						 
				
				while (rset_20.next()) 
                {
				
				cldia_jv=rset_20.getString("cldia1");				
				
rset_med = stmt_2000.executeQuery("select cldia1,sum(cant_costo),sum(diag1), sum(diag1) from t_diag_princ where cldia1='"+cldia_jv+"' and edad in (19,20,21,22,23,24,25,26,27,28) group by cedis ;");
				
	if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				rset_med = stmt_2000.executeQuery("select cldia1,sum(cant_costo),sum(diag1) from t_diag_princ where cldia1='"+cldia_jv+"' and fecha between '"+fecha_1+"' and '"+fecha_2+"' and edad in (19,20,21,22,23,24,25,26,27,28) group by cedis;");
	}
	
				 while (rset_med.next()) 
                {
					cont5=Integer.parseInt(rset_med.getString("sum(diag1)"));
				ixt_cad2=rset_20.getString("sum(cant_costo)");
				ixt_costo= Double.parseDouble(ixt_cad2);

                res2=cont5;
 				ixt_uni1=cont5;
				res3=ixt_costo;
				promedio=(res3/res2);
               
				//cierra del while
				}
				
						
						 %>
                       
                         <tr height="17">
                           <td height="17" align="right" width="51"><div align="center"><%=("-")%><%//=rset_20.getString("cldia1")%></div>
                           <div align="center"></div></td>
                           <td width="457"><div align="left"><%=("-")%><%//=rset_20.getString("dia1")%></div></td>
                           <td align="right" width="117"><div align="center"><%=nf1.format(cont5)%></div></td>
                           <!--td width="117"><div align="center" class="style6">
                               <div align="center"><%=nf1.format(ixt_costo)%></div>
                           </div></td>
						  
                           <td width="117"><div align="center"><%=nf1.format(promedio)%></div></td-->
                           <td width="118"><div align="center"><%=formatter.format(ixt_uni1/cont261)%></div>
                           <div align="center" class="style6"></div></td>
                         </tr>
                         <%
				//}
					cont5=0;
				}
				
				%>
                
				
                         <tr height="17">
                           <td height="17" valign="top">&nbsp;</td>
                           <td><div align="left"></div>
                             <a href="#ancla2">&nbsp;Ir Encabezado</a></td>
                           <td align="right"><div align="center"><strong><a name="ancla1" id="ancla1"></a> </strong></div>
                               <div align="center" class="style2 style11">
							   
                                 <div align="center"><%=nf1.format(cont26)%></div>
                               </div></td>
                           <!--td><div align="center"><strong><span class="style6">$</span></strong><%=nf1.format(cant_totMon)%></div></td>
                           <td><div align="center"><strong><span class="style6">&nbsp;$ <%=nf1.format(res_por)%></span></strong></div></td-->
                           <td><div align="center"><strong>
                           1</strong></div></td>
                         </tr>
				     <%
				//}
				
				
				%>		 
                       </table></td>
                     </tr>
  </table>
                  
<p>&nbsp;</p>
<table width="602" border="0" cellpadding="0" cellspacing="0" bordercolor="#000033">
  <tr>
    <td width="74">&nbsp;</td>
    <td width="442"><div align="center"></div></td>
    <td width="78"><div align="center"></div></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
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
</body>
</html>
