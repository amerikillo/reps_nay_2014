<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../pag_man.html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
//----------------------------------------- Driver para MySQL ---------------------------------

Class.forName("org.gjt.mm.mysql.Driver");

// ---------------------------------------- Conexión a la base de datos -----------------------
Connection conn_001 = DriverManager.getConnection("jdbc:mysql://162.209.67.250/rweb_nay","receta_usr","M8KbqNjTD2");

// ---- Objetos para dar formato a las cifras
DecimalFormat formateador = new DecimalFormat("######,###.00");
DecimalFormat formateador2 = new DecimalFormat("######,###.000");
DecimalFormat formateador3 = new DecimalFormat("###,###");

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=REPORTE N° 5.xls");

// ---- Para generar los statemant para los queries

        Statement stmt_001 = conn_001.createStatement();
        Statement stmt_002 = conn_001.createStatement();
		Statement stmt_003 = conn_001.createStatement();
		Statement stmt_004 = conn_001.createStatement();
		Statement stmt_005 = conn_001.createStatement();
		Statement stmt_006 = conn_001.createStatement();
		Statement stmt_44 = conn_001.createStatement();
        ResultSet rset_001=null;
        ResultSet rset_002=null;	
		ResultSet rset_003=null;	
		ResultSet rset_004=null;
		ResultSet rset_005=null;
		ResultSet rset_006=null;	
		ResultSet rset_77=null;		

//--- variables
double sumas=0;
int cont_reg=0;
int total_reg=0;
double costos=0.0;
int cantidad_sur=0;
int part=0;
String suma_mc="",suma_med="",precio_unit="",precio_unit_mc="",medicamento="";
int total_med=0,total_mcur=0,suma_int=0,suma_int_mc=0,suma_med_mc=0;
double total_mc=0.0,precio_uni_d=0.0,precio_uni_d_mc=0.0,total_pre=0.0,total_pre_mc=0.0,suma_total_pre=0.0,suma_total_pre_mc=0.0,subt=0.0,iva=0.0,total_g=0.0;

String reg_actual="";
		
//-------------- CREACION DE ARREGLO DE LISTA --------------------------------------------------
ArrayList lista_fol = new ArrayList(); 
ArrayList lista_fecha = new ArrayList(); 
ArrayList lista_ben = new ArrayList();
ArrayList lista_servicios = new ArrayList();
ArrayList lista_descri = new ArrayList();
ArrayList lista_present = new ArrayList();
ArrayList lista_origen = new ArrayList();
ArrayList lista_precio = new ArrayList();
ArrayList lista_cant_sur = new ArrayList();
ArrayList lista_tt = new ArrayList();
ArrayList lista_partida = new ArrayList();


//----------------------------------------------------------------------------------------------


%>
<%
/*----------------------------------------------------------------------------------------------------------------------
Nombre del Archivo:5_rep_det_folreci_pag.jsp
Fecha:16 de agosto 2012
Autor: ARD, DSL, RHW
Descripción General: Reporte No. 5 que muestra el detallado de Receta por Unidad, utilizando para su visualización la paginación
Nombre de la(s) tabla(s): Todas las U, solo las tablas de las Unidades empezando por la letra u y seguido del número de la unidad
Parámetros de la URL: rango1=fecha inicio&rango2=fecha final&programa=Tipo de Programa&servicio=Tipo de Servicio&uni=Nombre de la Unidad&receta=Tipo de Receta&ban=bandera&bd=número de la Unidad				 
  ----------------------------------------------------------------------------------------------------------------------*/
String fe1="",fe2="";

String bd_jv="";


String juris="";
String uni="";
String muni="";
String ran1="";
String ran2="";
String ran11="";
String ran22="";

String prog="";
String medi="";
String receta="";
String rep="",medic="",medic1="",medic3="",costo1="",costo2="",costotota="",ban="",serv="",precio222="",clave22_jv="",partida22_jv="",medic_mat="",costo2_mat="";
int medi1=0,medi2=0,medi3=0,cont=1800,ban_jv=0,medi1_mat=0;
double costomed=0.0,costomat=0.0,costototal=0.0,costo22=0.0,precio2222=0.0,partida222_jv=0.0,ptotal22=0.0,ptotal=0.0,ptotalt=0.0,ptotalt2=0.0,ptotalt22=0.0,pt=0.0,costomed_mat=0.0;
 double costo22_med=0.0,costo22_mat=0.0;

try { 

            ban=request.getParameter("ban");
            ban_jv=Integer.parseInt(ban);
      
           uni=request.getParameter("uni");
           ran1=request.getParameter("rango1");
		   fe1=request.getParameter("rango1");
           ran2=request.getParameter("rango2");
		   fe2=request.getParameter("rango2");
           prog=request.getParameter("programa");
           serv=request.getParameter("servicio");
           receta=request.getParameter("receta");
           ran11=request.getParameter("rango1");
           ran22=request.getParameter("rango2");
		   bd_jv=request.getParameter("bd");
           if (serv.equals("-- Seleccione Servicio --")){
           serv="";
           }
                //out.print("but ="+but);
        
    }catch(Exception e){System.out.print("not");}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>REPORTE 5</title>
        <style type="text/css">
            <!--
            .style1 {color: #FFFFFF}
            .style4 {font-size: 11px; font-family: Arial, Helvetica, sans-serif; }
            .style5 {
                color: #000099;
                font-weight: bold;
            }
            .style7 {
                color: #000099;
                font-weight: bold;
                font-family: Arial, Helvetica, sans-serif;
                font-size: 11px;
            }
.Estilo2 {color: #FFFFFF; font-weight: bold; }
.Estilo4 {font-size: 11px; font-family: Arial, Helvetica, sans-serif; font-weight: bold; }
            -->
        </style>
		<script language="javascript" type="text/javascript"> 
              //CUANDO LE DA CLIC EN SIGUIENTE SE MANDA A LLAMAR ESTA FUNCION 
                function otraVez(){ 
                document.form1.submit();
				}
				
        </script> 
		
</head>

    <body>
        <div align="left">
            <table width="1273" border="0" cellpadding="2">
                <tr>
                    <td width="1265"><p align="center"><a name="ir_arr" id="ir_arr"></a><strong>REPORTE NO. 4 - REPORTE DETALLADO POR BENEFICIARIO</strong></p>
                        <p align="center"><strong>SALIDA DE    MEDICAMENTO Y MATERIAL DE CURACI&Oacute;N</strong></p>
                      <table width="1264" border="0" cellpadding="2">
                            <tr>
                                <td colspan="5"></td>
                            </tr>
                            <tr>
                                <td colspan="5" class="style4"><div align="left">DEL &nbsp;&nbsp;<span class="style7"><%=ran1%></span>&nbsp; AL <span class="style7">&nbsp;<%=ran2%></span></div></td>
                            </tr>
                            <tr>
                                <td width="72"><div align="left"><span class="Estilo4"> PROGRAMA:</span></div></td>
                                <td colspan="2"><div align="left"><span class="style7"><%=prog%></span></div></td>
                                <td width="95"><div align="left"></div></td>
                                <td width="221"><div align="left"></div></td>
                            </tr>
                            <tr>
                                <td><div align="left"><span class="Estilo4">SERVICIO:</span></div></td>
                                <td colspan="2"><div align="left"><span class="style7"><%=serv%></span></div></td>
                                <td><div align="left"></div></td>
                                <td><div align="left"></div></td>
                            </tr>
                            <tr>
                                <td><div align="left"><span class="Estilo4">NOMBRE DE LA UNIDAD:</span></div></td>
                                <td colspan="2"><div align="left"><span class="style7"><%=uni%></span></div></td>
                                <td><div align="left"></div></td>
                                <td><div align="left"></div></td>
                            </tr>
                            
                      </table>      
<form name="form1" method="post" action=""> 
                      <table width="1433" border="1" cellpadding="0" cellspacing="0">
                            <col width="80" />
                            <col width="93" />
                            <col width="80" />
                            <col width="158" />
                            <col width="263" />
                            <col width="102" />
                            <col width="80" span="3" />
                            <tr height="21">
                              <td width="67" height="29" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">FOLIO    RECIBO ENTREGA</span></div></td>
                              <td width="48" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">FOLIO RECETA</span></div></td>
                              <td width="68" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">FECHA</span></div></td>
                              <td width="325" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">BENEFICIARIO</span></div></td>
                                <td width="462" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">ESPECIFICACION    TECNICA MEDICAMENTO/MATERIAL DE CURACI&Oacute;N</span></div></td>
                              <td width="82" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">PRESENTACION</span></div></td>
                              <td width="120" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">ORIGEN</span></div></td>
                              <td width="65" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">PRECIO UNITARIO</span></div></td>
                              <td width="84" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">CANTIDAD SURTIDA</span></div></td>
                              <td width="84" background="fndo3.jpg" bgcolor="#1C3466"><div align="center" class="style4"><span class="style1">IMPORTE</span></div></td>
                            </tr>
<%
                     NumberFormat nf1 = NumberFormat.getInstance(Locale.US);
   
  try{
//NumberFormat nf1 = NumberFormat.getInstance(Locale.US);
                      Connection conne_day = DriverManager.getConnection("jdbc:mysql://162.209.67.250/rweb_nay","receta_usr","M8KbqNjTD2");
                                                      Statement stmt_day = conne_day.createStatement();
                                       ResultSet rset_day = stmt_day.executeQuery("SELECT STR_TO_DATE('"+ran1+"', '%d/%m/%Y')"); 
                                        if(rset_day.next()){
                                        ran1= rset_day.getString("STR_TO_DATE('"+ran1+"', '%d/%m/%Y')");
                                                            }
                                   rset_day = stmt_day.executeQuery("SELECT STR_TO_DATE('"+ran2+"', '%d/%m/%Y')"); 
                                        if(rset_day.next()){
                                        ran2= rset_day.getString("STR_TO_DATE('"+ran2+"', '%d/%m/%Y')"); }
                 
if (lista_fol.isEmpty()){
//out.print("entro a la lista vacía"+total_reg);
conne_day.close();
conne_day=null;
 if(ban_jv==3)
   {
   //out.print("entro al if de ban_jv");
     if (receta.equals("RF"))
       {
	     if(prog.equals("Todos"))
                    {
                    rset_001=stmt_001.executeQuery("select id_med,fecha,nombre_pac,costo_u,uni,costo,descri,folio_re,partida,present,id_med from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"'  and tipo_receta='"+receta+"'");
					//out.print("entro al if de Todos");
					
				}else{
					rset_001=stmt_001.executeQuery("select juris,mpio,uni_ate,id_med,fecha,nombre_pac,costo_u,uni,costo,descri,folio_re,present,partida,id_med from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"' and afiliado = '"+prog+"' and tipo_receta='"+receta+"' ");
								
							}		               
	   }else if (receta.equals("RC"))
                    {
					if(serv.equals("TODOS"))
                    {
                    rset_001=stmt_001.executeQuery("select juris,mpio,uni_ate,id_med,fecha,nombre_pac,costo_u,uni,costo,descri,folio_re,partida,present,id_med,servicio from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"'  and tipo_receta='"+receta+"'");
                    }else{
                                   rset_001=stmt_001.executeQuery("select juris,mpio,uni_ate,id_med,fecha,nombre_pac,costo_u,uni,costo,descri,folio_re,present,partida,id_med,servicio from "+bd_jv+" where fecha between '"+ran1+"' and '"+ran2+"' and servicio='"+serv+"' and tipo_receta='"+receta+"'");
						}			 
					}
                }
/* stmt1 = con1.createStatement();
 
 rs1=stmt1.executeQuery("select id_med,fecha,nombre_pac,costo_u,uni,costo,descri,folio_re,partida,present,id_med from u1144 where fecha between '2012-01-01' and '2012-06-30'  and tipo_receta='RF' order by (folio_re+0)");*/
//-------------- BORRO EL CONTENIDO DE LA LISTA -------------------------------------------------
 lista_fol.clear();
 lista_fecha.clear();
 lista_ben.clear();
 lista_servicios.clear();
 lista_descri.clear();
 lista_present.clear();
 lista_origen.clear();
 lista_precio.clear();
 lista_cant_sur.clear();
 lista_tt.clear();
 lista_partida.clear(); 

//-------------- SE LLENA LA LISTA CON EL RESULTSET (rs1) ---------------------------------------
 //-------------- VARIABLE total_reg CONTIENE LA CANTIDAD TOTAL DE REGISTROS ---------------------
cont=0;
cont_reg=0;
total_reg=0;
   while (rset_001.next()) 
      {
        cont++;
        cont_reg++;
		lista_fol.add((rset_001.getString("folio_re"))); 
		lista_fecha.add((rset_001.getString("fecha")));
		lista_ben.add((rset_001.getString("nombre_pac"))); 
		lista_descri.add((rset_001.getString("descri")));
		lista_present.add((rset_001.getString("present")));
		lista_origen.add((rset_001.getString("partida")));
		lista_precio.add((rset_001.getString("costo_u")));
		lista_cant_sur.add((rset_001.getString("uni")));
		
		medicamento=rset_001.getString("id_med");
		
		//Toma por medio del if - else los que son medicamentos, caso contrario son MC
		
		if(medicamento.equals("MEDICAMENTO"))
		  {
		  //--------- rutina para calcular la suma del total del medicamento (unidades)
		  suma_med=rset_001.getString("uni");
		  suma_int=Integer.parseInt(suma_med);
		  total_med+=suma_int;
		  //-----------------------------------------------------------------
		 
		 //----------- rutina para obtener el total de las unidades por precio, origen 2 inclusive
		 precio_unit=rset_001.getString("costo_u");
		 precio_uni_d=Double.parseDouble(precio_unit);
		 total_pre=suma_int*precio_uni_d;
		 suma_total_pre=suma_total_pre+total_pre;
		 //--------------------------------------------------------------------------------------- 
		  }else {
		  //--------- rutina para calcular el valor del total de unidades del material de curación
		  suma_mc=rset_001.getString("uni");
		  suma_int_mc=Integer.parseInt(suma_mc);
		  total_mcur+=suma_int_mc;
		  //-----------------------------------------------------------------
		 
		 //----------- rutina para obtener el total de los importes calculados del MC, origen 2 inclusive
		 precio_unit_mc=rset_001.getString("costo_u");
		 precio_uni_d_mc=Double.parseDouble(precio_unit_mc);
		 total_pre_mc=suma_int_mc*precio_uni_d_mc;
		 suma_total_pre_mc=suma_total_pre_mc+total_pre_mc;
		 //--------------------------------------------------------------------------------------- 
		  
		  }//fin else
		  
		  // Para calcular el subtotal del reporte
		     subt=suma_total_pre+suma_total_pre_mc;
		  // Cálculo de IVA para MC, solo aplica al mismo
		     iva= ((suma_total_pre_mc*16) / 100);
		  // Cálculo de el total general
		    total_g=subt+iva;
			//Math.round((total_g*100.0)/100.0);	 
		  // Suma de Medicamento más MC
		    suma_med_mc=total_med+total_mcur;
			
			//out.print(""+subt+iva+total_g);
			 
		lista_partida.add((rset_001.getString("partida")));
		
		if (receta.equals("RC"))
		  {
		   lista_servicios.add((rset_001.getString("servicio")));
		  }
		//costos=Double.parseDouble(rset_001.getString("costo_u"));
		//cantidad_sur=Integer.parseInt(rset_001.getString("uni"));
        total_reg=total_reg+1; 
		
		
      } 

/* while (rs1.next()){ 
        //lista_fol.add((rs1.getString("uni"))); 
		lista_fol.add((rs1.getString("folio_re"))); 
		lista_fecha.add((rs1.getString("fecha")));
		lista_ben.add((rs1.getString("nombre_pac"))); 
        total_reg=total_reg+1; 
       }//while */
 }//if 
 // out.print("registros"+total_reg);

	   
 //----------- OBTENGO LOS REGISTROS QUE SE HAN MOSTRADO --------------------------------------------------
 //----------- LA PRIMERA VEZ QUE SE EJECUTA LA PAGINA reg_actual=0 ---------------------------------------
int regActual=0;
//out.print(reg_actual);
 reg_actual=request.getParameter("reg_actual"); 
        //out.print("regaactual: "+reg_actual);
       if (reg_actual==null || reg_actual.equals("")) 
	       { 
			reg_actual="0";
            regActual=Integer.parseInt(reg_actual);
            }
	   else
     {regActual=Integer.parseInt(reg_actual);regActual=regActual-1;}

//----------- CANTIDAD DE REGISTROS A PAGINAR 17 (n-1)-----------------------------------------------------
 int paginacion=total_reg; 

//----------- VARIABLE "HASTA" CONTROLA LA CANTIDAD DE REGISTROS QUE SE MOSTRANRAN EN PANTALLA ------------
 int hasta=regActual+paginacion; 
       if (hasta>=(total_reg-1)){ 
           hasta=total_reg-1; 
          } 

String fol="";
String fecha=""; 
String ben="";
String descri="",present="",origen="",precio_uni="",cant_sur="",importe="",partidas="",servi="";
double precios=0.0,cant_surt=0.0,tt=0.0;


                    	  
//----------- MUESTRA EL CONTENIDO DEL ARREGLO DE LISTA EN PANTALLA ----------------------------------------
 if (!lista_fol.isEmpty()){ 
if (hasta<=total_reg){ 
int renglon=1; //---- VARIABLE PARA DEFINIR EL COLOR DEL RENGLON 
for (int i=regActual; i<=hasta; i++){ //---- VACIO EL ARREGLO DE LISTA 

fol = ((String)lista_fol.get(i)); 
fecha = ((String)lista_fecha.get(i)); 
ben=((String)lista_ben.get(i));
descri=((String)lista_descri.get(i));
present=((String)lista_present.get(i));
origen=((String)lista_origen.get(i));
precio_uni=((String)lista_precio.get(i));
cant_sur=((String)lista_cant_sur.get(i));
partidas=((String)lista_partida.get(i));
if (receta.equals("RC"))
   servi= ((String)lista_servicios.get(i));

precios=Double.parseDouble(precio_uni);
cantidad_sur=Integer.parseInt(cant_sur);
//total_med=total_med+cantidad_sur;

   if(receta.equals("RC"))
	     serv=servi;

						  if (partidas.equals("1"))
						  {
						      precios=0.00;
						  }
			
			tt=precios*cantidad_sur;
			 total_mc=total_mc+tt;


if(renglon % 2 == 0){ // ---- SI ES PAR EL COLOR DEL RENGLON ES BLANCO, SI NO ES AZUL CLARO
 %> <tr class="Estilo9"> 
<td><div align="center" class="style4"><%=i+1%></div></td> 
<td><div align="center" class="style4"><%=fol%></div> </td> 
<td><div align="center" class="style4"><%=fecha%></div> </td> 
<%
   if(receta.equals("RF"))
		{
%>
<td><div class="style4"><%=ben%></div> </td>
<%
		}
		else
		   {
%>
<td><div class="style4"><%=servi%></div> </td>
 <%
								  
		  }
 %>
<td><div class="style4"><%=descri%></div> </td>
<td><div align="center" class="style4"><%=present%></div> </td>
<td><div align="center" class="style4"><%=origen%></div> </td>
<td><div align="right" class="style4"><%=precios%></div> </td>
<td><div align="center" class="style4"><%=cant_sur%></div> </td>
<td><div align="right" class="style4"><%=tt%></div> </td>
</tr> 
<% } else { // ---- SI ES IMPAR EL COLOR DEL RENGLON ES AZUL CLARO 
%> <tr class="Estilo9"> 
<td bgcolor="#EFF3FB"><div align="center" class="style4"><%=i+1%></div></td> 
<td bgcolor="#EFF3FB"><div align="center" class="style4"><%=fol%></div> </td> 
<td bgcolor="#EFF3FB"><div align="center" class="style4"><%=fecha%></div></td>
<%
   if(receta.equals("RF"))
		{
%>
<td bgcolor="#EFF3FB"><div class="style4"><%=ben%></div> </td>
<%
		}
		else
		   {
%>
<td bgcolor="#EFF3FB"><div class="style4"><%=servi%></div> </td>
 <%
								  
		  }
 %>

<td bgcolor="#EFF3FB"><div class="style4"><%=descri%></div> </td>
<td bgcolor="#EFF3FB"><div align="center" class="style4"><%=present%></div> </td>
<td bgcolor="#EFF3FB"><div align="center" class="style4"><%=origen%></div> </td>
<td bgcolor="#EFF3FB"><div align="right" class="style4"><%=precios%> </div></td>
<td bgcolor="#EFF3FB"><div align="center" class="style4"><%=cant_sur%></div> </td>
<td bgcolor="#EFF3FB"><div align="right" class="style4"><%=tt%></div> </td>
</tr> 
<% } 
renglon=renglon+1; //---- INCREMENTO LA VARIABLE 
}//for 
regActual=hasta+1;//---- CANTIDAD DE REGISTROS QUE SE MUESTRAN EN CADA CICLO 
}//if 
} 
%> <tr bgcolor="#3399FF" class="Estilo8"> 
<% if (regActual<=21){ //---- NO MUESTRA LA LEYENDA ANTERIOR 
%> <td  background="fndo3.jpg" bgcolor="#1C3466"> </td><td  background="fndo3.jpg" bgcolor="#1C3466"> </td><td  background="fndo3.jpg" bgcolor="#1C3466"> </td>
<% } else { //---- MUESTRA LA LEYENDA ANTERIOR 
%><td  background="fndo3.jpg" bgcolor="#1C3466"> </td> <td  background="fndo3.jpg" bgcolor="#1C3466"> </td> <td background="fndo3.jpg" bgcolor="#1C3466"></td>
 <% } 
 String total_regis="";
 total_regis=total_regis+total_reg;
%> <td  background="fndo3.jpg" bgcolor="#1C3466"><div align="center"><span class="Estilo2"><%=regActual%> Registros de</span> <span class="Estilo2"><%=total_regis%></span></div></td>
 <% if (total_reg!=regActual){ //---- MUESTRA LA LEYENDA SIGUIENTE Y LE DA UN SUBMIT A LA PAGINA EJECUTANDO LA FUNCION OTRAVEZ
 %> <td   background="fndo3.jpg" bgcolor="#1C3466"> </td><td  background="fndo3.jpg" bgcolor="#1C3466"> </td><td background="fndo3.jpg" bgcolor="#1C3466"> </td>
 <td background="fndo3.jpg" bgcolor="#1C3466"> </td><td background="fndo3.jpg" bgcolor="#1C3466"> </td><td background="fndo3.jpg" bgcolor="#1C3466"> </td>
 <% } else{ //---- NO MUESTRA LA LEYENDA SIGUIENTE 
%> <td  background="fndo3.jpg" bgcolor="#1C3466"> </td> <td  background="fndo3.jpg" bgcolor="#1C3466"> </td><td width="0"  background="fndo3.jpg" bgcolor="#1C3466"> </td>
 <td width="0"  background="fndo3.jpg" bgcolor="#1C3466"> </td>
 <td width="0" background="fndo3.jpg" bgcolor="#1C3466"> </td>
 
<% } 
%> </tr> 

<%
            
		//	    cont++;
          //      cont_reg++;
		  
%>
                      	
												
							
								
                              
                            <%
							
							//}
							
							//}//fin del if de la list_fol	  
							%>
                       <tr>
                         <td colspan="5" class="style7"><!--input name="reg_actual" type="text" id="reg_actual" value="<%//=regActual%>"> </td-->                                                </tr> 
								<% 
								
								
								} catch (Exception e) { 
%> <table width="585" border="0" align="center"> 
<tr> 
<td width="240" class="Estilo7"> </td> 
<td width="241" class="Estilo7"> </td> 
</tr> 
<tr> 
<td class="Estilo7"> </td> 
<td class="Estilo7"><div align="right"></div></td>
 </tr> 
<tr> 
<td class="Estilo7"> </td> 
<td class="Estilo7"> </td> 
</tr> 
<tr> 
<td colspan="2" class="Estilo7"><div align="center">Se genero un error consulte a su Administrador</div></td>
 </tr> 
<tr> 
<td colspan="2" class="Estilo7"><div align="center">Gracias<%=e%></div></td> 
</tr> 
</table> 
<% } finally { 
if (conn_001!=null) { 
rset_001.close(); 
rset_001=null; 
stmt_001.close(); 
stmt_001=null; 
conn_001.close(); 
conn_001=null; 
}//if 
}
%> 
                      </table>
					  </form>
      
<table width="806" border="1" align="right">
<tr>
    <th scope="row">&nbsp;</th>
    <th scope="row"><span class="Estilo4">PIEZAS</span></th>
    <th scope="row"><span class="Estilo4">IMPORTES</span></th>
  </tr>
  <tr height="20">
    <td width="539" height="28" background="fndo3.jpg" bgcolor="#1C3466" class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL MEDICAMENTO:</span></div></td>
    <td width="121"><div align="center" class="Estilo5"><span class="style4"><%=total_med%></span></div></td>
    <td width="124"><div align="right" class="style4 Estilo6"><strong>&nbsp;<%=formateador.format(suma_total_pre)%></strong></div></td>
  </tr>
                            <tr height="20">
                                <td height="27" background="fndo3.jpg" bgcolor="#1C3466" class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL MATERIAL DE CURACI&Oacute;N:</span></div></td>
                                <td><div align="center" class="Estilo5"><span class="style4"><%=total_mcur%></span></div></td>
                                <td><div align="right"><span class="Estilo6 style4"><strong>&nbsp;<%=formateador.format(suma_total_pre_mc)%></strong></span></div></td>
                            </tr>
                            <tr height="20">
                                <td height="28" background="fndo3.jpg" bgcolor="#1C3466" class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL OTROS (INSUMOS SOLO DESPLAZADOS):</span></div></td>
                                <td><div align="center"><span class="style4 Estilo6"><strong>0</strong></span></div></td>
                                <td><div align="right"><span class="style4 Estilo6"><strong> 0.00</strong></span></div></td>
                            </tr>
                            <tr height="20">
                                <td height="27" background="fndo3.jpg" bgcolor="#1C3466" class="style4"><div align="right" class="Estilo2"><span class="style1">SUBTOTAL:</span></div></td>
                                <td>&nbsp;</td>
                                <td><div align="right"><span class="Estilo6 style4"><strong><%=formateador.format(subt)%>
                                </strong></span></div></td>
                            </tr>
                            <tr height="20">
                                <td height="28" background="fndo3.jpg" bgcolor="#1C3466" class="style4"><div align="right" class="Estilo2"><span class="style1">IMPUESTO:</span></div></td>
                                <td>&nbsp;</td>
                                <td><div align="right"><span class="style4 Estilo6"><strong>&nbsp;<%=formateador.format(iva)%></strong></span></div></td>
                            </tr>
  <tr height="20">
                                <td height="29" background="fndo3.jpg" bgcolor="#1C3466" class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL GENERAL:</span></div></td>
    <td><div align="center" class="Estilo6"><strong><span class="style4"><%=suma_med_mc%></span></strong></div></td>
                                <td><div align="right"><span class="style4 Estilo6"><strong>$&nbsp;<strong><%=formateador.format(total_g)%></strong></strong></span></div></td>
  </tr>
</table>
        
            
             <h5 align="center">DERECHOS RESERVADOS GNKL/DESARROLLOS WEB©2012, PARA USO EXCLUSIVO DE SORIANA/SSD<br />VERSION 1.2</h5>
        <p>&nbsp;<%//=cont_reg%></p><%//out.print("ff"+total_med);%>
		<map name="Map" id="Map">
<area shape="poly" coords="241,165" href="#" />
<area shape="poly" coords="230,40,231,88,270,43" href="#" />
</map>
<script language="Javascript">
<!-- Rutina para enviar como parámetros los datos de los Totales hacia el archivo totales.jsp
function abrir(){
nueva_vent=open('totales.jsp?total_med=<%=formateador3.format(total_med)%>&precios_med=<%=formateador.format(suma_total_pre)%>&total_mcur=<%=formateador3.format(total_mcur)%>&precios_mc=<%=formateador.format(suma_total_pre_mc)%>&subt=<%=formateador.format(subt)%>&iva=<%=formateador.format(iva)%>&total_g=<%=formateador.format(total_g)%>&suma_med_mc=<%=formateador3.format(suma_med_mc)%>&uni=<%=uni%>&fe1=<%=fe1%>&fe2=<%=fe2%>','Totales','toolbar=0,status=0,location=0,directories=0,menubar=0,scrollbars=0,resize=0,width=500,height=320');
}
//-->
</script>
    </body>
</html>
