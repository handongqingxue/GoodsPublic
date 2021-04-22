<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>付费记录列表</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
var alipayNo='${sessionScope.user.alipayNo}';
var realName='${sessionScope.user.realName}';
var openId='${sessionScope.user.openId}';
$(function(){
	tab1=$("#tab1").datagrid({
		title:"付费记录查询",
		url:"queryAccountPayRecordList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountId:'${sessionScope.user.id}'},
		columns:[[
			{field:"outTradeNo",title:"订单号",width:200},
            {field:"payTime",title:"支付时间",width:200},
            {field:"endTime",title:"到期时间",width:200},
            {field:"state",title:"状态",width:80,formatter:function(value,row){
            	var str;
            	switch (value) {
				case 1:
					str="使用中";
					break;
				case 2:
					str="即将到期";
					break;
				case 3:
					str="已到期";
					break;
				case 4:
					str="已退款";
					break;
				}
            	return str;
            }},
            {field:"vipType",title:"版本",width:80,formatter:function(value,row){
            	var str;
            	switch (value) {
				case 1:
					str="免费";
					break;
				case 2:
					str="基础";
					break;
				case 3:
					str="高级";
					break;
				case 4:
					str="行业";
					break;
				}
            	return str+="版";
            }},
            {field:"payType",title:"支付类型",width:100,formatter:function(value,row){
            	var str;
            	switch (value) {
				case 1:
					str="支付宝";
					break;
				case 2:
					str="微信";
					break;
				default:
					str="无";
					break;
				}
            	return str;
            }},
            {field:"money",title:"支付金额",width:100},
            {field:"phone",title:"用户名",width:150},
            {field:"id",title:"操作",width:80,formatter:function(value,row){
            	var str="";
            	if(row.payType!=null&row.allowRefund&row.state!=4){
            		var str;
                	switch (row.payType) {
    				case 1:
    					str+="<a onclick=\"alipayTK('"+row.money+"','"+value+"')\">退款</a>";
    					break;
    				case 2:
    					str+="<a onclick=\"wxTK('"+row.money+"','"+value+"')\">退款</a>";
    					break;
    				}
            		
            	}
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{outTradeNo:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"outTradeNo",colspan:9});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
			
			$(".datagrid-header td .datagrid-cell").each(function(){
				$(this).find("span").eq(0).css("margin-left","11px");
			});
			$(".datagrid-body td .datagrid-cell").each(function(){
				var html=$(this).html();
				$(this).html("<span style=\"margin-left:11px;\">"+html+"</span>");
			});
		}
	});
});

function alipayTK(money,aprId){
	if(checkAlipayInfo()){
		if(confirm("确认退款？")){
			$.post("alipayFundTransUniTransfer",
				{alipayNo:alipayNo,realName:realName,money:money,aprId:aprId},
				function(result){
					if(result.msg=="Success"){
						alert("退款成功");
						tab1.datagrid("load");
					}
					else{
						alert(result.sub_msg);
					}
				}
			,"json");
		}
	}
}

function wxTK(money,aprId){
	if(checkWxInfo()){
		if(confirm("确认退款？")){
			$.post("wxWithDraw",
				{openId:openId,money:money,aprId:aprId},
				function(result){
					if(result.status=="ok"){
						alert(result.message);
						tab1.datagrid("load");
					}
					else{
						alert(result.message);
					}
				}
			,"json");
		}
	}
}

function checkAlipayInfo(){
	if(alipayNo==null||alipayNo==""||realName==null||realName==""){
		alert("请先去系统管理-商家信息里完善支付宝信息");
		return false;
	}
	else{
		return true;
	}
}

function checkWxInfo(){
	if(openId==null||openId==""){
		alert("请先去系统管理-商家信息里绑定微信");
		return false;
	}
	else{
		return true;
	}
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-270;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../side.jsp"%>
	<div id="tab1_div" style="margin-top:20px;margin-left: 238px;">
		<table id="tab1">
		</table>
	</div>
	<%@include file="../foot.jsp"%>
</div>
</body>
</html>