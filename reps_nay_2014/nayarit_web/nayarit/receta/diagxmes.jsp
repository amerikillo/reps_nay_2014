<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="../../../pag_man.html" session="true" %>

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
ResultSet rset_2=null;
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
String descri_jv="";

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
int cont27=0;
int cont28=0;
int cont29=0;
int cont30=0;
int cont31=0;
int cont32=0;
int cont33=0;
int x=0;

int ed=0;//variable que toma el total de edad
int edd=0;//variable que toma el valor de la consulta
double res_por=0.0,res_por1=0.0,res_por2=0.0,res_por3=0.0,res_por4=0.0,res_por5=0.0,res_por6=0.0,res_por7=0.0,res=0.0,res1=0.0,res2=0.0,res3=0.0,res4=0.0,res5=0.0,res6=0.0,res7=0.0 ;
double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;//variables para dar formato de 0.00
int total_pzs=0,total_medi=0,total_cura=0;
String total_jv="";

try {
		unidad_jv = request.getParameter("med");       			   
} catch (Exception e) { }

try {
		descri_jv = request.getParameter("descr");       			   
} catch (Exception e) { }


Statement stmt_sexf = null;

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
     stmt_sexf = conexion.createStatement();
	 
	 
	 
	 
         /*guardando la conexion en la session*/
        session.setAttribute("conexion",conexion);
       } catch (Exception ex){
        mensaje=ex.toString();
    }
    mensaje="conectado";
    if(conexion.isClosed()){
        mensaje="desconectado";
    }


		  
rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-04-01' and '2013-04-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont1=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-05-01' and '2013-05-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont2=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				 rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-06-01' and '2013-06-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont3=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }   
				   
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-07-01' and '2013-07-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont4=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-08-01' and '2013-08-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont5=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-09-01' and '2013-09-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont6=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-10-01' and '2013-10-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont7=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-11-01' and '2013-11-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont8=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2012-08-01' and '2012-08-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont9=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2012-09-01' and '2012-09-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont10=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2012-10-01' and '2012-10-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont11=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2012-11-01' and '2012-11-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont12=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2012-12-01' and '2012-12-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont13=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-01-01' and '2013-01-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont14=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-02-01' and '2013-02-28' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont15=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-03-01' and '2013-03-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont16=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-12-01' and '2013-12-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont17=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-01-01' and '2014-01-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont18=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-02-01' and '2014-02-28' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont19=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-03-01' and '2014-03-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont20=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-04-01' and '2014-04-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont21=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-05-01' and '2014-05-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont22=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-06-01' and '2014-06-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont23=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-07-01' and '2014-07-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont24=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-08-01' and '2014-08-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont25=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-09-01' and '2014-09-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont26=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-10-01' and '2014-10-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont27=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-11-01' and '2014-11-30' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont28=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-12-01' and '2014-12-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont29=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2012-01-01' and '2012-12-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont30=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2013-01-01' and '2013-12-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont31=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where fecha between '2014-01-01' and '2014-12-31' and cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont32=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(diag1) from t_diag_princ where cldia1='"+unidad_jv+"' group by cedis ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  cont33=Integer.parseInt(rset_sexf.getString("sum(diag1)"));
			       }
				   //FIN DEL WHILE
					res=cont;
					res1=cont1;
					res2=cont2;
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
//					out.print(""+res_por7);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../../../css/dis1.css" type="text/css" />

<title>Untitled Document</title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style4 {color: #003366}
.style5 {
	color: #000000;
	font-weight: bold;
}
.style7 {font-size: 14px}
-->
</style>
</head>

<body>

<form name="form" action="diagxmes.jsp" method="post">
<table width="147" border="0" align="left">
  <tr>
    <td><a href="diagmes.jsp">Regresar a Men&uacute; </a></td>
  </tr>
</table>
<table width="518" height="76" border="2" align="left" bordercolor="#A01B24">
  <tr>
    <th scope="col"><div align="left">
      <table width="581" border="1" cellpadding="1">
        
          <tr>
            <td height="29" colspan="4" bgcolor="#A01B24" class="dis3" ><div align="center">DIAGNOSTICOS POR MES CIE-10=<%=unidad_jv%>&nbsp;DESCRIPCI&Oacute;N=<%=descri_jv%></div></td>
            </tr>
          <tr>
            <td colspan="4" bgcolor="#A01B24" class="dis3" align="center" >PERIODO</td>
            </tr>
          <tr>
            <td width="193" height="26"  align="center" bgcolor="#A01B24" class="dis2"><span class="dis2">MES</td>
            <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2012</td>
            <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2013</td>
            <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2014</td>
            
          </tr>
        
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">ENERO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont14)%></td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont18)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">FEBRERO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont15)%></td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont19)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">MARZO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont16)%></td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont20)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">ABRIL</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont1)%></td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont21)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">MAYO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont2)%></td>
           <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont22)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">JUNIO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont3)%></td>
          <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont23)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">JULIO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center">0</td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont4)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont24)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">AGOSTO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont9)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont5)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont25)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">SEPTIEMBRE</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont10)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont6)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont26)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">OCTUBRE</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont11)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont7)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont27)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">NOVIEMBRE</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont12)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont8)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont28)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">DICIEMBRE</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont13)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont17)%></td>
<td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont29)%></td>
            
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">TOTAL POR PERIODO</td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont30)%></td>
          <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont31)%></td>
            <td bgcolor="#FFFFFF" class="ver-" align="center"><%=nf1.format(cont32)%></td>
        
          </tr>
          <tr>
          <td colspan="2" bgcolor="#FFFFFF" class="ver-"><div align="center">TOTAL DE DIAGNOSTICOS</div>            <div align="center"></div></td>
          <td colspan="2" bgcolor="#FFFFFF" class="ver-"><div align="center"><%=nf1.format(cont33)%></div>            <div align="center"></div></td>
		 
		  
		  
          </tr>         
      </table>
    </div></th>
  </tr>
</table>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<table width="903" border="0">
  <tr>
    <td><div ><span class="style7">Indica el total del diagnostico&nbsp;<%=unidad_jv%> encontrato por mes, en el periodo 2012,2013 y 2014.</span> </div></td>
  </tr>
</table>
<p align="center">&nbsp;</p>
<table width="1011" border="0">
  
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
