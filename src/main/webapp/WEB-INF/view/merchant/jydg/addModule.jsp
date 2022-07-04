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
var path='<%=basePath %>';
var addDelImgTimeout2;
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

$(function(){
	var bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");

    //这里必须延迟1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
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

function addHtmlGoodsSMYL(){
	renameFile();
	document.getElementById("sub_but").click();
}

function openEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","block");
}

function openEmbed2ModBgDiv(){
	$("#embed2ModBg_div").css("display","block");
}

function openPdf1ModBgDiv(){
	$("#pdf1ModBg_div").css("display","block");
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
}

function openImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","block");
}

function deleteEmbed1Div(){
	$("#embed1_div").remove();
	$("#uploadFile3_div input[type='file']").remove();
	resetDivPosition();
}

function deleteEmbed2Div(){
	$("#embed2_div").remove();
	$("#uploadFile4_div input[type='file']").remove();
	resetDivPosition();
}

function deletePdf1Div(){
	$("#pdf1_div").remove();
	$("#uploadFile5_div input[type='file']").remove();
	resetDivPosition();
}

function deleteImage1Div(){
	$("#image1_div").remove();
	$("#uploadFile1_div input[type='file']").remove();
	resetDivPosition();
}

function deleteImage2Div(){
	$("#image2_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
	resetDivPosition();
}

function renameFile(){
	$("#uploadFile1_div input[type='file']").each(function(i){
		$(this).attr("name","file1_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile2_div input[type='file']").each(function(i){
		$(this).attr("name","file2_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile3_div input[type='file']").each(function(i){
		$(this).attr("name","file3_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile4_div input[type='file']").each(function(i){
		$(this).attr("name","file4_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile5_div input[type='file']").each(function(i){
		$(this).attr("name","file5_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function closeEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","none");
}

function closeEmbed2ModBgDiv(){
	$("#embed2ModBg_div").css("display","none");
}

function closePdf1ModBgDiv(){
	$("#pdf1ModBg_div").css("display","none");
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

function uploadEmbed1(){
	var uuid=createUUID();
	$("#uuid_hid3").val(uuid);
	$("#uploadFile3_div").html("<input type=\"file\" id=\"uploadFile3_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodeEmbed1(this)\"/>");
	document.getElementById("uploadFile3_inp").click();
}

function uploadEmbed2(){
	if($("#embed2Mod_div .embedList_div div[class='item_div']").length>=5){
		alert("最多上传5段视频!");
		return false;
	}
	var uuid=createUUID();
	$("#uuid_hid4").val(uuid);
	$("#uploadFile4_div").append("<input type=\"file\" id=\"uploadFile4_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodeEmbed2(this)\"/>");
	document.getElementById("uploadFile4_inp").click();
}

function uploadPdf1(){
	var uuid=createUUID();
	$("#uuid_hid5").val(uuid);
	$("#uploadFile5_div").html("<input type=\"file\" id=\"uploadFile5_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePdf1(this)\"/>");
	document.getElementById("uploadFile5_inp").click();
}

function uploadImage1(){
	if($("#image1Mod_div table td[class='file_td']").length>=5){
		alert("最多上传5张图片!");
		return false;
	}
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	document.getElementById("uploadFile1_inp").click();
}

function uploadImage2(){
	if($("#image2Mod_div table td[class='file_td']").length>=5){
		alert("最多上传5张图片!");
		return false;
	}
	var uuid=createUUID();
	$("#uuid_hid2").val(uuid);
	$("#uploadFile2_div").append("<input type=\"file\" id=\"uploadFile2_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic2(this)\"/>");
	document.getElementById("uploadFile2_inp").click();
}

function deleteEmbed2(o){
	var curItem=$(o).parent();
	var uuid=curItem.attr("id").substring(8);
	$("#embed2_div #list_div embed[id='embed"+uuid+"']").remove();
	curItem.remove();
	$("#uploadFile4_div input[type='file'][name='file"+uuid+"']").remove();
	
	var embedListDiv=$("#embed2Mod_div #embedList_div");
	var itemArr1=embedListDiv.find(".item_div");
	embedListDiv.empty();
	for(var i=0;i<itemArr1.length;i++){
		embedListDiv.append(itemArr1[i]);
	}
	
	resetDivPosition();
}

function deletePdf1(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#pdf1_div #list_div div[id='pdf"+uuid+"']").remove();
	td.remove();
	$("#uploadFile5_div input[type='file'][name='file"+uuid+"']").remove();
	
	var pdfTab=$("#pdf1Mod_div table");
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

function deleteImage1(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image1_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile1_div input[type='file'][name='file"+uuid+"']").remove();
	
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

function deleteImage2(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image2_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile2_div input[type='file'][name='file"+uuid+"']").remove();
	
	var imageTab=$("#image2Mod_div table");
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

function showQrcodeEmbed1(obj){
	var uuid=$("#uuid_hid3").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var embedShowDiv=$("#embed1Mod_div #embedShow_div");
	var embedTag;
	if (!!window.ActiveXObject || "ActiveXObject" in window)
		embedTag="embed";
	else
		embedTag="iframe";
	embedShowDiv.html("<"+embedTag+" class=\"item_embed\" id=\"embed"+uuid+"\" alt=\"\">"
			+fileHtml);

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $embed = $("#embed"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $embed.attr("src", dataURL);
        
        $("#embed1_div #embed1_1").replaceWith("<"+embedTag+" class=\"item_embed\" id=\"embed1_1\" src=\""+dataURL+"\"/>");
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

function showQrcodeEmbed2(obj){
	var uuid=$("#uuid_hid4").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var embedListDiv=$("#embed2Mod_div #embedList_div");
	var embedTag;
	if (!!window.ActiveXObject || "ActiveXObject" in window)
		embedTag="embed";
	else
		embedTag="iframe";
	embedListDiv.append("<div class=\"item_div\" id=\"item_div"+uuid+"\">"
				+"<"+embedTag+" class=\"item_embed\" id=\"embed"+uuid+"\" alt=\"\"\>"
			+"</div>"+fileHtml);
	
	addDelImgTimeout2=setTimeout(function(){
		embedListDiv.find("#item_div"+uuid).append("<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteEmbed2(this);\">");
		clearTimeout(addDelImgTimeout2);
	},"1000");

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $embed = $("#embed"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $embed.attr("src", dataURL);

        var listDiv=$("#embed2_div #list_div");
        listDiv.append("<"+embedTag+" class=\"item_embed\" id=\"embed"+uuid+"\" src=\""+dataURL+"\"/>");

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

function showQrcodePdf1(obj){
	var uuid=$("#uuid_hid5").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");

	var appendStr="<div class=\"item_pdf\" id=\"pdf"+uuid+"\">";
		appendStr+="<input type=\"hidden\" id=\"url_hid"+uuid+"\"/>";
		appendStr+="<img class=\"file_img\" alt=\"\" src=\""+path+"/resource/images/011.png\">";
		appendStr+="<span class=\"name_span\" id=\"name_span"+uuid+"\"></span>";
		appendStr+="<span class=\"size_span\" id=\"size_span"+uuid+"\"></span>";
		appendStr+="</div>";
	var pdfModListDiv=$("#pdf1Mod_div #pdfList_div");
	pdfModListDiv.html(appendStr);
	
	var pdfListDiv=$("#pdf1_div #list_div");
	pdfListDiv.html(appendStr);

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var fileName;
    var fileSize;
    
    var modPdfDiv = pdfModListDiv.find("#pdf"+uuid);
    var modUrlHid = pdfModListDiv.find("#url_hid"+uuid);
    var modNameSpan = pdfModListDiv.find("#name_span"+uuid);
    var modSizeSpan = pdfModListDiv.find("#size_span"+uuid);

    var pdfDiv = pdfListDiv.find("#pdf"+uuid);
    var urlHid = pdfListDiv.find("#url_hid"+uuid);
    var nameSpan = pdfListDiv.find("#name_span"+uuid);
    var sizeSpan = pdfListDiv.find("#size_span"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        fileName=fileObj.files[0].name;
        fileSize=(fileObj.files[0].size/1024).toFixed(2)+"kb";

        modPdfDiv.attr("onclick","window.open('"+dataURL+"')")
        modUrlHid.val(dataURL);
        modNameSpan.text(fileName);
        modSizeSpan.text(fileSize);
        
        pdfDiv.attr("onclick","window.open('"+dataURL+"')")
        urlHid.val(dataURL);
        nameSpan.text(fileName);
        sizeSpan.text(fileSize);
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

function showQrcodePic2(obj){
	var uuid=$("#uuid_hid2").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	var tdHtml="<td class=\"file_td\" id=\"file_td"+uuid+"\">"
				+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage2(this);\">"
				+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
				+fileHtml
			+"</td>";
	
	var imageTab=$("#image2Mod_div table");
	//var length=imageTab.find("td[id^='file_td']").length;
	var tdLength=imageTab.find("td").length;
    if(tdLength%4==0){
    	var tr=imageTab.find("tr").eq(imageTab.find("tr").length-1);
    	tr.append(tdHtml)
    	imageTab.append("<tr>"+$("#image2Mod_div table #upload_td").prop("outerHTML")+"</tr>");
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
    var $img = $("#image2Mod_div table #img"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
        
        var listDiv=$("#image2_div #list_div");
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

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=jydg";
}

function checkForm(){
	if(checkIfLogined()){
		if(checkIfPaid()){
			return true;
		}
	}
	return false;
}

function checkIfLogined(){
	var bool=false;
	$.ajaxSetup({async:false});
	$.post("checkIfLogined",
		function(data){
			if(data.status=="ok"){
				bool=true;
			}
			else{
				//alert(data.message);
				showLoginBgDiv(true);
				bool=false;
			}
		}
	,"json");
	return bool;
}

function checkIfPaid(){
	var bool=false;
	$.ajaxSetup({async:false});
	$.post("checkIfPaid",
		{accountNumber:'${sessionScope.user.id}'},
		function(data){
			if(data.status=="ok"){
				bool=true;
			}
			else{
				alert(data.message);
				bool=false;
			}
		}
	,"json");
	return bool;
}
</script>
</head>
<body>
<%@include file="../registerDialog.jsp"%>
<%@include file="../loginDialog.jsp"%>
<form id="form1" name="form1" method="post" action="addHtmlGoodsJYDG" onsubmit="return checkForm();" enctype="multipart/form-data">
<div class="embed1ModBg_div" id="embed1ModBg_div">
	<div class="embed1Mod_div" id="embed1Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedShow_div" id="embedShow_div">
				<embed class="item_embed" id="embed1_1" alt="" src="/GoodsPublic/upload/embed/jydg/20220628152315.mp4">
			</div>
			<div class="reupload_div" onclick="uploadEmbed1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile3_div" id="uploadFile3_div">
				<input type="file" id="file3_1" name="file" onchange="showQrcodeEmbed1(this)" />
			</div>
			<input type="hidden" id="uuid_hid3"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeEmbed1ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeEmbed1ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="embed2ModBg_div" id="embed2ModBg_div">
	<div class="embed2Mod_div" id="embed2Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed2ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedList_div" id="embedList_div">
				<div class="item_div" id="item_div2_1">
					<embed class="item_embed" id="embed2_1" alt="" src="/GoodsPublic/upload/embed/jydg/20220628152315.mp4">
					<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteEmbed2(this);">
				</div>
				<div class="item_div" id="item_div2_2">
					<embed class="item_embed" id="embed2_2" alt="" src="/GoodsPublic/upload/embed/jydg/20220628152315.mp4">
					<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteEmbed2(this);">
				</div>
				<div class="item_div" id="item_div2_3">
					<embed class="item_embed" id="embed2_3" alt="" src="/GoodsPublic/upload/embed/jydg/20220628152315.mp4">
					<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteEmbed2(this);">
				</div>
				<div class="item_div" id="item_div2_4">
					<embed class="item_embed" id="embed2_4" alt="" src="/GoodsPublic/upload/embed/jydg/20220628152315.mp4">
					<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteEmbed2(this);">
				</div>
				<div class="item_div" id="item_div2_5">
					<embed class="item_embed" id="embed2_5" alt="" src="/GoodsPublic/upload/embed/jydg/20220628152315.mp4">
					<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteEmbed2(this);">
				</div>
			</div>
			<div class="upload_div" onclick="uploadEmbed2();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">上传</div>
			<div class="uploadFile4_div" id="uploadFile4_div">
				<input type="file" id="file4_1" name="file" onchange="showQrcodeEmbed2(this)" />
			</div>
			<input type="hidden" id="uuid_hid4"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeEmbed2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeEmbed2ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="pdf1ModBg_div" id="pdf1ModBg_div">
	<div class="pdf1Mod_div" id="pdf1Mod_div">
		<div class="title_div">
			<span class="title_span">pdf模块</span>
			<span class="close_span" onclick="closePdf1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="pdfList_div" id="pdfList_div">
				<div class="item_pdf" id="pdf1_1">
					<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
					<span class="name_span">D2105 免SP蒸蛋糕(电饭煲版).pdf</span>
					<span class="size_span">186.00kb</span>
				</div>
			</div>
			<div class="upload_div" onclick="uploadPdf1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">上传</div>
			<div class="uploadFile5_div" id="uploadFile5_div">
				<input type="file" id="file5_1" name="file5_1" onchange="showQrcodePdf1(this)" />
			</div>
			<input type="hidden" id="uuid_hid5"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closePdf1ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closePdf1ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<tr>
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="/GoodsPublic/upload/image/jydg/20220628144715.png">
					</td>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
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
				<tr>
					<td class="file_td" id="file_td2_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_1" alt="" src="/GoodsPublic/upload/image/jydg/20220629103508.png">
					</td>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
				</tr>
			</table>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" />
			</div>
			<input type="hidden" id="uuid_hid2"/>
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
					<input type="text" name="jyyyblName${status.index+1 }" value="${jyyybl.name }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue${status.index+1 }" value="${jyyybl.value }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo${status.index+1 }" value="${jyyybl.memo }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow${status.index+1 }" name="jyyyblIfShow${status.index+1 }" value="true" />
					<input type="button" class="jyyyblIfShow_inp" value="显示" onclick="changeJYYYBLTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
			<c:forEach begin="5" end="10" varStatus="status">
			<tr class="item_tr" id="tr${status.index }" height="50">
				<td class="name_td">
					<input type="text" name="jyyyblName${status.index }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="jyyyblValue${status.index }" maxlength="80" />
				</td>
				<td class="memo_td">
					<input type="text" name="jyyyblMemo${status.index+1 }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="jyyyblIfShow${status.index }" name="jyyyblIfShow${status.index }" value="true" />
					<input type="button" class="jyyyblIfShow_inp" value="显示" onclick="changeJYYYBLTrIfShow(${status.index },this)"/>
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
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.pdf1List }" var="pdf1" varStatus="status">
			<div class="item_pdf" id="pdf1_1" onclick="window.open('${pdf1.url }');">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${pdf1.name }.${pdf1.suffix }</span>
				<span class="size_span">${pdf1.size }${pdf1.unit }</span>
			</div>
			</c:forEach>
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
		<textarea class="memo2_ta" id="memo2" name="memo2" cols="100" rows="8"><%=htmlspecialchars(memo2) %></textarea>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.image1List }" var="image1" varStatus="status">
			<img class="item_img" id="img1_1" alt="" src="${image1.url }">
			</c:forEach>
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
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.embed2List }" var="embed2" varStatus="status">
			<embed class="item_embed" id="embed2_${status.index+1 }" src="${embed2.url }"/>
			</c:forEach>
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
			<c:forEach items="${requestScope.image2List }" var="image2" varStatus="status">
			<img class="item_img" id="img2_1" alt="" src="${image2.url }">
			</c:forEach>
		</div>
		<div class="space_div"></div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="uncreate_img" alt="" src="/GoodsPublic/resource/images/007.png">
	<div class="createQrcode_div" onclick="addHtmlGoodsSMYL();">生成二维码</div>
</div>
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