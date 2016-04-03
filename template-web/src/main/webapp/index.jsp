<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en"
	class="app" 
	xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/common/common.jspf"%>
<script type="text/javascript" src="${ctx}/js/system/user/updatePassword.js"></script>
<script type="text/javascript">
	$(function() {
    //修改时间2015年10月13日14:32:57
    //修改在手机上点击菜单后菜单不关闭问题
    //修改人赵雷
    var winwidth = $("body").width();
    if(winwidth<770){
      $("#nav ul.lt li").click(function(){
        $("#nav").removeClass("nav-off-screen");
     });
    }
    //---------修改人赵雷完毕----------
		 var tb = $("#loadhtml");
		tb.html(CommnUtil.loadingImg());
		tb.load(rootPath+"/welcome.jsp");
		$("[nav-n]").each(function () {
				$(this).bind("click",function(){
						var nav = $(this).attr("nav-n");
						var sn = nav.split(",");
						var html = '<li><i class="fa fa-home"></i>';
						html+='<a href="index.shtml"> 主页</a></li>';
						for(var i=0;i<2;i++){
							html+='<li><a href="javascript:void(0)">'+sn[i]+'</a></li>';
						}
						$("#topli").html(html);
						var tb = $("#loadhtml");
						tb.html(CommnUtil.loadingImg());
						tb.load(rootPath+sn[2]);
				});
			});
		});
</script>
</head>
<body class="" style="margin-top:0px;">
	<section class="vbox">
		<header class="bg-dark dk header navbar navbar-fixed-top-xs">
			<div class="navbar-header aside-md" >
				<a class="btn btn-link visible-xs"
					data-toggle="class:nav-off-screen,open" data-target="#nav,html">
					<i class="fa fa-bars"></i>
				</a> <a href="index.shtml#" class="navbar-brand"
					data-toggle="fullscreen"><img
					src="${ctx}/notebook/notebook_files/logo.png" class="m-r-sm">权限管理系统</a>
				<a class="btn btn-link visible-xs" data-toggle="dropdown"
					data-target=".nav-user"> <i class="fa fa-cog"></i>
				</a>
			</div>
			<ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user">
				
				<li class="dropdown"><a href="index.html#"
					class="dropdown-toggle" data-toggle="dropdown"> <span
						class="thumb-sm avatar pull-left"> <img
							src="${ctx}/notebook/notebook_files/tupian.png">
							
					</span> ${userFormMap.userName} <b class="caret"></b> 					
					
				</a>
					<ul class="dropdown-menu animated fadeInRight">
						<li><a href="#" onclick="javascript:updatePasswordLayer();">密码修改</a></li>
						<li class="divider"></li>
						<li><a href="logout.shtml">退出</a></li>
					</ul>
				</li>
				<li class="dropdown"><a href="index.html#"
					class="dropdown-toggle" data-toggle="dropdown">
					  部门：${userFormMap.deptName}
				</a>
					
				</li>
			</ul>
		</header>
		<section>
			<section class="hbox stretch">
				<!-- .aside -->
				<aside class="bg-dark lter aside-md hidden-print hidden-xs" id="nav">
					<section class="vbox">
						<!-- <header class="header bg-primary lter text-center clearfix">
							<div class="btn-group">
							系统菜单
							</div>
						</header> -->
						<section class="w-f scrollable">
							<div class="slim-scroll" data-height="auto"
								data-disable-fade-out="true" data-distance="0" data-size="5px"
								data-color="#333333">
								<!-- nav -->
								<nav class="nav-primary hidden-xs">
									<ul class="nav">
										<c:forEach var="key" items="${list}" varStatus="s">
											<!-- <li class="active"> 某一项展开-->
											<!-- 一级菜单 -->
											<li <c:if test="${s.index==0}">class="active"</c:if>>
												<a href="javascript:void(0)" title="${key.name}" <c:if test="${s.index==0}">class="active"</c:if>> 
													<c:if test="${s.index==0}">
														<i class="fa fa-dashboard icon"> <b class="bg-danger"></b></i>
													</c:if> 
													<c:if test="${s.index==1}">
														<i class="fa fa-pencil-square icon"> <b class="bg-warning"></b></i>
													</c:if> 
													<c:if test="${s.index==2}">
														<i class="fa fa-columns icon"> <b class="bg-primary"></b></i>
													</c:if> 
													<c:if test="${s.index==3}">
														<i class="fa fa-book icon"> <b class="bg-info"></b></i>
													</c:if> 
													<c:if test="${s.index==4}">
														<i class="fa fa-th-list icon"> <b class="bg-success"></b></i>
													</c:if> 
													<span class="pull-right"> 
													<i class="fa fa-angle-down text"></i> 
													<i class="fa fa-angle-up text-active"></i>
													</span><span>${key.name}</span>
												</a>
												<!-- 二级菜单 -->
												<ul class="nav lt">
													<c:forEach var="kc" items="${key.children}">
														<li>
															<a href="javascript:void(0)" title="${kc.name}" class="active" <c:if test="${kc.type=='1'}"> nav-n="${key.name},${kc.name},${kc.resUrl}?id=${kc.id}" </c:if>> 
																<i class="fa fa-angle-right"></i> 
																<span>${kc.name}</span>
															</a>
															<c:if test="${fn:length(kc.children) > 0}">
																<!-- 三级菜单 -->
																<ul class="nav lt">
															 		<c:forEach var="cy" items="${kc.children}">
																		<li class="active">
																			<a href="javascript:void(0)" title="${cy.name}" class="active" nav-n="${kc.name},${cy.name},${cy.resUrl}?id=${cy.id}"> 
																				<i class="fa fa-angle-right"></i> 
																				<span>${cy.name}</span>
																			</a>
																		</li>
																	</c:forEach> 
																</ul>
													 		</c:if>
														</li>
													</c:forEach>
												</ul>
											</li>
										</c:forEach>
									</ul>
								</nav>
								<!-- / nav -->
							</div>
						</section>
						<footer class="footer lt hidden-xs b-t b-dark">
							
							<a href="#nav" data-toggle="class:nav-xs"
								class="pull-right btn btn-sm btn-dark btn-icon"> <i
								class="fa fa-angle-left text"></i> <i
								class="fa fa-angle-right text-active"></i>
							</a>
							
						</footer>
					</section>
				</aside>
				<!-- /.aside -->
				<section id="content">
					<section id="id_vbox" class="vbox">
						<ul class="breadcrumb no-border no-radius b-b b-light" id="topli">
						</ul>
						<section id="content_section" class="scrollable" style="margin-top: 35px;">
						<div id="loadhtml" style="position:relative;"></div>
						</section>
					</section>
				</section>
				<aside class="bg-light lter b-l aside-md hide" id="notes">
					<div class="wrapper">Notification</div>
				</aside>
			</section>
		</section>
	</section>
	<!-- Bootstrap -->
	<div id="flotTip" style="display: none; position: absolute;"></div>


</body>
</html>