<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta charset="UTF-8">
<title>客户信息</title>
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
   //打开添加客户信息的dialog
   function openClientAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加客户信息");
		url="${pageContext.request.contextPath}/client/clientSave.do";
	}
   //删除客户信息
   function deleteClient(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strNos=[];
		for(var i=0;i<selectedRows.length;i++){
			strNos.push(selectedRows[i].no);
		}
		var nos=strNos.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/client/clientDelete.do",{delNos:nos},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}
   
   //打开修改客户信息窗口
   function openClientModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑客户信息");
		$("#fm").form("load",row);
		url="${pageContext.request.contextPath}/client/clientUpdate.do?no="+row.no;
	}

 //保存客户信息
   function saveClient(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#cli_name').val==""){
					$.messager.alert("系统提示","请输入姓名");
					return false;
				}
				if($('#cli_phone').val==""){
					$.messager.alert("系统提示","请输入联系方式");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				console.log(result.errorMsg);
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					resetValue();
					return;
				}else{
					resetValue();
					$.messager.alert("系统提示","保存成功,该客户的id为:"+result.id);
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	//搜索客户信息
   function searchClient(){
		$('#dg').datagrid('load',{
			id:$('#id').val(),
			name:$('#name').val(),
			sex:$('#sex').combobox("getValue"),
		});
	}
   //关闭dialog
   function closeClientDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
   //重置信息
   function resetValue(){
		$("#cli_id").val(""); 
		$("#cli_name").val(""); 
		$("#cli_sex").combobox("setValue","");
		$("#cli_phone").val(""); 
		$("#cli_address").val(""); 
	}
 //重置搜索栏
   function resetSearch(){
		$("#id").val(""); 
		$("#name").val(""); 
		$("#sex").combobox("setValue","");
	}
</script>
	<div class="easyui-layout" data-options="fit:true">
  	<div data-options="region:'center',title:'客户信息'">
  		<table id="dg" class="easyui-datagrid" data-options="fit:true,fitColumns:true,rownumbers:true,pagination:true,pageSize:10"
  		url="${pageContext.request.contextPath}/client/getClients.do" toolbar="#tb">
  			<thead>
  				<tr>
					<th data-options="field:'ck',width:100,checkbox:true"></th>
					<th data-options="field:'no',width:100">编号</th>
					<th data-options="field:'id',width:100">id</th>
					<th data-options="field:'name',width:100">姓名</th>
					<th data-options="field:'sex',width:100">性别</th>
					<th data-options="field:'phone',width:100">联系方式</th>
					<th data-options="field:'address',width:100">地址信息</th>
				</tr>
  			</thead>
  		</table>
  <div id="tb">
	<a href="javascript:openClientAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
	<a href="javascript:openClientModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
	<a href="javascript:deleteClient()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
	<br>
    <div style="float: left;">&nbsp;id：&nbsp;<input type="text" class="p1" name="id" id="id" size="10"/>
		&nbsp;姓名：&nbsp;<input type="text" class="p1" name="name" id="name" size="10"/>
		&nbsp;性别：&nbsp;<select class="easyui-combobox" id="sex" name="sex" editable="false" panelHeight="auto">
		    <option value="">请选择...</option>
			<option value="男">男</option>
			<option value="女">女</option>
		</select>
		<a href="javascript:searchClient()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a></div>
		<a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a></div>
  </div>
  
  <div id="dlg" class="easyui-dialog" style="width: 600px;height: 190px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="10px;" height="90%" width="90%">
				<tr height="30%">
					<td>姓名：</td>
					<td><input type="text" name="name" id="cli_name" class="easyui-validatebox p1" required="true"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>性别：</td>
					<td><select class="easyui-combobox" id="cli_sex" name="sex" editable="false" panelHeight="auto" style="width: 147px">
					    <option value="">请选择...</option>
						<option value="男">男</option>
						<option value="女">女</option>
					</select></td>
				</tr>
				<tr height="30%">
					<td>联系方式：</td>
					<td><input type="text" name="phone" id="cli_phone" class="easyui-validatebox p1" required="true"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td >地址信息：</td>
					<td ><input type="text" name="address" id="cli_address" class="easyui-validatebox p1" /></td>
				</tr>
			</table>
		</form>
	</div>
  
  	<div id="dlg-buttons">
		<a href="javascript:saveClient()" class="easyui-linkbutton" iconCls="icon-ok">提交</a>
		<a href="javascript:closeClientDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>