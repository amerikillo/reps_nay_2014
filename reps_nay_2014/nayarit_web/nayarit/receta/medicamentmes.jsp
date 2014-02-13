<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="../../../pag_man.html" session="true" %>

<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
//out.print("Id de sesion: "+sesion.getId());
String vali="", user="";



if (sesion.getAttribute("valida")!=null){
	vali=(String)sesion.getAttribute("valida");
	user=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!vali.equals("valido")){
	
	%>
    <script>self.location='../index.jsp';</script>
    <%
}
%>

<% 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
NumberFormat formatter = new DecimalFormat("#0.00"); 



Statement stmt_sex = null;
Statement stmt_sexf = null;
Statement stmt_2 = null;

Connection conexion=null;
    String mensaje="";
   /*parametros para la conexion*/
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/receta_electronica";    String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
    conexion = DriverManager.getConnection(url,usuario,pass);
     stmt_sexf = conexion.createStatement();
	 stmt_sex = conexion.createStatement();
	 stmt_2 = conexion.createStatement();
	 
	 
	 
	 
         /*guardando la conexion en la session*/
        session.setAttribute("conexion",conexion);
       } catch (Exception ex){
        mensaje=ex.toString();
    }
    mensaje="conectado";
    if(conexion.isClosed()){
        mensaje="desconectado";
    }
//ResultSet rset_2=null;
ResultSet rset_20=null;//Para obtener los datos de forma global
ResultSet rset_fol=null;
ResultSet rset_sex=null;
ResultSet rset_sexf=null;
String totPzs="";
String totMon="";
String totPzsMed="";
String totMonMed="";
String totPzsMat="";
String totMonMat="";
String fecha_1= "";
String fecha_2= "";
String unidad_jv="";
//variables para definir recetas, piezas y costos
String no_rec_elb="20";
String no_pzs_sol="";
String no_pzs_sur="";
String st="10";
String sf="10";
String ixt_cad="",ixt_cad2="",ixt_cad3="";
int cant_pzs=0, ixt_uni=0 , ixt_uni2=0, ixt_uni3=0;
int cont=0, medd=0 ;
int h=0;
int cont3=0;
int cont4=0;
int cont1=0;
int cont2=0;
int cont5=0;
int cont6=0;
int cont7=0;
int cont8=0;
int cont9=0;
int cont10=0;
int cont11=0;
int cont12=0;
int cont13=0;
int cont14=0;
int cont15=0;
int cont16=0;
int cont17=0;
int cont18=0;
int cont19=0;
int cont20=0;
int cont21=0;
int cont22=0;
int cont23=0;
int cont24=0;
int cont25=0;
int cont26=0;
int x=0;

int ed=0;//variable que toma el total de edad
int edd=0;//variable que toma el valor de la consulta
double res=0.0, res2=0.0, res3=0.0, res4=0.0, promedio=0.0, promedio2=0.0, ixt_costo=0.0, res1=0.0, res_por=0.0, costt=0.0, total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, cant_totMon=0.0, montos_res=0.0, total_t=0.0;//variables para dar formato de 0.00
int total_pzs=0,total_medi=0,total_cura=0;

try {
		unidad_jv = request.getParameter("med");       			   
} catch (Exception e) { }



rset_sex = stmt_sex.executeQuery("select sum(dr.cos_tot) as cant_costo from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med;");

	  
rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  //cont26++;
				 ixt_cad2=rset_sexf.getString("sur");
					ixt_uni3= Integer.parseInt(ixt_cad2);
					//out.print(""+ixt_cad2);
	 				}
					while (rset_sex.next()) 
                  {//out.print("hola");
				  //no_rec_elb=rset_20.getString("count(paciente)");
				  //no_pzs_sol=rset_sex.getString("sum(cant_sol)");
				  //no_pzs_sur=rset_20.getString("sum(cant_sur)");
				  totMon=rset_sex.getString("cant_costo");
				  //cant_pzs=Integer.parseInt(no_rec_elb);
				  cant_totMon=Double.parseDouble(totMon);
				  }
					//FIN DEL WHILE
					res=cont26;
					res1=cant_totMon;
					res_por=(res1/res);
					//out.print(""+res_por);
					/*res2=cont2;
					res3=cont3;
					res4=cont4;
					res5=cont5;
					res6=cont6;
					res7=cont7;
					
					res_por=(res/cont26);
					res_por1=(res1/cont26);
					res_por2=(res2/cont26);
					res_por3=(res3/cont26);
					res_por4=(res4/cont26);
					res_por5=(res5/cont26);
					res_por6=(res6/cont26);
					res_por7=(res7/cont26);
//					*/

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/dis1.css" type="text/css" />
<title>TOTAL MEDICAMENTO</title>
<style type="text/css">
<!--
.style7 {font-size: 14px}
.style8 {color: #FFFFFF}
.style9 {font-weight: bold}
.style81 {color: #FFFFFF}
-->
</style>
</head>

<body>

<form name="form" action="medicamentmes.jsp" method="post">
<table width="150" border="0">
  <tr>
    <td><a href="consultas.html">Regresar a Men&uacute;</a><a name="ancla2" id="ancla2"></a><a href="infor_reisem1.jsp"> </a></td>
  </tr>
</table>
<table width="600" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              
              <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
			</tr>
			
			
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" valign="top"><table width="500" border="1" cellpadding="2" bordercolor="#932321">
                  <tr>
                    <td><table width="914" border="1" cellpadding="0" cellspacing="0">
                      <col width="70" />
                      <col width="336" />
                      <col width="71" />
                      <col width="82" />
                      <col width="23" />
                      <col width="80" />
                      <col width="330" />
                      <col width="80" span="2" />
                      <tr height="17">
                        <td height="23" colspan="8" bgcolor="#990000"><div align="center" class="style7"><a href="#ancla1" class="style81">TOTAL MEDICAMENTO POR MES </a></div></td>
                      </tr>
                      <tr height="17">
                        <td width="78" height="17" bgcolor="#CCCCCC" class="dis2"><div align="center">CLAVE</div></td>
                        <td width="428" bgcolor="#CCCCCC" class="dis2"><div align="center">DESCRIPCION</div></td>
                        <td width="97" bgcolor="#CCCCCC" class="dis2"><div align="center"><span class="style3">CANTIDAD SURTIDA </span></div></td>
                        <td width="100" bgcolor="#CCCCCC" class="dis2"><div align="center">PROPORCION</div></td>
                        <!--td width="97" bgcolor="#CCCCCC" class="dis2"><div align="center">COSTO</div></td>
                        <td width="100" bgcolor="#CCCCCC" class="dis2"><div align="center">COSTO PROMEDIO </div></td-->
                      </tr>
                      <%				  				  
				  ResultSet rset_2 = rset_2 = stmt_2.executeQuery("select prod.cla_pro as med, prod.des_pro as descr, sum(dr.cant_sur) as receta, sum(dr.cos_tot) as cant_costo from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med group by med order by receta desc limit 0, 20 ;");
				 
				  
				  //select clave,uniaten,descr,sum(uni),sum(cant_costo) from eltunal where partida='MEDICAMENTOS' and fecha between '2009-03-10' and '2009-05-19' group by clave;				  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_fol = stmt_2.executeQuery("select sum(cant_sur) as sur, sum(cos_tot) as cant_costo from detreceta  ;");
				  }
				  while (rset_2.next()) 
                  { 
				  /* medd=Integer.parseInt(rset_2.getString("sum(cant_sur)"));
				   
				  //out.print("hola"+med);
				 
				  if(medd>0  )			
				  {*/
					ixt_cad=rset_2.getString("receta");
					ixt_uni = Integer.parseInt(ixt_cad);
					total_t =total_t + ixt_uni;
					ixt_cad2=rset_2.getString("cant_costo");
					ixt_costo= Double.parseDouble(ixt_cad2);
					res2=ixt_uni;
					res3=ixt_costo;
					res4=ixt_uni3;
					promedio=(res3/res2);
					promedio2=((res2/res4));
					//}
					//out.print(""+promedio2);				  
				  %>
                      <tr height="17">
                        <td width="78" height="17" align="right" class="ver"><div align="center"><a href="medixmes.jsp?med=<%=rset_2.getString("med")%>&descr=<%=rset_2.getString("descr")%>"><%=rset_2.getString("med")%></a>&nbsp; </div></td>
                        <td width="428" class="ver"><div align="left"><%=rset_2.getString("descr")%> </div></td>
                        <td width="97" align="right" class="ver"><div align="center"><span class="style3"><%=nf1.format(ixt_uni)%></span></div></td>
                        <td width="100" class="ver"><div align="center"><span class="style6"><%=formatter.format(promedio2)%></span></div></td>
                        <!--td width="97" class="ver"><div align="center" class="style6">
                            <div align="center"><%=nf1.format(ixt_costo)%></div>
                        </div></td>
                        <td width="100" class="ver"><div align="center"><span class="style6"><%=nf1.format(promedio)%></span></div></td-->
                      </tr>
                      <%
				}
				%>
                      <tr height="17">
                        <td height="17" valign="top" class="ver"><div align="center"></div></td>
                        <td class="ver"><div align="left"><a href="#ancla2">&nbsp;Ir Encabezado</a></div></td>
                        <td align="right" class="ver style9"><div align="center"><a name="ancla1" id="ancla1"></a> </div>
                            <div align="center" class="style2">
                              <div align="center">&nbsp;<%=nf1.format(total_t)%></div>
                            </div></td>
                        <td class="ver"><div align="center"><strong>
                            <%//=nf1.format(total_mon_medi)%>
                          1</strong></div></td>
                        <!--td class="ver"><div align="center"><strong><span class="style6">$<%=nf1.format(cant_totMon)%></span></strong></div></td>
                        <td class="ver"><div align="center"><strong><span class="style6">&nbsp;$<%=nf1.format(res_por)%> </span></strong></div></td-->
                      </tr>
                    </table></td>
                  </tr>
                </table>
                <p>&nbsp;</p>
                <p align="center">&nbsp;</p>
<table width="524" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
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
