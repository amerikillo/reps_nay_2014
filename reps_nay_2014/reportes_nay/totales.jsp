<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../pag_man.html" session = "true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >
<%
HttpSession sesion = request.getSession(); 
////out.print("Id de sesion: "+sesion.getId());
String val_sesion="", us_sesion="";



if (sesion.getAttribute("valida")!=null){
	val_sesion=(String)sesion.getAttribute("valida");
	us_sesion=(String)sesion.getAttribute("usuario");
}

//out.print(user);
if(!val_sesion.equals("valido")){
	
	%>
    <script>self.location='index.jsp';</script>
    <%
}
%>
<%
String total_med_uni="",total_mc_uni="",total_precios_med="",total_precios_mc="",subt="",iva="", total="",suma_med_mc="",uni="",fe1="",fe2="";;
int total_med_int=0,total_mc_int=0,subt_int=0;
double tax_d=0.0;

try { 
      //Para nombre de la Unidad
	  uni=request.getParameter("uni");//nombre de la unidad
	  
	  //Para fechas
	  fe1=request.getParameter("fe1");//fecha 1
	  fe2=request.getParameter("fe2");//fecha 2
     
      //Para medicamento
	  total_med_uni=request.getParameter("total_med");//piezas
	  total_precios_med=request.getParameter("precios_med");//importes
	 	  
	  //Para MC
	  total_mc_uni=request.getParameter("total_mcur");//piezas
	  total_precios_mc=request.getParameter("precios_mc");//importes
	  
	  // Suma de Medicamento más MC
	  suma_med_mc=request.getParameter("suma_med_mc");
	  
	  //Importe de subtotal, iva y total
	   subt=request.getParameter("subt");//subtotal med+mc
	   iva=request.getParameter("iva");//subtotal med+mc
	   total=request.getParameter("total_g");//subtotal med+mc
           // ban_jv=Integer.parseInt(ban);
      
    
	}catch(Exception e){System.out.print("not");}




%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>TOTALES DEL REPORTE 5</title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.Estilo2 {font-size: 12px; font-weight: bold; }
.Estilo4 {font-size: 16px}
.Estilo5 {font-size: 14px; font-weight: bold; }
.Estilo6 {font-size: 14px}
.Estilo7 {color: #000066}
-->
</style>
</head>

<body>
<table width="442" border="1" align="center">
  <tr>
    <th colspan="3" scope="col"  background="../imagen/fon4.png" class="style1">REPORTE NO. 5 - REPORTE DETALLADO POR RECETA</th>
  </tr>
  <tr>
    <th colspan="3" scope="row"><%=uni%></th>
  </tr>
  <tr>
    <th colspan="3" scope="row">PERIODO DEL<span class="Estilo7">:&nbsp;<span class="Estilo7">&nbsp;<%=fe1%></span></span> &nbsp;&nbsp;AL<span class="Estilo7">:&nbsp;&nbsp;<%=fe2%></span> </th>
  </tr>
  <tr>
    <th scope="row">&nbsp;</th>
    <th scope="row"><span class="Estilo4">PIEZAS</span></th>
    <!--th scope="row"><span class="Estilo4">IMPORTES</span></th-->
  </tr>
  <tr height="20">
    <td width="212" height="28" background="../imagen/fon4.png"><div align="right" class="Estilo2"><span class="style1"><a name="ir_aba" id="ir_aba"></a>TOTAL MEDICAMENTO:</span></div></td>
    <td width="104"><div align="center" class="Estilo5"><span class="style4"><%=total_med_uni%></span></div></td>
    <!--td width="104"><div align="right" class="style4 Estilo6"><strong>$&nbsp;<%=total_precios_med%></strong></div></td-->
  </tr>
                            <tr height="20">
                                <td height="27" background="../imagen/fon4.png" class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL MATERIAL DE CURACI&Oacute;N:</span></div></td>
                                <td><div align="center" class="Estilo5"><span class="style4"><%=total_mc_uni%></span></div></td>
                                <!--td><div align="right"><span class="Estilo6 style4"><strong>$&nbsp;<%=total_precios_mc%></strong></span></div></td-->
                            </tr>
                            <tr height="20">
                                <td height="28" background="../imagen/fon4.png"class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL OTROS (INSUMOS SOLO DESPLAZADOS):</span></div></td>
                                <td><div align="center"><span class="style4 Estilo6"><strong>0</strong></span></div></td>
                                <!--td><div align="right"><span class="style4 Estilo6"><strong>$ 0.00</strong></span></div></td-->
                            </tr>
                            <tr height="20">
                                <td height="27" background="../imagen/fon4.png" class="style4"><div align="right" class="Estilo2"><span class="style1">SUBTOTAL:</span></div></td>
                                <td>&nbsp;</td>
                                <!--td><div align="right"><span class="Estilo6 style4"><strong>$&nbsp;
                                <%=subt%>
                                </strong></span></div></td-->
                            </tr>
                            <tr height="20">
                                <td height="28" background="../imagen/fon4.png" class="style4"><div align="right" class="Estilo2"><span class="style1">IMPUESTO:</span></div></td>
                                <td>&nbsp;</td>
                                <!--td><div align="right"><span class="style4 Estilo6"><strong>$&nbsp;<%=iva%></strong></span></div></td>
                            </tr-->
  <tr height="20">
                                <td height="29" background="../imagen/fon4.png" class="style4"><div align="right" class="Estilo2"><span class="style1">TOTAL GENERAL:</span></div></td>
    <td><div align="center" class="Estilo6"><strong><span class="style4"><%=suma_med_mc%></span></strong></div></td>
                                <!--td><div align="right"><span class="style4 Estilo6"><strong>$&nbsp;<%=total%></strong></span></div></td-->
  </tr>
</table>
</body>
</html>
