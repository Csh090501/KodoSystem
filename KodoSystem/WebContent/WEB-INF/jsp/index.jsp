<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>科多进销存</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<link href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/easyui/themes/icon.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/icons/iconextension.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>

<style type="text/css">
	/*ul属性  */
	.easyui-accordion ul {
		list-style-type:none; /*定义列表项的符号 （无序列表）none：不使用项目符号 */
		padding: 0px;
		margin: 0px;
	}
	.easyui-accordion ul li {
		margin: 5px; 
		line-height: 24px;
	}
	.easyui-accordion ul li div {
		border: 1px solid #99BBE8;/* 设置边框的宽度、样式、颜色 */
		background: #E0ECFF;
	}
	.bb:hover{
	        cursor: pointer;
	    }
</style>
<script type="text/javascript">
	$(function() {
		// 利用jQuery来完成对网页元素的遍历
		bindListener();
	});
	function bindListener(){
		$(".easyui-accordion ul li").click(function() {
			var title = $(this).find("div").attr("title");
			var url = $(this).find("div").attr("url");
			addTabs(title, url);
		});
	}
	function addTabs(title,url){
		if (!$(".easyui-tabs").tabs("exists",title)){  /*判断名字为titel参数名内容的选项卡是否存在  */
			$(".easyui-tabs").tabs("add",{
				title:title,
				href:url,
				closable: true
			});
		}else{
			$(".easyui-tabs").tabs("select",title);
		}	
	}

</script>
</head>
<body class="easyui-layout">
	<div data-options = "region:'north'" style="heigth:50px;overflow:hidden;background: url(../images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; line-height:30px; color: #fff;">
		<span style="float:right;padding-right:20px;" class="head">管理员,<font color="red">${userName }</font>,欢迎您。 </span>
		<span style="padding-left:10px;font-size:15px;"><img src="../images/logo1.png" width="25" height="25" align="absmiddle">&nbsp;科多进销存</span>
	</div>
	<div data-options="region:'west',title:'导航菜单'" style="width:180px;">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			<ul>
				<li><div title="客户管理" url="${pageContext.request.contextPath}/client.jsp" class="bb"><span class="icon-bullet_right">&nbsp;</span>客户管理</div></li>
				<li><div title="订单管理" url="${pageContext.request.contextPath}/order.jsp" class="bb"><span class="icon-bullet_right">&nbsp;</span>订单管理</div></li>
				<li><div title="产品管理" url="${pageContext.request.contextPath}/product.jsp" class="bb"><span class="icon-bullet_right">&nbsp;</span>产品管理</div></li>
				<li><div title="原材料管理" url="${pageContext.request.contextPath}/material.jsp" class="bb"><span class="icon-bullet_right">&nbsp;</span>原材料管理</div></li>
				<li><div title="材料入库" url="${pageContext.request.contextPath}/input.jsp" class="bb"><span class="icon-bullet_right">&nbsp;</span>材料入库</div></li>
				<li><div title="供应商信息" url="${pageContext.request.contextPath}/supplier.jsp" class="bb"><span class="icon-bullet_right">&nbsp;</span>供应商信息</div></li>
			</ul>
		</div>
	</div>
	<div data-options="region:'center'" >
		<div class="easyui-tabs" data-options="fit:true">
			<div data-options="title:'欢迎'">
				<h1 style="padding: 20px;">欢迎使用</h1>
			</div>
		</div>
	</div>

</body>
</html>