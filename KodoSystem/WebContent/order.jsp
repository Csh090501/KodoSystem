<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单信息</title>
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
   //实现添加订单时，选在材料后，实时显示对应的价格
   $('#ord_pro_name2').combobox({
		 onSelect: function(){ 
			 console.log("选择响应成功");
			 var order = 
		     {	     
					 "pro_name"   : $('#ord_pro_name2').combobox('getValue'),
		     };
			 console.log(order);
			 $.ajax({
			        type    : "post",
			        url     : "${pageContext.request.contextPath}/order/orderFind.do",
			        data    : order,
			        dataType: "json",
			        success : function(data)
			        {
			        	console.log(data);
			        	$('#ord_pro_price2').val(data);
			        },
				error:function()
				{
				   alert("加载失败！");
				}
			 });
		 }
	});
   //打开添加订单信息的dialog
   function openOrderAddDialog(){
		$("#dlg_ord").dialog("open").dialog("setTitle","添加订单信息");
		$("#ord_client2").attr("disabled",false);
		resetValue();
		url="${pageContext.request.contextPath}/order/orderSave.do";
		
  }
   //删除订单信息
   function deleteOrder(){
		var selectedRows=$("#dg_ord").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strNos=[];
		for(var i=0;i<selectedRows.length;i++){
			strNos.push(selectedRows[i].ord_no);
		}
		var nos=strNos.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/order/orderDelete.do",{delNos:nos},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg_ord").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}
   
   //打开修改订单信息窗口
   function openOrderModifyDialog(){
	   resetValue();
		var selectedRows=$("#dg_ord").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg_ord").dialog("open").dialog("setTitle","编辑订单信息");
		$("#ord_client2").attr("disabled",true);
		$("#fm_ord").form("load",row);
		url="${pageContext.request.contextPath}/order/orderUpdate.do?ord_no="+row.ord_no;
	}

 //保存订单信息
   function saveOrder(){
		$("#fm_ord").form("submit",{
			url:url,
			onSubmit:function(){
				if($('#ord_pro_name2').combobox("getValue")==""){
					$.messager.alert("系统提示","请选择产品");
					return false;
				}
				if($('#ord_pro_price2').val==""){
					$.messager.alert("系统提示","请输入单价");
					return false;
				}
				if($('#ord_number2').val==""){
					$.messager.alert("系统提示","请输入购买量");
					return false;
				}
				if($('#ord_client2').val==""){
					$.messager.alert("系统提示","请输入客户id");
					return false;
				}
				
				
				return $(this).form("validate");
			},
			success:function(result){
				if(result.errorMsg){
					$.messager.alert("系统提示",resule.errorMsg,"warning");
					$("#ord_client2").attr("disabled",false);
					return;
				}else{
					$.messager.alert("系统提示","保存成功","info");
					resetValue();
					$("#ord_client2").attr("disabled",false);
					$("#dlg_ord").dialog("close");
					$("#dg_ord").datagrid("reload");
				}
			}
		});
	}
	//搜索订单信息
   function searchOrder(){
		$('#dg_ord').datagrid('load',{
			ord_id:$('#ord_id3').val(),
			ord_stime:$('#ord_stime3').datebox('getValue'),
			ord_etime:$('#ord_etime3').datebox('getValue'),
		});
	}
   //关闭dialog
   function closeOrderDialog(){
		$("#dlg_ord").dialog("close");
		resetValue();
	}
   //重置信息
   function resetValue(){
		$("#ord_id2").val(""); 
		$("#ord_pro_name2").val(""); 
		$("#ord_pro_price2").val(""); 
		$("#ord_number2").val(""); 
		$("#ord_client2").val(""); 
	}

   function resetSearch(){
	   console.log("响应成功");
	    $('#ord_id3').val('');
		$('#ord_stime3').datebox('setValue','');
		$('#ord_etime3').datebox('setValue','');
	}

   function cellStyler(value,row,index){
		if (value == '未接收'){
			return 'color:red;';
		}
		if(value == '已接收'){
			return 'color:orange;';
	    }
		if(value == '已完成'){
			return 'color:green;';
	    }
	}

	function receiveOrder(){
		var selectedRows=$("#dg_ord").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要接收的订单！");
			return;
		}
		var row=selectedRows[0];
		console.log("点击响应成功");
			var order = 
		     {	     "ord_id"   	  : row.ord_id,
					 "ord_status"     : row.ord_status
		     };
		     
			 $.ajax({
			        type    : "post",
			        url     : "${pageContext.request.contextPath}/order/orderReceive.do",
			        data    : order,
			        dataType: "json",
			        success : function(data)
			        {
			        	console.log(data);
			        	if(data==1){
			        		$.messager.alert("系统提示","成功接收订单！","info");
			        	    $("#dg_ord").datagrid('reload');
				        }else{
				        	$.messager.alert("系统提示","接收订单失败！","warning");
						}
			        },
				error:function()
				{
				   alert("Ajax技术加载失败！");
				}
			 }); 
   }
	function finishOrder(){
		var selectedRows=$("#dg_ord").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要接收的订单！");
			return;
		}
		var row=selectedRows[0];
			var order = 
		     {	     "ord_id"   	  : row.ord_id,
					 "ord_status"     : row.ord_status,
					 "ord_number"     : row.ord_number,
					 "ord_pro_name"   : row.ord_pro_name
		     };
		     
			 $.ajax({
			        type    : "post",
			        url     : "${pageContext.request.contextPath}/order/orderFinish.do",
			        data    : order,
			        dataType: "json",
			        success : function(data)
			        {
			        	console.log(data);
			        	if(data==1){
			        		$.messager.alert("系统提示","成功完成订单！","info");
			        	    $("#dg_ord").datagrid('reload');
				        }else{
				        	$.messager.alert("系统提示","完成订单失败,可能是产品数量不足或订单已完成！","warning");
						}
			        },
				error:function()
				{
				   alert("Ajax技术加载失败！");
				}
			 }); 
   }
   function refresh(){
	   $("#dg_ord").datagrid('reload');
	}
</script>
	<div class="easyui-layout" data-options="fit:true">
  	<div data-options="region:'center',title:'订单信息'">
  		<table id="dg_ord" class="easyui-datagrid" data-options="fit:true,fitColumns:true,rownumbers:true,pagination:true,pageSize:10"
  		url="${pageContext.request.contextPath}/order/getOrders.do" toolbar="#tb_ord">
  			<thead>
  				<tr>
					<th data-options="field:'ck',width:100,checkbox:true"></th>
					<th data-options="field:'ord_no',width:30">编号</th>
					<th data-options="field:'ord_id',width:100">订单号</th>
					<th data-options="field:'ord_client',width:60">客户id</th>
					<th data-options="field:'ord_address',width:100">收货地址</th>
					<th data-options="field:'ord_date',width:100">订单日期</th>
					<th data-options="field:'ord_pro_name',width:100">产品名称</th>
					<th data-options="field:'ord_pro_price',width:50">单价</th>
					<th data-options="field:'ord_number',width:50">数量</th>
					<th data-options="field:'ord_tot_price',width:100">总价</th>
					<th data-options="field:'ord_status',width:100,styler:cellStyler">订单状态</th>
				</tr>
  			</thead>
  		</table>
  <div id="tb_ord">
	<a href="javascript:openOrderAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
	<a href="javascript:openOrderModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >修改</a>
	<a href="javascript:deleteOrder()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
    <br/>
    <div style="float: left;">&nbsp;订单id：&nbsp;
        <input type="text" class="p1" name="ord_id" id="ord_id3" size="10"/>
		&nbsp;下单时间：&nbsp;<input class="easyui-datebox" name="ord_stime" id="ord_stime3" editable="false" size="10"/>
		To:&nbsp;&nbsp;<input class="easyui-datebox" name="ord_etime" id="ord_etime3" editable="false" size="10"/>
		<a href="javascript:searchOrder()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a></div>
		<a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a>
		<a href="javascript:receiveOrder()" class="easyui-linkbutton" iconCls="icon-redo" plain="true">接收订单</a>
		<a href="javascript:finishOrder()" class="easyui-linkbutton" iconCls="icon-ok	" plain="true">完成订单</a>
		<a href="javascript:refresh()" class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
		</div>
  </div>
  
  <div id="dlg_ord" class="easyui-dialog" style="width: 570px;height: 250px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm_ord" method="post">
			<table cellspacing="10px;" height="90%" width="90%">
				<tr height="30%">
				<td>产品名称：</td>
					<td><input type="text" name="ord_pro_name" id="ord_pro_name2" class="easyui-combobox p1" 
					data-options="panelHeight:'auto',editable:false,valueField:'ord_pro_name',textField:'ord_pro_name',url:'${pageContext.request.contextPath}/product/getProductCombobox.do'"
					/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>单价：</td>
					<td><input type="text"  name="ord_pro_price" id="ord_pro_price2" class="easyui-validatebox p1" required="true"/></td>
				</tr>
				<tr height="30%">
				<td>客户id：</td>
					<td><input type="text" name="ord_client" id="ord_client2" class="easyui-validatebox p1" ></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td >数量：</td>
					<td ><input type="text" name="ord_number" id="ord_number2" class="easyui-validatebox p1" /></td>
				</tr>
			</table>
		</form>
	</div>
  
  	<div id="dlg-buttons">
		<a href="javascript:saveOrder()" class="easyui-linkbutton" iconCls="icon-ok">提交</a>
		<a href="javascript:closeOrderDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>