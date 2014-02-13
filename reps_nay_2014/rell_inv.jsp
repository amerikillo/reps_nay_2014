<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" import="java.util.Date" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%
// Conexión a la BDD
		Class.forName("org.gjt.mm.mysql.Driver");
 		Connection conn = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
		Connection conn2 = DriverManager.getConnection("jdbc:mysql://162.209.67.250/receta_electronica","receta_usr","M8KbqNjTD2");
        Statement stmt = conn.createStatement();
		ResultSet rset = null;
		Statement stmt2 = conn2.createStatement();
		ResultSet rset2 = null;
		Statement stmt3 = conn.createStatement();
		ResultSet rset3 = null;
// -----------------   

//-----------------------------------------------------------------
		String unidad="", cla_pro="", lote="", cad="", cant="", fec_ela="", but="", mensaje_error="", det_pro="";
		int ban_error=0;
//-----------------------------------------------------------------



//----LLENA VALORES DE MEDICO--------------------------------------------------------------
/*
TAMBIEN COMPARA CONTRA LO YA REGISTRADO
PARA NO CARGA MEDICOS DOBLE VEZ
*/
	String qry_inv = "select * from carga_inventarios";
	rset = stmt.executeQuery(qry_inv);
	
	while (rset.next()) {
		unidad=rset.getString(1);
		cla_pro=rset.getString(2);	
		lote=rset.getString(3);	
		cad=rset.getString(4);	
		cant=rset.getString(5);
		fec_ela=rset.getString(6);
		
		String qry_det_prod="select det_pro from detalle_productos where cla_pro = '"+cla_pro+"' and lot_pro = '"+lote+"' and cad_pro = '"+cad+"' limit 0,1";
		//out.print(qry_det_prod+"<br>");
		
		try{
		rset2 = stmt2.executeQuery(qry_det_prod);
		while (rset2.next()) {
			det_pro=rset2.getString(1);
		}
		} catch (Exception e) {out.print(qry_det_prod+"<br>");}
		
		String qry_ins_inv="insert into inventarios_rurales values ('"+fec_ela+"','"+unidad+"','"+det_pro+"','"+cant+"','0')";
		//out.print(qry_ins_inv+"<br>");
		try{
			stmt2.execute(qry_ins_inv);
		} catch (Exception e) {out.print(qry_ins_inv+"<br>");}
	}
	
//--------------------------------------------------------------------------------------
%>

<%
conn.close();
%>