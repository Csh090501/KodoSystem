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
$(function(){
	$("#dg_material").datagrid({loadFilter:pagerFilter}).datagrid({
		url:'${pageContext.request.contextPath}/material/getMaterial.do' ,
	});
});
//前台实现数据的分页显示
function pagerFilter(data){
    if (typeof data.length == 'number' && typeof data.splice == 'function'){    // 判断数据是否是数组
        data = {
            total: data.length,
            rows: data
        }
    }
    var dg = $(this);
    var opts = dg.datagrid('options');
    var pager = dg.datagrid('getPager');
    pager.pagination({
        onSelectPage:function(pageNum, pageSize){
            opts.pageNumber = pageNum;
            opts.pageSize = pageSize;
            pager.pagination('refresh',{
                pageNumber:pageNum,
                pageSize:pageSize
            });
            dg.datagrid('loadData',data);
        }
    });
    if (!data.originalRows){
        data.originalRows = (data.rows);
    }
    var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
    var end = start + parseInt(opts.pageSize);
    data.rows = (data.originalRows.slice(start, end));
    return data;
}
//选择可以批量删除数据
function deleteMaterial(){
	var SelectedRows = $("#dg_material").datagrid('getSelections');
	if(SelectedRows.length==0){
		$.messager.alert("系统提示","请选择要删除的数据！");
		return;
	}
	var strIds=[];
	for(var i=0;i<SelectedRows.length;i++){
		strIds.push(SelectedRows[i].mat_id);
	}
	var ids=strIds.join(",");   //将数据转化成数组
	$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+SelectedRows.length+"</font>条数据吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/material/deleteMaterial.do",{delIds:ids},function(result){
				if(result){
					$.messager.alert("系统提示","您已成功删除<font color=red>"+SelectedRows.length+"</font>条数据！");
					$("#dg_material").datagrid('reload');
				}else{
					$.messager.alert('系统提示',result);
				}
			},"json");
		}
	});
}
//实现对数据信息的修改
function openMaterialModifyDialog(){
	var selectedRows=$("#dg_material").datagrid('getSelections');
	if(selectedRows.length!=1){
		$.messager.alert("系统提示","请选择一条要编辑的数据！");
		return;
	}
	var row = selectedRows[0];
	$("#dlg_material").dialog("open").dialog("setTitle","编辑客户信息");
	$("#fm_material").form("load",row);
	url="${pageContext.request.contextPath}/material/modifyMaterial.do?mat_no="+row.mat_no;
	
}
//打开添加窗口
function openMaterialAddDialog(){
	$("#dlg_material").dialog("open").dialog("setTitle","编辑客户信息");
	url="${pageContext.request.contextPath}/material/addMaterial.do";
}
//保存按钮
function saveMaterial(){
	$("#fm_material").form("submit",{
		url:url,
		onSubmit:function(){
			if($('#mat_id').val==""){
				$.messager.alert("系统提示","请输入id");
				return false;
			}
			if($('#mat_name').val==""){
				$.messager.alert("系统提示","请输入名称");
				return false;
			}
			if($('#mat_number').val==""){
				$.messager.alert("系统提示","请输入数量");
				return false;
			}
			return $(this).form("validate");
		},
		success:function(result){
			if(!result){
				$.messager.alert("系统提示",result.errorMsg);
				resetValue();
				return;
			}else{
				$.messager.alert("系统提示","保存成功");
				$("#dg_material").datagrid('reload');
				$("#dlg_material").dialog("close");
				$("#dg_material").datagrid("reload");
				resetValue();
			}
		}
	});
} 
//查询功能
function searchMaterial(){
	
	var material = 
     {	     "mat_id"   : $("#search_id").val(),
			 "mat_name"   : $("#search_name").val(),
     };
	 $.ajax({
	        type    : "post",
	        url     : "${pageContext.request.contextPath}/material/searchMaterial.do",
	        data    : material,
	        dataType: "json",
	        success : function(data)
	        {
	        	console.log(data);
	        	$("#dg_material").datagrid('loadData',data);
	        },
		error:function()
		{
		   alert("Ajax技术加载失败！");
		}
	 }); 
}

//关闭按钮
function closeMaterialDialog(){
	$("#dlg_material").dialog("close");
	resetValue();
}
//重置信息
function resetValue(){
		$("#mat_number").val("");
		$("#mat_id").val(""); 
		$("#mat_name").val(""); 
	}
function cellStyler(value,row,index){
	if (value < 100){
		return 'color:red;';
	}
}
function resetSearch(){
	$("#search_id").val(""); 
	$("#search_name").val(""); 
}
</script>
	<div class="easyui-layout" data-options="fit:true">
  	<div data-options="region:'center',title:'客户信息'">
  		<table id="dg_material" class="easyui-datagrid" data-options="fit:true,fitColumns:true,rownumbers:true,pagination:true,pageSize:10" toolbar="#tb_material">
  			<thead>
  				<tr>
					<th data-options="field:'ck',width:100,checkbox:true"></th>
					<th data-options="field:'mat_no',width:100">编号</th>
					<th data-options="field:'mat_id',width:100">id</th>
					<th data-options="field:'mat_name',width:100">名称</th>
					<th data-options="field:'mat_number',width:100,styler:cellStyler">数量</th>
				</tr>
  			</thead>
  		</table>
  <div id="tb_material">
	<a href="javascript:openMaterialAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
	<a href="javascript:openMaterialModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
	<a href="javascript:deleteMaterial()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
    <br>
    <div style="float: left;">&nbsp;id：&nbsp;<input type="text" class="p1" name="search_id" id="search_id" size="10"/>
		&nbsp;名称：&nbsp;<input type="text" class="p1" name="search_name" id="search_name" size="10"/>
		<a href="javascript:searchMaterial()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a></div>
		<a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a></div>
  </div>
  
  <div id="dlg_material" class="easyui-dialog" style="width: 320px;height: 200px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons_material">
		<form id="fm_material" method="post">
			<table cellspacing="5px;" >
				<tr height="26%">
					<td>id：</td>
					<td><input type="text" name="mat_id" id="mat_id" class="easyui-validatebox p1" required="true"/></td>
				</tr>
				<tr height="10%"></tr>
				<tr height="26%">
				    <td>名称：</td>
					<td><input type="text" name="mat_name" id="mat_name" class="easyui-validatebox p1" required="true"/></td>
				</tr>
				<tr height="10%"></tr>
				<tr height="26%">
					<td >数量：</td>
					<td ><input type="text" name="mat_number" id="mat_number" class="easyui-validatebox p1" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
  
  	<div id="dlg-buttons_material">
		<a href="javascript:saveMaterial()" class="easyui-linkbutton" iconCls="icon-ok">提交</a>
		<a href="javascript:closeMaterialDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>