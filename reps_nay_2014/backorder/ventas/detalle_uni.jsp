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
<script>self.location='../../reportes_nay/index.jsp';</script>
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
/*procedimiento de la conexion*/
 try{
Class.forName(driver);
conexion = DriverManager.getConnection(url,usuario,pass);
stmt = conexion.createStatement();
stmt2 = conexion.createStatement();
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
fecha1 = "2013-04-01";

if(boton.equals("Filtrar")){
	f1_cr=""+request.getParameter("fecha1");
	f2_cr=""+request.getParameter("fecha2");
	
	fecha1 = "" + df.format(df2.parse(f1_cr));
	fecha2 = "" + df.format(df2.parse(f2_cr));
}

f1_mos = "" + df2.format(df.parse(fecha1));
f2_mos = "" + df2.format(df.parse(fecha2));

//-------------------------------------------
String muni = request.getParameter("mun");
String juris = request.getParameter("juris");
//-------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit SAVI - GNKL</title>
<link rel="stylesheet" href="../css/bootstrap.css" />
<link rel="stylesheet" href="../css/bootstrap-responsive.css" />
<script language="javascript" src="../js/list02.js"></script>
<script src="../js/scw.js" type="text/javascript"> </script>
</head>

<body>
<!-- Navigation Bar -->

<div class="navbar navbar-inverse">
  <div class="navbar-inner">
    <div class="container-fluid"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a> <a class="brand" href="../index.jsp">Reportes Web Nayarit - BackOrders</a> 
      <!--div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="../main_menu.jsp">Reporte de Ventas</a></li>
              <li><a href="../transferencias.jsp">Reporte de Transferencias</a></li>
              <li><a href="../existencias.jsp">Reporte de Existencias</a></li>
               <li><a href="#contact">Reporte de Censos</a></li>
            </ul>
            <p class="navbar-text pull-right">Usuario: <a href="#"><%=user%></a></p>
          </div><!--/.nav-collapse --> 
    </div>
  </div>
</div>
<!------------->
<div class="container">
  <div class="row">
  <%
		String tip="";
		if(request.getParameter("tipo").equals("F")){
			tip="Farmacia";
		}
		if(request.getParameter("tipo").equals("A")){
			tip="Almacenes";
		}
		if(request.getParameter("tipo").equals("1")){
			tip="Primer Nivel";
		}
		if(request.getParameter("tipo").equals("P")){
			tip="Programas";
		}
		if(request.getParameter("tipo").equals("PE")){
			tip="Pedidos Extraordinarios";
		}
		if(request.getParameter("tipo").equals("C")){
			tip="Controlados";
		}
	%>
    <div> <a href="venta_total.jsp">Reporte de Ventas</a> &gt; <a href="det_venta.jsp?tipo=<%=tip%>">Tipo <%=tip%></a> &gt; <a href="detalle_juris.jsp?tipo=<%=request.getParameter("tipo")%>&juris=<%=request.getParameter("juris")%>">Jurisdiccion <%=juris%></a> &gt; <%=request.getParameter("uni")%></div>
  </div>
  <div>
    <h2>Ventas Totales&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="gnr_detalle_uni.jsp?uni=<%=request.getParameter("uni")%>&juris=<%=request.getParameter("juris")%>&tipo=<%=request.getParameter("tipo")%>"><img src="../../imagen/Excel-2013.png" alt="Exportar a Excel" width="40" height="40" /></a></h2>
    <p>&nbsp;</p>
  </div>
  <div style="width:920px; margin:auto; background-color:#FFFfff">
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif"> 
      <!--div class="tit_tablas">
    <form name="form1" action="">
    <input name="mun" id="mun" value="<%=muni%>" style="display:none"/>
    <input name="juris" id="juris" value="<%=juris%>"  style="display:none"/>
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     <a href="recetas_surtidas/gnr_rec_sur.jsp?fecha1=<%=f1_mos%>&fecha2=<%=f2_mos%>&Submit=Filtrar" target="_blank"><img src="../../imagen/exc.jpg" width="69" height="50" alt="Exportar a Excel" /></a>
    </form>
    </div-->
      <div>
        <table width="700"  class="table table-bordered table-striped table-hover" style="font-size:10px;">
          <tr>
            <td>&nbsp;</td>
            <td class="tit_tablas"><strong>Requisición</strong></td>
            <td class="tit_tablas"><strong>Abasto</strong></td>
            <td class="tit_tablas"><strong>Adeudo</strong></td>
            <td class="tit_tablas"><strong>Porcentaje</strong></td>
          </tr>
          <%
			String jjuris="";
			int jsol=0, jsur=0, jdif=0;
			float jniv=0;
			rset = stmt.executeQuery("SELECT m.des_mun, sum(b.can_sol) from jurisdicciones j, municipios m, unidades u, folio_back f, back_solicitado b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND u.des_uni='"+(request.getParameter("uni"))+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY j.cla_jur ;");
			try{
			while(rset.next()){
				jjuris=rset.getString(1);
				jsol=Integer.parseInt(rset.getString(2));
				rset2 = stmt2.executeQuery ("SELECT sum(b.can_sur) from jurisdicciones j, municipios m, unidades u, folio_back f, back_surtido b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND u.des_uni='"+(request.getParameter("uni"))+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY j.cla_jur ;");
				while(rset2.next()){
					jsur=Integer.parseInt(rset2.getString(1));
				}
			}
			} catch (Exception e) {jsol=0;jsur=0;}
			jdif=jsol-jsur;
			try{
			jniv = (float)(jsur*100/jsol);
			} catch(Exception e) {jniv=0;}
			%>
          <tr class="numeros">
            <td class="tit_tablas" style="text-align:left"><strong><%=jjuris%></strong></td>
            <td><%=forma.format(jsol)%></td>
            <td><%=forma.format(jsur)%></td>
            <td><%=forma.format(jdif)%></td>
            <td><%=forma.format(jniv)%>%</td>
          </tr>
        </table>
        <br />
        <table border="1" class="table table-bordered table-striped table-hover" style="font-size:10px;">
          <tr class="tit_tablas">
            <td width="40"><strong>Clave</strong></td>
            <td width="300"><strong>Descricpion</strong></td>
            <td width="61"><strong>Req.</strong></td>
            <td width="63"><strong>Abasto</strong></td>
            <td width="61"><strong>Adeudo</strong></td>
            <td width="52"><strong>%</strong></td>
          </tr>
          <%
	  String qry_meds="SELECT p.cla_pro, p.des_pro, b.can_sol from jurisdicciones j, municipios m, unidades u, folio_back f, back_solicitado b, productos p WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND b.cla_pro = p.cla_pro AND u.des_uni = '"+request.getParameter("uni")+"' and u.tip_uni = '"+request.getParameter("tipo")+"' GROUP BY p.cla_pro order by p.cla_pro+0 ;";
	  rset = stmt.executeQuery(qry_meds);
	  try{
	  while(rset.next()){
		  String clave=rset.getString(1);
		  String descr=rset.getString(2);
		  int sur=0;
		  int sol=0;
		  int dif=0;
		  float niv=0;
		  try{
			  sol=Integer.parseInt(rset.getString(3));
		  } catch (Exception e) {
			  sol=0;
		  }
		  String qry_meds2="SELECT p.cla_pro, p.des_pro, b.can_sur from jurisdicciones j, municipios m, unidades u, folio_back f, back_surtido b, productos p WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND b.cla_pro = p.cla_pro AND u.des_uni = '"+request.getParameter("uni")+"' and u.tip_uni = '"+request.getParameter("tipo")+"' and p.cla_pro='"+clave+"' GROUP BY p.cla_pro order by p.cla_pro+0 ;";
		  rset2 = stmt2.executeQuery(qry_meds2);
	  	  while(rset2.next()){
			  try{
			  sur=Integer.parseInt(rset2.getString(3));
			  } catch (Exception e) {
				  sur=0;
			  }
		  }
		  try{
			  dif=sol-sur;
			  niv=(sur*100)/sol;
		  } catch (Exception e) {
			  dif=0;niv=0;
		  }
	  %>
          <tr class="numeros">
            <td style="text-align: left" ><%=clave%></td>
            <td style="text-align: left"><%=descr%></td>
            <td><%=forma.format(sol)%></td>
            <td><%=forma.format(sur)%></td>
            <td><%=forma.format(dif)%></td>
            <td><%=(niv)%> %</td>
          </tr>
          <%
	  }}catch(Exception e){out.println(e.getMessage());}
	  %>
        </table>
        <br />
        <br />
        <br />
      </div>
    </div>
  </div>
  <div class="navbar navbar-fixed-bottom">
    <div class="modal-footer"> DERECHOS RESERVADOS GNKL/DESARROLLOS WEB &reg; 2009 - 2013 </div>
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