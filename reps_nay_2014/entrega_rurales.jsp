<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="" session = "true"%>
<%
try{
ResultSet r_fecha=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
Statement s_fecha=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
ResultSet r_consulta=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
Statement s_consulta=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
ResultSet r_consulta2=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
Statement s_consulta2=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
ResultSet r_consulta3=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
Statement s_consulta3=null; // Consulta de fecha minima y maxima de la tabla total_juris_all_actualizacion
ResultSet r_formato=null; // Cambia el formato de fecha  minima y maxima
Statement s_formato=null; // Cambia el formato de fecha minima y maxima 
Statement s_insert=null; // Inserta información hacia la tabla registro por fecha

Connection conexion=null;

String f_min="",f_max="";// Variables para extraer las valores minimo y maximo de las fecha de los txtf
String mensaje="",bt_fecha="";
String anio1_jv="",mes1_jv="",dia1_jv="",anio2_jv="",mes2_jv="",dia2_jv="",fecha_min="",fecha_max="",juris="",mpios="",unidad="",fecha="",clave="",medica="",c_sur="",c_costo="",c_reg="";//Variables para extraer lo minimo y maximo de fechas
double c_total=0.0;

    try { 
        bt_fecha=""+request.getParameter("Submit");
    }catch(Exception e){System.out.print("not");}


/*parametros para la conexion*/
    String driver = "org.gjt.mm.mysql.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";
    String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
		conexion = DriverManager.getConnection(url,usuario,pass);
		s_fecha= conexion.createStatement();
		s_consulta= conexion.createStatement();
		s_consulta2= conexion.createStatement();
		s_consulta3= conexion.createStatement();
		s_formato= conexion.createStatement();
		s_insert= conexion.createStatement();
       } catch (Exception ex){
        mensaje=ex.toString();
       }
		mensaje="conectado";
		if(conexion.isClosed()){
			mensaje="desconectado";
		}
		
r_fecha = s_fecha.executeQuery("SELECT YEAR(min(fecha)) AS anio1,MONTH(Min(fecha)) AS mes1 ,DAY(Min(fecha)) AS dia1,YEAR(MAX(fecha)) AS anio2,MONTH(MAX(fecha)) AS mes2 ,DAY(MAX(fecha)) AS dia2 FROM carga_distribuido;");
	  
	  while(r_fecha.next())
	  {
	  anio1_jv=r_fecha.getString("anio1");
	  mes1_jv=r_fecha.getString("mes1");
	  dia1_jv=r_fecha.getString("dia1");
	  anio2_jv=r_fecha.getString("anio2");
	  mes2_jv=r_fecha.getString("mes2");
	  dia2_jv=r_fecha.getString("dia2");
	  fecha_min=dia1_jv+"/"+mes1_jv+"/"+anio1_jv;
	  fecha_max=dia2_jv+"/"+mes2_jv+"/"+anio2_jv;
	  }		

	if (bt_fecha.equals("Por Fecha"))
	{
		f_min=request.getParameter("txtf_fmin");
		f_max=request.getParameter("txtf_fmax");
		
		  r_formato = s_formato.executeQuery("SELECT STR_TO_DATE('"+f_min+"', '%d/%m/%Y')"); 
          while(r_formato.next()){	
    	    f_min= r_formato.getString("STR_TO_DATE('"+f_min+"', '%d/%m/%Y')");}
			
		r_formato = s_formato.executeQuery("SELECT STR_TO_DATE('"+f_max+"', '%d/%m/%Y')"); 
	      while(r_formato.next()){	
		    f_max= r_formato.getString("STR_TO_DATE('"+f_max+"', '%d/%m/%Y')");}
	   			
	}
	
	  
			
	if (!(f_min.equals("")) && !(f_max.equals("")))
		{
		
		r_consulta = s_consulta.executeQuery("select juris,mpio,uni_ate,cv_uni,fecha from carga_distribuido where fecha between '"+f_min+"' and '"+f_max+"' group by uni_ate,fecha;");
		
		
		
		
		
		}else{
			
		r_consulta = s_consulta.executeQuery("select juris,mpio,uni_ate,cv_uni,fecha from carga_distribuido where cv_uni='0' group by uni_ate,fecha;");
		}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>:: CARGA DISTRIBUIDO ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body bgcolor="#FFFFFF">
<form action="entrega_rurales.jsp" method="post" name="form">
<table width="713" border="1">
  <tr>
    <td colspan="5" align="center">DISTRIBUIDO A Unidades</td>
    </tr>
  <tr>
    <td colspan="5">Rango de Fecha&nbsp;&nbsp;
      <input name="txtf_fmin" type="text" id="datepicker" size="10" readonly title="dd/mm/aaaa">&nbsp;Al&nbsp;<input name="txtf_fmax" type="text" id="datepicker1" size="10" readonly title="dd/mm/aaaa"><input type="submit" name="Submit" value="Por Fecha"><input type="submit" name="Submit2" value="<<Valor Inicial>>"></td>
  </tr>
  <tr>
    <td colspan="5">Periodo del&nbsp;<%=fecha_min%>&nbsp; al &nbsp;<%=fecha_max%></td>
    </tr>
  <tr>
    <td width="126">Jurisdicciones</td>
    <td width="148">Municipios</td>
    <td width="282">Unidades</td>
    <td width="50">Clave Unidad</td>
    <td width="73">Fecha Entrega</td>
  </tr>
  <%
  while (r_consulta.next())
  {
	  juris=r_consulta.getString("juris");
	  mpios=r_consulta.getString("mpio");
	  unidad=r_consulta.getString("uni_ate");
	  clave=r_consulta.getString("cv_uni");
	  fecha=r_consulta.getString("fecha");
	  
	  
	  s_insert.execute("insert into registro_surtido values(0,'"+clave+"',curdate(),'"+fecha+"');");
	  
	  r_consulta2 = s_consulta2.executeQuery("select cla_reg from registro_surtido where cla_uni='"+clave+"' and fec_sur='"+fecha+"'");
	  while(r_consulta2.next())
	   c_reg=r_consulta2.getString("cla_reg");

      r_consulta3 = s_consulta3.executeQuery("select clave,uni,costo from carga_distribuido where cv_uni='"+clave+"' and fecha='"+fecha+"'");
	  while(r_consulta3.next())
	  {
	  medica=r_consulta3.getString("clave");
	  c_sur=r_consulta3.getString("uni");
	  c_costo=r_consulta3.getString("costo");
	  c_total=Double.parseDouble(c_costo);
	 s_insert.execute("insert into entregado_trans values('"+c_reg+"','"+medica+"','"+c_sur+"','"+c_total+"',0);");
	  }
	
	  
  %>
  <tr>
    <td><%=juris%></td>
    <td><%=mpios%></td>
    <td><%=unidad%></td>
    <td><%=clave%></td>
    <td><%=fecha%></td>
  </tr>
  
 <%}%>
    <link rel="stylesheet" href="jq/themes/base/jquery.ui.all.css">
	<script src="jq/jquery-1.9.0.js"></script>
	<script src="jq/ui/jquery.ui.core.js"></script>
	<script src="jq/ui/jquery.ui.widget.js"></script>
	<script src="jq/ui/i18n/jquery.ui.datepicker-es.js"></script>
	<script src="jq/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="css/demos.css">
	<script>
	$(function() {
	
	var año1=<%=anio1_jv%>;
	var mes1=<%=mes1_jv%>;
	var dia1=<%=dia1_jv%>;
	var año2=<%=anio2_jv%>;
	var mes2=<%=mes2_jv%>;
	var dia2=<%=dia2_jv%>;
	var ft1=<%=dia1_jv%>+"/"+<%=mes1_jv%>+"/"+<%=anio1_jv%>;
	
	
		$( "#datepicker" ).datepicker({
			//defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "imagen/calendar.gif",
			buttonImageOnly: true,
			//numberOfMonths: 1,
			defaultDate: ft1,
			minDate:new Date(año1, mes1 - 1, dia1),
			//maxDate: '+0m',
			maxDate:new Date(año2, mes2 - 1, dia2)
		});
		$( "#datepicker1" ).datepicker({
			//defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "imagen/calendar.gif",
			buttonImageOnly: true,
			//numberOfMonths: 1,
			minDate:new Date(año1, mes1 - 1, dia1),
			//maxDate: '+0m',
			maxDate:new Date(año2, mes2 - 1, dia2)
		});
	});
	</script>
</table>
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
<%
} catch (Exception e) {out.println(e.getMessage());}
%>