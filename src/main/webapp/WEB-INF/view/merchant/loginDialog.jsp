<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/loginDialog.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/MD5.js"></script>
<script type="text/javascript">
var synLogin,synLoginInter;
$(function(){
	synLoginInter=setInterval("synchronizeLogin()","3000","3000");
});

function synchronizeLogin(){
	var uuid=$("#login_div #uuid").val();
	$.post(baseUrl + "/merchant/synchronizeLogin",
		{uuid:uuid},
		function(result){
			//console.log(JSON.stringify(result));
			if(result.status==1){
				var account=result.data;
				var userName=account.userName;
				var password=account.passWord;
				var from='${param.from}';
				synLogin=true;
				login(userName,password);
			}
		}
	,"json");
}

function checkLoginInputData(){
	if(checkLoginUserName()){
		if(checkLoginPassword()){
			var userName=$("#login_div #userName").val();
		    var password=MD5($("#login_div #password").val()).toUpperCase();
			login(userName,password);
		}
	}
}

function focusLoginUserName(){
	var userName=$("#login_div #userName").val();
	if(userName=="请填写用户名"){
		$("#login_div #userName").val("");
		$("#login_div #userName").css("color","#000");
	}
}

function checkLoginUserName(){
	var userName=$("#login_div #userName").val();
	if(userName==null||userName==""||userName=="请填写用户名"){
		$("#login_div #userName").css("color","#f00");
		$("#login_div #userName").val("请填写用户名");
		return false;
	}
	else
		return true;
}

function checkLoginPassword(){
	var password=$("#login_div #password").val();
	if(password==null||password==""||password=="请填写密码"){
		alert("请填写密码");
		return false;
	}
	else
		return true;
}

function login(userName,password){
	  $.ajax({
		 url:"http://www.qrcodesy.com:8080/GoodsPublic/merchant/loginQL",
		 //url:"http://localhost:8080/GoodsPublic/merchant/loginQL",
		 dataType:'jsonp',
		 data:"userName="+userName+"&password="+password+"&action=addModule",
		 processData: false, 
		 jsonp:'callback',
		 jsonpCallback:"jsonpCallback",
		 type:'get',
		 success:function(data){
		   var json=JSON.parse(data);
		   //console.log(json);
		   if(json.status==0){
			  $("#accountNumber_hid").val(json.accountNumber);
			  var trade='${param.trade}';
			  if(trade=="spzs")
			  	addHtmlGoodsSPZS();
			  else if(trade=="dmtzl")
				 addHtmlGoodsDMTZL();
			  else if(trade=="jzsg")
				  addHtmlGoodsJZSG();
			  else if(trade=="smyl")
				  addHtmlGoodsSMYL();
		   }
		   else{
			  	alert(json.msg);
		   }
		 },
		 error:function(XMLHttpRequest, textStatus, errorThrown) {
		   alert(XMLHttpRequest);
		   alert(XMLHttpRequest.status);
		   alert(XMLHttpRequest.readyState);
		   alert(textStatus);
		 }
	 });
}

function showLoginBgDiv(show){
	if(show)
		$("#login_bg_div").css("display","block");
	else
	 	$("#login_bg_div").css("display","none");
}

function doMfzc(){
	showLoginBgDiv(false);
	showRegisterBgDiv(true);
}
</script>
<div class="login_bg_div" id="login_bg_div">
	<div class="login_div" id="login_div">
		<div class="closeBut_div" onclick="showLoginBgDiv(false);">X</div>
		<div class="dlqlzh_div">登录辰麒账号</div>
		<div class="main_div">
			<div class="logLeft_div">
				<h2 class="sjhdl_h2">手机号登录</h2>
				<div class="userName_div">
					<input type="text" class="userName_inp" id="userName" onfocus="focusLoginUserName();" onblur="checkLoginUserName();"/>
				</div>
				<div class="password_div">
					<input type="password" class="password_inp" id="password" onblur="checkLoginPassword();"/>
				</div>
				<div class="loginBut_div" onclick="checkLoginInputData();">登 录</div>
			</div>
			<div class="cutLine_div"></div>
			<div class="logRight_div">
				<h2 class="wxkjdl_h2">微信快捷登录</h2>
				<div class="wxkjdl_div">
					<!-- 
					<img class="qrcode_img" src="<%=basePath%>resource/images/009.png"/>
					 -->
	 				<img class="qrcode_img" alt="" src="${requestScope.qrcode}">
	 				<input type="hidden" id="uuid" value="${requestScope.uuid}"/>
 					<div class="wxsys_div">微信扫一扫，快速登录</div>
				</div>
			</div>
 			<div class="regist_div">还没有账号？<a class="regist_a" onclick="doMfzc()">立即免费注册</a></div>
		</div>
		<input type="hidden" id="price_hid"/>
	</div>
</div>