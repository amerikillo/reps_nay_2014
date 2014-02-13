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
	
String med_jv="";


int ban=0, folio=0;


 try{
        med_jv=request.getParameter("med");   
		
		 }catch(Exception e){ System.out.print("Doesn't make the altaOK"); }
		// out.print(""+med_jv);
%>

<% 
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 

Statement stmt_sex = null;
Statement stmt_sexf = null;
Statement stmt_2 = null;

Connection conexion=null;
    String mensaje="";
   /*parametros para la conexion*/
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://162.209.67.250:3306/nay_re";    String usuario = "receta_usr";
    String pass = "M8KbqNjTD2";
/*procedimiento de la conexion*/
    try{
         Class.forName(driver);
    conexion = DriverManager.getConnection(url,usuario,pass);
     stmt_sex = conexion.createStatement();
	 stmt_sexf = conexion.createStatement();
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
//out.print(mensaje);

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
String totsol="";
String totsur="";
String sf="10";
String ixt_cad="",ixt_cad2="",ixt_cad1="",ixt_cad3="";
int cant_pzs=0, ixt_uni=0,ixt_uni1=0,ixt_uni2=0,ixt_uni3=0;
int cont=0;
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
double res=0.0, res2=0.0, res3=0.0, res4=0.0, promedio=0.0, promedio2=0.0, ixt_costo=0.0, res1=0.0, res_por=0.0, total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, cant_totMon=0.0, montos_res=0.0;//variables para dar formato de 0.00
int total_pzs=0,total_medi=0,total_cura=0;


				  

rset_sex = stmt_sex.executeQuery("select sum(cant_costo),sum(cant_sol),sum(cant_sur) from consolidado where cldia1='"+med_jv+"' and sexo ='femenino';");

	  
					while (rset_sex.next()) 
                  {
				  totMon=rset_sex.getString("sum(cant_costo)");
				  totsol=rset_sex.getString("sum(cant_sol)");
				  totsur=rset_sex.getString("sum(cant_sur)");
				  //cant_pzs=Integer.parseInt(no_rec_elb);
				  cant_totMon=Double.parseDouble(totMon);
				  ixt_uni2 = Integer.parseInt(totsol);
				  ixt_uni3 = Integer.parseInt(totsur);
				  }
					//FIN DEL WHILE
					
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/dis1.css" type="text/css" />

<title>Untitled Document</title>
<style type="text/css">
<!--
.style7 {font-size: 14px}
.style8 {color: #FFFFFF}
.style10 {font-weight: bold}
-->
</style>
</head>

<body>

<form name="form" action="medttisem_feme.jsp" method="post">
<table width="115" border="0">
  <tr>
    <td><a href="diagttsexisem.jsp">Regresar</a></td>
  </tr>
</table>
<a name="ancla2" id="ancla2"></a>
<table width="600" cellpadding="0" cellspacing="0" border="0">
            <col width="80" span="2" />
			<tr height="17">
              
              <td width="87" bgcolor="#FFFFFF" class="style3" valign="top"></td>
			</tr>
			
			
            <tr bgcolor="#FFFFFF" height="17">
              <td height="17" valign="top"><table width="801" border="1" cellpadding="2" bordercolor="#932321">
                  <tr>
                    <td><table width="792" border="1" cellpadding="0" cellspacing="0" class="ver">
                      <col width="70" />
                      <col width="336" />
                      <col width="71" />
                      <col width="82" />
                      <col width="23" />
                      <col width="80" />
                      <col width="330" />
                      <col width="80" span="2" />
                      <tr height="17">
                        <td height="26" colspan="7" background="../../../imagen/fon3.jpg"><div align="center" >
                          <div align="center"><a href="#ancla1" ><span class="style8">TOTAL MEDICAMENTO POR DIAGNÓSTICO SEXO FEMENINO </span></a></div>
                        </div></td>
                      </tr>
                      <tr height="17">
                        <td width="80" height="17" bgcolor="#FFFFFF" class="dis2"><div align="center" class="style12">CLAVE</div></td>
                        <td width="400" bgcolor="#FF0000" class="dis2"><div align="center">DESCRIPCION</div></td>
                        <td width="104" bgcolor="#FF0000" class="dis2"><div align="center"><span class="style3">CANTIDAD SOLICITADA </span></div></td>
                        <td width="95" bgcolor="#FF0000" class="dis2"><div align="center">CANTIDAD SURTIDA </div></td>
                        <!--td width="101" bgcolor="#FF0000" class="dis2"><div align="center">COSTO</div></td-->
                      </tr>
                      <%				  				  
				  ResultSet rset_2 = rset_2 = stmt_2.executeQuery("select med,cldia1,descr,sum(cant_sol) as sol,sum(cant_sur),sum(cant_costo) from consolidado where cldia1='"+med_jv+"' and sexo ='femenino' group by med order by  sol desc;");
				 
				  
				  //select clave,uniaten,descr,sum(uni),sum(cant_costo) from eltunal where partida='MEDICAMENTOS' and fecha between '2009-03-10' and '2009-05-19' group by clave;				  
				  if(!(fecha_1.equals("")) && !(fecha_2.equals(""))){
				  	rset_fol = stmt_2.executeQuery("select med,descr,sum(cant_sol),sum(cant_sur),sum(cant_costo) from consolidado where cldia1='"+med_jv+"' and sexo ='femenino' group by med order by  med desc;");
				  }
				  /* while (rset_fol.next()) 
                  {//out.print("hola");
				  //cont=rset_fol.getInt(1);
				  ixt_cad2=rset_2.getString("sum(cant_costo)");
				  ixt_costo= Double.parseDouble(ixt_cad2);	
				  //cont++;
				  }//out.print("hola"+cont);*/
  				  while (rset_2.next()) 
                  { 
					//ixt_cad3=rset_2.getString("cldia1");
					ixt_cad=rset_2.getString("sol");
					ixt_uni = Integer.parseInt(ixt_cad);
					ixt_cad1=rset_2.getString("sum(cant_sur)");
					ixt_uni1 = Integer.parseInt(ixt_cad);
					
					ixt_cad2=rset_2.getString("sum(cant_costo)");
					ixt_costo= Double.parseDouble(ixt_cad2);
					//res2=ixt_uni;
					res3=ixt_costo;
					res4=cont26;
					promedio=(res3/res2);
					promedio2=((res2/res4));
					
					//out.print(""+promedio2);				  
				  %>
                      <tr height="17">
                        <td height="17" align="right" width="80"><div align="center"><%=rset_2.getString("med")%>&nbsp; </div>
                            <div align="center"></div></td>
                        <td width="400"><%=rset_2.getString("descr")%>
                            <div align="left"></div></td>
                        <td align="right" width="104"><div align="center"><span class="style3"><%=nf1.format(ixt_uni)%></span></div></td>
                        <td width="95"><div align="center"><%=nf1.format(ixt_uni1)%></div></td>
                        <!--td width="101"><div align="center" class="style6">
                            <div align="center"><%=nf1.format(ixt_costo)%></div>
                        </div></td-->
                      </tr>
                      <%
				}
				%>
                      <tr height="17">
                        <td height="17" valign="top">&nbsp;</td>
                        <td><div align="left"></div>
                          <a href="#ancla2">&nbsp;Ir Encabezado</a></td>
                        <td align="right"><div align="center"><strong><a name="ancla1" id="ancla1"></a> </strong></div>
                            <div align="center" class="style2 style10">
                              <div align="center"><%=nf1.format(ixt_uni2)%></div>
                            </div></td>
                        <td><div align="center"><strong><%=nf1.format(ixt_uni3)%></strong></div></td>
                        <!--td><div align="center"><strong><span class="style6">$<%=nf1.format(cant_totMon)%></span></strong></div></td-->
                      </tr>
                    </table></td>
                  </tr>
                </table>
                <p>&nbsp;</p>
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
