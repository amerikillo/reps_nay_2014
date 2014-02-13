**<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*"
         errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss"); %>

<% java.util.Calendar currDate = new java.util.GregorianCalendar();
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn_001 = DriverManager.getConnection("jdbc:mysql://162.209.67.250/r_nay_disp", "receta_usr", "M8KbqNjTD2");
    // add 1 to month because Calendar's months start at 0, not 1
/*----------------------------------------------------------------------------------------------------------------------
Nombre del Archivo: elim_folio.jsp
------------------------------------------------------------------------------------------------------------------------*/
    ResultSet rset = null;
    ResultSet rset_re = null;
    Statement stmt = null;
    Statement stmt_re = null;
    Statement stmt1 = null;
    String mensaje = "";
    stmt = conn_001.createStatement();
    stmt1 = conn_001.createStatement();
    stmt_re = conn_001.createStatement();

    Statement stmt_date = conn_001.createStatement();
    ResultSet rset_date = stmt_date.executeQuery("select fecha_re, juris, unidad, clave, descrip, cant_sur, clave_uni, id_med, precio_tt, mpio from receta;");
    while (rset_date.next()) {
        String fecha = rset_date.getString("fecha_re");
        String juris = rset_date.getString("juris");
        String unidad = rset_date.getString("unidad");
        String clave = rset_date.getString("clave");
        String descrip = rset_date.getString("descrip");
        String cant_sur = rset_date.getString("cant_sur");
        String clave_uni = rset_date.getString("clave_uni");
        String id_med = rset_date.getString("id_med");
        String precio = rset_date.getString("precio_tt");
        String mpio = rset_date.getString("mpio");


        stmt.execute("insert into total_juris_all_actualizacion values ( '" + juris + "', '" + mpio + "', '" + id_med + "', '" + unidad + "', '" + fecha + "', '" + clave + "', '" + descrip + "', '" + cant_sur + "', '" + precio + "', 'NAYARIT', '" + clave_uni + "' ) ;");
    }


//stmt1.execute(qry_col);

%>

<%
    // ----- try que cierra la conexión a la base de datos
    try {
        // Se cierra la conexión dentro del try
        conn_001.close();
    } catch (Exception e) {
        mensaje = e.toString();
    } finally {
        if (conn_001 != null) {
            conn_001.close();
            if (conn_001.isClosed()) {
                mensaje = "desconectado2";
            }
        }
    }
    //out.print(mensaje);
    // ---- fin de la conexión

%>
</html>