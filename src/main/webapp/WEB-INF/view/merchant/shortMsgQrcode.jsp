<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>Insert title here</title>
<style type="text/css">
.tiShi_div{
	width: 300px;margin: 30px auto 0;
}
.qrcode_div{
	width: 300px; height: 300px; margin: 0 auto;
}
.qrcode_img{
	width: 100%; 
	height: 100%;
}
</style>
</head>
<body>
<c:choose>
	<c:when test="${requestScope.status eq 'ok' }">
		<div class="tiShi_div">
			此二维码24小时有效，若想长期有效，请联系客服15712773653（微信同号）
		</div>
		<div class="qrcode_div">
			<img class="qrcode_img" alt="" src="${requestScope.qrcode }" />
		</div>
	</c:when>
	<c:otherwise>
		<div class="tiShi_div">${requestScope.message }</div>
	</c:otherwise>
</c:choose>
</body>
</html>