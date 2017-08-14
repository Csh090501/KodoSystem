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
	$("#dg_input").datagrid({loadFilter:pagerFilter}).datagrid({
		url:'${pageContext.request.contextPath}/input/getInput.do' ,
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
function deleteInput(){
	var SelectedRows = $("#dg_input").datagrid('getSelections');
	if(SelectedRows.length==0){
		$.messager.alert("系统提示","请选择要删除的数据！");
		return;
	}
	var strIds=[];
	for(var i=0;i<SelectedRows.length;i++){
		strIds.push(SelectedRows[i].inp_id);
	}
	var ids=strIds.join(",");   //将数据转化成数组
	$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+SelectedRows.length+"</font>条数据吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/input/deleteInput.do",{delIds:ids},function(result){
				if(result){
					$.messager.alert("系统提示","您已成功删除<font color=red>"+SelectedRows.length+"</font>条数据！");
					$("#dg_input").datagrid('reload');
				}else{
					$.messager.alert('系统提示',result);
				}
			},"json");
		}
	});
}
//实现对数据信息的修改
function openInputModifyDialog(){
	var selectedRows=$("#dg_input").datagrid('getSelections');
	if(selectedRows.length!=1){
		$.messager.alert("系统提示","请选择一条要编辑的数据！");
		return;
	}
	var row = selectedRows[0];
	$("#dlg_input").dialog("open").dialog("setTitle","编辑客户信息");
	$("#fm_input").form("load",row);
	url="${pageContext.request.contextPath}/input/modifyInput.do?inp_no="+row.inp_no;
}
//打开添加窗口
function openInputAddDialog(){
	$("#dlg_input").dialog("open").dialog("setTitle","编辑客户信息");
	url="${pageContext.request.contextPath}/input/addInput.do";
}
//保存按钮
function saveInput(){
	$("#fm_input").form("submit",{
		url:url,
		onSubmit:function(){
			if($('#inp_id2').val==""){
				$.messager.alert("系统提示","请输入id");
				return false;
			}
			if($('#inp_mat_name2').val==""){
				$.messager.alert("系统提示","请输入材料名称");
				return false;
			}
			if($('#inp_number2').val==""){
				$.messager.alert("系统提示","请输入数量");
				return false;
			}
			if($('#inp_price2').val==""){
				$.messager.alert("系统提示","请输入单价");
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
				$("#dg_input").datagrid('reload');
				$("#dlg_input").dialog("close");
				$("#dg_input").datagrid("reload");
				resetValue();
			}
			
		}
	});
} 
//查询功能
function searchInput(){
	var input = 
     {	     "inp_id"   	  : $("#inp_id").val(),
			 "inp_name"   : $("#inp_name").val(),
			 "inp_stime"   : $("#inp_stime").datebox('getValue'),
			 "inp_etime"   : $("#inp_etime").datebox('getValue'),
     };
	 $.ajax({
	        type    : "post",
	        url     : "${pageContext.request.contextPath}/input/searchInput.do",
	        data    : input,
	        dataType: "json",
	        success : function(data)
	        {
	        	console.log(data);
	        	$("#dg_input").datagrid('loadData',data);
	        },
		error:function()
		{
		   alert("Ajax技术加载失败！");
		}
	 }); 
}
//关闭按钮
function closeInputDialog(){
	$("#dlg_input").dialog("close");
	resetValue();
}
//重置信息
function resetValue(){
		$("#inp_number2").val("");
		$("#inp_id2").val(""); 
		$("#inp_price2").val(""); 
		$("#inp_mat_name2").val(""); 
	}
function resetSearch(){
    $('#inp_id').val('');
    $('#inp_name').val('');
	$('#inp_stime').datebox('setValue','');
	$('#inp_etime').datebox('setValue','');
}
</script>
	<div class="easyui-layout" data-options="fit:true">
  	<div data-options="region:'center',title:'客户信息'">
  		<table id="dg_input" class="easyui-datagrid" data-options="fit:true,fitColumns:true,rownumbers:true,pagination:true,pageSize:10" toolbar="#tb_input">
  			<thead>
  				<tr>
					<th data-options="field:'ck',width:100,checkbox:true"></th>
					<th data-options="field:'inp_no',width:100">编号</th>
					<th data-options="field:'inp_id',width:100">入库号</th>
					<th data-options="field:'inp_date',width:200">入库时间</th>
					<th data-options="field:'inp_mat_name',width:100">名称</th>
					<th data-options="field:'inp_price',width:100">单价</th>
					<th data-options="field:'inp_number',width:100">数量</th>
					<th data-options="field:'inp_tot_price',width:100">总费用</th>
					
				</tr>
  			</thead>
  		</table>
  <div id="tb_input">
	<a href="javascript:openInputAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
	<a href="javascript:openInputModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
	<a href="javascript:deleteInput()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
     <br>
    <div style="float: left;">&nbsp;id：&nbsp;<input type="text" class="p1" name="inp_id" id="inp_id" size="10"/>
		&nbsp;名称：&nbsp;<input type="text" class="p1" name="inp_name" id="inp_name" size="10"/>
		&nbsp;入库时间：&nbsp;<input class="easyui-datebox" name="inp_stime" id="inp_stime" editable="false" size="10"/>
		To:&nbsp;&nbsp;<input class="easyui-datebox" name="inp_etime" id="inp_etime" editable="false" size="10"/>
		<a href="javascript:searchInput()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a></div>
        <a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a></div>
  </div>
  
  <div id="dlg_input" class="easyui-dialog" style="width: 570px;height: 200px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons_input">
		<form id="fm_input" method="post">
			<table cellspacing="10px;" >
				<tr >
					<td>id：</td>
					<td><input type="text" name="inp_id" id="inp_id2" class="easyui-validatebox p1" required="true"/></td>
					<td>名称：</td>
					<td><input type="text" name="inp_mat_name" id="inp_mat_name2" class="easyui-validatebox p1" required="true"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr >
				    <td >单价：</td>
					<td ><input type="text" name="inp_price" id="inp_price2" class="easyui-validatebox p1" required="true"/></td>
					<td >数量：</td>
					<td ><input type="text" name="inp_number" id="inp_number2" class="easyui-validatebox p1" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
  
  	<div id="dlg-buttons_input">
		<a href="javascript:saveInput()" class="easyui-linkbutton" iconCls="icon-ok">提交</a>
		<a href="javascript:closeInputDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>