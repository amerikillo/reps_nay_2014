<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../../../pag_man.html" %>

<% 
Class.forName("org.gjt.mm.mysql.Driver"); 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
NumberFormat formatter = new DecimalFormat("#0.00"); 

				ResultSet rset_200 =null;
				ResultSet rset_201 =null;
				ResultSet rset_202 =null;
				ResultSet rset_203 =null;
				ResultSet rset_sexf =null;
				ResultSet rset_sexm =null;
				ResultSet rset_204 =null;
				ResultSet rset_205 =null;
				ResultSet rset_20 =null;
				ResultSet rset_med =null;
				ResultSet rset_recf =null;
				ResultSet rset_recc =null;
				ResultSet rset_recfx =null;
				ResultSet rset_reccx =null;
				
				
				String cldia_jv="";
	 		
			  Statement stmt_20 = null;
			  Statement stmt_sexf = null;
			  Statement stmt_sexm = null;
			  Statement stmt_2000 = null;
              Statement stmt_200 = null;
			  Statement stmt_201 = null;
			  Statement stmt_202 = null;
    		  Statement stmt_d = null;
   			  Statement stmt_day = null;
			  Statement stmt_Elimin = null;
			  Statement stmt_recf = null;
			  Statement stmt_recc = null;
			  Statement stmt_recfx = null;
			  Statement stmt_reccx = null;
		      Statement stmt_min_max=null;
			  
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
	  stmt_201 = conexion.createStatement();
	  stmt_202 = conexion.createStatement();
	 stmt_d = conexion.createStatement();
	 stmt_day = conexion.createStatement();
	 stmt_Elimin = conexion.createStatement();
	 stmt_sexf = conexion.createStatement();
	 stmt_sexm = conexion.createStatement();
	 stmt_recf= conexion.createStatement();
	 stmt_recc= conexion.createStatement();
	 stmt_recfx= conexion.createStatement();
	 stmt_reccx= conexion.createStatement();
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

//variables para las fechas minimas y maximas calendario
String anio1_jv="",mes1_jv="",dia11_jv="",anio2_jv="",mes2_jv="",dia22_jv="",fecha_t1="",fecha_t2="";

String costot_jv="",cant_ct_jv="",sexot_jv="";
String fecha_1= "",fecha_11= "";
String fecha_2= "",fecha_22= "";
String juris_jv="",juris2_jv="",mpio_jv="",mpio2_jv="",fecha2_jv="",mpio1_jv="",idm_jv="",unidad_jv="",fecha_jv="",clave_jv="",descri_jv="",uni_jv="",costo_jv="",cedis_jv="";
String juris3_jv="",mpio3_jv="",idm3_jv="",unidad3_jv="",fecha3_jv="",clave3_jv="",descri3_jv="",uni3_jv="",costo3_jv="",cedis3_jv="",cldia3_jv="";
String juris4_jv="",fecha4_jv="",uni4_jv="",costo4_jv="",cedis4_jv="";
String juris5_jv="",fecha5_jv="",uni5_jv="",costo5_jv="",cedis5_jv="",mpio5_jv="",clave5_jv="",descri5_jv="",idm5_jv="",slt_jv="";
String but="r";

String folio_jv="",sol_jv="",sur_jv="",cant_c_jv="",sexo_jv="",diag1_jv="",descr_diag_jv="",med_jv="",edad_jv="",cont_diag="";
String folcont_jv="",paciente_jv="",medico_jv="",rfc_medico_jv="",cldia1_jv="",dia1_jv="",cldia2_jv="",dia2_jv="",dosis_jv="",uni_ate_jv="",tiempo_tra_jv="",rec_jv="",n_afi_jv="",origen_jv="",cedula_prof_jv="",servicio_jv="",status_sur_jv="",cv_uni_jv="",rec1_jv="";

String solf_jv="",surf_jv="",costo5f_jv="",cant_cf_jv="",solc_jv="",surc_jv="0",costo5c_jv="",cant_cc_jv="",msj_jv="";

int ban=0,ban_cur=0,cont_t=0,cont_sf=0,cont_sm=0,cont_rc=0,cont_rf=0;
	  
try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}

   				  
				  rset_200 = stmt_min_max.executeQuery("SELECT MIN(FECHA),MAX(FECHA),YEAR(min(FECHA)) AS anio1,MONTH(Min(FECHA)) AS mes1 ,DAY(Min(FECHA)) AS dia1,YEAR(MAX(FECHA)) AS anio2,MONTH(MAX(FECHA)) AS mes2 ,DAY(MAX(FECHA)) AS dia2 FROM CONSOLIDADO_ACTUALIZACION;");
	  
	  while(rset_200.next())
	  {
	  anio1_jv=rset_200.getString("anio1");
	  mes1_jv=rset_200.getString("mes1");
	  dia11_jv=rset_200.getString("dia1");
	  anio2_jv=rset_200.getString("anio2");
	  mes2_jv=rset_200.getString("mes2");
	  dia22_jv=rset_200.getString("dia2");
	  fecha_t1=dia11_jv+"/"+mes1_jv+"/"+anio1_jv;
	  fecha_t2=dia22_jv+"/"+mes2_jv+"/"+anio2_jv;
	  fecha_22=rset_200.getString("MAX(fecha)");
      fecha_11=rset_200.getString("min(fecha)");
	  }
	  
				
										
			
	  
if(but.equals("Por Fechas"))
      {	    
	  ban=2;	 
	  ban_cur=1;
	  
// Rutina para fechas
           fecha_1= request.getParameter("txtf_caduc");
		   fecha_2= request.getParameter("txtf_caduci");
		   slt_jv= request.getParameter("select_u_m");
		 
		 if(slt_jv.equals("1"))
		 {
			 msj_jv="UNIDADES";
		 }
		 if(slt_jv.equals("2"))
		 {
			 msj_jv="MUNICIPIOS";
		 }
		 if(slt_jv.equals("3"))
		 {
			 msj_jv="TOTALES";
		 }
		 if(slt_jv.equals("4"))
		 {
			 msj_jv="JURISDICCIONES";
		 }
		 if(slt_jv.equals("5"))
		 {
			 msj_jv="DIAGNÓSTICOS PRINCIPALES";
		 }
		 if(slt_jv.equals("6"))
		 {
			 msj_jv="DIAGNÓSTICOS POR SEXO";
		 }
		 if(slt_jv.equals("8"))
		 {
			 msj_jv="MEDICAMENTOS PRINCIPALES";
		 }
		 if(slt_jv.equals("9"))
		 {
			 msj_jv="MEDICAMENTO FEMENINOS";
		 }
		 if(slt_jv.equals("10"))
		 {
			 msj_jv="MEDICAMENTO MASCULINO";
		 }
		 if(slt_jv.equals("11"))
		 {
			 msj_jv="LIMPIAR TABLA DE ACTUALIZACIÓN";
		 }
		   
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
        		 
		   ResultSet rset_d = stmt_d.executeQuery("select MAX(fecha) from consolidado_actualizacion;"); 
                    String fechmax="";
					int banexi=1;
					while(rset_d.next()){
                    fechmax=rset_d.getString("MAX(fecha)");
					}
					rset_d = stmt_d.executeQuery("select MIN(fecha) from consolidado_actualizacion;"); 
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

  				 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/dis1.css" type="text/css" />

<title>RE CEAPS</title>
<style type="text/css">
<!--
.style11 {font-weight: bold}
.style12 {color: #FFFFFF}
-->
</style>
</head>

<body>
<script src="scw.js" type="text/javascript"> </script>
<form name="form" action="genera_bd_rec.jsp" method="post">
<table width="160" border="0">
  <tr>
    <td width="154"><p><a href="consultas.html">Regresar a Men&uacute;</a><a name="ancla2" id="ancla2"></a></p></td>
  </tr>
</table>
<table width="1015" border="1" cellpadding="2" bordercolor="#7D2322" class="ver">
                     <tr>
                       <td width="585"><table width="1005" border="1" cellpadding="0">
                         
                         <tr height="17">
                           <td height="26" colspan="6" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><div align="center"><a href="#ancla1" class="style12">LLENADO DE INFORMACI&Oacute;N A LAS TABLAS RECETA ELECTRONICA</a></div></td>
                         </tr>
                         <tr height="17">
                           <td height="26" colspan="4" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><span class="style12"><strong>Rango de fechas</strong>:</span>
                             <input name="txtf_caduc" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa">                             &nbsp;&nbsp;&nbsp;&nbsp;
                             <label> <span class="style12">al</span>&nbsp;&nbsp;
                    <input name="txtf_caduci" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa">
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
                             <label></label>
                             <select name="select_u_m">
                               <option value="0">----Seleccione----</option>
                               <option value="3">Totales</option>
							   <option value="4">Jurisdicciones</option>
							   <option value="2">Municipios</option>
                               <option value="1">Unidades</option>
							   <option value="5">Diagnósticos Principales</option>
							   <option value="6">Diagnósticos Por Sexo</option>
							   <option value="8">Medicamentos Principales</option>
							   <option value="9">Medicamentos Femenino</option>
							   <option value="10">Medicamentos Masculino</option>
                               <option value="11">Limpiar Tabla Actualización</option>
							 
                             </select>
                             <input type="submit" name="Submit" value="Por Fechas" />
               
                             <span class="style12"><%=!(fecha_1.equals(""))?"Rango desde "+fechaa1_jv+" hasta "+fechaa2_jv:""%></span>                             <input type="submit" name="Submit" value="Val. Iniciales" /></td>
                         </tr>
                         <tr height="17">
                           <td height="26" colspan="4" background="../../../imagen/fon3.jpg" bgcolor="#F0F0F0"><span class="style12">Periodo del:</span> <span class="style12"><%=fecha_11%></span>&nbsp;&nbsp;<span class="style12">al</span>&nbsp;<span class="style12">&nbsp;<%=fecha_22%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;SELECCIONO:&nbsp;&nbsp;&nbsp;<%=msj_jv%></strong></span></td>
                         </tr>
                         <tr height="17">
                           <td width="137" height="23" bgcolor="#CCCCCC" class="dis2"><div align="center">CLAVE UNIDAD </div></td>
                           <td width="213" height="23" bgcolor="#CCCCCC" class="dis2"><div align="center">JURSICCI&Oacute;N SANITARIA </div></td>
                           <td width="254" bgcolor="#CCCCCC" class="dis2"><div align="center"><span class="style3">MUNICIPIO</span></div></td>
                           
                           <td width="381" bgcolor="#CCCCCC" class="dis2"><div align="center">UNIDAD </div></td>
                         </tr>
                        
                         <%
						 if (slt_jv.equals("0"))
							{
							%>
							<script>
							
							alert ("Favor de Seleccionar Unidad O Municipio");
							</script>
							<%
							}
						 rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate from consolidado_actualizacion where cv_uni='1' group by cv_uni order by  (juris),mpio,uni_ate ;");
						 if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				 			if (slt_jv.equals("1"))
							{
				
				rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' group by cv_uni order by  cv_uni ;");//QUERY PARA SELECCIONAR LAS UNIDADES
				            }
					if (slt_jv.equals("2"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' group by mpio order by  mpio ASC ;");//QUERY PARA SELECCIONAR LOS MUNICIPIO
				            }
							if (slt_jv.equals("3"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo,rec from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' group by juris order by  juris asc ;");//QUERY PARA SELECCIONAR LOS TOTALES
				  
				  
				  rset_203 = stmt_2000.executeQuery("select juris,folio,rec,sexo,fecha,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,cedis from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' group by (juris) ,fecha ,folio ,edad ,sexo ,rec,cldia1 order by juris asc;");
				
			while(rset_203.next())
			{
			    
				juris5_jv=rset_203.getString("juris");
				folio_jv=rset_203.getString("folio");
				rec1_jv=rset_203.getString("rec");
				sexo_jv=rset_203.getString("sexo");
				fecha5_jv=rset_203.getString("fecha");
				sol_jv=rset_203.getString("sol");
				sur_jv=rset_203.getString("sur");
				costot_jv=rset_203.getString("costo");
				cant_ct_jv=rset_203.getString("cant_costo");
				cedis5_jv=rset_203.getString("cedis");
				
				stmt_20.execute("insert into total_rec_t values('"+juris5_jv+"','"+folio_jv+"','"+rec1_jv+"','"+sexo_jv+"','"+fecha5_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LAS TABLAS TOTALES GLOBAL
				
				
				
					
			}
			
			rset_recf = stmt_recf.executeQuery("select juris,count(folio),rec,sexo,count(sexo),fecha,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,cedis from total_rec_t  group by (juris) ,fecha,rec,sexo  order by juris asc;");
			
			while(rset_recf.next())
			{
			    juris5_jv=rset_recf.getString("juris");
				folio_jv=rset_recf.getString("count(folio)");
				rec1_jv=rset_recf.getString("rec");
				sexo_jv=rset_recf.getString("sexo");
				sexot_jv=rset_recf.getString("count(sexo)");
				fecha5_jv=rset_recf.getString("fecha");
				sol_jv=rset_recf.getString("sol");
				sur_jv=rset_recf.getString("sur");
				costot_jv=rset_recf.getString("costo");
				cant_ct_jv=rset_recf.getString("cant_costo");
				cedis5_jv=rset_recf.getString("cedis");
				
				stmt_20.execute("insert into total_rec values('"+juris5_jv+"','"+folio_jv+"','"+rec1_jv+"','"+sexo_jv+"','"+sexot_jv+"','"+fecha5_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LAS TABLAS TOTALES GLOBAL
				
				stmt_20.execute("delete from total_rec_t;");
				
			}
				  
				  
				            }
							if (slt_jv.equals("4"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' group by cv_uni,fecha order by  cv_uni ;");//QUERY PARA SELECCIONAR LOS JURISDICCIONES
				  
				  rset_203 = stmt_2000.executeQuery("select juris,mpio,uni_ate,folio,sum(cant_sol) as sol, sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,fecha,uni_ate,cedis,cv_uni from consolidado_actualizacion  where fecha BETWEEN '"+fecha_1+"' and '"+fecha_2+"' group by juris,fecha,folio,edad,cldia1,rec,cv_uni,sexo;");
				
			while(rset_203.next())
			{
			    
				juris5_jv=rset_203.getString("juris");
				mpio_jv=rset_203.getString("mpio");
				folio_jv=rset_203.getString("folio");
				sol_jv=rset_203.getString("sol");
				sur_jv=rset_203.getString("sur");
				costot_jv=rset_203.getString("costo");
				cant_ct_jv=rset_203.getString("cant_costo");
				fecha5_jv=rset_203.getString("fecha");
				unidad_jv=rset_203.getString("uni_ate");
				cedis5_jv=rset_203.getString("cedis");
				cldia_jv=rset_203.getString("cv_uni");
			
								
				stmt_20.execute("insert into juris_t values('"+juris5_jv+"','"+mpio_jv+"','"+folio_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA JURIS_T (JURIS TOTAL)
				
	    	}
			
			
			
			
			rset_204 = stmt_2000.executeQuery("select juris,mpio,uni_ate,count(folio),sum(cant_sol) as sol, sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,fecha,uni_ate,cedis,cv_uni from juris_t  where juris='JURISDICCION SANITARIA I' group by juris,fecha,cv_uni;");
				
			while(rset_204.next())
			{
				
				juris5_jv=rset_204.getString("juris");
				mpio_jv=rset_204.getString("mpio");
				folio_jv=rset_204.getString("count(folio)");
				sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costot_jv=rset_204.getString("costo");
				cant_ct_jv=rset_204.getString("cant_costo");
				fecha5_jv=rset_204.getString("fecha");
				unidad_jv=rset_204.getString("uni_ate");
				cedis5_jv=rset_204.getString("cedis");
				cldia_jv=rset_204.getString("cv_uni");
			
								
				stmt_20.execute("insert into j1_re values('"+juris5_jv+"','"+mpio_jv+"','"+folio_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA J2
				
			   stmt_Elimin.execute("delete  from juris_t where juris='JURISDICCION SANITARIA I';");
			
			}
			
			rset_205 = stmt_2000.executeQuery("select juris,mpio,uni_ate,count(folio),sum(cant_sol) as sol, sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,fecha,uni_ate,cedis,cv_uni from juris_t  where juris='JURISDICCION SANITARIA II' group by juris,fecha,cv_uni;");
				
			while(rset_205.next())
			{
			    juris5_jv=rset_205.getString("juris");
				mpio_jv=rset_205.getString("mpio");
				folio_jv=rset_205.getString("count(folio)");
				sol_jv=rset_205.getString("sol");
				sur_jv=rset_205.getString("sur");
				costot_jv=rset_205.getString("costo");
				cant_ct_jv=rset_205.getString("cant_costo");
				fecha5_jv=rset_205.getString("fecha");
				unidad_jv=rset_205.getString("uni_ate");
				cedis5_jv=rset_205.getString("cedis");
				cldia_jv=rset_205.getString("cv_uni");
			
								
				stmt_20.execute("insert into j2_re values('"+juris5_jv+"','"+mpio_jv+"','"+folio_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA J4
				 stmt_Elimin.execute("delete  from juris_t where juris='JURISDICCION SANITARIA II';");
			
			}
			
			rset_200 = stmt_min_max.executeQuery("select juris,mpio,uni_ate,count(folio),sum(cant_sol) as sol, sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,fecha,uni_ate,cedis,cv_uni from juris_t  where juris='JURISDICCION SANITARIA III' group by juris,fecha,cv_uni;");
			
			
			while(rset_200.next())
			{
			    juris5_jv=rset_200.getString("juris");
				mpio_jv=rset_200.getString("mpio");
				folio_jv=rset_200.getString("count(folio)");
				sol_jv=rset_200.getString("sol");
				sur_jv=rset_200.getString("sur");
				costot_jv=rset_200.getString("costo");
				cant_ct_jv=rset_200.getString("cant_costo");
				fecha5_jv=rset_200.getString("fecha");
				unidad_jv=rset_200.getString("uni_ate");
				cedis5_jv=rset_200.getString("cedis");
				cldia_jv=rset_200.getString("cv_uni");
			
								
				stmt_20.execute("insert into j3_re values('"+juris5_jv+"','"+mpio_jv+"','"+folio_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA J8
			
			 stmt_Elimin.execute("delete  from juris_t where juris='JURISDICCION SANITARIA III';");
			}
			
			
			
			
				            }
							if (slt_jv.equals("5"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and rec='RF' group by cldia1,fecha order by  cldia1 ;");//QUERY PARA SELECCIONAR LOS DIAGNÓSTICOS PRINCIPALES
				  
				  
								
				rset_203 = stmt_2000.executeQuery("select juris,cldia1,dia1,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,fecha,folio,edad,cedis from consolidado_actualizacion  where rec='RF' and fecha between '"+fecha_1+"' and '"+fecha_2+"' group by folio,cldia1,sexo,juris,fecha,edad order by fecha asc;");
				
			while(rset_203.next())
			{
			    
				juris5_jv=rset_203.getString("juris");
				diag1_jv=rset_203.getString("cldia1");
				descr_diag_jv=rset_203.getString("dia1");
				sol_jv=rset_203.getString("sol");
				sur_jv=rset_203.getString("sur");
				costot_jv=rset_203.getString("costo");
				cant_ct_jv=rset_203.getString("cant_costo");
				fecha5_jv=rset_203.getString("fecha");
				folio_jv=rset_203.getString("folio");
				edad_jv=rset_203.getString("edad");
				cedis5_jv=rset_203.getString("cedis");
				
				
				
				
				stmt_20.execute("insert into t_diag_princ_t values('"+juris5_jv+"','"+diag1_jv+"','"+descr_diag_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+fecha5_jv+"','"+folio_jv+"','"+edad_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LAS TABLAS DIAGNOSTICOS PRINCIPADES DETALLE
						
				
				
												
			}
			
			rset_204 = stmt_2000.executeQuery("select juris,cldia1,descrip,sum(cant_sol) as sol, sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,count(cldia1),fecha,folio,edad,cedis from t_diag_princ_t group by cldia1,fecha order by fecha asc");
				
			while(rset_204.next())
			{
			    
				
				
				juris5_jv=rset_204.getString("juris");
				diag1_jv=rset_204.getString("cldia1");
				descr_diag_jv=rset_204.getString("descrip");
				folio_jv=rset_204.getString("count(cldia1)");
				sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costo5_jv=rset_204.getString("costo");
				cant_c_jv=rset_204.getString("cant_costo");
				fecha5_jv=rset_204.getString("fecha");
				edad_jv=rset_204.getString("edad");
				cedis5_jv=rset_204.getString("cedis");
				
			stmt_20.execute("insert into t_diag_princ values('"+juris5_jv+"','"+diag1_jv+"','"+descr_diag_jv+"','"+folio_jv+"','"+sol_jv+"','"+sur_jv+"','"+costot_jv+"','"+cant_ct_jv+"','"+fecha5_jv+"','"+edad_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LAS TABLAS DIAGNOSTICOS PRINCIPADES
			
			stmt_20.execute("DELETE FROM t_diag_princ_t");
			
			}
				
				
				            }
							
				 if (slt_jv.equals("6"))
							{
							 rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and rec='RF' group by juris order by  juris asc ;");//QUERY PARA SELECCIONAR LOS MEDICAMENTOS PRINCIPALES
							
							
						rset_203 = stmt_2000.executeQuery("select juris,cldia1,dia1,fecha,cedis,sexo,sum(cant_sol) as sol,sum(cant_sur) as sur, costo,sum(cant_costo) as cant_costo,fecha,cedis from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and rec='RF' group by folio,juris,fecha,edad,sexo,cldia1 order by fecha asc;");
				
			while(rset_203.next())
			{
			
				juris5_jv=rset_203.getString("juris");
				diag1_jv=rset_203.getString("cldia1");
				descr_diag_jv=rset_203.getString("dia1");
			    sexo_jv=rset_203.getString("sexo");
				sol_jv=rset_203.getString("sol");
				sur_jv=rset_203.getString("sur");
				costo5_jv=rset_203.getString("costo");
				cant_c_jv=rset_203.getString("cant_costo");
				fecha5_jv=rset_203.getString("fecha");
			    cedis5_jv=rset_203.getString("cedis");
			
			stmt_20.execute("insert diag1 values('"+juris5_jv+"','"+diag1_jv+"','"+descr_diag_jv+"','"+sexo_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cedis5_jv+"') ;"); //QUERY PARA LLENAR LA TABLA DIAGNÓSTICOS	
			}	
			
			rset_204 = stmt_2000.executeQuery("select juris,cldia1,dia1,fecha,cedis,sexo,sum(cant_sol) as sol,sum(cant_sur) as sur, costo,sum(cant_costo) as cant_costo,fecha,cedis,count(cldia1) as t_diag  from diag1  where sexo='Femenino' group by cldia1;");
				
			while(rset_204.next())
			{
			
			    juris5_jv=rset_204.getString("juris");
				diag1_jv=rset_204.getString("cldia1");
				descr_diag_jv=rset_204.getString("dia1");
			    sexo_jv=rset_204.getString("sexo");
				sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costo5_jv=rset_204.getString("costo");
				cant_c_jv=rset_204.getString("cant_costo");
				fecha5_jv=rset_204.getString("fecha");
			    cedis5_jv=rset_204.getString("cedis");
				cont_diag=rset_204.getString("t_diag");
		     
			 stmt_201.execute("insert t_diag_feme values('"+juris5_jv+"','"+diag1_jv+"','"+descr_diag_jv+"','"+cont_diag+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA DIAGNÓSTICOS	PRINCIPALES FEMENINO 
			 stmt_Elimin.execute("delete  from diag1 where sexo='Femenino';");
			 }
			
			rset_205 = stmt_2000.executeQuery("select juris,cldia1,dia1,fecha,cedis,sexo,sum(cant_sol) as sol,sum(cant_sur) as sur, costo,sum(cant_costo) as cant_costo,fecha,cedis,count(cldia1) as t_diag  from diag1  where sexo='Masculino' group by cldia1;");//QUERY PARA SELECCIONAR LOS DIAGNÓSTICOS PRINCIPALES 
			while(rset_205.next())
			{
			
			    juris5_jv=rset_205.getString("juris");
				diag1_jv=rset_205.getString("cldia1");
				descr_diag_jv=rset_205.getString("dia1");
			    sexo_jv=rset_205.getString("sexo");
				sol_jv=rset_205.getString("sol");
				sur_jv=rset_205.getString("sur");
				costo5_jv=rset_205.getString("costo");
				cant_c_jv=rset_205.getString("cant_costo");
				fecha5_jv=rset_205.getString("fecha");
			    cedis5_jv=rset_205.getString("cedis");
				cont_diag=rset_205.getString("t_diag");
		     
			 stmt_202.execute("insert t_diag_mascu values('"+juris5_jv+"','"+diag1_jv+"','"+descr_diag_jv+"','"+cont_diag+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA DIAGNÓSTICOS	PRINCIPALES MASCULINO
			
			stmt_Elimin.execute("delete  from diag1 where sexo='Masculino';");
			}
			
			
			
			}
				    
							
							if (slt_jv.equals("8"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and rec='RF' group by med,fecha order by  med ;");//QUERY PARA SELECCIONAR LOS MEDICAMENTOS PRINCIPALES
				  
				  rset_204 = stmt_2000.executeQuery("select juris,med,descr,cedis,fecha,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo from consolidado_actualizacion  where rec='RF' and fecha between '"+fecha_1+"' and '"+fecha_2+"' group by (med),fecha ORDER BY FECHA ASC;");
				
			while(rset_204.next())
			{
			    juris5_jv=rset_204.getString("juris");
				med_jv=rset_204.getString("med");
				descr_diag_jv=rset_204.getString("descr");
				sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costo5_jv=rset_204.getString("costo");
				cant_c_jv=rset_204.getString("cant_costo");
				fecha5_jv=rset_204.getString("fecha");
			    cedis5_jv=rset_204.getString("cedis");
			
						
			stmt_20.execute("insert t_medica_princ values('"+juris5_jv+"','"+med_jv+"','"+descr_diag_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA MEDICAMENTOS PRINCIPALES
			
			}
				  
				  
	}
							if (slt_jv.equals("9"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and sexo='Femenino' and rec='RF' group by med,fecha order by  fecha ;");//QUERY PARA SELECCIONAR LOS MEDICAMENTOS PRINCIPALES SEXO FEMENINO
				  
				  rset_204 = stmt_2000.executeQuery("select juris,med,descr,cedis,fecha,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo from consolidado_actualizacion  where rec='RF' and fecha between '"+fecha_1+"' and '"+fecha_2+"' and sexo='Femenino' group by (med),fecha order by fecha;");
				
			while(rset_204.next())
			{
			   
			    juris5_jv=rset_204.getString("juris");
			    med_jv=rset_204.getString("med");
			    descr_diag_jv=rset_204.getString("descr");
				sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costo5_jv=rset_204.getString("costo");
				cant_c_jv=rset_204.getString("cant_costo");
				fecha5_jv=rset_204.getString("fecha");
			    cedis5_jv=rset_204.getString("cedis");
			
			
				
			
			stmt_20.execute("insert t_medica_feme values('"+juris5_jv+"','"+med_jv+"','"+descr_diag_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA MEDICAMENTOS PRINCIPALES SEXO FEMENINO
			
			}
				            }
							if (slt_jv.equals("10"))
							{
				  rset_20 = stmt_200.executeQuery("select cv_uni,juris,mpio,uni_ate,fecha,cldia1,med,edad,sexo from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and sexo='Masculino' and rec='RF' group by med,fecha order by  fecha ;");//QUERY PARA SELECCIONAR LOS MEDICAMENTOS PRINCIPALES SEXO MASCULINO
				  
				  	rset_204 = stmt_2000.executeQuery("select juris,med,descr,cedis,fecha,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo from consolidado_actualizacion  where rec='RF' and fecha between '"+fecha_1+"' and '"+fecha_2+"' and sexo='Masculino' group by (med),fecha order by fecha;");
				
			while(rset_204.next())
			{
			    juris5_jv=rset_204.getString("juris");
				med_jv=rset_204.getString("med");
				descr_diag_jv=rset_204.getString("descr");
				sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costo5_jv=rset_204.getString("costo");
				cant_c_jv=rset_204.getString("cant_costo");
				fecha5_jv=rset_204.getString("fecha");
			    cedis5_jv=rset_204.getString("cedis");
			
			
				
			
			stmt_20.execute("insert t_medica_mascu values('"+juris5_jv+"','"+med_jv+"','"+descr_diag_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA MEDICAMENTOS PRINCIPALES SEXO FEMENINO
			
			}
				            }
						
					if (slt_jv.equals("11"))
							{
								stmt_20.execute("DELETE FROM CONSOLIDADO_ACTUALIZACION");
							}
				 
	}
						 
	
				while (rset_20.next()) 
                {
				
			
				cldia_jv=rset_20.getString("cv_uni");	
				juris2_jv=rset_20.getString("juris");
				mpio2_jv=rset_20.getString("mpio");
				fecha2_jv=rset_20.getString("fecha");
				mpio1_jv=mpio2_jv.replaceAll(" ", "");
				med_jv=rset_20.getString("med");
				edad_jv=rset_20.getString("edad");
				sexo_jv=rset_20.getString("sexo");
				diag1_jv=rset_20.getString("cldia1");
				
				
							
				
				
				
				
				
				
				if (slt_jv.equals("1"))
							{
				
					//		stmt_20.execute("create table re_"+cldia_jv+" (select * from consolidado_actualizacion where cv_uni='"+cldia_jv+"' group by cv_uni) ;"); //QUERY PARA GENERAR LAS TABLAS POR UNIDAD POR PRIMERA VEZ									
rset_203 = stmt_2000.executeQuery("select * from consolidado_actualizacion where cv_uni='"+cldia_jv+"' and fecha between '"+fecha_1+"' and '"+fecha_2+"';");
				
			while(rset_203.next())
			{
			
			    folcont_jv=rset_203.getString("folcont");
				folio_jv=rset_203.getString("folio");
				juris5_jv=rset_203.getString("juris");
				mpio5_jv=rset_203.getString("mpio");
				paciente_jv=rset_203.getString("paciente");
				medico_jv=rset_203.getString("medico");
				rfc_medico_jv=rset_203.getString("rfc_medico");
				cldia1_jv=rset_203.getString("cldia1");
				dia1_jv=rset_203.getString("dia1");
				cldia2_jv=rset_203.getString("cldia2");
				dia2_jv=rset_203.getString("dia2");
             	clave5_jv=rset_203.getString("med");
				descri5_jv=rset_203.getString("descr");
				sol_jv=rset_203.getString("cant_sol");
				sur_jv=rset_203.getString("cant_sur");
				costo5_jv=rset_203.getString("costo");
				dosis_jv=rset_203.getString("dosis");
				tiempo_tra_jv=rset_203.getString("tiempo_tra");
				cant_c_jv=rset_203.getString("cant_costo");
				fecha5_jv=rset_203.getString("fecha");
				uni_ate_jv=rset_203.getString("uni_ate");
				idm5_jv=rset_203.getString("id_med");				
				edad_jv=rset_203.getString("edad");
				sexo_jv=rset_203.getString("sexo");
				rec_jv=rset_203.getString("rec");
				n_afi_jv=rset_203.getString("n_afi");
				origen_jv=rset_203.getString("origen");
				cedula_prof_jv=rset_203.getString("cedula_prof");
				servicio_jv=rset_203.getString("servicio");
				status_sur_jv=rset_203.getString("status_sur");
				cedis5_jv=rset_203.getString("cedis");
				cv_uni_jv=rset_203.getString("cv_uni");
										



stmt_20.execute("insert into re_"+cldia_jv+" values('"+folcont_jv+"','"+folio_jv+"','"+juris5_jv+"','"+mpio5_jv+"','"+paciente_jv+"','"+medico_jv+"','"+rfc_medico_jv+"','"+cldia1_jv+"','"+dia1_jv+"','"+cldia2_jv+"','"+dia2_jv+"','"+clave5_jv+"','"+descri5_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+dosis_jv+"','"+tiempo_tra_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+uni_ate_jv+"','"+idm5_jv+"','"+edad_jv+"','"+sexo_jv+"','"+rec_jv+"','"+n_afi_jv+"','"+origen_jv+"','"+cedula_prof_jv+"','"+servicio_jv+"','"+status_sur_jv+"','"+cedis5_jv+"','"+cv_uni_jv+"',curdate(),curtime());"); //QUERY PARA LLENAR LAS TABLAS POR UNIDAD



stmt_20.execute("insert into consolidado values('"+folcont_jv+"','"+folio_jv+"','"+juris5_jv+"','"+mpio5_jv+"','"+paciente_jv+"','"+medico_jv+"','"+rfc_medico_jv+"','"+cldia1_jv+"','"+dia1_jv+"','"+cldia2_jv+"','"+dia2_jv+"','"+clave5_jv+"','"+descri5_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+dosis_jv+"','"+tiempo_tra_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+uni_ate_jv+"','"+idm5_jv+"','"+edad_jv+"','"+sexo_jv+"','"+rec_jv+"','"+n_afi_jv+"','"+origen_jv+"','"+cedula_prof_jv+"','"+servicio_jv+"','"+status_sur_jv+"','"+cedis5_jv+"','"+cv_uni_jv+"',curdate(),curtime());");//QUERY PARA LLENAR LA TABLA CONSOLIDADO



			}

//stmt_20.execute("insert into re_"+cldia_jv+" (folcont, folio, juris, mpio, paciente, medico, rfc_medico, cldia1, dia1, cldia2, dia2, med, descr, cant_sol, cant_sur, costo, dosis, tiempo_tra, cant_costo, fecha, uni_ate, id_med, edad, sexo, rec, n_afi, origen, cedula_prof, servicio, status_sur, cedis, cv_uni) select *,curdate(),curtime() from consolidado_actualizacion where cv_uni='"+cldia_jv+"' and fecha between '"+fecha_1+"' and '"+fecha_2+"' ;"); //QUERY PARA LLENAR LAS TABLAS POR UNIDAD



//stmt_20.execute("insert into consolidado (folcont, folio, juris, mpio, paciente, medico, rfc_medico, cldia1, dia1, cldia2, dia2, med, descr, cant_sol, cant_sur, costo, dosis, tiempo_tra, cant_costo, fecha, uni_ate, id_med, edad, sexo, rec, n_afi, origen, cedula_prof, servicio, status_sur, cedis, cv_uni,curdate(),curtime()) select *,curdate(),curtime() from consolidado_actualizacion where cv_uni='"+cldia_jv+"' and fecha between '"+fecha_1+"' and '"+fecha_2+"' ;"); //QUERY PARA LLENAR LA TABLA CONSOLIDADO


}

		


				
			if (slt_jv.equals("2"))
							{
							
						//	stmt_20.execute("create table mre_"+mpio1_jv+" (select juris,mpio,med,descr,cant_sol,cant_sur,costo,cant_costo,fecha,id_med,cedis,date_i,time from consolidado_actualizacion where mpio like '%"+mpio2_jv+"%' group by MPIO) ;"); //QUERY PARA GENERAR LAS TABLAS POR MUNICIPIO POR PRIMERA VEZ
				rset_203 = stmt_2000.executeQuery("select juris,mpio,med,descr,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo,fecha,id_med,cedis from consolidado_actualizacion  where fecha between '"+fecha_1+"' and '"+fecha_2+"' and mpio='"+mpio2_jv+"' group by (mpio),med,fecha;");
				
			while(rset_203.next())
			{
			    
				juris5_jv=rset_203.getString("juris");
				mpio5_jv=rset_203.getString("mpio");
				clave5_jv=rset_203.getString("med");
				descri5_jv=rset_203.getString("descr");
				sol_jv=rset_203.getString("sol");
				sur_jv=rset_203.getString("sur");
				costo5_jv=rset_203.getString("costo");
				cant_c_jv=rset_203.getString("cant_costo");
				fecha5_jv=rset_203.getString("fecha");
				idm5_jv=rset_203.getString("id_med");
				cedis5_jv=rset_203.getString("cedis");
				
				
				stmt_20.execute("insert into mre_"+mpio1_jv+" values('"+juris5_jv+"','"+mpio5_jv+"','"+clave5_jv+"','"+descri5_jv+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+idm5_jv+"','"+cedis5_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LAS TABLAS POR MUNICIPIO
			
			}
			}
			
			
				
				/*
				if (slt_jv.equals("4"))
							{
						
		
			
			
			rset_204 = stmt_2000.executeQuery("select juris,sum(cant_sol) as sol,sum(cant_sur) as sur,costo,sum(cant_costo) as cant_costo from consolidado_actualizacion  where fecha ='"+fecha2_jv+"' and cv_uni='"+cldia_jv+"' group by (cv_uni),fecha;");
				
			while(rset_204.next())
			{
			    sol_jv=rset_204.getString("sol");
				sur_jv=rset_204.getString("sur");
				costo5_jv=rset_204.getString("costo");
				cant_c_jv=rset_204.getString("cant_costo");
			
			}
			
			rset_205 = stmt_2000.executeQuery("select juris,fecha,cedis,uni_ate,mpio from consolidado_actualizacion  where fecha ='"+fecha2_jv+"' and cv_uni='"+cldia_jv+"' group by (cv_uni),fecha;");
				
			while(rset_205.next())
			{
			fecha5_jv=rset_205.getString("fecha");
			cedis5_jv=rset_205.getString("cedis");
			mpio_jv=rset_205.getString("mpio");	
			unidad_jv=rset_205.getString("uni_ate");
			
			
			
				
				
			
				if (juris2_jv.equals("JURISDICCION SANITARIA I"))
				{
				stmt_20.execute("insert into j2_re values('"+juris5_jv+"','"+mpio_jv+"','"+cont_t+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA J2
				}
				
				
				if (juris2_jv.equals("JURISDICCION SANITARIA II"))
				{
				stmt_20.execute("insert into j4_re values('"+juris5_jv+"','"+mpio_jv+"','"+cont_t+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA J4
				}
				
				if (juris2_jv.equals("JURISDICCION SANITARIA III"))
				{
				stmt_20.execute("insert into j8_re values('"+juris5_jv+"','"+mpio_jv+"','"+cont_t+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+unidad_jv+"','"+cedis5_jv+"','"+cldia_jv+"',curdate(),curtime()) ;"); //QUERY PARA LLENAR LA TABLA J8
				}
				
			//stmt_20.execute("insert into total_rec values('"+juris5_jv+"','"+cont_t+"','"+sol_jv+"','"+sur_jv+"','"+costo5_jv+"','"+cant_c_jv+"','"+fecha5_jv+"','"+cont_sf+"','"+cont_sm+"','"+cedis5_jv+"') ;"); //QUERY PARA LLENAR LAS TABLAS POR MUNICIPIO
			
			}
			cont_t=0;
			}*/
				
						 %>
                       
                         <tr height="17">
                           <td height="17" align="right" width="137"><div align="center"><%=rset_20.getString("cv_uni")%></div>
                           <div align="center"></div></td>
                           <td width="213"><div align="left"><%=rset_20.getString("juris")%></div></td>
                           <td width="254"><%=rset_20.getString("mpio")%></td>
                           <td width="381"><%=rset_20.getString("uni_ate")%></td>
                         </tr>
                         <%
				
		 
				}
				
				%>
                <script>
				alert("DATOS GUARDADOS CORRECTAMENTE");
				</script>
                <%
				
				%>
                
				
                         <tr height="17">
                           <td height="17" valign="top">&nbsp;</td>
                           <td><div align="left"></div>
                             <a href="#ancla2">&nbsp;Ir Encabezado</a><a name="ancla1" id="ancla1"></a></td>
                           <td align="right">&nbsp;</td>
                          
                           <td>&nbsp;</td>
                         </tr>
				    
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
  <link rel="stylesheet" href="themes/base/jquery.ui.all.css">
	<script src="jquery-1.9.0.js"></script>
	<script src="ui/jquery.ui.core.js"></script>
	<script src="ui/jquery.ui.widget.js"></script>
	<script src="ui/i18n/jquery.ui.datepicker-es.js"></script>
	<script src="ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="demos.css">
	<script>
	

         
		 
	$(function() {
	
	var año1=<%=anio1_jv%>;
	var mes1=<%=mes1_jv%>;
	var dia1=<%=dia11_jv%>;
	var año2=<%=anio2_jv%>;
	var mes2=<%=mes2_jv%>;
	var dia2=<%=dia22_jv%>;
	var ft1=<%=dia11_jv%>+"/"+<%=mes1_jv%>+"/"+<%=anio1_jv%>;
	
	
	
   


	
		$( "#datepicker" ).datepicker({
			//defaultDate: "+1w",
			
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "calendar.gif",
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
			buttonImage: "calendar.gif",
			buttonImageOnly: true,
			//numberOfMonths: 1,
			minDate:new Date(año1, mes1 - 1, dia1),
			//maxDate: '+0m',
			maxDate:new Date(año2, mes2 - 1, dia2),
			//beforeShowDay: unavailable  // dias que no se van a visualizar
		});
	});
	</script>
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
