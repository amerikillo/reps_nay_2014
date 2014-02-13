<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true" import="java.util.Calendar" import="java.util.Date" import="java.text.DateFormat" import="java.text.DecimalFormat"import="java.util.Locale" import="java.text.NumberFormat" import="java.text.DecimalFormatSymbols"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat sdf = new java.text.SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy"); %>
<%NumberFormat forma= NumberFormat.getInstance(Locale.US); %>
<%
DecimalFormatSymbols simbolos = new DecimalFormatSymbols();
simbolos.setDecimalSeparator('.');
simbolos.setGroupingSeparator(',');
DecimalFormat forma2= new DecimalFormat("##,###.##", simbolos);
%>
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

ResultSet rset4=null;
Statement stmt4 = null;
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
stmt3 = conexion.createStatement();
stmt4 = conexion.createStatement();
/*guardando la conexion en la session*/
} catch (Exception ex){
	mensaje=ex.toString();
}
mensaje="conectado";
if(conexion.isClosed()){
	mensaje="desconectado";
}
//--------------OBTENCION DEL BOTON-----------------
String boton="";
try { 
     boton=""+request.getParameter("Submit");
}catch(Exception e){}

//---------PROCESO DE FECHAS----------------------------------
String f1_cr="", f2_cr="";
String f1_mos="";
String f2_mos="";
 Calendar calendar = Calendar.getInstance();
 Calendar calendar2 = Calendar.getInstance();
calendar.add(Calendar.DATE, -15);
String fecha1 = "" + df.format(calendar.getTime());
String fecha2 = "" + df.format(calendar2.getTime());
String d = "0";
int dias = 0;

//fecha1= "2013-03-27";

String qry_fechas1 = "select max(fec_sur) from detreceta group by fec_sur order by fec_sur asc";
rset2 = stmt2.executeQuery(qry_fechas1);
while(rset2.next()){
	fecha2 = rset2.getString(1);
}
calendar.setTime(df.parse(fecha2));
calendar.add(Calendar.DATE, -7);
fecha1 = "" + df.format(calendar.getTime());


if(boton.equals("Filtrar")){
	f1_cr=""+request.getParameter("fecha1");
	f2_cr=""+request.getParameter("fecha2");
	
	fecha1 = "" + df.format(df2.parse(f1_cr));
	fecha2 = "" + df.format(df2.parse(f2_cr));
}

f1_mos = "" + df2.format(df.parse(fecha1));
f2_mos = "" + df2.format(df.parse(fecha2));


String cant_sol="0", cant_sur="0", cant_nosur="0", recetas_tot="0", recetas_par="0", porcentaje="0", fecha=""; 
String cant_sol_col="0", cant_sur_col="0", cant_nosur_col="0", recetas_tot_col="0", recetas_par_col="0", porcentaje_col="0", fecha_col=""; 
int sol=0, sur=0, dif=0, sol_col=0, sur_col=0, dif_col=0, total_sol=0, total_sur=0, i=1, ancho=0;
//-------------------------------------------

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit SAVI - GNKL</title>
<link href="../css/reporte_sem.css" rel="stylesheet" type="text/css" />
<script src="../js/scw.js" type="text/javascript"> </script>
</head>

<body bgcolor="#FCFCFC">
<div style="font-family:'Times New Roman', Times, serif;  background-color:#FFF; padding:15;"><div style="float:right"><img src="../imagen/ima_main.jpg" /></div>
<h1>REPORTE: NIVEL DE SERVICIO</h1> <h3>(Recetas al 100 % contra Recetas Parciales)</h3> <h3>Receta Colectiva</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp; <a href="menu_rec_sur.jsp" class="banda">Regresar</a> </div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
<div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif">
  <div class="tit_tablas">
    <form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     <a href="recetas_surtidas/gnr_rec_sur_rc.jsp?fecha1=<%=f1_mos%>&fecha2=<%=f2_mos%>&Submit=Filtrar"><img src="../imagen/exc.jpg" width="69" height="50" alt="Exportar a Excel" /></a>
    </form>
    </div>
 <br /><br />
    <div class="tit_tablas">
	
    <%
	String qry_unidades = "SELECT des_uni, sum(cos) as cos from total_dispensado group by des_uni order by cos desc ;";
	rset4 = stmt4.executeQuery(qry_unidades);
	while(rset4.next()){
		String unidad = rset4.getString(1);
	%>
    <h3>Unidad: <%=unidad%></h3>
    
    <table>
    	<tr>
        	<td>
            	<table border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
                	<tr>
                    	<td width="134">
                        Fecha
                        </td>
                    </tr>
                    <tr>
                    	<td>
                        Pzs Solicitadas
                        </td>
                    </tr>
                    <tr>
                    	<td>
                        Pzs no Surtidas
                        </td>
                    </tr>
                    <tr>
                    	<td>
                        Claves Solicitadas
                        </td>
                    </tr>
                    <tr>
                    	<td>
                        Claves No Sur.
                        </td>
                    </tr>
                    <tr>
                    	<td>
                        Recetas Sol.
                        </td>
                    </tr>
                    <tr>
                    	<td>
                        Rec 100 / Rec Par.</td>
                    </tr>
                    <tr>
                      <td>Porcentaje</td>
                    </tr>
                    <tr>
                      <td>Pzs Vendidas</td>
                    </tr>
                    <tr>
                      <td>Importe Ventas</td>
                    </tr>
                </table>
            </td>
            <td>
                 <table border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
                    <%
					
                    try{
                    %>
                    <tr>
                    <%
                    String qry_fecha="select fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
                    rset = stmt.executeQuery(qry_fecha); 
                    while(rset.next())
                    {
                        fecha=df2.format(df.parse(rset.getString("fec_sur"))); 
                        %>
                        <td style="width:auto"><%=fecha%></td>
                        <%
                    }
                    %>
                    <td><strong>Totales</strong></td>
                    </tr>
                    <%
                    String qry_pzsol="select sum(can_sol) as sol, bi.fec_carga from receta r, detreceta dr, usuarios us, unidades un, bitacora bi where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by DAY(fec_carga) ;";
            //String qry_pzsol="select sum(can_sol) as sol, fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' and  group by fec_sur";
                    %>
                    <tr>
                    <%
                    int total_pzs_sol=0;
                    rset = stmt.executeQuery(qry_pzsol); 
                    while(rset.next())
                    {
                      cant_sol=rset.getString("sol");
                      fecha=rset.getString("fec_carga");
                      sol = Integer.parseInt(cant_sol);
                      total_sol=sol;
                      total_pzs_sol += total_sol;
                      %>
                      <td style="text-align: right"><%=total_sol%></td>
                      <%
                    }
                    %>
                    <td style="text-align: right"><strong><%=total_pzs_sol%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    <%
                    try{
                    %>
                    <%
                    String qry_pzsur="select sum(can_sol) as sol, sum(cant_sur) as sur, bi.fec_carga from receta r, detreceta dr, bitacora bi, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by DAY(fec_carga) ;";
                    %>
                    <tr>
                    <%
                    int total_pzs_no_sur=0;
                    rset = stmt.executeQuery(qry_pzsur); 
                    while(rset.next())
                    {
                        cant_sol=rset.getString("sol"); 
                        cant_sur=rset.getString("sur"); 
                        fecha=rset.getString("fec_carga"); 
                        sol=Integer.parseInt(cant_sol);
                        sur=Integer.parseInt(cant_sur);
                        dif=sol-sur;
                        
                        total_sol=dif;
                        
                    %>
                    <td style="text-align: right"><%=total_sol%></td>
                    <%
                    total_pzs_no_sur += total_sol;
                    }
                    %>
                    <td style="text-align: right"><strong><%=total_pzs_no_sur%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    
                    <%
                    try{
                    %>
                    <tr>
                    <%
                    int tot_clavez_sol=0, total_cla_sol_c=0;
                    String qry_cant_pzs="select fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
                    rset = stmt.executeQuery(qry_cant_pzs); 
                    while(rset.next())
                    {
                        fecha=rset.getString("fec_sur");
                        int cont = 0, cont2=0;
                        String qry_clasur="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59'  and r.id_tip='2'group by DAY(fec_carga), dp.cla_pro ;";
                        rset2 = stmt2.executeQuery(qry_clasur); 
                        while(rset2.next()){
                            cont++;
                        }
                        %>
                        <td style="text-align: right">
                        <%=cont+cont2%>
                        </td>
                        <%
                    }
                    
                    String qry_cant_pzsf="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by dp.cla_pro ;";
                    rset = stmt.executeQuery(qry_cant_pzsf); 
                    while(rset.next()){
                        tot_clavez_sol++;
                    }
                    
                    int total_cla_soli=tot_clavez_sol;
                    %>
                    
                    <td style="text-align: right"><strong><%=total_cla_soli%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    <%
                    try{
                    %>
                    <tr>
                    <%
                    int total_cla_no_sur=0, cont_nosur=0, cont4=0;
                    String qry_cant_pzs1="select fec_sur from detreceta where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
                    rset = stmt.executeQuery(qry_cant_pzs1); 
                    while(rset.next())
                    {
                        fecha=rset.getString("fec_sur");
                        int cont = 0, cont2=0, tot=0, cont3=0, cont5=0;
                        String qry_clasur="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and dr.status=0 and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.id_tip='2' group by DAY(fec_carga), dp.cla_pro ;";
                        rset2 = stmt2.executeQuery(qry_clasur); 
                        while(rset2.next()){
                            cont++;
                        }
                        
                        
                        tot = (cont+cont5);
                        %>
                        <td style="text-align: right">
                        <%=tot%>
                       
                        </td>
                        <%
                        //total_cla_no_sur += tot;
                        //cont_nosur++;
                    }
                    int tot_clavez_nsol1=0, total_cla_nsol_c=0;
                    String qry_cant_pzsnf="select dp.cla_pro from receta r, detreceta dr, bitacora bi, detalle_productos dp, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and dr.status=0 and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND dr.det_pro = dp.det_pro and bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by dp.cla_pro ;";
                    rset = stmt.executeQuery(qry_cant_pzsnf); 
                    while(rset.next()){
                        tot_clavez_nsol1++;
                    }
                    
                    int total_cla_nos=tot_clavez_nsol1+total_cla_nsol_c;
                    %>
                    <td style="text-align: right"><strong><%=total_cla_nos%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    
                    
                    
                    <%
                    try{
                    %>
                    <%
                    String qry_tot_rece="select fec_sur from detreceta  where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
                    %>
                    <tr>
                    <%
                    int tot_rec_sol = 0;
                    rset = stmt.executeQuery(qry_tot_rece); 
                    while(rset.next()){
                        fecha=rset.getString("fec_sur"); 
                        int tot_folios=0;
                        String qry_pzsur_col="select r.id_rec from bitacora bi, receta r, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and bi.fec_carga between '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.baja = '0' and r.id_rec = bi.id_rec and r.id_tip='2' group by id_rec";
                        rset2 = stmt2.executeQuery(qry_pzsur_col); 
                        while(rset2.next()){
                            tot_folios++;
                        }
                    %>
                    <td style="text-align: right"><%=tot_folios%></td>
                    <%
                        tot_rec_sol+=tot_folios;
                    }
                    %>
                    
                    <td style="text-align: right"><strong><%=tot_rec_sol%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                   
                   
                    <%
                    try{
                    %>
                    <%
                    String qry_sur="select fec_sur from detreceta  where fec_sur BETWEEN '"+fecha1+"' AND '"+fecha2+"' group by fec_sur";
                    %>
                    <tr>
                    <%
                    int tot_rec_100 = 0, tot_rec_par= 0;
                    rset = stmt.executeQuery(qry_sur); 
                    while(rset.next())
                    {
                        int r_rf=0, r_no=0, r_parcial=0;
                        fecha=rset.getString("fec_sur"); 
                        
                        String qry_surno="select r.id_rec from bitacora bi, receta r, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and bi.fec_carga between '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.baja = '0' and r.id_rec = bi.id_rec and r.id_tip='2' group by id_rec";
                        rset2 = stmt2.executeQuery(qry_surno); 
                        while(rset2.next()){
                            r_rf++;
                        }
                    
                    
                        qry_surno="select r.id_rec from bitacora bi, receta r, detreceta dr, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and dr.status='0' and r.baja='0'  and bi.fec_carga between '"+fecha+" 00:00:01' and '"+fecha+" 23:59:59' and r.id_rec = bi.id_rec and r.id_tip='2' group by id_rec";
                        rset2 = stmt2.executeQuery(qry_surno); 
                        while(rset2.next()){
                            r_no++;
                        }
                    
                        r_parcial= r_rf - r_no;
                    %>
                    <td style="text-align: right"><%=r_parcial%> / <%=r_no%></td>
                    <%
                        tot_rec_100+=r_parcial;
                        tot_rec_par+=r_no;
                    }
                    %>
                    <td style="text-align: right"><strong><%=(tot_rec_100)%>/<%=tot_rec_par%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    
                    
                    <%
                    try{
                    %>
                    <%
                    String qry_por="select sum(can_sol) as sol, sum(cant_sur) as sur, bi.fec_carga from receta r, detreceta dr, bitacora bi, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by DAY(fec_carga) ;";
                    %>
                    <tr>
                    <%
                    int c_dias=0;
                    float total_por=0;
                    rset = stmt.executeQuery(qry_por); 
                    while(rset.next())
                    {
                        cant_sol=rset.getString("sol"); 
                        cant_sur=rset.getString("sur"); 
                        fecha=rset.getString("fec_carga"); 
                        
                        if (cant_sol_col==null)
                        cant_sol_col="0";
                        
                        if (cant_sur_col==null)
                        cant_sur_col="0";
                        
                        float sol_d=Integer.parseInt(cant_sol);
                        float sur_d=Integer.parseInt(cant_sur);
                        float sol_d_col=Integer.parseInt(cant_sol_col);
                        float sur_d_col=Integer.parseInt(cant_sur_col);
                        
                        float tot_f=((sur_d+sur_d_col)*100)/(sol_d+sol_d_col);
                        
                        %>
                        <td style="text-align: right"><%=tot_f%> %</td>
                        <%
                        c_dias++;
                        total_por += tot_f;
                    }	
                    float tot_porc = 0;
                    if ( c_dias == 0){
                        tot_porc = 0;
                    } else {
                        tot_porc = (total_por/c_dias);
                    }
                    
                    %>
                    <td style="text-align: right"><strong><%=tot_porc%> %</strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    
                    <%
                    try{
                    %>
                    <tr>
                    <%
                    int tot_pzs_sol=0;
                    String qry_fecha1="select sum(cant_sur) as sur, bi.fec_carga from receta r, detreceta dr, bitacora bi, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and r.id_rec = dr.id_rec and  r.id_rec = bi.id_rec AND bi.fec_carga BETWEEN '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by DAY(fec_carga) ;";
                    rset = stmt.executeQuery(qry_fecha1); 
                    while(rset.next())
                    {
                      cant_sol=rset.getString("sur");
                      fecha=rset.getString("fec_carga");
                      
                      if (cant_sol_col==null){
                        cant_sol_col="0";
                      }
                      sol = Integer.parseInt(cant_sol);
                      sol_col=Integer.parseInt(cant_sol_col);
                      total_sol=sol+sol_col;
                      %>
                      <td style="text-align: right"><%=total_sol%></td>
                      <%
                      tot_pzs_sol += total_sol;
                    }
                    %>
                    <td style="text-align: right"><strong><%=tot_pzs_sol%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
                    %>
                    
                    
                    
                    <%
                    try{
                    %>
                    <tr>
                    <%
                    float tot_ventas=0;
                    String qry_fecha2="SELECT p.cos_pro, dr.cant_sur, sum(p.cos_pro * dr.cant_sur) as sum FROM detreceta dr, detalle_productos dp, productos p, receta r, bitacora bi, usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = r.id_usu and un.des_uni = '"+unidad+"' and dr.id_rec = r.id_rec and r.id_rec = bi.id_rec and dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro and bi.fec_carga between '"+fecha1+" 00:00:01' and '"+fecha2+" 23:59:59' and r.id_tip='2' group by DAY(bi.fec_carga) asc;";
                    rset = stmt.executeQuery(qry_fecha2); 
                    while(rset.next())
                    {
                      float precio = Float.parseFloat(rset.getString("sum"));
                      %>
                      <td style="text-align: right">$ <%=forma.format(precio)%></td>
                      <%
                      tot_ventas += precio;
                    }
                    %>
                    <td style="text-align: right"><strong>$ <%=forma.format(tot_ventas)%></strong></td>
                    </tr>
                    <%
                    } catch(Exception e){
                        out.println(e.getMessage());
                    }
					
                    %>
                    
                  </table>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <%
	}
	%>
    </div>
</div>
</body>
</html>

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