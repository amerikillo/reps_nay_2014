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

Statement stmt_sexf = null;

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
	 
	          /*guardando la conexion en la session*/
        session.setAttribute("conexion",conexion);
       } catch (Exception ex){
        mensaje=ex.toString();
    }
    mensaje="conectado";
    if(conexion.isClosed()){
        mensaje="desconectado";
    }
				  
				  
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
String descri_jv="";
//variables para definir recetas, piezas y costos
String no_rec_elb="20";
String no_pzs_sol="";
String no_pzs_sur="";
String st="10";
String sf="10";

String ixt_cad="",ixt_cad1="",ixt_cad2="",ixt_cad3="",ixt_cad4="" ,ixt_cad5="" ,ixt_cad6="" ,ixt_cad7="" ,ixt_cad8="" ,ixt_cad9="" ,ixt_cad10="" ,ixt_cad11="" ,ixt_cad12="" ,ixt_cad13="" ,ixt_cad14="" ,ixt_cad15="" ,ixt_cad16="" ,ixt_cad17="" ,ixt_cad18="",ixt_cad19="",ixt_cad20="",ixt_cad21="",ixt_cad22="",ixt_cad23="",ixt_cad24="",ixt_cad25="",ixt_cad26="",ixt_cad27="",ixt_cad28="",ixt_cad29="",ixt_cad30="",ixt_cad31="",ixt_cad32="",ixt_cad33="";


int cant_pzs=0, ixt_uni=0 ,ixt_uni1=0 , ixt_uni2=0, ixt_uni3=0,ixt_uni4=0 ,ixt_uni5=0 ,ixt_uni6=0 ,ixt_uni7=0 ,ixt_uni8=0 ,ixt_uni9=0 ,ixt_uni10=0 ,ixt_uni11=0 ,ixt_uni12=0 ,ixt_uni13=0 ,ixt_uni14=0 ,ixt_uni15=0 ,ixt_uni16=0 ,ixt_uni17=0 ,ixt_uni18=0,ixt_uni19=0,ixt_uni20=0,ixt_uni21=0,ixt_uni22=0,ixt_uni23=0,ixt_uni24=0,ixt_uni25=0,ixt_uni26=0,ixt_uni27=0,ixt_uni28=0,ixt_uni29=0,ixt_uni30=0,ixt_uni31=0,ixt_uni32=0,ixt_uni33=0 ;

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
double res_por=0.0,res_por1=0.0,res_por2=0.0,res_por3=0.0,res_por4=0.0,res_por5=0.0,res_por6=0.0,res_por7=0.0,res=0.0,res1=0.0,res2=0.0,res3=0.0,res4=0.0,res5=0.0,res6=0.0,res7=0.0 ;
double total_mon_medi=0.0,total_mon_cura=0.0, total_montos=0.0, total_tot=0.0, montos_res=0.0;//variables para dar formato de 0.00
int total_pzs=0,total_medi=0,total_cura=0;

try {
		unidad_jv = request.getParameter("med");       			   
} catch (Exception e) { }

try {
		descri_jv = request.getParameter("descr");       			   
} catch (Exception e) { }

//out.print(""+unidad_jv);


		  
rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-04-01' and '2013-04-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				 ixt_cad9=rset_sexf.getString("sur");
					ixt_uni9 = Integer.parseInt(ixt_cad9);
				 // cont1++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-05-01' and '2013-05-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				 ixt_cad10=rset_sexf.getString("sur");
					ixt_uni10 = Integer.parseInt(ixt_cad10);
				 // cont2++;
			       }
				 rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-06-01' and '2013-06-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				 ixt_cad11=rset_sexf.getString("sur");
					ixt_uni11 = Integer.parseInt(ixt_cad11);
				 // cont3++;
			       }   
				   
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-07-01' and '2013-07-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad12=rset_sexf.getString("sur");
					ixt_uni12 = Integer.parseInt(ixt_cad12);
				  //cont4++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-08-01' and '2013-08-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad13=rset_sexf.getString("sur");
					ixt_uni13 = Integer.parseInt(ixt_cad13);
				  //cont5++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-09-01' and '2013-09-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad14=rset_sexf.getString("sur");
					ixt_uni14 = Integer.parseInt(ixt_cad14);
				  //cont6++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-10-01' and '2013-10-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad15=rset_sexf.getString("sur");
					ixt_uni15 = Integer.parseInt(ixt_cad15);
				  //cont7++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-11-01' and '2013-11-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad16=rset_sexf.getString("sur");
					ixt_uni16 = Integer.parseInt(ixt_cad16);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-12-01' and '2013-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad17=rset_sexf.getString("sur");
					ixt_uni17 = Integer.parseInt(ixt_cad17);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-01-01' and '2014-01-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad18=rset_sexf.getString("sur");
					ixt_uni18 = Integer.parseInt(ixt_cad18);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-02-01' and '2014-02-28' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad19=rset_sexf.getString("sur");
					ixt_uni19 = Integer.parseInt(ixt_cad19);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-03-01' and '2014-03-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad20=rset_sexf.getString("sur");
					ixt_uni20 = Integer.parseInt(ixt_cad20);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-04-01' and '2014-04-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad21=rset_sexf.getString("sur");
					ixt_uni21 = Integer.parseInt(ixt_cad21);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-05-01' and '2014-05-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad22=rset_sexf.getString("sur");
					ixt_uni22 = Integer.parseInt(ixt_cad22);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-06-01' and '2014-06-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad23=rset_sexf.getString("sur");
					ixt_uni23 = Integer.parseInt(ixt_cad23);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-07-01' and '2014-07-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad24=rset_sexf.getString("sur");
					ixt_uni24 = Integer.parseInt(ixt_cad24);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-08-01' and '2014-08-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad25=rset_sexf.getString("sur");
					ixt_uni25 = Integer.parseInt(ixt_cad25);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-09-01' and '2014-09-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad26=rset_sexf.getString("sur");
					ixt_uni26 = Integer.parseInt(ixt_cad26);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-10-01' and '2014-10-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad27=rset_sexf.getString("sur");
					ixt_uni27 = Integer.parseInt(ixt_cad27);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-11-01' and '2014-11-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad28=rset_sexf.getString("sur");
					ixt_uni28 = Integer.parseInt(ixt_cad28);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-12-01' and '2014-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad29=rset_sexf.getString("sur");
					ixt_uni29 = Integer.parseInt(ixt_cad29);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2012-01-01' and '2012-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad30=rset_sexf.getString("sur");
					ixt_uni30 = Integer.parseInt(ixt_cad30);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-01-01' and '2013-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad31=rset_sexf.getString("sur");
					ixt_uni31 = Integer.parseInt(ixt_cad31);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2014-01-01' and '2014-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad32=rset_sexf.getString("sur");
					ixt_uni32 = Integer.parseInt(ixt_cad32);
				  //cont8++;
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2012-08-01' and '2012-08-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad1=rset_sexf.getString("sur");
					ixt_uni1 = Integer.parseInt(ixt_cad1);
				  //cont9++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2012-09-01' and '2012-09-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad2=rset_sexf.getString("sur");
					ixt_uni2 = Integer.parseInt(ixt_cad2);
				  //cont10++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2012-10-01' and '2012-10-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad3=rset_sexf.getString("sur");
					ixt_uni3 = Integer.parseInt(ixt_cad3);
				  //cont11++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2012-11-01' and '2012-11-30' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad4=rset_sexf.getString("sur");
					ixt_uni4 = Integer.parseInt(ixt_cad4);
				  //cont12++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2012-12-01' and '2012-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				 
				 ixt_cad5=rset_sexf.getString("sur");
					ixt_uni5 = Integer.parseInt(ixt_cad5);
				 // cont13++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-01-01' and '2013-01-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad6=rset_sexf.getString("sur");
					ixt_uni6 = Integer.parseInt(ixt_cad6);
				  //cont14++;
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-02-01' and '2013-02-28' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  //cont15++;
				  ixt_cad7=rset_sexf.getString("sur");
					ixt_uni7 = Integer.parseInt(ixt_cad7);
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-03-01' and '2013-03-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  //cont16++;
				  ixt_cad8=rset_sexf.getString("sur");
					ixt_uni8 = Integer.parseInt(ixt_cad8);
			       }
				    rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where  j.cla_jur = m.cla_jur and   m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and  med.cla_med = r.cla_med and dr.fec_sur between '2013-12-01' and '2013-12-31' and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  //cont17++;
				  ixt_cad17=rset_sexf.getString("sur");
					ixt_uni = Integer.parseInt(ixt_cad17);
			       }
				   rset_sexf = stmt_sexf.executeQuery("select sum(dr.cant_sur) as sur from jurisdicciones j, municipios m, unidades u, receta r, detreceta dr, paciente p, detalle_productos dp, productos prod, medico med where j.cla_jur = m.cla_jur and  m.cla_mun = u.cla_mun and  u.cla_uni = r.cla_uni and  p.cla_pac = r.cla_pac and  r.id_rec = dr.id_rec and  dr.det_pro = dp.det_pro and  dp.cla_pro = prod.cla_pro and med.cla_med = r.cla_med and prod.cla_pro = '"+unidad_jv+"' group by prod.cla_pro ;");
 
					while (rset_sexf.next()) 
                  {
				  //edd=Integer.parseInt(rset_sexf.getString("folio"));
				  ixt_cad=rset_sexf.getString("sur");
					ixt_uni = Integer.parseInt(ixt_cad);
				  //cont26++;
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
.style7 {font-size: 14px}
.style9 {font-family: Verdana, Arial, Helvetica, sans-serif}
-->
</style>
</head>

<body>

<form name="form" action="medixmes.jsp" method="post">
<table width="147" border="0" align="left">
  <tr>
    <td><a href="medicamentmes.jsp">Regresar a Men&uacute; </a></td>
  </tr>
</table>
<table width="518" height="76" border="2" align="left" bordercolor="#A01B24">
  <tr>
    <th scope="col"><div align="left">
      <table width="558" border="1" cellpadding="1">
        
          <td height="29" colspan="23" bgcolor="#A01B24" class="dis3" ><div align="center">MEDICAMENTO POR MES CLAVE=<%=unidad_jv%>&nbsp;DESCRIPCION=<%=descri_jv%></div></td>
          </tr>
          <tr>
            <td colspan="6" bgcolor="#A01B24" class="dis3" align="center" >PERIODO </td>
            </tr>
          <tr>
          <td width="170" height="24"  align="center" bgcolor="#A01B24" class="dis2"><span class="style2">MES</td>
          <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2012</td>
		  <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2013</td>
		  <td width="120" align="center" bgcolor="#A01B24" class="dis2" >2014</td>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">ENERO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni6)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni18)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">FEBRERO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni7)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni19)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">MARZO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni8)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni20)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">ABRIL</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni9)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni21)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">MAYO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni10)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni22)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">JUNIO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni11)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni23)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">JULIO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center">0</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni12)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni24)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">AGOSTO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni1)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni13)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni25)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">SEPTIEMBRE</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni2)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni14)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni26)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">OCTUBRE</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni3)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni15)%></td>
           <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni27)%></td>
          </tr>
          <tr>
            <td height="29" bgcolor="#FFFFFF" class="ver-">NOVIEMBRE</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni4)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni16)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni28)%></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">DICIEMBRE</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni5)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni17)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni29)%></td>
          </tr>
          
          <tr>
            <td bgcolor="#FFFFFF" class="ver-">TOTAL POR PERIODO</td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni30)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni31)%></td>
            <td bgcolor="#FFFFFF" class="navText" align="center"><%=nf1.format(ixt_uni32)%></td>
          </tr>
          <tr>
          <td colspan="2" bgcolor="#FFFFFF" class="ver-">TOTAL MEDICAMENTO PREESCRITO</td>
          <td colspan="2" align="center" bgcolor="#FFFFFF" class="navText"><%=nf1.format(ixt_uni)%></td>
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
<p align="center">&nbsp;</p>
<table width="903" border="0">
  <tr>
    <td><div align="center"><span class="style7">Indica el total de medicamento&nbsp;&nbsp;<%=unidad_jv%> &nbsp;entregadas por mes.</span></div></td>
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
