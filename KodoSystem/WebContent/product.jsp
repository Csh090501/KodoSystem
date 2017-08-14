<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>产品信息</title>
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
<script type="text/javascript" src="../easyui/jquery.min.js"></script>
<script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../easyui/locale/easyui-lang-zh_CN.js"></script>

</head>
<body>
<style> 
.p1
{
	border:1px solid #a1a1a1;
	border-radius:5px;
}
</style>
<script type="text/javascript">
   var url;
   //打开添加产品信息的dialog
   function openProductAddDialog(){
		$("#pro_dlg").dialog("open").dialog("setTitle","添加产品信息");
		url="${pageContext.request.contextPath}/product/productSave.do";
	}
   //删除产品信息
   function deleteProduct(){ 
		var selectedRows=$("#pro_dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strNos=[];
		for(var i=0;i<selectedRows.length;i++){
			strNos.push(selectedRows[i].pro_no);
		}
		var nos=strNos.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/product/productDelete.do",{delNos:nos},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#pro_dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}
   
   //打开修改产品信息窗口
   function openProductModifyDialog(){
		var selectedRows=$("#pro_dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#pro_dlg").dialog("open").dialog("setTitle","编辑产品信息");
		$("#pro_fm").form("load",row);
		url="${pageContext.request.contextPath}/product/productUpdate.do?pro_no="+row.pro_no;
	}

 //保存产品信息
   function saveProduct(){
		$("#pro_fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#pro_id').val==""){
					$.messager.alert("系统提示","请输入产品id");
					return false;
				}
				if($('#pro_name').val==""){
					$.messager.alert("系统提示","请输入产品名称");
					return false;
				}
				if($('#pro_price').val==""){
					$.messager.alert("系统提示","请输入产品价格");
					return false;
				}
				if($('#pro_number').val==""){
					$.messager.alert("系统提示","请输入产品数量");
					return false;
				}
				if($('#pro_description').val==""){
					$.messager.alert("系统提示","请输入产品颜色");
					return false;
				}
				if($('#pro_material').val==""){
					$.messager.alert("系统提示","请输入材料");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					resetValue();
					return;
				}else{
					resetValue();
					$.messager.alert("系统提示","保存成功");
					$("#pro_dlg").dialog("close");
					$("#pro_dg").datagrid("reload");
				}
			}
		});
	}
	//搜索产品信息
   function searchProduct(){
		$('#pro_dg').datagrid('load',{
			pro_id:$('#pro_id').val(),
			pro_name:$('#pro_name').val(),
		});
	}
   //关闭dialog
   function closeProductDialog(){
		$("#pro_dlg").dialog("close");
		resetValue();
	}
   //重置信息
   function resetValue(){
		$("#pro_id").val(""); 
		$("#pro_name").val(""); 
		$("#pro_price").val(""); 
		$("#pro_number").val(""); 
		$("#pro_description").val("");
		$("#pro_material").val("");
	}
   function cellStyler(value,row,index){
		if (value < 50){
			return 'color:red;';
		}
	}
 //重置搜索栏
   function resetSearch(){
		$("#pro_id").val(""); 
		$("#pro_name").val(""); 
	}
</script>
	<div class="easyui-layout" data-options="fit:true">
  	<div data-options="region:'center',title:'产品信息'">
  		<table id="pro_dg" class="easyui-datagrid" data-options="fit:true,fitColumns:true,rownumbers:true,pagination:true,pageSize:10"
  		url="${pageContext.request.contextPath}/product/getProducts.do" toolbar="#pro_tb">
  			<thead>
  				<tr>
					<th data-options="field:'ck',width:100,checkbox:true"></th>
					<th data-options="field:'pro_no',width:100">编号</th>
					<th data-options="field:'pro_id',width:100">产品id</th>
					<th data-options="field:'pro_name',width:100">产品名称</th>
					<th data-options="field:'pro_price',width:100">价格</th>
					<th data-options="field:'pro_number',width:100,styler:cellStyler">数量</th>
					<th data-options="field:'pro_description',width:100">描述</th>
					<th data-options="field:'pro_material',width:100">材料</th>
				</tr>
  			</thead>
  		</table>
  <div id="pro_tb">
	<a href="javascript:openProductAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
	<a href="javascript:openProductModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
	<a href="javascript:deleteProduct()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
    <br>
    <div style="float: left;">&nbsp;id：&nbsp;<input type="text" class="p1" name="pro_id" id="pro_id" size="10"/>
		&nbsp;产品名称：&nbsp;<input type="text" class="p1" name="pro_name" id="pro_name" size="10"/>
		<a href="javascript:searchProduct()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a></div>
        <a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a></div>
  </div>
  
  <div id="pro_dlg" class="easyui-dialog" style="width: 550px;height: 250px;padding: 10px 20px"
		closed="true" buttons="#pro_dlg-buttons">
		<form id="pro_fm" method="post">
			<table cellspacing="5px;" height="90%" width="90%">
				<tr height="30%">
					<td>pro_id：</td>
					<td><input type="text" name="pro_id" id="pro_id" class="easyui-validatebox p1" required="true"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>产品名称：</td>
					<td><input type="text" name="pro_name" id="pro_name" class="easyui-validatebox p1" required="true"/></td>
				</tr>
				<tr height="30%">
					<td>产品价格：</td>
					<td><input type="text" name="pro_price" id="pro_price" class="easyui-validatebox p1"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td >产品数量：</td>
					<td ><input type="text" name="pro_number" id="pro_number" class="easyui-validatebox p1" /></td>
				</tr>
				<tr height="30%">
					<td >产品描述：</td>
					<td ><input type="text" name="pro_description" id="pro_description" class="easyui-validatebox p1" /></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td >材料：</td>
					<td ><input type="text" name="pro_material" id="pro_material" class="easyui-validatebox p1" /></td>
				</tr>
			</table>
		</form>
	</div>
  	<div id="pro_dlg-buttons">
		<a href="javascript:saveProduct()" class="easyui-linkbutton" iconCls="icon-ok">提交</a>
		<a href="javascript:closeProductDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>