<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
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
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
stmt3 = conexion.createStatement();
/*guardando la conexion en la session*/
} catch (Exception ex){
	mensaje=ex.toString();
}
mensaje="conectado";
if(conexion.isClosed()){
	mensaje="desconectado";
}
//---------------------------------------------------------------

String cos1="select dp.det_pro, p.cos_pro from productos p, detalle_productos dp where dp.cla_pro = p.cla_pro ";
rset = stmt.executeQuery(cos1);
while (rset.next()) {
	String cla=rset.getString(1);
	String cos=rset.getString(2);	
	
	String up="update detreceta set cos_uni = '"+cos+"' where det_pro = '"+cla+"'";
	try {
		stmt2.execute(up);
	} catch (Exception e) {out.print(up+"<br>");}
}

cos1="select fol_det, cos_uni, cant_sur from detreceta;";
rset = stmt.executeQuery(cos1);
while (rset.next()) {
	String fol =rset.getString(1);
	String cos_u=rset.getString(2);
	String cant=rset.getString(3);	
	
	Double total = Double.parseDouble(cos_u)*Double.parseDouble(cant);
	
	try {
		stmt2.execute("update detreceta set cos_tot = '"+total+"' where fol_det = '"+fol+"'");
	} catch (Exception e) {out.print("<br>");}
}



//-----------------------------------------------------------------
cos1="select bs.id_bac_sur, bs.cla_pro, bs.can_sur, p.cos_pro from back_surtido bs, productos p where bs.cla_pro = p.cla_pro ";
rset = stmt.executeQuery(cos1);
while (rset.next()) {
	String fol =rset.getString(1);
	String cla=rset.getString(2);
	String cant=rset.getString(3);
	String cos=rset.getString(4);
	
	float total = Integer.parseInt(cant)*Float.parseFloat(cos);
	try {
		stmt2.execute("update back_surtido set cos_tot = '"+total+"' where id_bac_sur = '"+fol+"'");
	} catch (Exception e) {out.print("<br>");}
}
%>