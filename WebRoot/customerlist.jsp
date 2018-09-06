<%@page import="com.lee.view.*"%>
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
						收件箱 <span class="am-badge am-badge-warning">5</span> </a></li>
				<li class="am-dropdown" data-am-dropdown><a
					class="am-dropdown-toggle" data-am-dropdown-toggle
					href="javascript:;"> <span class="am-icon-users"></span> <%=session.getAttribute("worker_name")%>
						<span class="am-icon-caret-down"></span> </a>
					<ul class="am-dropdown-content">
						<li><a href="#"><span class="am-icon-user"></span> 资料</a></li>
						<li><a href="#"><span class="am-icon-cog"></span> 设置</a></li>
						<li><a href="login.jsp"><span class="am-icon-power-off"></span>
								退出</a></li>
					</ul>
				</li>
				<li class="am-hide-sm-only"><a href="javascript:;"
					id="admin-fullscreen"><span class="am-icon-arrows-alt"></span>
						<span class="admin-fullText">开启全屏</span> </a></li>
			</ul>
		</div>
	</header>

	<div class="am-cf admin-main">
		<!-- sidebar start -->
		<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
			<div class="am-offcanvas-bar admin-offcanvas-bar">
				<ul class="am-list admin-sidebar-list">
					<li><a href="index.jsp"><span class="am-icon-home"></span>
							餐桌管理</a></li>
					<li><a href="orderlist.jsp"><span class="am-icon-table"></span>
							订单管理</a></li>
					<li><a href="workerlist.jsp"><span class="am-icon-users"></span>
							员工管理</a></li>
					<li><a href="customerlist.jsp"><span class="am-icon-bank"></span>
							客户管理</a>
					</li>
					<li><a href="selllist.jsp"><span class="am-icon-diamond"></span>
							销售管理</a>
					</li>
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
		<div class="admin-content">
			<div class="admin-content-body">
				<table class="am-table am-table-striped am-table-hover">
					<thead>
						<tr>
							<th>客户姓名</th>
							<th>年龄</th>
							<th>性别</th>
							<th>电话</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
							CustomerModel cm=new CustomerModel();
											List<CustomerVo> li=cm.selectCustomers();
											Iterator<CustomerVo> it=li.iterator();
											while(it.hasNext()){
												CustomerVo cv=it.next();
						%>
						<tr>
							<td><%=cv.getName()%></td>
							<td><%=cv.getAge()%></td>
							<td>
								<%
									if(cv.getGender()==1){
												 			out.print("男");
												 		}
												 			else{
												 			out.print("女");
												 			}
								%>
							</td>
							<td><%=cv.getTel()%></td>
							<td><a class="am-btn am-btn-default am-btn-xs"
								href="/restaurant/CustomerCtrl?action=updateshow&id=<%=cv.getId()%>"
								target="_top"><span
									class="am-icon-pencil-square-o  am-text-primary"> 修改</span> </a> <a
								class="am-btn am-btn-default am-btn-xs"
								href="/restaurant/CustomerCtrl?action=delete&id=<%=cv.getId()%>"
								target="_top"><span class="am-icon-trash  am-text-danger">
										删除</span> </a> 
								<a class="am-btn am-btn-default am-btn-xs"
								href="/restaurant/CustomerCtrl?action=selectseat&id=<%=cv.getId()%>"
								target="_top"><span class="am-icon-coffee  am-text-danger">
										选座</span> </a>
								
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="am-g am-text-center">
					<a class="am-btn am-btn-success am-btn-xs"
						href="insertcustomer.jsp" target="_top"><span
						class="am-icon-book "> 新增</span> </a>
				</div>
			</div>

			<footer class="admin-content-footer">
				<hr>
				<p class="am-padding-left">© Jiagen Lee designed by Amaze UI.
					under MIT license.</p>
			</footer>

		</div>

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