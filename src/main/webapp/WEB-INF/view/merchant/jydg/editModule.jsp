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
var path='<%=basePath %>';
var editor1,editor2;
var addDelImgTimeout2;
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

var dpn;
var disArr1=[];
var disArr2=[];
var desArr1=[];
var desArr2=[];
var dpnsArr1=[];
var dpssArr1=[];
var dm1Html,dm2Html;
function initDefaultHtmlVal(){
	dpn=$("#middle_div #productName").val();
	for(var i=0;i<5;i++){
		disArr1[i]="";
		disArr1[i]=$("#image1_div #list_div img[id^='img']").eq(i).attr("src");
	}
	for(var i=0;i<5;i++){
		disArr2[i]="";
		disArr2[i]=$("#image2_div #list_div img[id^='img']").eq(i).attr("src");
	}
	for(var i=0;i<1;i++){
		desArr1[i]="";
		desArr1[i]=$("#embed1_div #list_div embed[id^='embed']").eq(i).attr("src");
	}
	for(var i=0;i<5;i++){
		desArr2[i]="";
		desArr2[i]=$("#embed2_div #list_div embed[id^='embed']").eq(i).attr("src");
	}
	for(var i=0;i<3;i++){
		dpnsArr1[i]="";
		dpnsArr1[i]=$("#middle_div #pdf1_div #list_div div[id^='pdfUrl']").eq(i).find("span[class='name_span']").text();
		dpssArr1[i]="";
		dpssArr1[i]=$("#middle_div #pdf1_div #list_div div[id^='pdfUrl']").eq(i).find("span[class='size_span']").text();
	}
	setTimeout(function(){
		dm1Html=editor1.html();
		dm2Html=editor2.html();
	},"1000");
}

function resetDivPosition(){
	var middleDivHeight=$("#middle_div").css("height").substring(0,$("#middle_div").css("height").length-2);
	$("#right_div").css("margin-top","-"+(parseInt(middleDivHeight))+"px");
}

function deleteEmbed1Div(){
	$("#embed1_div").remove();
	$("#uploadFile3_div input[type='file']").remove();
	$("#uploadFile3_div input[type='text']").remove();
	resetDivPosition();
}

function deleteEmbed2Div(){
	$("#embed1_div").remove();
	$("#uploadFile4_div input[type='file']").remove();
	$("#uploadFile4_div input[type='text']").remove();
	resetDivPosition();
}

function deletePdf1Div(){
	$("#pdf1_div").remove();
	$("#uploadFile5_div input[type='file']").remove();
	$("#uploadFile5_div input[type='text']").remove();
	resetDivPosition();
}

function deleteImage1Div(){
	$("#image1_div").remove();
	$("#uploadFile1_div input[type='file']").remove();
	$("#uploadFile1_div input[type='text']").remove();
	resetDivPosition();
}

function deleteImage2Div(){
	$("#image2_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
	$("#uploadFile2_div input[type='text']").remove();
	resetDivPosition();
}

function resetEditorHtml(){
	$("#memo1").val(editor1.html());
	$("#memo2").val(editor2.html());
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

function renameImage(){
	$("#uploadFile1_div input[type='text']").each(function(i){
		$(this).attr("name","image1_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile2_div input[type='text']").each(function(i){
		$(this).attr("name","image2_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function previewHtmlGoodsJYDG(){
	if(!compareHtmlVal()){//这是已经编辑过内容的情况
		saveEditHtmlGoodsJYDG();
		
		var goodsNumber='${requestScope.htmlGoodsJYDG.goodsNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"jydg",goodsNumber:goodsNumber,accountId:accountId},
			function(data){
				console.log("==="+JSON.stringify(data));
				var previewJYDG=data.previewJYDG;
				$("#preview_div #title_div").text(previewJYDG.title);
				
				$("#preview_div #memo1_div").html(previewJYDG.memo1);
				
				$("#preview_div #memo2_div").html(previewJYDG.memo2);
				
				var image1_1=previewJYDG.image1_1;
				if(image1_1==null){
					$("#preview_div #image1_1_img").css("display","none");
					$("#preview_div #image1_1_img").attr("src","");
				}
				else{
					$("#preview_div #image1_1_img").css("display","block");
					$("#preview_div #image1_1_img").attr("src",image1_1);
				}
				
				var image1_2=previewJYDG.image1_2;
				if(image1_2==null){
					$("#preview_div #image1_2_img").css("display","none");
					$("#preview_div #image1_2_img").attr("src","");
				}
				else{
					$("#preview_div #image1_2_img").css("display","block");
					$("#preview_div #image1_2_img").attr("src",image1_2);
				}
				
				var image1_3=previewJYDG.image1_3;
				if(image1_3==null){
					$("#preview_div #image1_3_img").css("display","none");
					$("#preview_div #image1_3_img").attr("src","");
				}
				else{
					$("#preview_div #image1_3_img").css("display","block");
					$("#preview_div #image1_3_img").attr("src",image1_3);
				}
				
				var image1_4=previewJYDG.image1_4;
				if(image1_4==null){
					$("#preview_div #image1_4_img").css("display","none");
					$("#preview_div #image1_4_img").attr("src","");
				}
				else{
					$("#preview_div #image1_4_img").css("display","block");
					$("#preview_div #image1_4_img").attr("src",image1_4);
				}
				
				var image1_5=previewJYDG.image1_5;
				if(image1_5==null){
					$("#preview_div #image1_5_img").css("display","none");
					$("#preview_div #image1_5_img").attr("src","");
				}
				else{
					$("#preview_div #image1_5_img").css("display","block");
					$("#preview_div #image1_5_img").attr("src",image1_5);
				}
				
				var image2_1=previewJYDG.image2_1;
				if(image2_1==null){
					$("#preview_div #image2_1_img").css("display","none");
					$("#preview_div #image2_1_img").attr("src","");
				}
				else{
					$("#preview_div #image2_1_img").css("display","block");
					$("#preview_div #image2_1_img").attr("src",image2_1);
				}
				
				var image2_2=previewJYDG.image2_2;
				if(image2_2==null){
					$("#preview_div #image2_2_img").css("display","none");
					$("#preview_div #image2_2_img").attr("src","");
				}
				else{
					$("#preview_div #image2_2_img").css("display","block");
					$("#preview_div #image2_2_img").attr("src",image2_2);
				}
				
				var image2_3=previewJYDG.image2_3;
				if(image2_3==null){
					$("#preview_div #image2_3_img").css("display","none");
					$("#preview_div #image2_3_img").attr("src","");
				}
				else{
					$("#preview_div #image2_3_img").css("display","block");
					$("#preview_div #image2_3_img").attr("src",image2_3);
				}
				
				var image2_4=previewJYDG.image2_4;
				if(image2_4==null){
					$("#preview_div #image2_4_img").css("display","none");
					$("#preview_div #image2_4_img").attr("src","");
				}
				else{
					$("#preview_div #image2_4_img").css("display","block");
					$("#preview_div #image2_4_img").attr("src",image2_4);
				}
				
				var image2_5=previewJYDG.image2_5;
				if(image2_5==null){
					$("#preview_div #image2_5_img").css("display","none");
					$("#preview_div #image2_5_img").attr("src","");
				}
				else{
					$("#preview_div #image2_5_img").css("display","block");
					$("#preview_div #image2_5_img").attr("src",image2_5);
				}
				
				var embed1_1=previewJYDG.embed1_1;
				if(embed1_1==null){
					$("#preview_div #embed1_1_embed").css("display","none");
					$("#preview_div #embed1_1_embed").attr("src","");
				}
				else{
					$("#preview_div #embed1_1_embed").css("display","block");
					$("#preview_div #embed1_1_embed").attr("src",embed1_1);
				}
				
				var embed2_1=previewJYDG.embed2_1;
				if(embed2_1==null){
					$("#preview_div #embed2_1_embed").css("display","none");
					$("#preview_div #embed2_1_embed").attr("src","");
				}
				else{
					$("#preview_div #embed2_1_embed").css("display","block");
					$("#preview_div #embed2_1_embed").attr("src",embed2_1);
				}

				var pdfUrlDiv1_1=$("#preview_div #list_div #pdfUrl1_1");
				var pdfName1_1=previewJYDG.pdfName1_1;
				var pdfSize1_1=previewJYDG.pdfSize1_1;
				if(pdfName1_1==null){
					pdfUrlDiv1_1.css("display","none");
					pdfUrlDiv1_1.find(".name_span").text("");
					pdfUrlDiv1_1.find(".size_span").text("");
				}
				else{
					pdfUrlDiv1_1.css("display","block");
					pdfUrlDiv1_1.find(".name_span").text(pdfName1_1);
					pdfUrlDiv1_1.find(".size_span").text(pdfSize1_1+"kb");
				}

				var pdfUrlDiv1_2=$("#preview_div #list_div #pdfUrl1_2");
				var pdfName1_2=previewJYDG.pdfName1_2;
				var pdfSize1_2=previewJYDG.pdfSize1_2;
				if(pdfName1_2==null){
					pdfUrlDiv1_2.css("display","none");
					pdfUrlDiv1_2.find(".name_span").text("");
					pdfUrlDiv1_2.find(".size_span").text("");
				}
				else{
					pdfUrlDiv1_2.css("display","block");
					pdfUrlDiv1_2.find(".name_span").text(pdfName1_2);
					pdfUrlDiv1_2.find(".size_span").text(pdfSize1_2+"kb");
				}

				var pdfUrlDiv1_3=$("#preview_div #list_div #pdfUrl1_3");
				var pdfName1_3=previewJYDG.pdfName1_3;
				var pdfSize1_3=previewJYDG.pdfSize1_3;
				if(pdfName1_3==null){
					pdfUrlDiv1_3.css("display","none");
					pdfUrlDiv1_3.find(".name_span").text("");
					pdfUrlDiv1_3.find(".size_span").text("");
				}
				else{
					pdfUrlDiv1_3.css("display","block");
					pdfUrlDiv1_3.find(".name_span").text(pdfName1_3);
					pdfUrlDiv1_3.find(".size_span").text(pdfSize1_3+"kb");
				}
				
				initDefaultHtmlVal();
			}
		,"json");
	}
	else{
		$("#preview_div #productName_div").text(dpn);
		
		var image1_1_src=disArr1[0];
		if(image1_1_src==undefined||image1_1_src==""){
			$("#preview_div #image1_div #image1_1_img").css("display","none");
			$("#preview_div #image1_div #image1_1_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_1_img").css("display","block");
			$("#preview_div #image1_div #image1_1_img").attr("src",image1_1_src);
		}
		
		var image1_2_src=disArr1[1];
		if(image1_2_src==undefined||image1_2_src==""){
			$("#preview_div #image1_div #image1_2_img").css("display","none");
			$("#preview_div #image1_div #image1_2_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_2_img").css("display","block");
			$("#preview_div #image1_div #image1_2_img").attr("src",image1_2_src);
		}
		
		var image1_3_src=disArr1[2];
		if(image1_3_src==undefined||image1_3_src==""){
			$("#preview_div #image1_div #image1_3_img").css("display","none");
			$("#preview_div #image1_div #image1_3_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_3_img").css("display","block");
			$("#preview_div #image1_div #image1_3_img").attr("src",image1_3_src);
		}
		
		var image1_4_src=disArr1[3];
		if(image1_4_src==undefined||image1_4_src==""){
			$("#preview_div #image1_div #image1_4_img").css("display","none");
			$("#preview_div #image1_div #image1_4_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_4_img").css("display","block");
			$("#preview_div #image1_div #image1_4_img").attr("src",image1_4_src);
		}
		
		var image1_5_src=disArr1[4];
		if(image1_5_src==undefined||image1_5_src==""){
			$("#preview_div #image1_div #image1_5_img").css("display","none");
			$("#preview_div #image1_div #image1_5_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_5_img").css("display","block");
			$("#preview_div #image1_div #image1_5_img").attr("src",image1_5_src);
		}

		var image2_1_src=disArr2[0];
		if(image2_1_src==undefined||image2_1_src==""){
			$("#preview_div #image2_div #image2_1_img").css("display","none");
			$("#preview_div #image2_div #image2_1_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_1_img").css("display","block");
			$("#preview_div #image2_div #image2_1_img").attr("src",image2_1_src);
		}
		
		var image2_2_src=disArr2[1];
		if(image2_2_src==undefined||image2_2_src==""){
			$("#preview_div #image2_div #image2_2_img").css("display","none");
			$("#preview_div #image2_div #image2_2_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_2_img").css("display","block");
			$("#preview_div #image2_div #image2_2_img").attr("src",image2_2_src);
		}
		
		var image2_3_src=disArr2[2];
		if(image2_3_src==undefined||image2_3_src==""){
			$("#preview_div #image2_div #image2_3_img").css("display","none");
			$("#preview_div #image2_div #image2_3_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_3_img").css("display","block");
			$("#preview_div #image2_div #image2_3_img").attr("src",image2_3_src);
		}
		
		var image2_4_src=disArr2[3];
		if(image2_4_src==undefined||image2_4_src==""){
			$("#preview_div #image2_div #image2_4_img").css("display","none");
			$("#preview_div #image2_div #image2_4_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_4_img").css("display","block");
			$("#preview_div #image2_div #image2_4_img").attr("src",image2_4_src);
		}
		
		var image2_5_src=disArr2[4];
		if(image2_5_src==undefined||image2_5_src==""){
			$("#preview_div #image2_div #image2_5_img").css("display","none");
			$("#preview_div #image2_div #image2_5_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_5_img").css("display","block");
			$("#preview_div #image2_div #image2_5_img").attr("src",image2_5_src);
		}
		
		var embed1_1_src=desArr1[0];
		if(embed1_1_src==undefined||embed1_1_src==""){
			$("#preview_div #embed1_1_embed").css("display","none");
			$("#preview_div #embed1_1_embed").attr("src","");
		}
		else{
			$("#preview_div #embed1_1_embed").css("display","block");
			$("#preview_div #embed1_1_embed").attr("src",embed1_1_src);
		}
		
		var embed2_1_src=desArr2[0];
		if(embed2_1_src==undefined||embed2_1_src==""){
			$("#preview_div #embed2_1_embed").css("display","none");
			$("#preview_div #embed2_1_embed").attr("src","");
		}
		else{
			$("#preview_div #embed2_1_embed").css("display","block");
			$("#preview_div #embed2_1_embed").attr("src",embed2_1_src);
		}

		var pdfUrlDiv1_1=$("#preview_div #list_div #pdfUrl1_1");
		var pdfName1_1=dpnsArr1[0];
		var pdfSize1_1=dpssArr1[0];
		if(pdfName1_1==undefined||pdfName1_1==""){
			pdfUrlDiv1_1.css("display","none");
			pdfUrlDiv1_1.find(".name_span").text("");
			pdfUrlDiv1_1.find(".size_span").text("");
		}
		else{
			pdfUrlDiv1_1.css("display","block");
			pdfUrlDiv1_1.find(".name_span").text(pdfName1_1);
			pdfUrlDiv1_1.find(".size_span").text(pdfSize1_1);
		}

		var pdfUrlDiv1_2=$("#preview_div #list_div #pdfUrl1_2");
		var pdfName1_2=dpnsArr1[1];
		var pdfSize1_2=dpssArr1[1];
		if(pdfName1_2==undefined||pdfName1_2==""){
			pdfUrlDiv1_2.css("display","none");
			pdfUrlDiv1_2.find(".name_span").text("");
			pdfUrlDiv1_2.find(".size_span").text("");
		}
		else{
			pdfUrlDiv1_2.css("display","block");
			pdfUrlDiv1_2.find(".name_span").text(pdfName1_2);
			pdfUrlDiv1_2.find(".size_span").text(pdfSize1_2);
		}

		var pdfUrlDiv1_3=$("#preview_div #list_div #pdfUrl1_3");
		var pdfName1_3=dpnsArr1[2];
		var pdfSize1_3=dpssArr1[2];
		if(pdfName1_3==undefined||pdfName1_3==""){
			pdfUrlDiv1_3.css("display","none");
			pdfUrlDiv1_3.find(".name_span").text("");
			pdfUrlDiv1_3.find(".size_span").text("");
		}
		else{
			pdfUrlDiv1_3.css("display","block");
			pdfUrlDiv1_3.find(".name_span").text(pdfName1_3);
			pdfUrlDiv1_3.find(".size_span").text(pdfSize1_3);
		}
	}
	openPreviewBgDiv(1);
}

function compareHtmlVal(){
	var flag=true;
	var cpn=$("#middle_div #productName").val();
	if(dpn!=cpn){
		flag=false;
		return flag;
	}
	
	var cm1Html=editor1.html();
	if(dm1Html!=cm1Html){
		flag=false;
		return flag;
	}

	var cm2Html=editor2.html();
	if(dm2Html!=cm2Html){
		flag=false;
		return flag;
	}
	
	$("#uploadFile1_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr1[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});
	$("#uploadFile2_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr2[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});
	$("#uploadFile3_div input[id^='embed']").each(function(i){
		var embedSrc=$(this).val();
		alert(embedSrc)
		if(desArr1[i]!=embedSrc){
			flag=false;
			return flag;
		}
	});
	alert($("#uploadFile4_div input[id^='embed']").length)
	$("#uploadFile4_div input[id^='embed']").each(function(i){
		var embedSrc=$(this).val();
		if(desArr2[i]!=embedSrc){
			flag=false;
			return flag;
		}
	});
	$("#uploadFile5_div input[id^='pdfName']").each(function(i){
		var pdfName=$(this).val();
		if(dpnsArr1[i]!=pdfName){
			flag=false;
			return flag;
		}
	});
	
	return flag;
}

function saveEditHtmlGoodsJYDG(){
	if(checkIfPaid()){
		resetEditorHtml();
		renameFile();
		renameImage();
		
		var formData = new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"saveEditHtmlGoodsJYDG",
			dataType: "json",
			data:formData,
			cache: false,
			processData: false,
			contentType: false,
			success: function (data){
				if(data.status==1){
					$("#saveStatus_div").css("display","block");
					setTimeout("hideSaveStatusDiv()",3000);
				}
				else{
					$("#saveStatus_div").css("display","none");
				}
				$("#saveStatus_div").text(data.msg);
			}
		});
	}
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

function hideSaveStatusDiv(){
	$("#saveStatus_div").text("");
	$("#saveStatus_div").css("display","none");
}

function finishEditHtmlGoodsJYDG(){
	renameFile();
	renameImage();
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
	$("#uploadFile3_div").append("<input type=\"text\" id=\"embed"+uuid+"\" name=\"embed"+uuid+"\" />");
	document.getElementById("uploadFile3_inp").click();
}

function uploadEmbed2(){
	var uuid=createUUID();
	$("#uuid_hid4").val(uuid);
	$("#uploadFile4_div").html("<input type=\"file\" id=\"uploadFile4_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodeEmbed2(this)\"/>");
	document.getElementById("uploadFile4_inp").click();
}

function uploadPdf1(){
	var uuid=createUUID();
	$("#uuid_hid5").val(uuid);
	$("#uploadFile5_div").html("<input type=\"file\" id=\"uploadFile5_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePdf1(this)\"/>");
	$("#uploadFile5_div").append("<input type=\"text\" id=\"pdfUrl"+uuid+"\" name=\"pdfUrl"+uuid+"\" />");
	$("#uploadFile5_div").append("<input type=\"text\" id=\"pdfName"+uuid+"\" name=\"pdfName"+uuid+"\" />");
	$("#uploadFile5_div").append("<input type=\"text\" id=\"pdfSize"+uuid+"\" name=\"pdfSize"+uuid+"\" />");
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
	$("#uploadFile1_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
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
	$("#uploadFile2_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile2_inp").click();
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

function deleteImage2(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image2_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile2_div input[type='file'][name='file"+uuid+"']").remove();
	$("#uploadFile2_div input[type='text'][name='image"+uuid+"']").remove();

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
	
	var embedListDiv=$("#embed1Mod_div #embedList_div");
	var embedTag;
	if (!!window.ActiveXObject || "ActiveXObject" in window)
		embedTag="embed";
	else
		embedTag="iframe";
	embedListDiv.html("<"+embedTag+" class=\"item_embed\" id=\"embed"+uuid+"\" alt=\"\">"
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
<div class="embed1ModBg_div" id="embed1ModBg_div">
	<div class="embed1Mod_div" id="embed1Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedList_div" id="embedList_div">
				<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsJYDG.embed1_1 }">
			</div>
			<div class="reupload_div" onclick="uploadEmbed1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile3_div" id="uploadFile3_div">
				<c:if test="${requestScope.htmlGoodsJYDG.embed1_1 ne null }">
				<input type="file" id="file3_1" name="file3_1" onchange="showQrcodeEmbed1(this)" />
				<input type="text" id="embed1_1" name="embed1_1" value="${requestScope.htmlGoodsJYDG.embed1_1 }" />
				</c:if>
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
					<embed class="item_embed" id="embed2_1" alt="" src="${requestScope.htmlGoodsJYDG.embed2_1 }">
					<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteEmbed2(this);">
				</div>
			</div>
			<div class="reupload_div" onclick="uploadEmbed2();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile4_div" id="uploadFile4_div">
				<c:if test="${requestScope.htmlGoodsJYDG.embed1_1 ne null }">
				<input type="file" id="file4_1" name="file4_1" onchange="showQrcodeEmbed2(this)" />
				<input type="text" id="embed2_1" name="embed2_1" value="${requestScope.htmlGoodsJYDG.embed2_1 }" />
				</c:if>
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
				<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_1 ne null }">
				<div class="item_pdf" id="pdfUrl1_1">
					<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
					<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_1 }.pdf</span>
					<span class="size_span">${requestScope.htmlGoodsJYDG.pdfSize1_1 }kb</span>
				</div>
				</c:if>
			</div>
			<div class="upload_div" onclick="uploadPdf1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">上传</div>
			<div class="uploadFile5_div" id="uploadFile5_div">
				<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_1 ne null }">
				<input type="file" id="file5_1" name="file5_1" onchange="showQrcodePdf1(this)" />
				<input type="text" id="pdfUrl1_1" name="pdfUrl1_1" value="${requestScope.htmlGoodsJYDG.pdfUrl1_1 }" />
				<input type="text" id="pdfName1_1" name="pdfName1_1" value="${requestScope.htmlGoodsJYDG.pdfName1_1 }" />
				<input type="text" id="pdfSize1_1" name="pdfSize1_1" value="${requestScope.htmlGoodsJYDG.pdfSize1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_2 ne null }">
				<input type="file" id="file5_2" name="file5_2" onchange="showQrcodePdf1(this)" />
				<input type="text" id="pdfUrl1_2" name="pdfUrl1_2" value="${requestScope.htmlGoodsJYDG.pdfUrl1_2 }" />
				<input type="text" id="pdfName1_2" name="pdfName1_2" value="${requestScope.htmlGoodsJYDG.pdfName1_2 }" />
				<input type="text" id="pdfSize1_2" name="pdfSize1_2" value="${requestScope.htmlGoodsJYDG.pdfSize1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_3 ne null }">
				<input type="file" id="file5_3" name="file5_3" onchange="showQrcodePdf1(this)" />
				<input type="text" id="pdfUrl1_3" name="pdfUrl1_3" value="${requestScope.htmlGoodsJYDG.pdfUrl1_3 }" />
				<input type="text" id="pdfName1_3" name="pdfName1_3" value="${requestScope.htmlGoodsJYDG.pdfName1_3 }" />
				<input type="text" id="pdfSize1_3" name="pdfSize1_3" value="${requestScope.htmlGoodsJYDG.pdfSize1_3 }" />
				</c:if>
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
				<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null||requestScope.htmlGoodsJYDG.image1_2 ne null||requestScope.htmlGoodsJYDG.image1_3 ne null||requestScope.htmlGoodsJYDG.image1_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null&&requestScope.htmlGoodsJYDG.image1_1 ne '' }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsJYDG.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_2 ne null&&requestScope.htmlGoodsJYDG.image1_2 ne '' }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_2"  alt="" src="${requestScope.htmlGoodsJYDG.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_3 ne null&&requestScope.htmlGoodsJYDG.image1_3 ne '' }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsJYDG.image1_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_4 ne null&&requestScope.htmlGoodsJYDG.image1_4 ne '' }">
					<td class="file_td" id="file_td1_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsJYDG.image1_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_5 eq null&&requestScope.htmlGoodsJYDG.image1_5 ne '' }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null&&requestScope.htmlGoodsJYDG.image1_5 ne ''}">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null&&requestScope.htmlGoodsJYDG.image1_5 ne '' }">
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
				<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null&&requestScope.htmlGoodsJYDG.image1_1 ne '' }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsJYDG.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_2 ne null&&requestScope.htmlGoodsJYDG.image1_2 ne '' }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsJYDG.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_3 ne null&&requestScope.htmlGoodsJYDG.image1_3 ne '' }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsJYDG.image1_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_4 ne null&&requestScope.htmlGoodsJYDG.image1_4 ne '' }">
				<input type="file" id="file1_4" name="file1_4" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_4" name="image1_4" value="${requestScope.htmlGoodsJYDG.image1_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null&&requestScope.htmlGoodsJYDG.image1_5 ne '' }">
				<input type="file" id="file1_5" name="file1_5" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_5" name="image1_5" value="${requestScope.htmlGoodsJYDG.image1_5 }" />
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
					<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null&&requestScope.htmlGoodsJYDG.image2_1 ne '' }">
					<td class="file_td" id="file_td2_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsJYDG.image2_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_2 ne null&&requestScope.htmlGoodsJYDG.image2_2 ne '' }">
					<td class="file_td" id="file_td2_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_2"  alt="" src="${requestScope.htmlGoodsJYDG.image2_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_3 ne null&&requestScope.htmlGoodsJYDG.image2_3 ne '' }">
					<td class="file_td" id="file_td2_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_3" alt="" src="${requestScope.htmlGoodsJYDG.image2_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_4 ne null&&requestScope.htmlGoodsJYDG.image2_4 ne '' }">
					<td class="file_td" id="file_td2_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_4" alt="" src="${requestScope.htmlGoodsJYDG.image2_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_5 eq null&&requestScope.htmlGoodsJYDG.image2_5 ne '' }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null&&requestScope.htmlGoodsJYDG.image2_5 ne '' }">
				<tr>
					<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null&&requestScope.htmlGoodsJYDG.image2_5 ne '' }">
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
				<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null&&requestScope.htmlGoodsJYDG.image2_1 ne '' }">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_1" name="image2_1" value="${requestScope.htmlGoodsJYDG.image2_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_2 ne null&&requestScope.htmlGoodsJYDG.image2_2 ne '' }">
				<input type="file" id="file2_2" name="file2_2" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_2" name="image2_2" value="${requestScope.htmlGoodsJYDG.image2_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_3 ne null&&requestScope.htmlGoodsJYDG.image2_3 ne '' }">
				<input type="file" id="file2_3" name="file2_3" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_3" name="image2_3" value="${requestScope.htmlGoodsJYDG.image2_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_4 ne null&&requestScope.htmlGoodsJYDG.image2_4 ne '' }">
				<input type="file" id="file2_4" name="file2_4" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_4" name="image2_4" value="${requestScope.htmlGoodsJYDG.image2_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null&&requestScope.htmlGoodsJYDG.image2_5 ne '' }">
				<input type="file" id="file2_5" name="file2_5" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_5" name="image2_5" value="${requestScope.htmlGoodsJYDG.image2_5 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid2"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage2ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="previewBg_div" id="previewBg_div">
	<div class="preview_div" id="preview_div">
		<div class="productName_div" id="productName_div"></div>
		<div class="embed1_div" id="embed1_div">
			<embed class="embed1_1_embed" id="embed1_1_embed" alt="" src=""/>
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
				</tr>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow1 }">
				<tr class="item_tr" id="tr1" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName1 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue1 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo1 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow2 }">
				<tr class="item_tr" id="tr2" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName2 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue2 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo2 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow3 }">
				<tr class="item_tr" id="tr3" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName3 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue3 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo3 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow4 }">
				<tr class="item_tr" id="tr4" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName4 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue4 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo4 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow5 }">
				<tr class="item_tr" id="tr5" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName5 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue5 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo5 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow6 }">
				<tr class="item_tr" id="tr6" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName6 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue6 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo6 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow7 }">
				<tr class="item_tr" id="tr7" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName7 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue7 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo7 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow8 }">
				<tr class="item_tr" id="tr8" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName8 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue8 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo8 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow9 }">
				<tr class="item_tr" id="tr9" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName9 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue9 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo9 }
					</td>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsJYDG.jyyyblIfShow10 }">
				<tr class="item_tr" id="tr10" height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJYDG.jyyyblName10 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJYDG.jyyyblValue10 }
					</td>
					<td class="memo_td">
						${requestScope.htmlGoodsJYDG.jyyyblMemo10 }
					</td>
				</tr>
				</c:if>
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
			<div class="content_div">${requestScope.htmlGoodsJYDG.memo1 }</div>
		</div>
		<div class="pdf1_div" id="pdf1_div">
			<div class="title_div">
				<span class="text_span">产品说明书下载</span>
			</div>
			<div class="list_div" id="list_div">
				<div class="item_pdf" id="pdfUrl1_1">
					<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
					<span class="name_span"></span>
					<span class="size_span"></span>
				</div>
				<div class="item_pdf" id="pdfUrl1_2">
					<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
					<span class="name_span"></span>
					<span class="size_span"></span>
				</div>
				<div class="item_pdf" id="pdfUrl1_3">
					<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
					<span class="name_span"></span>
					<span class="size_span"></span>
				</div>
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
			<div class="content_div">${requestScope.htmlGoodsJYDG.memo2 }</div>
		</div>
		<div class="image1_div"  id="image1_div">
			<img class="image1_1_img" id="image1_1_img" alt="" src="">
			<img class="image1_2_img" id="image1_2_img" alt="" src="">
			<img class="image1_3_img" id="image1_3_img" alt="" src="">
			<img class="image1_4_img" id="image1_4_img" alt="" src="">
			<img class="image1_5_img" id="image1_5_img" alt="" src="">
		</div>
		<div class="embed2_div" id="embed2_div">
			<div class="title_div">
				<div class="num_div">04</div>
				<div class="text_div">
					<span class="text_span">拓展应用</span>
				</div>
			</div>
			<embed class="embed2_1_embed" id="embed2_1_embed" alt="" src=""/>
		</div>
		<div class="image2_div"  id="image2_div">
			<img class="image2_1_img" id="image2_1_img" alt="" src="">
			<img class="image2_2_img" id="image2_2_img" alt="" src="">
			<img class="image2_3_img" id="image2_3_img" alt="" src="">
			<img class="image2_4_img" id="image2_4_img" alt="" src="">
			<img class="image2_5_img" id="image2_5_img" alt="" src="">
		</div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsJYDG.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
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
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
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
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_1 ne null }">
			<div class="item_pdf" id="pdfUrl1_1" onclick="window.open('${requestScope.htmlGoodsJYDG.pdfUrl1_1 }');">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_1 }</span>
				<span class="size_span">${requestScope.htmlGoodsJYDG.pdfSize1_1 }kb</span>
			</div>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_2 ne null }">
			<div class="item_pdf" id="pdfUrl1_2">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_2 }</span>
				<span class="size_span">${requestScope.htmlGoodsJYDG.pdfSize1_2 }kb</span>
			</div>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_3 ne null }">
			<div class="item_pdf" id="pdfUrl1_3">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<span class="name_span">${requestScope.htmlGoodsJYDG.pdfName1_3 }</span>
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
			<c:if test="${requestScope.htmlGoodsJYDG.image1_2 ne null }">
			<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsJYDG.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image1_3 ne null }">
			<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsJYDG.image1_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image1_4 ne null }">
			<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsJYDG.image1_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null }">
			<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsJYDG.image1_5 }">
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
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
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
			<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null&&requestScope.htmlGoodsJYDG.image2_1 ne '' }">
			<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsJYDG.image2_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image2_2 ne null }">
			<img class="item_img" id="img2_2" alt="" src="${requestScope.htmlGoodsJYDG.image2_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image2_3 ne null }">
			<img class="item_img" id="img2_3" alt="" src="${requestScope.htmlGoodsJYDG.image2_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image2_4 ne null }">
			<img class="item_img" id="img2_4" alt="" src="${requestScope.htmlGoodsJYDG.image2_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null&&requestScope.htmlGoodsJYDG.image2_5 ne '' }">
			<img class="item_img" id="img2_5" alt="" src="${requestScope.htmlGoodsJYDG.image2_5 }">
			</c:if>
		</div>
		<div class="space_div"></div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsJYDG.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsJYDG();">预览</div>
	<div class="save_div" onclick="saveEditHtmlGoodsJYDG();">保存</div>
	<div class="finishEdit_div" onclick="finishEditHtmlGoodsJYDG();">完成编辑</div>
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