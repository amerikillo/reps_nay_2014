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


if(boton.equals("Filtrar")){
	f1_cr=""+request.getParameter("fecha1");
	f2_cr=""+request.getParameter("fecha2");
	
	fecha1 = "" + df.format(df2.parse(f1_cr));
	fecha2 = "" + df.format(df2.parse(f2_cr));
}

f1_mos = "" + df2.format(df.parse(fecha1));
f2_mos = "" + df2.format(df.parse(fecha2));

//---PROCESO DE FARMACIAS----------------------------------------
String tipo = request.getParameter("tipo");
//-------------------------------------------
try {
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
<h1>REPORTE: NIVEL DE SERVICIO EN <%=tipo%></h1> <h3>(Solicitado vs Entregado)</h3>
<p>&nbsp;</p>
</div>
<div class="banda">
&nbsp;
</div>
<div style="width:920px; margin:auto; background-color:#FFFfff">
  <div style="width:180; float:left; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif; font-size:10px;">
    <p>SOLICITADO / ENTREGADO</p>
        <p><a href="rec_sur.jsp">RECETAS SURTIDAS</a></p>
        <p><a href="cla_des.jsp">CLAVES EN DESABASTO</a></p>
        <p><a href="ranking.jsp">RANKING DE CLAVES</a></p>
        <p><a href="inventarios.jsp">INVENTARIOS</a></p>
    </div>
    <div style="width:600; float:right; background-color:#FFF; padding:15px; font-family:Arial, Helvetica, sans-serif">
     <div class="tit_tablas">
    <form name="form1" action="">
    <input name="tipo" type="text" id = "tipo" value="<%=tipo%>" size="10" readonly style="display:none"/>
    Filtrar por fechas del: <input name="fecha1" type="text" id = "fecha1" value="<%=f1_mos%>" size="10" readonly /> <img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha1'),event);"/>
    al: <input name="fecha2" type="text" id = "fecha2" value="<%=f2_mos%>" size="10" readonly /><img src="../imagen/cal.gif" width="15" height="15" border="0" onClick="scwShow(scwID('fecha2'),event);"/>
     <input type="submit" value="Filtrar" name="Submit"  />
     <input type="submit" value="Quitar Filtro" name="Submit"/>
    </form>
    </div>
    <a class="regresa" href="index.jsp">Regresar</a>
<!--Para Farmacias-->
        <div <%if (!tipo.equals("FARMACIAS")){out.print("style='display:none'");}%> >
          <%
		  if (tipo.equals("FARMACIAS")){
		  %>
          Farmacias
          <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
            <tr>
              <td>&nbsp;</td>
              <td>Requisición</td>
              <td>Abasto</td>
              <td>Adeudo</td>
              <td>Porcentaje</td>
              <td>Importe</td>
            </tr>
            <%
			rset = stmt.executeQuery("SELECT j.des_jur, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur, SUM(dr.can_sol-dr.cant_sur) as dif, j.cla_jur, sum(dr.cos_tot) as cos from detreceta dr, receta r, unidades u, municipios m, jurisdicciones j where j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = r.cla_uni AND r.id_rec = dr.id_rec AND dr.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' group by j.cla_jur order by j.des_jur");
			while(rset.next()){
				String costo = rset.getString("cos");
				if (costo == null) {
					costo = "0";
				}
				float cos_f=Float.parseFloat(costo);
			%>
            <tr class="numeros">
              <td style="text-align:left"><a href="surtido_farmacias/det_jur_sol.jsp?juris=<%=rset.getString(5)%>"><%=rset.getString(1)%></a></td>
              <td><%=forma.format(Integer.parseInt(rset.getString(2)))%></td>
              <td><%=forma.format(Integer.parseInt(rset.getString(3)))%></td>
              <td><%=forma.format(Integer.parseInt(rset.getString(4)))%></td>
              <td><%=forma2.format((Integer.parseInt(rset.getString(3))*100)/(Integer.parseInt(rset.getString(2))))%>%</td>
              <td>$ <%=forma2.format(cos_f)%></td>
            </tr>
            <%
			}
			%>
          </table>
          <%
		  }
		  %>
        </div>
      <!--Para Almacenes-->
      <div <%if (!tipo.equals("ALMACENES")){out.print("style='display:none'");}%> >
      Almacenes
        <%
		  if (tipo.equals("ALMACENES")){
			  String sol[] = {"1","1","1"};
			  String sur[] = {"0","0","0"};
			  String cos[] = {"0","0","0"}; 
			  int cont=0;
			  String qry_sol = "select j.des_jur, sum(bsol.can_sol) FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'A' and bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsol.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  sol[cont]=rset.getString(2);
				  if (sol[cont]==null || sol[cont].equals(""))
				  	sol[cont]="1";
				  cont++;
			  }
			  cont = 0;
			  qry_sol = "select j.des_jur, sum(bsur.can_sur), sum(cos_tot) as cos FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'A' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  sur[cont]=rset.getString(2);
				  if (sur[cont]==null || sol[cont].equals(""))
				  	sur[cont]="0";
				  cont++;
			  }
			  cont = 0;
			  qry_sol = "select j.des_jur, sum(cos_tot) as cos FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'A' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  cos[cont]=rset.getString(2);
				  if (cos[cont]==null || cos[cont].equals(""))
				  	cos[cont]="0";
				  cont++;
			  }
			  
		  %>
        <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
                <tr>
                  <td>&nbsp;</td>
                  <td>Requisición</td>
                  <td>Abasto</td>
                  <td>Adeudo</td>
                  <td>Porcentaje</td>
                  <td>Importe</td>
                </tr>
                <tr class="numeros">
                  <td style="text-align:left"><a href="surtido_almacenes/det_alm_jur.jsp?juris=1">Jurisdicción Sanitaria I</a></td>
                  <td><%=forma.format( (Integer.parseInt(sol[0])))%></td>
                  <td><%=forma.format( (Integer.parseInt(sur[0])))%></td>
                  <td><%=forma.format( (Integer.parseInt(sol[0])) - (Integer.parseInt(sur[0])) )%></td>
                  <td><%=( (Integer.parseInt(sur[0]))*100 / (Integer.parseInt(sol[0])) )%>%</td>
                  <td>$ <%=forma2.format(Float.parseFloat(cos[0]))%></td>
                </tr>
                <tr class="numeros">
                  <td style="text-align:left"><a href="surtido_almacenes/det_alm_jur.jsp?juris=2">Jurisdicción Sanitaria II</a></td>
                  <td><%=forma.format( (Integer.parseInt(sol[1])))%></td>
                  <td><%=forma.format( (Integer.parseInt(sur[1])))%></td>
                  <td><%=forma.format( (Integer.parseInt(sol[1])) - (Integer.parseInt(sur[1])) )%></td>
                  <td><%=( (Integer.parseInt(sur[1]))*100 / (Integer.parseInt(sol[1])) )%>%</td>
                  <td>$ <%=forma2.format(Float.parseFloat(cos[1]))%></td>
                </tr>
                <tr class="numeros">
                  <td style="text-align:left"><a href="surtido_almacenes/det_alm_jur.jsp?juris=3">Jurisdicción Sanitaria III</a></td>
                  <td><%=forma.format( (Integer.parseInt(sol[2])))%></td>
                  <td><%=forma.format( (Integer.parseInt(sur[2])))%></td>
                  <td><%=forma.format( (Integer.parseInt(sol[2])) - (Integer.parseInt(sur[2])) )%></td>
                  <td><%=( (Integer.parseInt(sur[2]))*100 / (Integer.parseInt(sol[2])) )%>%</td>
                  <td>$ <%=forma2.format(Float.parseFloat(cos[2]))%></td>
                </tr>
              </table>
       	  <%
		  }
		  %>
      </div>
        <!--Para 1er Nivel-->
      <div <%if (!tipo.equals("1ER NIVEL")){out.print("style='display:none'");}%>>
        1er Nivel
        <%
		  if (tipo.equals("1ER NIVEL")){
			  int por_ier=0;
			  String sol[] = {"0","0","0"};
			  String sur[] = {"0","0","0"};
			  String cos[] = {"0","0","0"};
			  int cont=0;
			  String qry_sol = "select j.des_jur, sum(bsol.can_sol) FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j where u.tip_uni = '1' and bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsol.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  sol[cont]=rset.getString(2);
				  if (sol[cont]==null || sol[cont].equals("")){
				  	sol[cont]="0";
				  }
				  cont++;
			  }
			  cont = 0;
			  qry_sol = "select j.des_jur, sum(bsur.can_sur) FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = '1' and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  sur[cont]=rset.getString(2);
				  if (sur[cont]==null || sol[cont].equals("")){
				  	sur[cont]="0";
				  }
				  cont++;
			  }
			  cont = 0;
			  qry_sol = "select j.des_jur, sum(bsur.cos_tot) FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = '1' and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  cos[cont]=rset.getString(2);
				  if (cos[cont]==null || sol[cont].equals(""))
				  	cos[cont]="0";
				  cont++;
			  }
			  try{
			  if (sol[2]=="0"){
			  por_ier = 0;
			  }else{
				 por_ier = (Integer.parseInt(sur[2])*100)/(Integer.parseInt(sol[2]));
			  }
			  } catch(Exception e) {por_ier = 0;}
			  
		%>
        <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
                <tr>
                  <td>&nbsp;</td>
                  <td>Requisición</td>
                  <td>Abasto</td>
                  <td>Adeudo</td>
                  <td>Porcentaje</td>
                  <td>Importe</td>
                </tr>
                <tr class="numeros">
                  <td style="text-align:left"><a href="surtido_primer/det_pri_jur.jsp?juris=1">Jurisdicción Sanitaria I</a></td>
                  <td><%=sol[0]%></td>
                  <td><%=sur[0]%></td>
                  <td><%=( (Integer.parseInt(sol[0])) - (Integer.parseInt(sur[0])) )%></td>
                  <td><%=por_ier%>%</td>
                  <td>$ <%=forma2.format(Float.parseFloat(cos[0]))%></td>
                </tr>
                <tr class="numeros">
                  <td style="text-align:left"><a href="surtido_primer/det_pri_jur.jsp?juris=1">Jurisdicción Sanitaria II</a></td>
                  <td><%=sol[1]%></td>
                  <td><%=sur[1]%></td>
                  <td><%=( (Integer.parseInt(sol[1])) - (Integer.parseInt(sur[1])) )%></td>
                  <td><%=por_ier%>%</td>
                  <td>$ <%=forma2.format(Float.parseFloat(cos[1]))%></td>
                </tr>
                <tr class="numeros">
                  <td style="text-align:left"><a href="surtido_primer/det_pri_jur.jsp?juris=1">Jurisdicción Sanitaria III</a></td>
                  <td><%=sol[2]%></td>
                  <td><%=sur[2]%></td>
                  <td><%=( (Integer.parseInt(sol[2])) - (Integer.parseInt(sur[2])) )%></td>
                  <td><%=por_ier%>%</td>
                  <td>$ <%=forma2.format(Float.parseFloat(cos[2]))%></td>
                </tr>
        </table>
        <%
		}
		%>
      </div>
        <!--Para Programas-->
      <div <%if (!tipo.equals("PROGRAMAS")){out.print("style='display:none'");}%>>
        Programas
        <%
		  if (tipo.equals("PROGRAMAS")){
			  int por_ier=0;
			  String sol[] = {"0","0","0"};
			  String sur[] = {"0","0","0"};
			  String cos[] = {"0","0","0"};
			  int cont=0;
			  String qry_sol = "select j.des_jur, sum(bsol.can_sol) FROM back_solicitado bsol, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'P' and bsol.FEC_Sol between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsol.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  sol[cont]=rset.getString(2);
				  if (sol[cont]==null || sol[cont].equals("")){
				  	sol[cont]="0";
				  }
				  cont++;
			  }
			  cont = 0;
			  qry_sol = "select j.des_jur, sum(bsur.can_sur) FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'P' and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  sur[cont]=rset.getString(2);
				  if (sur[cont]==null || sol[cont].equals("")){
				  	sur[cont]="0";
				  }
				  cont++;
			  }
			  
			  cont = 0;
			  qry_sol = "select j.des_jur, sum(bsur.cos_tot) FROM back_surtido bsur, unidades u, municipios m, jurisdicciones j where u.tip_uni = 'P' and bsur.FEC_SUR between '"+fecha1+"' and '"+fecha2+"' and j.cla_jur = m.cla_jur and m.cla_mun = u.cla_mun and u.cla_uni = bsur.cla_uni GROUP BY j.cla_jur ;";
			  rset = stmt.executeQuery(qry_sol);
			  while(rset.next()){
				  cos[cont]=rset.getString(2);
				  if (cos[cont]==null || sol[cont].equals(""))
				  	cos[cont]="0";
				  cont++;
			  }
			  
			  try{
			  if (sol[2]=="0"){
			  por_ier = 0;
			  }else{
				 por_ier = (Integer.parseInt(sur[2])*100)/(Integer.parseInt(sol[2]));
			  }
			  } catch(Exception e) {por_ier = 0;}
			  
		%>
        <table width="690" border="1" bgcolor="#F2F2F2" bordercolor="#FFFFFF" cellspacing="0">
            <tr>
              <td>&nbsp;</td>
              <td>Requisición</td>
              <td>Abasto</td>
              <td>Adeudo</td>
              <td>Porcentaje</td>
              <td>Importe</td>
            </tr>
            <tr>
              <td class="numeros" style="text-align: left"><a href="surtido_prog/det_pro_jur.jsp?juris=1">Jurisdicción Sanitaria I</a></td>
              <td class="numeros"><%=sol[0]%></td>
              <td class="numeros"><%=sur[0]%></td>
              <td class="numeros"><%=( (Integer.parseInt(sol[0])) - (Integer.parseInt(sur[0])) )%></td>
              <td class="numeros"><%=por_ier%>%</td>
              <td class="numeros">$ <%=forma2.format(Float.parseFloat(cos[0]))%></td>
            </tr>
            <tr>
              <td class="numeros" style="text-align: left"><a href="surtido_prog/det_pro_jur.jsp?juris=2">Jurisdicción Sanitaria II</a></td>
              <td class="numeros"><%=sol[1]%></td>
              <td class="numeros"><%=sur[1]%></td>
              <td class="numeros"><%=( (Integer.parseInt(sol[1])) - (Integer.parseInt(sur[1])) )%></td>
              <td class="numeros"><%=por_ier%>%</td>
              <td class="numeros">$ <%=forma2.format(Float.parseFloat(cos[1]))%></td>
            </tr>
            <tr>
              <td class="numeros" style="text-align: left"><a href="surtido_prog/det_pro_jur.jsp?juris=3">Jurisdicción Sanitaria III</a></td>
              <td class="numeros"><%=sol[2]%></td>
              <td class="numeros"><%=sur[2]%></td>
              <td class="numeros"><%=( (Integer.parseInt(sol[2])) - (Integer.parseInt(sur[2])) )%></td>
              <td class="numeros"><%=por_ier%>%</td>
              <td class="numeros">$ <%=forma2.format(Float.parseFloat(cos[2]))%></td>
            </tr>
        </table>
          <%
		  }
		  %>
      </div>
    </div>
  </div>
</body>
</html>

<%   
} catch (Exception e) {}
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