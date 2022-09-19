<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>商品</title>
<%@include file="../js.jsp"%>
<style type="text/css">
img{
   pointer-events:none;
}
</style>
<script type="text/javascript">
//https://www.jb51.net/html5/772143.html 禁止长按图片下载
//http://localhost:8080/GoodsPublic/merchant/main/goShowHtmlGoods?trade=jydg&goodsNumber=20220630141816&accountId=59
var path='<%=basePath %>';
var embedWHPercent=9/16;
$(function(){
	resetDivSize("embed1,embed2");
	//setUnTouch("img");
});

//这个方法虽然禁止下载图片，但点击图片无法拖动网页，暂时不用
function setUnTouch(tag){
	$(tag).attr("ontouchstart","return false");
}

function resetDivSize(nameStr){
	var bodyWidth=$("body").width();
	var nameArr=nameStr.split(",");
	for (var i = 0; i < nameArr.length; i++) {
		if(nameArr[i]=="embed1"){
			var embed1=$("#main_div #embed1_div video");
			var embed1Height=bodyWidth*0.95/embedWHPercent;
			embed1.attr("height",embed1Height);
		}
		else if(nameArr[i]=="embed2"){
			var embed2=$("#main_div #embed2_div .content_div video");
			var embed2Height=bodyWidth/embedWHPercent;
			embed2.attr("height",embed2Height);
		}
	}
}
</script>
<link rel="stylesheet" href="<%=basePath %>/resource/css/jydg/showHtmlGoods.css" />
</head>
<body>
<div class="main_div" id="main_div">
	<div class="productName_div">
		${requestScope.htmlGoodsJYDG.productName }
	</div>
	<div class="embed1_div" id="embed1_div">
		<c:if test="${requestScope.htmlGoodsJYDG.embed1_1 ne null }">
			<video controls="true" controlslist="nodownload">
			  <source src="${requestScope.htmlGoodsJYDG.embed1_1 }" type="video/mp4" />
			</video>
		</c:if>
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
		<div class="list_div">
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_1 ne null }">
			<div class="item_pdf" id="pdf1_1" onclick="window.open('${requestScope.htmlGoodsJYDG.pdfUrl1_1 }')">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<div class="name_div">${requestScope.htmlGoodsJYDG.pdfName1_1 }</div>
				<div class="size_div">${requestScope.htmlGoodsJYDG.pdfSize1_1 }kb</div>
			</div>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_2 ne null }">
			<div class="item_pdf" id="pdf1_2" onclick="window.open('${requestScope.htmlGoodsJYDG.pdfUrl1_2 }');">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<div class="name_div">${requestScope.htmlGoodsJYDG.pdfName1_2 }</div>
				<div class="size_div">${requestScope.htmlGoodsJYDG.pdfSize1_2 }kb</div>
			</div>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJYDG.pdfUrl1_3 ne null }">
			<div class="item_pdf" id="pdf1_3" onclick="window.open('${requestScope.htmlGoodsJYDG.pdfUrl1_3 }');">
				<img class="file_img" alt="" src="<%=basePath %>/resource/images/011.png">
				<div class="name_div">${requestScope.htmlGoodsJYDG.pdfName1_3 }</div>
				<div class="size_div">${requestScope.htmlGoodsJYDG.pdfSize1_3 }kb</div>
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
		<div class="content_div">${requestScope.htmlGoodsJYDG.memo2 }</div>
	</div>
	<div class="image1_div"  id="image1_div">
		<c:if test="${requestScope.htmlGoodsJYDG.image1_1 ne null }">
			<img class="image1_1_img" alt="" src="${requestScope.htmlGoodsJYDG.image1_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image1_2 ne null }">
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsJYDG.image1_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsJYDG.image1_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image1_4 ne null }">
			<img class="image1_4_img" alt="" src="${requestScope.htmlGoodsJYDG.image1_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image1_5 ne null }">
			<img class="image1_5_img" alt="" src="${requestScope.htmlGoodsJYDG.image1_5 }">
		</c:if>
	</div>
	<div class="embed2_div" id="embed2_div">
		<div class="title_div">
			<div class="num_div">04</div>
			<div class="text_div">
				<span class="text_span">拓展应用</span>
			</div>
		</div>
		<c:if test="${requestScope.htmlGoodsJYDG.embed2_1 ne null }">
			<div class="content_div">
				<video class="embed2_1_embed" controls="true" controlslist="nodownload">
				  <source src="${requestScope.htmlGoodsJYDG.embed2_1 }" type="video/mp4" />
				</video>
			</div>
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.embed2_2 ne null }">
			<div class="content_div">
				<video class="embed2_2_embed" controls="true" controlslist="nodownload">
				  <source src="${requestScope.htmlGoodsJYDG.embed2_2 }" type="video/mp4" />
				</video>
			</div>
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.embed2_3 ne null }">
			<div class="content_div">
				<video class="embed2_3_embed" controls="true" controlslist="nodownload">
				  <source src="${requestScope.htmlGoodsJYDG.embed2_3 }" type="video/mp4" />
				</video>
			</div>
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.embed2_4 ne null }">
			<div class="content_div">
				<video class="embed2_4_embed" controls="true" controlslist="nodownload">
				  <source src="${requestScope.htmlGoodsJYDG.embed2_4 }" type="video/mp4" />
				</video>
			</div>
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.embed2_5 ne null }">
			<div class="content_div">
				<video class="embed2_5_embed" controls="true" controlslist="nodownload">
				  <source src="${requestScope.htmlGoodsJYDG.embed2_5 }" type="video/mp4" />
				</video>
			</div>
		</c:if>
	</div>
	<div class="image2_div"  id="image2_div">
		<c:if test="${requestScope.htmlGoodsJYDG.image2_1 ne null }">
			<img class="image2_1_img" alt="" src="${requestScope.htmlGoodsJYDG.image2_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image2_2 ne null }">
			<img class="image2_2_img" alt="" src="${requestScope.htmlGoodsJYDG.image2_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image2_3 ne null }">
			<img class="image2_3_img" alt="" src="${requestScope.htmlGoodsJYDG.image2_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image2_4 ne null }">
			<img class="image2_4_img" alt="" src="${requestScope.htmlGoodsJYDG.image2_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJYDG.image2_5 ne null }">
			<img class="image2_5_img" alt="" src="${requestScope.htmlGoodsJYDG.image2_5 }">
		</c:if>
	</div>
</div>
</body>
</html>