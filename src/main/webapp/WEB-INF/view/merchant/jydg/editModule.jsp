<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page import="goodsPublic.entity.HtmlGoodsJYDG"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HtmlGoodsJYDG htmlGoodsJYDG=(HtmlGoodsJYDG)request.getAttribute("htmlGoodsJYDG");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/jydg/editModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
var editor1,editor2;
KindEditor.ready(function(K) {
	editor1 = K.create('textarea[name="memo1"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	editor2 = K.create('textarea[name="memo2"]', {
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

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">家用蛋糕-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input class="productName_input" type="text" id="productName" name="productName" value="${requestScope.htmlGoodsJYDG.productName }" placeholder="请输入标题"/>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJYDG.embed1_1 ne null }">
			<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsJYDG.embed1_1 }"/>
			</c:if>
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
			
			<tr class="item_tr" id="tr1" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName1" value="${requestScope.htmlGoodsJYDG.jyyyblName1 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue1" value="${requestScope.htmlGoodsJYDG.jyyyblValue1 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo1" value="${requestScope.htmlGoodsJYDG.jyyyblMemo1 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow1" name="jyyyblIfShow1" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow1 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow1?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName2" value="${requestScope.htmlGoodsJYDG.jyyyblName2 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue2" value="${requestScope.htmlGoodsJYDG.jyyyblValue2 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo2" value="${requestScope.htmlGoodsJYDG.jyyyblMemo2 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow2" name="jyyyblIfShow2" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow2 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow2?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName3" value="${requestScope.htmlGoodsJYDG.jyyyblName3 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue3" value="${requestScope.htmlGoodsJYDG.jyyyblValue3 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo3" value="${requestScope.htmlGoodsJYDG.jyyyblMemo3 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow3" name="jyyyblIfShow3" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow3 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow3?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName4" value="${requestScope.htmlGoodsJYDG.jyyyblName4 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue4" value="${requestScope.htmlGoodsJYDG.jyyyblValue4 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo4" value="${requestScope.htmlGoodsJYDG.jyyyblMemo4 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow4" name="jyyyblIfShow4" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow4 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow4?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName5" value="${requestScope.htmlGoodsJYDG.jyyyblName5 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue5" value="${requestScope.htmlGoodsJYDG.jyyyblValue5 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo5" value="${requestScope.htmlGoodsJYDG.jyyyblMemo5 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow5" name="jyyyblIfShow5" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow5 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow5?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName6" value="${requestScope.htmlGoodsJYDG.jyyyblName6 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue6" value="${requestScope.htmlGoodsJYDG.jyyyblValue6 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo6" value="${requestScope.htmlGoodsJYDG.jyyyblMemo6 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow6" name="jyyyblIfShow6" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow6 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow6?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName7" value="${requestScope.htmlGoodsJYDG.jyyyblName7 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue7" value="${requestScope.htmlGoodsJYDG.jyyyblValue7 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo7" value="${requestScope.htmlGoodsJYDG.jyyyblMemo7 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow7" name="jyyyblIfShow7" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow7 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow7?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(7,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr8" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName8" value="${requestScope.htmlGoodsJYDG.jyyyblName8 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue8" value="${requestScope.htmlGoodsJYDG.jyyyblValue8 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo8" value="${requestScope.htmlGoodsJYDG.jyyyblMemo8 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow8" name="jyyyblIfShow8" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow8 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow8?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(8,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr9" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName9" value="${requestScope.htmlGoodsJYDG.jyyyblName9 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue9" value="${requestScope.htmlGoodsJYDG.jyyyblValue9 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo9" value="${requestScope.htmlGoodsJYDG.jyyyblMemo9 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow9" name="jyyyblIfShow9" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow9 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow9?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(9,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr10" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName10" value="${requestScope.htmlGoodsJYDG.jyyyblName10 }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue10" value="${requestScope.htmlGoodsJYDG.jyyyblValue10 }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo10" value="${requestScope.htmlGoodsJYDG.jyyyblMemo10 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow10" name="jyyyblIfShow10" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow10 }" />
					<input type="button" class="jyyyblIfShow_inp" value="${requestScope.htmlGoodsJYDG.jyyyblIfShow10?'显示':'隐藏' }" onclick="changeJYYYBLTrIfShow(10,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
	<div class="memo1_div">
		<div class="title_div">
			<div class="num_div">02</div>
			<div class="text_div">
				<span class="text_span">推荐操作步骤</span>
			</div>
		</div>
		<div class="space_div"></div>
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsJYDG.getMemo1()) %></textarea>
	</div>
	<div class="pdf1_div" id="pdf1_div">
		<div class="title_div">
			<span class="text_span">产品说明书下载</span>
		</div>
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openPdf1ModBgDiv();">编辑</a>|
				<a onclick="deletePdf1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_1 ne null }">
			<div class="item_pdf" id="pdf1_1">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_1 }.pdf</span>
				<span class="size_span">${requestScope.htmlGoodsJYDG.pdfSize1_1 }kb</span>
			</div>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_2 ne null }">
			<div class="item_pdf" id="pdf1_2">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_2 }.pdf</span>
				<span class="size_span">${requestScope.htmlGoodsJYDG.pdfSize1_2 }kb</span>
			</div>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_3 ne null }">
			<div class="item_pdf" id="pdf1_3">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_3 }.pdf</span>
				<span class="size_span">${requestScope.htmlGoodsJYDG.pdfSize1_3 }kb</span>
			</div>
			</c:if>
		</div>
	</div>
	<div class="memo2_div" id="memo2_div">
		<div class="title_div">
			<div class="num_div">03</div>
			<div class="text_div">
				<span class="text_span">常见问题解答</span>
			</div>
		</div>
		<div class="space_div"></div>
		<textarea class="memo2_ta" id="memo2" name="memo2" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsJYDG.getMemo2()) %></textarea>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null }">
			<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsJYDG.image1_1 }">
			</c:if>
		</div>
	</div>
	<div class="embed2_div" id="embed2_div">
		<div class="title_div">
			<div class="num_div">04</div>
			<div class="text_div">
				<span class="text_span">拓展应用</span>
			</div>
		</div>
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed2ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed2Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJYDG.embed2_1 ne null }">
			<embed class="item_embed" id="embed2_1" alt="" src="${requestScope.htmlGoodsJYDG.embed2_1 }"/>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.embed2_2 ne null }">
			<embed class="item_embed" id="embed2_2" alt="" src="${requestScope.htmlGoodsJYDG.embed2_2 }"/>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.embed2_3 ne null }">
			<embed class="item_embed" id="embed2_3" alt="" src="${requestScope.htmlGoodsJYDG.embed2_3 }"/>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.embed2_4 ne null }">
			<embed class="item_embed" id="embed2_4" alt="" src="${requestScope.htmlGoodsJYDG.embed2_4 }"/>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.embed2_5 ne null }">
			<embed class="item_embed" id="embed2_5" alt="" src="${requestScope.htmlGoodsJYDG.embed2_5 }"/>
			</c:if>
		</div>
	</div>
	<div class="image2_div" id="image2_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage2ModBgDiv();">编辑</a>|
				<a onclick="deleteImage2Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null }">
			<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsJYDG.image2_1 }">
			</c:if>
		</div>
		<div class="space_div"></div>
	</div>
</div>
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