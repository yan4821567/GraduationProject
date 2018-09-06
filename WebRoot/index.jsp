<%@page import="com.lee.view.OrderVo"%>
<%@page import="com.lee.view.TableVo"%>
<%@page import="com.lee.model.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
						<p>周二下午三点开会，不要迟到</p>
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
				<div class="am-cf am-padding am-padding-bottom-0">
					<div class="am-fl am-cf">
						<strong class="am-text-primary am-text-lg">餐桌列表</strong> / <small>Table</small>
					</div>
				</div>

				<hr>

				<div class="am-g">
					<div class="am-u-sm-12">
						<form class="am-form">
							<table
								class="am-table am-table-striped am-table-hover table-main">
								<thead>
									<tr>
										<th>餐桌号</th>
										<th>区域</th>
										<th class="table-author am-hide-sm-only">当前人数</th>
										<th class="table-date am-hide-sm-only">当前状态</th>
										<th>消费金额</th>
										<th class="table-set">操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1001</td>
										<td>A</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(1001).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(1001).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(1001).isHasone()){
											OrderVo ov11=new OrderModel().selectOrderByTid(1001);
											out.print(ov11.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=1001"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=1001"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>1002</td>
										<td>A</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(1002).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(1002).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(1002).isHasone()){
											OrderVo ov12=new OrderModel().selectOrderByTid(1002);
											out.print(ov12.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=1002"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=1002"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>1003</td>
										<td>A</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(1003).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(1003).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(1003).isHasone()){
											OrderVo ov13=new OrderModel().selectOrderByTid(1003);
											out.print(ov13.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=1003"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=1003"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>1004</td>
										<td>A</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(1004).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(1004).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(1004).isHasone()){
											OrderVo ov14=new OrderModel().selectOrderByTid(1004);
											out.print(ov14.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=1004"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=1004"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>2001</td>
										<td>B</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(2001).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(2001).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(2001).isHasone()){
											OrderVo ov21=new OrderModel().selectOrderByTid(2001);
											out.print(ov21.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=2001"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=2001"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>2002</td>
										<td>B</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(2002).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(2002).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(2002).isHasone()){
											OrderVo ov22=new OrderModel().selectOrderByTid(2002);
											out.print(ov22.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=2002"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=2002"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>2003</td>
										<td>B</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(2003).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(2003).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(2003).isHasone()){
											OrderVo ov23=new OrderModel().selectOrderByTid(2003);
											out.print(ov23.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=2003"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=2003"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>2004</td>
										<td>B</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(2004).getSize());
											%>/4</td>
										<%
											if(!new TableModel().selectOneTable(2004).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(2004).isHasone()){
											OrderVo ov24=new OrderModel().selectOrderByTid(2004);
											out.print(ov24.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=2004"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=2004"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>3001</td>
										<td>C</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(3001).getSize());
											%>/6</td>
										<%
											if(!new TableModel().selectOneTable(3001).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
											if(new TableModel().selectOneTable(3001).isHasone()){
											OrderVo ov31=new OrderModel().selectOrderByTid(3001);
											out.print(ov31.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=3001"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=3001"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
									<tr>
										<td>3002</td>
										<td>C</td>
										<td>
											<%
												out.print(new TableModel().selectOneTable(3002).getSize());
											%>/6</td>
										<%
											if(!new TableModel().selectOneTable(3002).isHasone()){
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-danger am-btn-xs"
												disabled="disabled">无人</button>
										</td>
										<%
											} else{
										%>
										<td class="am-hide-sm-only"><button type="button"
												class="am-btn am-radius am-btn-success am-btn-xs"
												disabled="disabled">有人</button>
										</td>
										<%
											}
										%>
										<td class="am-hide-sm-only">￥ <%
										if(new TableModel().selectOneTable(3002).isHasone()){
											OrderVo ov32=new OrderModel().selectOrderByTid(3002);
											out.print(ov32.getCost());
										}
										else{
											out.print(0);
										}
										%>
										</td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=start&id=3002"
														target="_top"><span
														class="am-icon-pencil-square-o  am-text-primary">
															编辑</span>
													</a>
													<a class="am-btn am-btn-default am-btn-xs"
														href="/restaurant/TableCtrl?action=settle&id=3002"
														target="_top"><span
														class="am-icon-shopping-cart  am-text-danger">
															结算</span>
													</a>
												</div>
											</div></td>
									</tr>
								</tbody>
							</table>
							<hr />
							<p>注：请按规定操作</p>
						</form>
					</div>

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

