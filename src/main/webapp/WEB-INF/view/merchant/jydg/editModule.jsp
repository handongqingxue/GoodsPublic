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

var bodyWidth;
$(function(){
	bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");

    //这里必须延迟1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
    
	initDefaultHtmlVal();
});

function resetDivPosition(){
	var middleDivHeight=$("#middle_div").css("height").substring(0,$("#middle_div").css("height").length-2);
	$("#right_div").css("margin-top","-"+(parseInt(middleDivHeight))+"px");
}

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
}

function openImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","block");
}

function closeImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","none");
}

function closeImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","none");
}

function changeButStyle(o,flag){
	if(flag==1){
		$(o).css("color","#4caf50");
		$(o).css("border-color","#4caf50");
	}
	else{
		$(o).css("color","#999");
		$(o).css("border-color","#999");
	}
}

function uploadImage1(){
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	$("#uploadFile1_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile1_inp").click();
}

function deleteImage1(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image1_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile1_div input[type='file'][name='file"+uuid+"']").remove();
	$("#uploadFile1_div input[type='text'][name='image"+uuid+"']").remove();

	var imageTab=$("#image1Mod_div table");
	var tdArr1=imageTab.find("td");
	imageTab.empty();
	for(var i=0;i<tdArr1.length;i++){
		var tdArr2=imageTab.find("td");
		if(tdArr2.length==0||tdArr2.length%4==0)
			imageTab.append("<tr></tr>");
		imageTab.find("tr").eq(imageTab.find("tr").length-1).append(tdArr1[i]);
	}
	
	resetDivPosition();
}

function showQrcodePic1(obj){
	var uuid=$("#uuid_hid1").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	var tdHtml="<td class=\"file_td\" id=\"file_td"+uuid+"\">"
				+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage1(this);\">"
				+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
				+fileHtml
			+"</td>";
	
	var imageTab=$("#image1Mod_div table");
	//var length=imageTab.find("td[id^='file_td']").length;
    var tdLength=imageTab.find("td").length;
    if(tdLength%4==0){
    	var tr=imageTab.find("tr").eq(imageTab.find("tr").length-1);
    	tr.append(tdHtml)
    	imageTab.append("<tr>"+$("#image1Mod_div table #upload_td").prop("outerHTML")+"</tr>");
    	tr.find("td[id^='upload_td']").remove();
    }
    else{
		imageTab.find("#upload_td").before(tdHtml);
    }

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#image1Mod_div table #img"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);

        var listDiv=$("#image1_div #list_div");
        listDiv.append("<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\" src=\""+dataURL+"\">");

        //这里必须延迟0.1s，等图片加载完再重新设定右边div位置
        setTimeout(function(){
        	resetDivPosition();
        },"100")
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
}

function createUUID() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";
 
    var uuid = s.join("");
    return uuid;
}

function changeJYYYBLTrIfShow(index,o){
	var ifShow=$("#jyyyblIfShow"+index).val();
	if(ifShow=="true"){
		$("#jyyyblIfShow"+index).val(false);
		$(o).val("隐藏");
	}
	else{
		$("#jyyyblIfShow"+index).val(true);
		$(o).val("显示");
	}
}

function openPreviewBgDiv(flag){
	$("#previewBg_div").css("display",flag==1?"block":"none");
	
	var preDivWidth=$("#preview_div").css("width").substring(0,$("#preview_div").css("width").length-2);
	var preDivHeight=$("#preview_div").css("height").substring(0,$("#preview_div").css("height").length-2);
	$("#smck_div").css("margin-left",(parseInt(bodyWidth)+parseInt(preDivWidth))/2+20+"px");
	$("#smck_div").css("margin-top","-"+(parseInt(preDivHeight))+"px");
	$("#previewBg_div").css("height",(parseInt(preDivHeight)+80)+"px");
}

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=jydg";
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsJYDG" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null||requestScope.htmlGoodsJYDG.image1_2 ne null||requestScope.htmlGoodsJYDG.image1_3 ne null||requestScope.htmlGoodsJYDG.image1_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsJYDG.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_2 ne null }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_2"  alt="" src="${requestScope.htmlGoodsJYDG.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_3 ne null }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsJYDG.image1_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_4 ne null }">
					<td class="file_td" id="file_td1_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsJYDG.image1_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null }">
					<td class="file_td" id="file_td1_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsJYDG.image1_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsSMYL.image1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsSMYL.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_2 ne null }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsSMYL.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_3 ne null }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsSMYL.image1_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_4 ne null }">
				<input type="file" id="file1_4" name="file1_4" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_4" name="image1_4" value="${requestScope.htmlGoodsSMYL.image1_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_5 ne null }">
				<input type="file" id="file1_5" name="file1_5" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_5" name="image1_5" value="${requestScope.htmlGoodsSMYL.image1_5 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage1ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage1ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="image2ModBg_div" id="image2ModBg_div">
	<div class="image2Mod_div" id="image2Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage2ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null||requestScope.htmlGoodsJYDG.image2_2 ne null||requestScope.htmlGoodsJYDG.image2_3 ne null||requestScope.htmlGoodsJYDG.image2_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null }">
					<td class="file_td" id="file_td2_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsJYDG.image2_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_2 ne null }">
					<td class="file_td" id="file_td2_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_2"  alt="" src="${requestScope.htmlGoodsJYDG.image2_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_3 ne null }">
					<td class="file_td" id="file_td2_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_3" alt="" src="${requestScope.htmlGoodsJYDG.image2_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_4 ne null }">
					<td class="file_td" id="file_td2_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_4" alt="" src="${requestScope.htmlGoodsJYDG.image2_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null }">
					<td class="file_td" id="file_td2_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_5" alt="" src="${requestScope.htmlGoodsJYDG.image2_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<c:if test="${requestScope.htmlGoodsSMYL.image2_1 ne null }">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_1" name="image2_1" value="${requestScope.htmlGoodsSMYL.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image2_2 ne null }">
				<input type="file" id="file2_2" name="file2_2" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_2" name="image2_2" value="${requestScope.htmlGoodsSMYL.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image2_3 ne null }">
				<input type="file" id="file2_3" name="file2_3" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_3" name="image2_3" value="${requestScope.htmlGoodsSMYL.image2_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image2_4 ne null }">
				<input type="file" id="file2_4" name="file2_4" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_4" name="image2_4" value="${requestScope.htmlGoodsSMYL.image2_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image2_5 ne null }">
				<input type="file" id="file2_5" name="file2_5" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_5" name="image2_5" value="${requestScope.htmlGoodsSMYL.image2_5 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage2ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

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
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsJYDG.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsSMYL();">预览</div>
	<div class="save_div" onclick="saveEditHtmlGoodsSMYL();">保存</div>
	<div class="finishEdit_div" onclick="finishEditHtmlGoodsSMYL();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsJYDG.id }" />
<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsJYDG.goodsNumber }" />
<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
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