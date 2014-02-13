<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" import="java.util.Date" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%
// Conexión a la BDD
		Class.forName("org.gjt.mm.mysql.Driver");
 		Connection conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
        Statement stmt = conn.createStatement();
		ResultSet rset = null;
		Statement stmt2 = conn.createStatement();
		ResultSet rset2 = null;
		Statement stmt3 = conn.createStatement();
		ResultSet rset3 = null;
		Statement stmt4 = conn.createStatement();
		ResultSet rset4 = null;
// -----------------   

//-----------------------------------------------------------------
		String nombre_medico="", cedula_medico="", but="", mensaje_error="";
		int ban_error=0;
//-----------------------------------------------------------------

try {
    but = request.getParameter("Submit");
	if (but==null){
		but="";
	}
} catch (Exception e) {
	System.out.print("not");
}

//----LLENA VALORES DE MEDICO--------------------------------------------------------------
/*
TAMBIEN COMPARA CONTRA LO YA REGISTRADO
PARA NO CARGA MEDICOS DOBLE VEZ
*/
if (but.equals("Medicos")){
	String qry_medico = "select medico, rfc_medico from consolidado group by rfc_medico";
	rset = stmt.executeQuery(qry_medico);
	
	while (rset.next()) {
		int ban_med=0;
		nombre_medico=rset.getString("medico");
		cedula_medico=rset.getString("rfc_medico");
		
		String qry_comp_med="select nom_med from medico where cedula = '"+cedula_medico+"'";
		rset2 = stmt2.executeQuery(qry_comp_med);
		while (rset2.next()) {
			ban_med = 1;
		}
		
		if ( (!nombre_medico.equals("-")) && (ban_med==0) ){
			String qry_in_med="insert into medico (nom_med,cedula) values ('"+nombre_medico+"','"+cedula_medico+"') ";
			stmt2.execute(qry_in_med);
		}
	}
	%><script>alert ("Medicos Generados Correctamente");</script><%
}
//--------------------------------------------------------------------------------------
//----LLENA VALORES DE PACIENTE--------------------------------------------------------------
/*
TAMBIEN COMPARA CONTRA LO YA REGISTRADO
PARA NO CARGA PACIENTES DOBLE VEZ
*/

if (but.equals("Pacientes")){
	String qry_paciente = "select paciente, sexo, n_afi, servicio, edad from consolidado group by n_afi";
	rset = stmt.executeQuery(qry_paciente);
	
	
	while (rset.next()) {
		int ban_pac=0;
		String nombre_pac=rset.getString("paciente");
		String fecha_naci="0000-00-00";
		String sexo=rset.getString("sexo");
		String folio=rset.getString("n_afi");
		String programa=rset.getString("servicio");
		String f_inicio="0000-00-00";
		String f_fin="0000-00-00";
		String edad=rset.getString("edad");
		
		if (!sexo.equals("M")){
			if(!sexo.equals("F")){
				sexo = "-";
			}
		}
		
		String qry_comp_med="select nom_pac from paciente where num_afi = '"+folio+"'";
		rset2 = stmt2.executeQuery(qry_comp_med);
		while (rset2.next()) {
			ban_pac = 1;
		}
		
		if ( (!folio.equals("-")) && (ban_pac==0) ){
			String qry_in_med="insert into paciente (nom_pac, fec_nac, sexo, num_afi, tip_cob) values ('"+nombre_pac+"', '"+fecha_naci+"', '"+sexo+"', '"+folio+"', '"+programa+"') ";
			stmt2.execute(qry_in_med);
		}
		
		try{
			stmt2.execute("update paciente set ini_vig='"+f_inicio+"', fin_vig='"+f_fin+"', edad = '"+edad+"' where num_afi = '"+folio+"'");
		} catch (Exception e) {}
	}
	%><script>alert ("Pacientes generados correctamente");</script><%
}
//--------------------------------------------------------------------------------------


//----------------------PROCESO PARA LLENAR LAS TABLAS DE RECETAS--------------------------------------
if (but.equals("Llenar Recetas")) {
	String fecha1="", fecha2="";
	
	fecha1=request.getParameter("Fecha1");
	fecha2=request.getParameter("Fecha2");
	
	
	
	//out.print(qry_receta);
	
	if (!fecha1.equals("") && !fecha2.equals("")){
		
		 rset = stmt.executeQuery("SELECT STR_TO_DATE('"+fecha1+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
         while(rset.next())
		 {
         	fecha1= rset.getString("STR_TO_DATE('"+fecha1+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		 }
		 
		 rset = stmt.executeQuery("SELECT STR_TO_DATE('"+fecha2+"', '%d/%m/%Y')"); //;SELECT STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
         while(rset.next())
		 {
         	fecha2= rset.getString("STR_TO_DATE('"+fecha2+"', '%d/%m/%Y')");//STR_TO_DATE('"+date_jv+"', '%d/%m/%Y')
		 }
		
		String qry_receta="SELECT LTRIM(FOLIO),cv_uni, N_AFI,CEDULA_PROF,  REC FROM consolidado where fecha between '"+fecha1+"' and '"+fecha2+"' GROUP BY FOLIO, REC, cv_uni";
		rset = stmt.executeQuery(qry_receta);
		
		while (rset.next()) {
			//out.print("1");
			int ban_rec=0;
			String folio = rset.getString(1);
			String cv_uni = rset.getString(2);
			String num_afi = rset.getString(3);
			String cedula = rset.getString(4);
			String tipo_rec = rset.getString(5);
			String cla_pac="0", cla_med="0";
			//out.print(folio+"___"+cv_uni+"_"+num_afi+"_"+cedula+"_"+tipo_rec+"_"+cla_pac+"_"+cla_med+"<br>");
			try{
				//out.print("2");
				
				//out.print("Numero de cedula: " +cedula);
				//------------------PROCESO PARA CARGAR INFORMACION DE RECETA DE FARMACIA------------------------------------------
				if (tipo_rec.equals("RF")){
					//out.print("3");
					int ban_folio=0, ban_pac=0, ban_med=0, ban_cvuni=0;
					
					if (cv_uni==null||cv_uni.equals("null")){
						ban_cvuni=1;
						mensaje_error=mensaje_error+"Error al cargar folio:"+folio+" unidad "+ cv_uni+" tipo de receta "+tipo_rec+" numero de afiliacion "+num_afi+" cedula "+cedula+" Error en clave_unidad " +cv_uni+"---"+"<br>";
					}
					
					String qry_pac="select cla_pac from paciente where num_afi = '"+num_afi+"'";
					rset2 = stmt2.executeQuery(qry_pac);
					while (rset2.next()) {
						cla_pac = rset2.getString(1);
						if (cla_pac.equals("")||cla_pac==null){
							cla_pac="0";
						}
					}
					if (cla_pac.equals("0")){
						ban_pac=1;
						
						mensaje_error=mensaje_error+"Error al cargar folio:"+folio+" unidad "+ cv_uni+" tipo de receta "+tipo_rec+" numero de afiliacion "+num_afi+" cedula "+cedula+" Error en paciente no valido " +num_afi+""+"<br>";
					}
					
					String qry_med="select cla_med from medico where cedula = '"+cedula+"'";
					rset2 = stmt2.executeQuery(qry_med);
					while (rset2.next()) {
						cla_med = rset2.getString(1);
						if (cla_med.equals("")||cla_med==null){
							cla_med="0";
						}
					}
					if (cla_med.equals("0")){
						ban_med=1;
						
						mensaje_error=mensaje_error+"Error al cargar folio:"+folio+" unidad "+ cv_uni+" tipo de receta "+tipo_rec+" numero de afiliacion "+num_afi+" cedula "+cedula+" Error en medico no valido " +cedula+"---"+"<br>";
					}
					
					if (!num_afi.equals("-")){
						String qry_fol="select fol_rec from receta where BINARY fol_rec = '"+folio+"'";
						rset2 = stmt2.executeQuery(qry_fol);
						while (rset2.next()) {
							ban_folio=1;
						}
					}
					
					//if (ban_folio==1 || ban_med==1 || ban_pac==1 || ban_cvuni==1){
						//out.print("Error en folio: "+folio+"---"+cv_uni+"---"+cla_pac+"---"+cla_med+"<br>");
						//out.print("Error: "+ban_folio+"---"+ban_med+"---"+ban_pac+"---"+ban_cvuni+"<br>");
					//} else {
					String qry_revrec="select id_rec from receta where fol_rec= '"+folio+"' and cla_uni = '"+cv_uni+"' and tip_rec = '"+tipo_rec+"'";
					rset2 = stmt2.executeQuery(qry_revrec);
					while (rset2.next()) {
						ban_rec=1;
					}
					
					if (ban_rec == 0){	
						if (folio!=null && !folio.equals("")){
							String qry_inserta_receta="insert into receta (fol_rec, cla_uni, cla_pac, cla_med, tip_rec) values ('"+folio+"', '"+cv_uni+"', '"+cla_pac+"', '"+cla_med+"', '"+tipo_rec+"')";
							//try {
								//out.print(qry_inserta_receta);
							stmt2.execute(qry_inserta_receta);
							String qry_id="select max(id_rec) from receta";
							String id_rec="";
							rset2 = stmt2.executeQuery(qry_id);
							while (rset2.next()) {
								id_rec = rset2.getString(1);
							}
							stmt2.execute("insert into bitacora values ('0', '"+id_rec+"', '"+df.format(new java.util.Date())+"')");
							//} catch (Exception e) {/*out.print("Error con folio: "+folio);*/}
							//out.print("Correcto_"+folio);
						}
					}
				}
				if (tipo_rec.equals("RC")){
					//out.print("3");
					int ban_folio=0, ban_pac=0, ban_med=0, ban_cvuni=0;
					
					if (cv_uni==null||cv_uni.equals("null")){
						ban_cvuni=1;
					}
					
					String qry_pac="select cla_pac from paciente where num_afi = '-'";
					rset2 = stmt2.executeQuery(qry_pac);
					while (rset2.next()) {
						cla_pac = rset2.getString(1);
						if (cla_pac.equals("")||cla_pac==null){
							cla_pac="0";
						}
					}
					if (cla_pac.equals("0")){
						ban_pac=1;
					}
					
					String qry_med="select cla_med from medico where cedula = '-'";
					rset2 = stmt2.executeQuery(qry_med);
					while (rset2.next()) {
						cla_med = rset2.getString(1);
						if (cla_med.equals("")||cla_med==null){
							cla_med="0";
						}
					}
					
					if (!num_afi.equals("-")){
						String qry_fol="select fol_rec from receta where BINARY fol_rec = '"+folio+"'";
						rset2 = stmt2.executeQuery(qry_fol);
						while (rset2.next()) {
							ban_folio=1;
						}
					}
					
					String qry_revrec="select id_rec from receta where fol_rec= '"+folio+"' and cla_uni = '"+cv_uni+"' and tip_rec = '"+tipo_rec+"'";
					rset2 = stmt2.executeQuery(qry_revrec);
					while (rset2.next()) {
						ban_rec=1;
					}
					if (ban_rec == 0){	
						if (folio!=null && !folio.equals("")){
							String qry_inserta_receta="insert into receta (fol_rec, cla_uni, cla_pac, cla_med, tip_rec) values ('"+folio+"', '"+cv_uni+"', '"+cla_pac+"', '"+cla_med+"', '"+tipo_rec+"')";
							//out.print(qry_inserta_receta);
							stmt2.execute(qry_inserta_receta);
							String qry_id="select max(id_rec) from receta";
							String id_rec="";
							rset2 = stmt2.executeQuery(qry_id);
							while (rset2.next()) {
								id_rec = rset2.getString(1);
							}
							stmt2.execute("insert into bitacora values ('0', '"+id_rec+"', '"+df.format(new java.util.Date())+"')");
						}
					}
				}
			} catch (Exception e) { } 
		}
		
		
		String qry_cons="select r.fol_rec, dp.det_pro, c.cant_sol, c.cant_sur, c.cant_costo, c.fecha, c.status_sur,  r.id_rec, c.costo FROM receta r, detalle_productos dp, consolidado c where  LTRIM(r.fol_rec)=LTRIM(c.folio) and r.cla_uni = c.cv_uni and r.tip_rec = c.rec AND dp.cad_pro = '-' AND dp.lot_pro = '-' AND dp.cla_pro = c.med and c.fecha between '"+fecha1+"' and '"+fecha2+"'";
		rset = stmt.executeQuery(qry_cons);
		while (rset.next()) {
			String fol_rec = rset.getString(1);
			String det_pro = rset.getString(2);
			String cant_sol = rset.getString(3);
			String cant_sur = rset.getString(4);
			String cant_costo = rset.getString(5);
			String fecha = rset.getString(6);
			String fol_pac="-", ced_med="-";
			
			String sta_det = rset.getString(7);
			String sta_det_num="0";
			if(sta_det.equals("SURTIDO COMPLETO")){
				sta_det_num="1";
			}
			
			String id_rec = rset.getString(8);
			String costo = rset.getString(9);
			String qry_insreceta="insert into detreceta values ( '0', '"+det_pro+"', '"+cant_sol+"', '"+cant_sur+"', '"+costo+"', '1', '"+fecha+"', '"+cant_costo+"', '"+sta_det_num+"', '"+id_rec+"', '08:00:00' )";
			try{
				stmt2.execute(qry_insreceta);
			} catch (Exception e) {out.print("<br>Error al insertar: "+qry_insreceta);}
			
		}
		 %><script>alert("Carga Finalizada");</script><%	
	} else {
		%><script>alert("Fechas no Validas");</script><%
	}
}

//---------------------------------------------------------------------------------------------------------


%>
-
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>:: Llenado de la Receta Normalizada ::</title>
    <script language="javascript" src="js/scw.js"></script>
    <style type="text/css">
    a {
	font-family: Verdana, Geneva, sans-serif;
}
    body,td,th {
	font-family: Verdana, Geneva, sans-serif;
}
    body {
	background-color: #ECF2FF;
}
    </style>
	</head>

	<body>
    	<div style="width:800px; margin:auto; background-color:FFFFFF; padding:20px;">
            <form action="" method="post">
                <h1>Obtención de Información de la Receta Electrónica</h1>
                <div style="width:auto; height:10px; background-color:#57A3F7"></div>
                <table width="787" border="0" align="center">
                  <tr>
                    <td width="231">Obtener los Médicos:</td>
                    <td width="247"><input type="submit" name="Submit" value="Medicos" /></td>
                    <td width="158">&nbsp;</td>
                    <td width="133">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>Obtener los Pacientes:</td>
                    <td><input type="submit" name="Submit" value="Pacientes" /></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2"><p>Seleccione el rango de fechas para obtener la información de la Receta:</p></td>
                    <td colspan="2">del 
                      <label for="Fecha1"></label>
                    <input type="text" name="Fecha1" id="Fecha1" readonly size="7" /><img src="imagen/cal.gif" width="16" height="16" border="0" onClick="scwShow(scwID('Fecha1'), event)" />
                    al 
                    <label for="Fecha2"></label>
                    <input type="text" name="Fecha2" id="Fecha2" readonly size="7" /><img src="imagen/cal.gif" width="16" height="16" border="0" onClick="scwShow(scwID('Fecha2'), event)" /></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><input type="submit" name="Submit" value="Llenar Recetas" /></td>
                    <td>&nbsp;</td>
                  </tr>
                
              </table>
                <p>&nbsp;</p>
            </form>
        </div>
    <div style="font-family:'Courier New', Courier, monospace; font-size:12px;">
   	<p><%=mensaje_error%></p>
    </div>
	</body>
</html>

<%
conn.close();
%>