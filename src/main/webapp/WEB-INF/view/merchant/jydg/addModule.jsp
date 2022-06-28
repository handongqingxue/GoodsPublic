<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String memo1=(String)request.getAttribute("memo1");
	String memo2=(String)request.getAttribute("memo2");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/jydg/addModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
KindEditor.ready(function(K) {
	var editor1 = K.create('textarea[name="memo1"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	var editor2 = K.create('textarea[name="memo2"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	prettyPrint();
});
</script>
</head>
<body>
<%@include file="../registerDialog.jsp"%>
<%@include file="../loginDialog.jsp"%>
<form id="form1" name="form1" method="post" action="addHtmlGoodsJYDG" onsubmit="return checkForm();" enctype="multipart/form-data">

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">家用蛋糕-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input class="productName_input" type="text" id="productName" name="productName" value="${requestScope.productName }" placeholder="请输入标题"/>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.embed1List }" var="embed1" varStatus="status">
			<embed class="item_embed" id="embed1_1" src="${embed1.url }"/>
			</c:forEach>
		</div>
	</div>
	<div class="jyyybl_div" id="jyyybl_div">
		<div class="title_div">
			<div class="num_div">01</div>
			<div class="text_div">
				<span class="text_span">建议应用比例</span>
			</div>
		</div>
		<table class="jyyybl_tab" id="jyyybl_tab">
			<tr class="head_tr">
				<td class="jyyybl_td">原料</td>
				<td class="jyyybl_td">用量(g)</td>
				<td class="jyyybl_td">备注</td>
				<td class="cz_td">操作</td>
			</tr>
			<c:forEach items="${requestScope.jyyyblList }" var="jyyybl" varStatus="status">
			<tr class="item_tr" id="tr${status.index+1 }" height="50">
				<td class="name_td">
					<input type="text" name="yjyyblName${status.index+1 }" value="${jyyybl.name }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue${status.index+1 }" value="${jyyybl.value }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo${status.index+1 }" value="${jyyybl.memo }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yjyyblIfShow${status.index+1 }" name="yjyyblIfShow${status.index+1 }" value="true" />
					<input type="button" class="yjyyblIfShow_inp" value="显示" onclick="changeSPXQTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
			<c:forEach begin="5" end="10" varStatus="status">
			<tr class="item_tr" id="tr${status.index }" height="50">
				<td class="name_td">
					<input type="text" name="yjyyblName${status.index }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue${status.index }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo${status.index+1 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yjyyblIfShow${status.index }" name="yjyyblIfShow${status.index }" value="true" />
					<input type="button" class="yjyyblIfShow_inp" value="显示" onclick="changeSPXQTrIfShow(${status.index },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="memo1_div" id="memo1_div">
		<div class="title_div">
			<div class="num_div">02</div>
			<div class="text_div">
				<span class="text_span">推荐操作步骤</span>
			</div>
		</div>
		<div class="space_div"></div>
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div class="memo2_div" id="memo2_div">
		<div class="title_div">
			<div class="num_div">03</div>
			<div class="text_div">
				<span class="text_span">常见问题解答</span>
			</div>
		</div>
		<div class="space_div"></div>
		<textarea class="memo2_ta" id="memo2" name="memo2" cols="100" rows="8"><%=htmlspecialchars(memo2) %></textarea>
	</div>
</div>
</form>
</body>
</html>
<%!
private String htmlspecialchars(String str) {
	//System.out.println(str);
	if(!StringUtils.isEmpty(str)){
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
	}
	return str;
}
%>