<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>二维码商品发布登录</title>
<%@include file="js.jsp"%>
<style>
body{
	background-color: #f0f0f0;
}
.login_div{
	width: 816px;height:465px;background-color: #fff;margin: 175px auto 0;padding: 1px;
}
.main_div{
	margin-top: 70px;width: 100%;height: 250px;
}
.left_div{
	width: 406px;height:250px;
}
.sjhdl_h2{
	height: 20px;line-height: 20px;font-size: 16px;font-weight: 700;color: #4a4a4a;text-align: center;
}
.userName_div,.password_div{
	width: 220px;height:48px;margin: 20px auto 0;border-bottom: 1px solid #eee;
}
.userName_inp,.password_inp{
	height:48px;border:0;
}
.loginBut_div{
	width: 220px;height:38px;line-height:38px;margin:25px auto 0; font-size: 16px;color:#fff;text-align:center;background-color: #4caf50;border-radius:4px;cursor: pointer;
}
.cutLine_div{
	width: 1px;height: 250px;left: 50%;margin-top: -250px;background-color: #e6e6e6;position: absolute;
}
.right_div{
	width: 406px;height:250px;margin-left: 410px;margin-top: -250px;
}
.wxkjdl_h2{
	height: 20px;line-height: 20px;font-size: 16px;font-weight: 700;color: #4a4a4a;text-align: center;
}
.wxkjdl_div{
	width: 100%;height:210px;margin: 20px auto 0;text-align: center;
}
.qrcode_img{
	width: 180px;height:180px;
}
.wxsys_div{
	font-size: 12px;color: #9B9B9B;
}
.regist_div{
	font-size: 12px;color: #9b9b9b;text-align: center;margin-top: 80px;
}
.regist_a{
	color: #357bb3;
}
</style>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
$(function(){
	setInterval("synchronizeLogin()","3000","3000");
});

function synchronizeLogin(){
	var uuid=$("#uuid").val();
	$.post(baseUrl + "/merchant/synchronizeLogin",
		{uuid:uuid},
		function(result){
			//console.log(JSON.stringify(result));
			if(result.status==1){
				var account=result.data;
				var userName=account.userName;
				var password=account.passWord;
				var from='${param.from}';
				login(userName,password,from);
			}
		}
	,"json");
}

//更换验证码
var baseUrl="${pageContext.request.contextPath}";
function focusUserName(){
	var userName=$("#userName").val();
	if(userName=="请填写用户名"||userName=="用户名不能有特殊字符"||userName=="用户名首尾不能出现下划线\'_\'"){
		$("#userName").val("");
		$("#userName").css("color","#000");
	}
}
    
function checkUserName(){
    var userName=$("#userName").val();
    if(userName==null||userName==""||userName=="请填写用户名"){
		$("#userName").css("color","#f00");
		$("#userName").val("请填写用户名");
		return false;
	}
    else if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(userName)) {
    	$("#userName").css("color","#f00");
		$("#userName").val("用户名不能有特殊字符");
        return false;
    }
    else if (/(^\_)|(\__)|(\_+$)/.test(userName)) {
    	$("#userName").css("color","#f00");
		$("#userName").val("用户名首尾不能出现下划线\'_\'");
        return false;
    }
	else
		return true;
}

function checkPassword(){
	var password=$("#password").val();
	if(password==null||password==""||password=="请填写密码"){
		alert("请填写密码");
		return false;
	}
	else
		return true;
}

function checkInfo(){
	if(checkUserName()){
		if(checkPassword()){
			var userName=$("#userName").val();
			var password=MD5($("#password").val()).toUpperCase();
			var from='${param.from}';
			login(userName,password,from);
		}
	}
}

function login(userName,password,from){
	$.post(baseUrl + "/merchant/login",
		{userName:userName,password:password,from:from},
		function(json){
        	//console.log(json)
        	if(json.status==0){
        		window.location.href=baseUrl+json.url;
        	}else if(json.status==1){
        		alert(json.msg);
        	}
		}
	,"json");
}
</script>
</head>
<body>
 <div class="login_div">
 	<div class="main_div">
 		<div class="left_div">
 			<h2 class="sjhdl_h2">手机号登录</h2>
 			<div class="userName_div">
 				<input class="userName_inp layui-input" type="text" id="userName" placeholder="请输入登录名" value="" onfocus="focusUserName();" onblur="checkUserName();">
 			</div>
 			<div class="password_div">
 				<input class="password_inp layui-input" type="password" id="password" placeholder="请输入密码" value="" onblur="checkPassword()">
 			</div>
 			<div class="loginBut_div" onclick="checkInfo()">登录</div>
 		</div>
 		<div class="cutLine_div"></div>
 		<div class="right_div">
 			<h2 class="wxkjdl_h2">微信快捷登录</h2>
 			<div class="wxkjdl_div">
 				`<!-- 
 				<img class="qrcode_img" alt="" src="<%=basePath%>resource/images/010.png">
 				 -->
 				<img class="qrcode_img" alt="" src="${requestScope.qrcode}">
 				<input type="hidden" id="uuid" value="${requestScope.uuid}"/>
 				<div class="wxsys_div">微信扫一扫，快速登录</div>
 			</div>
 		</div>
 	</div>
 	<div class="regist_div">还没有账号？<a class="regist_a" href="<%=basePath%>merchant/regist">立即免费注册</a></div>
 </div>
</body>
</html>