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
String juris = request.getParameter("juris");
int cont_mun=0;
//-------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reportes Nayarit SAVI - GNKL</title>
</head>

<body bgcolor="#FCFCFC">
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
    <%
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"BackOrder_Juris"+request.getParameter("juris")+"_"+tip+".xls\"");
%>
    <div> Reporte de Ventas &gt; Tipo <%=tip%> &gt; <span class="banda">Jurisdiccion <%=juris%></span></div>
  </div>
  <div>
    <h2>Ventas Totales&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2>
    <p>&nbsp;</p>
  </div>
  <div style="width:920px; margin:auto; background-color:#FFFfff"> 
    <!--div class="tit_tablas">
    <form name="form1" action="">
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"  />
     <a href="recetas_surtidas/gnr_rec_sur.jsp?fecha1=<%=f1_mos%>&fecha2=<%=f2_mos%>&Submit=Filtrar" target="_blank"><img src="../../imagen/exc.jpg" width="69" height="50" alt="Exportar a Excel" /></a>
    </form>
    </div-->
    <div style="width:600; float:right; background-color:#FFF; padding:5px; font-family:Arial, Helvetica, sans-serif">
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
			rset = stmt.executeQuery("SELECT j.des_jur, sum(b.can_sol) from jurisdicciones j, municipios m, unidades u, folio_back f, back_solicitado b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND j.cla_jur='"+(request.getParameter("juris"))+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY j.cla_jur ;");
			try{
			while(rset.next()){
				jjuris=rset.getString(1);
				jsol=Integer.parseInt(rset.getString(2));
				rset2 = stmt2.executeQuery ("SELECT sum(b.can_sur) from jurisdicciones j, municipios m, unidades u, folio_back f, back_surtido b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND j.des_jur='"+(rset.getString(1))+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY j.cla_jur ;");
				while(rset2.next()){
					jsur=Integer.parseInt(rset2.getString(1));
				}
			}
			} catch (Exception e) {jsol=0;jsur=0;}
			jdif=jsol-jsur;
			jniv = (float)(jsur*100/jsol);
			%>
          <tr class="numeros">
            <td height="43" class="tit_tablas" style="text-align:left"><strong><%=jjuris%></strong></td>
            <td><%=forma.format(jsol)%></td>
            <td><%=forma.format(jsur)%></td>
            <td><%=forma.format(jdif)%></td>
            <td><%=forma.format(jniv)%>%</td>
          </tr>
        </table>
        <br />
      </div>
      <table width="690"  class="table table-bordered table-striped table-hover" style="font-size:10px;">
        <tr>
          <td width="360">&nbsp;</td>
          <td width="78" class="tit_tablas">Requisición</td>
          <td width="60" class="tit_tablas">Abasto</td>
          <td width="62" class="tit_tablas">Adeudo</td>
          <td width="62" class="tit_tablas">%</td>
        </tr>
        <%
		String qry_muni= "SELECT j.des_jur, m.des_mun, sum(b.can_sol) from jurisdicciones j, municipios m, unidades u, folio_back f, back_solicitado b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND j.cla_jur='"+request.getParameter("juris")+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY m.cla_mun ;";
		rset = stmt.executeQuery(qry_muni);
		while(rset.next()){
			cont_mun++;
			int msol=0;
			int msur=0;
			String muni = rset.getString(2);
			try {
			msol = Integer.parseInt(rset.getString(3));
			} catch (Exception e) {msol=0;}
			rset2=stmt2.executeQuery("SELECT j.des_jur, m.des_mun, sum(b.can_sur) from jurisdicciones j, municipios m, unidades u, folio_back f, back_surtido b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND j.cla_jur='"+request.getParameter("juris")+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY m.cla_mun ;");
			while (rset2.next()) {
				try{
				msur = Integer.parseInt(rset2.getString(3));
				} catch (Exception e) {msur=0;}
			}
			
			%>
        <tr class="mun_uni">
          <td ><a onClick="showHideItems('item<%=cont_mun%>',1);" class="link_muestra_u">Mostrar Unidades de: </a><a class="link_mun" href="detalle_mun.jsp?mun=<%=muni%>&amp;juris=<%=juris%>&tipo=<%=request.getParameter("tipo")%>"><%=muni%></a></td>
          <td class="numeros"><%=forma.format((msol))%></td>
          <td class="numeros"><%=forma.format((msur))%></td>
          <td class="numeros"><%=forma.format((msol-msur))%></td>
          <td class="numeros"><%=( ((msur))*100/ ((msol)))%> %</td>
        </tr>
        
          <td colspan="6"><div id="item<%=cont_mun%>" style="display:block" align="justify" >
              <table border="1" width="680"  class="table table-bordered table-striped table-hover" style="font-size:10px;">
                <%
				String qry_uni = "SELECT j.des_jur, m.des_mun, u.des_uni, sum(b.can_sol) from jurisdicciones j, municipios m, unidades u, folio_back f, back_solicitado b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND m.des_mun='"+muni+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY u.cla_uni ;";
				rset2 = stmt2.executeQuery(qry_uni);
				while(rset2.next()){
					String uni = rset2.getString(3);
					int usol = 0;
					int usur = 0;
					try {
					usol = Integer.parseInt(rset2.getString(4));
					} catch (Exception e) {usol=0;}
					rset3=stmt3.executeQuery("SELECT j.des_jur, m.des_mun, u.des_uni, sum(b.can_sur) from jurisdicciones j, municipios m, unidades u, folio_back f, back_surtido b WHERE j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = f.cla_uni AND f.fol_bac = b.fol_bac AND u.des_uni='"+uni+"' and u.tip_uni='"+request.getParameter("tipo")+"' GROUP BY u.cla_uni ;");
					while (rset3.next()) {
						try{
						usur = Integer.parseInt(rset3.getString(4));
						} catch (Exception e) {usur=0;}
					}
				%>
                <tr>
                  <td width="300"><%=uni%></td>
                  <td width="70" class="numeros"><%=forma.format(usol)%></td>
                  <td width="50" class="numeros"><%=forma.format(usur)%></td>
                  <td width="50" class="numeros"><%=forma.format(usol-usur)%></td>
                  <td width="49" class="numeros"><%=((usur)*100/ (usol))%> %</td>
                </tr>
                <%
				}
				%>
              </table>
            </div></td>
          <%
		}
		%>
      </table>
    </div>
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