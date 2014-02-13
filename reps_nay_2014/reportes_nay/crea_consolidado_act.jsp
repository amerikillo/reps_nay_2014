<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*"
         errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss"); %>

<% java.util.Calendar currDate = new java.util.GregorianCalendar();
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn_001 = DriverManager.getConnection("jdbc:mysql://162.209.67.250/nay_re", "receta_usr", "M8KbqNjTD2");
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
    ResultSet rset_date = stmt_date.executeQuery("select folio_re, juris, mpio, nombre_pac, nombre_medi, cedula_medi, clave, descrip, cant_sol, cant_sur, aux8, fecha_re, clave_uni, id_med, edad, aux7, tipo_receta, folio_sp, partida, fuente, status_receta, unidad, precio, precio_tt  from receta");
    while (rset_date.next()) {
        String folio_re = rset_date.getString("folio_re");
        String juris = rset_date.getString("juris");
        String mpio = rset_date.getString("mpio");
        String nombre_pac = rset_date.getString("nombre_pac");
        String nombre_medi = rset_date.getString("nombre_medi");
        String cedula_medi = rset_date.getString("cedula_medi");
        String clave = rset_date.getString("clave");
        String descrip = rset_date.getString("descrip");
        String cant_sol = rset_date.getString("cant_sol");
        String cant_sur = rset_date.getString("cant_sur");
        String indicaciones = rset_date.getString("aux8");
        String fecha_re = rset_date.getString("fecha_re");
        String clave_uni = rset_date.getString("clave_uni");
        String id_med = rset_date.getString("id_med");
        String edad = rset_date.getString("edad");
        String sexo = rset_date.getString("aux7");
        String tipo_rec = rset_date.getString("tipo_receta");
        String folio_sp = rset_date.getString("folio_sp");
        String partida = rset_date.getString("partida");
        String fuente = rset_date.getString("fuente");
        String status_receta = rset_date.getString("status_receta");
        String unidad = rset_date.getString("unidad");
		String costo = rset_date.getString("precio");
		String cant_costo = rset_date.getString("precio_tt");
        if (edad.equals("-")) {
            edad = "0";
        }

        //stmt.execute("insert into consolidado_actualizacion (folio, juris, mpio, paciente, medico, rfc_medico, med, descr, cant_sol, cant_sur, costo, dosis, tiempo_tra, cant_costo, fecha, uni_ate, id_med, edad, sexo, rec, n_afi, origen, cedula_prof, servicio, status_sur, cedis, cv_uni) values ( '"+folio_re+"', '"+juris+"', '"+mpio+"', '"+nombre_pac+"', '"+nombre_medi+"', '"+cedula_medi+"', '"+clave+"', '"+descrip+"', '"+cant_sol+"', '"+cant_sur+"', '"+indicaciones+"', '"+indicaciones+"', '-', '"+fecha_re+"', '"+unidad+"', '"+id_med+"', '"+edad+"', '"+sexo+"', '"+tipo_rec+"', '"+folio_sp+"', '"+partida+"', '"+cedula_medi+"', '"+fuente+"', '"+status_receta+"', 'TEPIC', '"+clave_uni+"' ) ;");
        //out.print("insert into consolidado_actualizacion (folio, juris, mpio, paciente, medico, rfc_medico, med, descr, cant_sol, cant_sur, costo, dosis, tiempo_tra, cant_costo, fecha, uni_ate, id_med, edad, sexo, rec, n_afi, origen, cedula_prof, servicio, status_sur, cedis, cv_uni) values ( '"+folio_re+"', '"+juris+"', '"+mpio+"', '"+nombre_pac+"', '"+nombre_medi+"', '"+cedula_medi+"', '"+clave+"', '"+descrip+"', '"+cant_sol+"', '"+cant_sur+"', '"+indicaciones+"', '"+indicaciones+"', '-', '-', '"+fecha_re+"', '"+unidad+"', '"+id_med+"', '"+edad+"', '"+sexo+"', '"+tipo_rec+"', '"+folio_sp+"', '"+partida+"', '"+cedula_medi+"', '"+fuente+"', '"+status_receta+"', 'TEPIC', '"+clave_uni+"' ) ;<br>");
        stmt.execute("insert into consolidado_actualizacion (folio, juris, mpio, paciente, medico, rfc_medico, med, descr, cant_sol, cant_sur, costo, dosis, tiempo_tra, cant_costo, fecha, uni_ate, id_med, edad, sexo, rec, n_afi, origen, cedula_prof, servicio, status_sur, cedis, cv_uni) values ( '" + folio_re + "', '" + juris + "', '" + mpio + "', '" + nombre_pac + "', '" + nombre_medi + "', '" + cedula_medi + "', '" + clave + "', '" + descrip + "', '" + cant_sol + "', '" + cant_sur + "', '"+costo+"', '" + indicaciones + "', '0', '"+cant_costo+"', '" + fecha_re + "', '" + unidad + "', '" + id_med + "', '" + edad + "', '" + sexo + "', '" + tipo_rec + "', '" + folio_sp + "', '" + partida + "', '" + cedula_medi + "', '" + fuente + "', '" + status_receta + "', 'TEPIC', '" + clave_uni + "' )");
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