<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
<%@include file="../js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/pdf/jspdf.debug.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/pdf/html2canvas.min.js"></script>
<link rel="stylesheet" href="<%=basePath %>/resource/css/jydg/browseHtmlGoods.css" />
<script type="text/javascript">
function editContent(goodsNumber,accountNumber){
	location.href="${pageContext.request.contextPath}/merchant/main/goEditModule?trade=jydg&goodsNumber="+goodsNumber+"&accountNumber="+accountNumber;
}

function openXzewmBgDiv(flag){
	$("#xzewmBg_div").css("display",flag==1?"block":"none");
}

function downloadQrocdeImg(){
	//使用html2canvas 转换html为canvas
    html2canvas($("#xzewmBg_div #qrcodeImg_div")).then(function (canvas) {
       var imgUri = canvas.toDataURL("image/jpg").replace("image/jpg", "image/octet-stream"); // 获取生成的图片的url 　
       var saveLink = document.createElement('a');
       saveLink.href = imgUri;
       saveLink.download = '${requestScope.htmlGoodsSMYL.productName }'+'.png';
       saveLink.click();
    });
}
</script>
</head>
<body>
<div class="xzewmBg_div" id="xzewmBg_div">
	<div class="xzewm_div">
		<div class="close_div">
			<span class="close_span" onclick="openXzewmBgDiv(0)">关闭</span>
		</div>
		<div class="qrcodeImg_div" id="qrcodeImg_div">
			<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsSMYL.qrCode }" />
		</div>
		<div class="xzBut_div" onclick="downloadQrocdeImg()">
			<div>
				<span class="xz_text_span">下载</span>
			</div>
			<div>
				<span class="xs_text_span">230*230像素</span>
			</div>
		</div>
	</div>
</div>

<div class="main_div" id="main_div">
	<div class="top_div">
		<img class="createSuccess_img" alt="" src="/GoodsPublic/resource/images/006.png">
		<span class="createSuccess_span">生码成功！</span>
		<a class="createQrcode_a" href="${pageContext.request.contextPath}/merchant/main/goAddModule?trade=smyl">新建二维码</a>
		<a class="return_a" href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=smyl">返回列表页</a>
	</div>
	<div class="left_div" id="left_div">
		<div class="productName_div">
			${requestScope.htmlGoodsJYDG.productName }
		</div>
		<div class="embed1_div" id="embed1_div">
			<c:if test="${requestScope.htmlGoodsJYDG.embed1_1 ne null }">
				<embed alt="" src="${requestScope.htmlGoodsJYDG.embed1_1 }">
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
			<div class="content_div">
				${requestScope.htmlGoodsJYDG.memo1 }
			</div>
		</div>
		<div class="pdf1_div" id="pdf1_div">
			<div class="title_div">
				<span class="text_span">产品说明书下载</span>
			</div>
			<div class="list_div">
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
		<div class="memo2_div">
			<div class="title_div">
				<div class="num_div">03</div>
				<div class="text_div">
					<span class="text_span">常见问题解答</span>
				</div>
			</div>
			<div class="space_div"></div>
			<div class="content_div">
				${requestScope.htmlGoodsJYDG.memo2 }
			</div>
		</div>
		<div class="image1_div" id="image1_div">
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
				<embed class="embed2_1_embed" id="embed2_1_embed" alt="" src="${requestScope.htmlGoodsJYDG.embed2_1 }"/>
			</div>
			</c:if>
		</div>
	</div>
</div>
</body>
</html>