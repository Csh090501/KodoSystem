<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
<title>Insert title here</title>
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
   //打开添加供应商信息的dialog
   function openSupplierAddDialog(){
		$("#dlg_supplier").dialog("open").dialog("setTitle","添加供应商信息");
		url="${pageContext.request.contextPath}/supplier/supplierSave.do";
	}
   //删除供应商信息
   function deleteSupplier(){
		var selectedRows=$("#dg_supplier").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strNos=[];
		for(var i=0;i<selectedRows.length;i++){
			strNos.push(selectedRows[i].sup_no);
		}
		var nos=strNos.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/supplier/supplierDelete.do",{delNos:nos},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg_supplier").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}
   
   //打开修改供应商信息窗口
   function openSupplierModifyDialog(){
		var selectedRows=$("#dg_supplier").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg_supplier").dialog("open").dialog("setTitle","编辑供应商信息");
		$("#fm_supplier").form("load",row);
		url="${pageContext.request.contextPath}/supplier/supplierUpdate.do?sup_no="+row.sup_no;
	}

 //保存供应商信息
   function saveSupplier(){
		$("#fm_supplier").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#sup_id1').val==""){
					$.messager.alert("系统提示","请输入id");
					return false;
				}
				if($('#sup_name1').val==""){
					$.messager.alert("系统提示","请输入供应商名称");
					return false;
				}
				if($('#sup_phone1').val==""){
					$.messager.alert("系统提示","请输入联系方式");
					return false;
				}
				if($('#sup_address1').val==""){
					$.messager.alert("系统提示","请输入地址信息");
					return false;
				}
				if($('#sup_description1').val==""){
					$.messager.alert("系统提示","请输入描述信息");
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
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg_supplier").dialog("close");
					$("#dg_supplier").datagrid("reload");
				}
			}
		});
	}
   //关闭dialog
   function closeSupplierDialog(){
		$("#dlg_supplier").dialog("close");
		resetValue();
	}
   //重置供应商信息
   function resetValue(){
		$("#sup_id1").val(""); 
		$("#sup_name1").val(""); 
		$("#sup_phone1").val(""); 
		$("#sup_address1").val(""); 
		$("#sup_description1").val(""); 
	}
   //搜索供应商信息
   function searchSupplier(){
		$('#dg_supplier').datagrid('load',{
			sup_id:$('#sup_id').val(),
			sup_name:$('#sup_name').val(),
		});
	}
 //重置搜索栏
   function resetSearch(){
		$("#sup_id").val(""); 
		$("#sup_name").val(""); 
	}
</script>
<div class="easyui-layout" data-options="fit:true">
  	<div data-options="region:'center',title:'供应商信息'">
  		<table id="dg_supplier" class="easyui-datagrid" data-options="fit:true,fitColumns:true,rownumbers:true,pagination:true,pageSize:10"
  		url="${pageContext.request.contextPath}/supplier/getSuppliers.do" toolbar="#tb_supplier">
  			<thead>
  				<tr>
					<th data-options="field:'ck',width:100,checkbox:true"></th>
					<th data-options="field:'sup_no',width:100">编号</th>
					<th data-options="field:'sup_id',width:100">供应商Id</th>
					<th data-options="field:'sup_name',width:100">供应商名称</th>
					<th data-options="field:'sup_phone',width:100">联系方式</th>
					<th data-options="field:'sup_address',width:100">地址信息</th>
					<th data-options="field:'sup_description',width:100">描述信息</th>
				</tr>
  			</thead>
  		</table>
  		<div id="tb_supplier">
	<a href="javascript:openSupplierAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
	<a href="javascript:openSupplierModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
	<a href="javascript:deleteSupplier()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
	<br>
	<div style="float:left;">&nbsp;id：&nbsp;<input type="text" class="p1" name="sup_id" id="sup_id" size="10"/>
		&nbsp;姓名：&nbsp;<input type="text" class="p1" name="sup_name" id="sup_name" size="10"/>
		<a href="javascript:searchSupplier()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a></div>
        <a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a></div>
    </div>
 
  <div id="dlg_supplier" class="easyui-dialog" style="width: 570px;height: 200px;padding: 10px 20px"
		closed="true" buttons="#dlg_supplier-buttons">
		<form id="fm_supplier" method="post">
			<table cellspacing="5px;" height="90%" width="90%">
				<tr height="30%">
					<td>供应商Id：</td>
					<td><input type="text" name="sup_id" id="sup_id1" class="easyui-validatebox p1" required="true"/></td>
					<td>供应商名称：</td>
					<td><input type="text" name="sup_name" id="sup_name1" class="easyui-validatebox p1" required="true"/></td>
				</tr>
				<tr height="30%">
					<td>联系方式：</td>
					<td><input type="text" name="sup_phone" id="sup_phone1" class="easyui-validatebox p1" required="true"/></td>
				</tr>
				<tr height="40%">
					<td >地址信息：</td>
					<td ><input type="text" name="sup_address" id="sup_address1" class="easyui-validatebox p1" /></td>
					<td >描述信息：</td>
					<td ><input type="text" name="sup_description" id="sup_description1" class="easyui-validatebox p1" /></td>
				</tr>
			</table>
		</form>
	</div> 
  
  	<div id="dlg_supplier-buttons">
		<a href="javascript:saveSupplier()" class="easyui-linkbutton" iconCls="icon-ok">提交</a>
		<a href="javascript:closeSupplierDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>

</body>
</html>