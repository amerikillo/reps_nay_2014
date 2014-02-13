<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="../pag_man.html" session="true"%>
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
<script>self.location='../index.jsp';</script>
<%
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: MEN&Uacute; DE OPCIONES ::</title>
<script src="../jq/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryDOMUtils.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryDOMEffects.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryWidget.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryPanelSelector.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryPanelSet.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryFadingPanels.js" type="text/javascript"></script>
<script src="../jq/Spry-UI-1.7/includes/SpryContentSlideShow.js" type="text/javascript"></script>
<link href="../jq/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<link href="../jq/Spry-UI-1.7/css/ContentSlideShow/wanderlust/wanderlust-brown.css" rel="stylesheet" type="text/css" />
<script type="text/xml">
<!--
<oa:widgets>
  <oa:widget wid="2141541" binding="#ImageSlideShow" />
  <oa:widget wid="2141541" binding="#ImageSlideShow_2" />
  <oa:widget wid="2141541" binding="#ImageSlideShow_3" />
  <oa:widget wid="2141541" binding="#ImageSlideShow_4" />
  <oa:widget wid="2141541" binding="#ImageSlideShow_5" />
  <oa:widget wid="2141541" binding="#ImageSlideShow_6" />
  <oa:widget wid="2141541" binding="#ImageSlideShow_7" />
</oa:widgets>
-->
function irMenu()
{
//alert("hello");
location='index_menus.html';
}
</script>
<style type="text/css">
<!--
.Estilo1 {
	font-size: 14px
}
-->
</style>
</head>

<body>
<div class="TabbedPanelsContent">
  <table width="703" border="0">
    <tr>
      <td colspan="2" bgcolor="#AA0000" class="TITULO">MENU DE OPCIONES </td>
    </tr>
    <tr>
      <td colspan="2" bgcolor="#FFFFFF" class="a2"><div align="center" class="Estilo1">BIENVENIDOS</div></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="a2"><a href="../reportes_nay/index_main.jsp" target="_parent">Regresar a Men&uacute;</a></td>
      <td bgcolor="#FFFFFF" class="a1">&nbsp;</td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0" class="a2">OPCI&Oacute;N 1: </td>
      <td bgcolor="#C0C0C0" class="a1"><a href="nayarit/infor.jsp">PIEZAS ENTREGADAS A ALMACENES Y PRIMER NIVEL</a></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="a2">&nbsp;</td>
      <td bgcolor="#FFFFFF" class="a1">&nbsp;</td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0" class="a2">OPCI&Oacute;N 2: </td>
      <td bgcolor="#C0C0C0" class="a1"><a href="nayarit/nayarit_disp/infor.jsp">PIEZAS DISPENSADAS POR FARMACIAS</a></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="a2">&nbsp;</td>
      <td bgcolor="#FFFFFF" class="a1">&nbsp;</td>
    </tr>
    <tr>
      <td bgcolor="#C0C0C0" class="a2">OPCI&Oacute;N 3: </td>
      <td bgcolor="#C0C0C0" class="a1"><a href="dist_farm/infor.jsp">PIEZAS </a><a href="dist_farm/infor.jsp">ENTREGADAS</a><a href="dist_farm/infor.jsp"> A FARMACIAS </a></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF" class="a2">&nbsp;</td>
      <td bgcolor="#FFFFFF" class="a1">&nbsp;</td>
    </tr>
  </table>
  <div id="ImageSlideShow">
    <div class="article">
      <div class="photo"> <img src="menu/100_0001.JPG" alt="" />
        <div class="caption">Desarrollo de Software GNKL </div>
      </div>
      <div class="story">
        <div class="banner">
          <div class="title">REPORTES WEB </div>
          <div class="subTitle"> Insumos distribuidos </div>
        </div>
        <div class="content">
          <p>Men&uacute; de Opciones para Informaci&oacute;n de Reportes WEB Insumos Distribuidos en Unidades Rurales y CEAPS </p>
        </div>
      </div>
    </div>
    <div class="article">
      <div class="photo"> <img src="menu/100_0014.JPG" alt="Servicios" />
        <div class="caption">Desarrollo de Software GNKL </div>
      </div>
      <div class="story">
        <div class="banner">
          <div class="title">REPORTES WEB </div>
          <div class="subTitle">Insumos distribuidos</div>
        </div>
        <div class="content">
          <p>Men&uacute; de Opciones para Informaci&oacute;n de Reportes WEB Insumos Distribuidos en Unidades Rurales y CEAPS </p>
        </div>
      </div>
    </div>
    <div class="article">
      <div class="photo"> <img src="menu/100_0116.JPG" alt="Open Space" />
        <div class="caption">Desarrollo de Software GNKL</div>
      </div>
      <div class="story">
        <div class="banner">
          <div class="title">REPORTES WEB</div>
          <div class="subTitle">Insumos distribuidos</div>
        </div>
        <div class="content">
          <p>Men&uacute; de Opciones para Informaci&oacute;n de Reportes WEB Insumos Distribuidos en Unidades Rurales y CEAPS </p>
        </div>
      </div>
    </div>
    <div class="article">
      <div class="photo"> <img src="menu/Fachada_Tecuala.jpg" alt="Orchids" />
        <div class="caption">Desarrollo de Software GNKL</div>
      </div>
      <div class="story">
        <div class="banner">
          <div class="title">REPORTES WEB</div>
          <div class="subTitle">Insumos distribuidos</div>
        </div>
        <div class="content">
          <p>Men&uacute; de Opciones para Informaci&oacute;n de Reportes WEB Insumos Distribuidos en Unidades Rurales y CEAPS</p>
        </div>
      </div>
    </div>
    <div class="article">
      <div class="photo"> <img src="menu/fachada3.jpg" alt="Orchids" />
        <div class="caption">Desarrollo de Software GNKL</div>
      </div>
      <div class="story">
        <div class="banner">
          <div class="title">REPORTES WEB</div>
          <div class="subTitle">Insumos distribuidos</div>
        </div>
        <div class="content">
          <p>Men&uacute; de Opciones para Informaci&oacute;n de Reportes WEB Insumos Distribuidos en Unidades Rurales y CEAPS</p>
        </div>
      </div>
    </div>
    <div class="article">
      <div class="photo"> <img src="menu/FACHADA.jpg" alt="Equipo de Cómputo" />
        <div class="caption">Desarrollo de Software GNKL</div>
      </div>
      <div class="story">
        <div class="banner">
          <div class="title">REPORTES WEB</div>
          <div class="subTitle">Insumos distribuidos</div>
        </div>
        <div class="content">
          <p>Men&uacute; de Opciones para Informaci&oacute;n de Reportes WEB Insumos Distribuidos en Unidades Rurales y CEAPS</p>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
// BeginOAWidget_Instance_2141541: #ImageSlideShow

var ImageSlideShow = new Spry.Widget.ContentSlideShow("#ImageSlideShow", {
	widgetClass: "WLBSlideShow",
	displayInterval: 4000,
	transitionDuration: 2000
});

// EndOAWidget_Instance_2141541
      </script> 
</div>
<script type="text/javascript">
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
</script>
</body>
</html>
