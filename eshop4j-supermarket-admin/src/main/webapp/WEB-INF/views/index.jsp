<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
//String scheme = request.getScheme();//总是http
String port = request.getServerPort()==80?"":":" +String.valueOf(request.getServerPort());
String basePath = "//" + request.getServerName() +  port + path + "/";
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <base href="<%=basePath%>">
        <meta charset="utf-8" />
        <title>运营管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <meta name="MobileOptimized" content="320">
		
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
		<link type="text/css" rel="stylesheet" href="assets/plugins/bootstrap-fileinput-master/css/fileinput.min.css" />
		<link rel="stylesheet" type="text/css" href="assets/plugins/bootstrap-daterangepicker/1.3.6/font-awesome.min.css" />
		<link rel="stylesheet" type="text/css" href="assets/plugins/bootstrap-daterangepicker/1.3.6/daterangepicker-bs3.css" />
		
		<link rel="stylesheet" type="text/css" href="assets/plugins/bootstrap-switch/2.0.0/css/bootstrap3/bootstrap-switch.min.css" />
		
        <!-- BEGIN THEME STYLES -->
        <link href="assets/css/style-metronic.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style-responsive.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/plugins.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/pages/tasks.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/themes/default.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="assets/css/custom.css" rel="stylesheet" type="text/css" />
        <!-- END THEME STYLES -->
        <!-- BEGIN PLUGIN STYLES -->
		<link href="assets/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
        <!-- END PLUGIN STYLES -->
        <link rel="shortcut icon" href="app/img/favicon.ico" />
        <!-- 图片放大插件 -->
        <link rel="stylesheet" type="text/css" href="assets/plugins/zoom/zoom.css"/>
        <style type="text/css">
        	.table th, .table td { 
				text-align: center; 
			}
        </style>
    </head>
    <!-- END HEAD -->

    <!-- BEGIN BODY -->
    <body class="page-header-fixed">
        <!-- BEGIN HEADER -->
        <div class="header navbar navbar-inverse navbar-fixed-top">
            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">
                <!-- BEGIN LOGO -->
                <a class="navbar-brand" href="javascript:;">
                    <img src="assets/img/logo.png" alt="logo" class="img-responsive" />
                </a>
                <!-- END LOGO -->
                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <img
                    src="assets/img/menu-toggler.png" alt="" />
                </a>
                <!-- END RESPONSIVE MENU TOGGLER -->
                <!-- BEGIN TOP NAVIGATION MENU -->
                <ul class="nav navbar-nav pull-right">
                    <li class="dropdown user">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <img alt="" src="assets/img/avatar1_small.jpg"/>
                            <span class="username"> ${userInfo.username } </span>
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="javascript:;" id="trigger_fullscreen">
                                    <i class="fa fa-move"></i> 全屏
                                </a>
                            </li>
                            <!-- <li>
                                <a href="extra_lock.html">
                                    <i class="fa fa-lock"></i> 锁屏
                                </a>
                            </li> -->
                            <li>
                                <a href="rest/auth/logout">
                                    <i class="fa fa-key"></i> 退出
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- END USER LOGIN DROPDOWN -->
                </ul>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END TOP NAVIGATION BAR -->
        </div>
        <!-- END HEADER -->
        <div class="clearfix"></div>
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper">
                <div class="page-sidebar navbar-collapse collapse">
                    <!-- BEGIN SIDEBAR MENU -->
                    <ul class="page-sidebar-menu" id="page-sidebar-menu">
                        <li class="sidebar-toggler-wrapper">
                            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                            <div class="sidebar-toggler hidden-phone"></div>
                            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                        </li>

                        <li class="start active">
                            <a href="rest/page/dashboard" id="btn-dashboard">
                                <i class="fa fa-home"></i><span class="title"> 首页 </span><span
                                class="selected"> </span>
                            </a>
                        </li>

                    <c:if test="${!empty menus}">
                        <c:forEach items="${menus}" var="menu" varStatus="dn">

                            <c:choose>
                                <c:when test="${!empty menu.permissionSign}">
                                    <shiro:hasPermission name="${menu.permissionSign}">
                                        <li class="">
                                            <a href="javascript:;">
                                                <i class="fa <c:out value="${menu.menuIcon}" default="fa-group"/>"></i><span class="title"> <c:out value="${menu.menuName}" default=""/> </span><span class="arrow "> </span>
                                            </a>
                                            <c:if test="${!empty menu.childList}">
                                                <ul class="sub-menu">
                                                    <c:forEach items="${menu.childList}" var="item" varStatus="dx">
                                                        <c:choose>
                                                            <c:when test="${!empty item.permissionSign}">
                                                                <shiro:hasPermission name="${item.permissionSign}">
                                                                    <li>
                                                                        <a href="<c:out value="${item.menuUrl}" default="javascript:;"/>">
                                                                            <c:out value="${item.menuName}" default=""/>
                                                                        </a>
                                                                    </li>
                                                                </shiro:hasPermission>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>
                                                                    <a href="<c:out value="${item.menuUrl}" default="javascript:;"/>">
                                                                        <c:out value="${item.menuName}" default=""/>
                                                                    </a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:forEach>
                                                </ul>
                                            </c:if>
                                        </li>
                                    </shiro:hasPermission>
                                </c:when>
                                <c:otherwise>
                                    <li class="">
                                        <a href="javascript:;">
                                            <i class="fa <c:out value="${menu.menuIcon}" default="fa-group"/>"></i><span class="title"> <c:out value="${menu.menuName}" default=""/> </span><span class="arrow "> </span>
                                        </a>
                                        <c:if test="${!empty menu.childList}">
                                            <ul class="sub-menu">
                                                <c:forEach items="${menu.childList}" var="item" varStatus="dx">
                                                    <c:choose>
                                                        <c:when test="${!empty item.permissionSign}">
                                                            <shiro:hasPermission name="${item.permissionSign}">
                                                                <li>
                                                                    <a href="<c:out value="${item.menuUrl}" default="javascript:;"/>">
                                                                        <c:out value="${item.menuName}" default=""/>
                                                                    </a>
                                                                </li>
                                                            </shiro:hasPermission>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>
                                                                <a href="<c:out value="${item.menuUrl}" default="javascript:;"/>">
                                                                    <c:out value="${item.menuName}" default=""/>
                                                                </a>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:otherwise>
                            </c:choose>


                        </c:forEach>
                    </c:if>



                    </ul>
                    <!-- END SIDEBAR MENU -->
                </div>
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <div class="page-content">
                    <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
                    <div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                    <h4 class="modal-title">Modal title</h4>
                                </div>
                                <div class="modal-body">
                                    Widget settings form goes here
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn blue">
                                        Save changes
                                    </button>
                                    <button type="button" class="btn default" data-dismiss="modal">
                                        Close
                                    </button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- /.modal -->
                    <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
                    <!-- BEGIN STYLE CUSTOMIZER -->
                    <div class="theme-panel hidden-xs hidden-sm">
                        <div class="toggler"></div>
                        <div class="toggler-close"></div>
                        <div class="theme-options">
                            <div class="theme-option theme-colors clearfix">
                                <span> 主题颜色 </span>
                                <ul>
                                    <li class="color-black current color-default" data-style="default"></li>
                                    <li class="color-blue" data-style="blue"></li>
                                    <li class="color-brown" data-style="brown"></li>
                                    <li class="color-purple" data-style="purple"></li>
                                    <li class="color-grey" data-style="grey"></li>
                                    <li class="color-white color-light" data-style="light"></li>
                                </ul>
                            </div>
                            <div class="theme-option">
                                <span> 布局 </span>
                                <select class="layout-option form-control input-small">
                                    <option value="fluid">顺序</option>
                                    <option value="boxed">盒状</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> 标题 </span>
                                <select class="header-option form-control input-small">
                                    <option value="fixed">固定</option>
                                    <option value="default">默认</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> 工具栏 </span>
                                <select class="sidebar-option form-control input-small">
                                    <option value="fixed">固定</option>
                                    <option value="default">默认</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> 工具栏位置 </span>
                                <select class="sidebar-pos-option form-control input-small">
                                    <option value="left">左边</option>
                                    <option value="right">右边</option>
                                </select>
                            </div>
                            <div class="theme-option">
                                <span> 页脚 </span>
                                <select class="footer-option form-control input-small">
                                    <option value="fixed">固定</option>
                                    <option value="default">默认</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <!-- END STYLE CUSTOMIZER -->

                    <!-- BEGIN PAGE HEADER-->
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                            <h3 class="page-title" id="index-page-title">${menu2 }</h3>
                            <ul class="page-breadcrumb breadcrumb">
                                <li>
                                    <i class="fa fa-home"></i>
                                    <a href="javascript:;" id="index-menu">
                                        ${menu }
                                    </a>
                                    <i class="fa fa-angle-right"></i>
                                </li>
                                <li>
                                    <a href="javascript:;" id="index-menu2">
                                        ${menu2 }
                                    </a>
                                </li>
                            </ul>
                            <!-- END PAGE TITLE & BREADCRUMB-->
                        </div>
                    </div>
                    <!-- END PAGE HEADER-->

                    <!-- BEGIN DASHBOARD STATS -->
                    <div id="main-content"></div>

                    <!-- END PORTLET-->
                </div>
            </div>
            <jsp:include page="model.jsp"></jsp:include>
            <!-- END CONTENT -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="footer">
            <div class="footer-inner">
                2016 &copy; Rapid4J By ESHOP.
            </div>
            <div class="footer-tools">
                <span class="go-top"><i class="fa fa-angle-up"></i></span>
            </div>
        </div>
        
        <!--[if lt IE 9]>
        <script src="assets/plugins/respond.min.js"></script>
        <script src="assets/plugins/excanvas.min.js"></script>
        <![endif]-->
        <script src="assets/plugins/jquery/jquery-1.11.1.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
        <script src="assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery.cokie.min.js" type="text/javascript"></script>
        <script src="assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
		<!-- layer弹层组件 -->
		 <script type="text/javascript" src="assets/plugins/layer/layer.js"></script>
		<!--  toast提示 -->
		 <script type="text/javascript" src="assets/plugins/bootstrap-toastr/toastr.min.js"></script>
		<!--  阻塞性box提示 -->
		 <script type="text/javascript" src="assets/plugins/bootbox/bootbox.min.js"></script>
		 <!-- 翻页 -->
		 <script type="text/javascript" src="assets/plugins/bootstrap-paginator/build/bootstrap-paginator.min.js"></script>
		
         <!--表单验证库,这里必须引入form,否则提交会被认为是普通表单提交--> 
        <script src="assets/plugins/jquery-validation/lib/jquery.form.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript"></script>
        <script src="assets/plugins/jquery-validation/dist/localization/messages_zh.js"></script>
         <!--表单验证库--> 
        <script type="text/javascript" src="assets/plugins/select2/select2.min.js"></script>
        <!-- 上传插件 -->
        <script type="text/javascript" src="assets/plugins/bootstrap-fileinput-master/js/fileinput.min.js"></script>
		<script type="text/javascript" src="assets/plugins/bootstrap-fileinput-master/js/locales/zh.js"></script>
		<!-- 日期插件 -->
		<script type="text/javascript" src="assets/plugins/bootstrap-daterangepicker/1.3.6/moment.js"  ></script>
		<script type="text/javascript" src="assets/plugins/bootstrap-daterangepicker/1.3.6/daterangepicker.js"></script>
		
		<!--开关插件 -->
		<script type="text/javascript" src="assets/plugins/bootstrap-switch/2.0.0/js/bootstrap-switch.min.js"></script>
		
		<!-- 图片放大插件 -->
 		<script type="text/javascript" src="assets/plugins/zoom/zoom.js"></script>
		 
        <script type="text/javascript" src="app/js/app.js" ></script>
        <script type="text/javascript" src="app/js/index.js"></script>
        <script type="text/javascript" src="app/js/utils.js"></script>
        <script type="text/javascript" src="app/common/milo.js"></script>
        <!-- <script data-main="app/js/main" src="app/lib/requirejs/require.js"></script> -->
    </body>
</html>