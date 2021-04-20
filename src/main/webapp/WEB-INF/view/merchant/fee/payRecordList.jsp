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
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str="<a href=\"${pageContext.request.contextPath}/merchant/main/goBrowseHtmlGoodsSMYL?goodsNumber="+row.goodsNumber+"&accountNumber="+row.accountNumber+"\">详情</a>"
            	+"&nbsp;|&nbsp;<a href=\"${pageContext.request.contextPath}/merchant/main/goEditModule?trade=smyl&goodsNumber="+row.goodsNumber+"&accountNumber="+row.accountNumber+"\">编辑</a>"
            	+"&nbsp;|&nbsp;<a onclick=\"deleteByIds("+value+")\">删除</a>";
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