<%@page import="com.lee.view.TableVo"%>
<%@page import="com.lee.model.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!doctype html>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>自助餐厅管理系统</title>
<meta name="description" content="这是一个 index 页面">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed"
	href="assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="assets/css/amazeui.min.css" />
<link rel="stylesheet" href="assets/css/admin.css">
</head>
<body>
	<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
  以获得更好的体验！</p>
<![endif]-->

	<header class="am-topbar am-topbar-inverse admin-header">
		<div class="am-topbar-brand">
			<strong>自助餐厅</strong> <small>管理系统</small>
		</div>

		<button
			class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
			data-am-collapse="{target: '#topbar-collapse'}">
			<span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span>
		</button>

		<div class="am-collapse am-topbar-collapse" id="topbar-collapse">

			<ul
				class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
				<li><a href="javascript:;"><span class="am-icon-envelope-o"></span>
						收件箱 <span class="am-badge am-badge-warning">5</span>
				</a>
				</li>
				<li class="am-dropdown" data-am-dropdown><a
					class="am-dropdown-toggle" data-am-dropdown-toggle
					href="javascript:;"> <span class="am-icon-users"></span> <%=session.getAttribute("worker_name")%>
						<span class="am-icon-caret-down"></span> </a>
					<ul class="am-dropdown-content">
						<li><a href="#"><span class="am-icon-user"></span> 资料</a>
						</li>
						<li><a href="#"><span class="am-icon-cog"></span> 设置</a>
						</li>
						<li><a href="login.jsp"><span class="am-icon-power-off"></span>
								退出</a>
						</li>
					</ul></li>
				<li class="am-hide-sm-only"><a href="javascript:;"
					id="admin-fullscreen"><span class="am-icon-arrows-alt"></span>
						<span class="admin-fullText">开启全屏</span>
				</a>
				</li>
			</ul>
		</div>
	</header>

	<div class="am-cf admin-main">
		<!-- sidebar start -->
		<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
			<div class="am-offcanvas-bar admin-offcanvas-bar">
				<ul class="am-list admin-sidebar-list">
					<li><a href="index.jsp"><span class="am-icon-home"></span>
							餐桌管理</a>
					</li>
					<li><a href="orderlist.jsp"><span class="am-icon-table"></span>
							订单管理</a>
					</li>
					<li><a href="workerlist.jsp"><span class="am-icon-users"></span>
							员工管理</a>
					</li>
					<li><a href="customerlist.jsp"><span class="am-icon-bank"></span>
							客户管理</a></li>
					<li><a href="selllist.jsp"><span class="am-icon-diamond"></span> 销售管理</a></li>
				</ul>

				<div class="am-panel am-panel-default admin-sidebar-panel">
					<div class="am-panel-bd">
						<p>
							<span class="am-icon-bookmark"></span> 公告
						</p>
						<p>李佳根毕业设计</p>
					</div>
				</div>

				<div class="am-panel am-panel-default admin-sidebar-panel">
					<div class="am-panel-bd">
						<p>
							<span class="am-icon-tag"></span> wiki
						</p>
						<p>推倒柏林墙！</p>
					</div>
				</div>
			</div>
		</div>
		<!-- sidebar end -->
		<!-- content start -->
		<form action="/restaurant/TableCtrl?action=update" method="post" class="am-form">
			<fieldset>
				<legend></br>餐桌状态</legend>

				<div class="am-form-group">
					<label>餐桌号：</label> <br/>
					<label for="doc-ipt-email-1" ><% TableVo tv=(TableVo)request.getAttribute("tv");
							out.print(tv.getId()+"--");%><input type="hidden" name="id" value="<%=tv.getId()%>"><span class="am-icon-hand-o-right">
							<%
								if(tv.getId()/1000==1){
									out.print("A区");
									}
								else if(tv.getId()/1000==2){
									out.print("B区");
								}
								else{
									out.print("C区");
								}
								 %>
							
							</span></label>
					
				</div>
				<label>客人</label>
				<div class="am-form-group">
						<label class="am-radio-inline"> 
							<input type="radio" value="1" name="size"> 1位</label> 
						<label class="am-radio-inline"> 
							<input type="radio" value="2" name="size"> 2位 </label> 
						<label class="am-radio-inline">
							<input type="radio" value="3" name="size"> 3位</label>
						<label class="am-radio-inline">
							<input type="radio" value="4" name="size"> 4位</label>
				</div>
				<div class="am-form-group">
					<label for="doc-ipt-pwd-1">折扣</label> 
					<input type="text" name="discount" value="0" placeholder="如果没有折扣请填0">
				</div>

				<p>
					<button type="submit" class="am-btn am-btn-default">提交</button>
				</p>
			</fieldset>

		</form>
		<!-- content end -->
	</div>

	<a href="#"
		class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
		data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

	<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="assets/js/jquery.min.js"></script>
	<!--<![endif]-->
	<script src="assets/js/amazeui.min.js"></script>
	<script src="assets/js/app.js"></script>
</body>
</html>