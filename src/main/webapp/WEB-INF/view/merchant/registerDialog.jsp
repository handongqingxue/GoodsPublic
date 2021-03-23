<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/registerDialog.css" />
<script type="text/javascript">
var baseUrl="${pageContext.request.contextPath}";
function checkRegisterForm(){
	if(checkRegisterUserName()){
		if(checkRegisterPassword()){
			if(checkRegisterPassword1()){
				submitRegister();
			}
		}
	}
}

function focusRegisterUserName(){
	var userName=$("#regist_div #userName").val();
	if(userName=="请输入手机号或邮箱"){
		$("#regist_div #userName").val("");
		$("#regist_div #userName").css("color","#000");
	}
}

function checkRegisterUserName(){
	var userName=$("#regist_div #userName").val();
	if(userName==null||userName==""||userName=="请输入手机号或邮箱"){
		$("#regist_div #userName").css("color","#f00");
		$("#regist_div #userName").val("请输入手机号或邮箱");
		return false;
	}
	else
		return true;
}

function checkRegisterPassword(){
	var password=$("#regist_div #password").val();
	if(password==null||password==""||password=="请输入密码"){
		alert("请输入密码");
		return false;
	}
	else
		return true;
}

function checkRegisterPassword1(){
	var password=$("#regist_div #password").val();
	var password1=$("#regist_div #password1").val();
	if(password1==null||password1==""||password1=="请输入确认密码"){
		alert("请输入确认密码");
		return false;
	}
	if(password!=password1){
		alert("两次密码不一致");
		return false;
	}
	else
		return true;
}

function submitRegister(){
	var userName=$("#regist_div #userName").val();
	var password=MD5($("#regist_div #password").val()).toUpperCase();
	var phone=$("#regist_div #userName").val();
	$.post(baseUrl+"/merchant/registQL",
		{userName:userName,passWord:password,phone:phone},
		function(result){
			if(result.status==0){
				$("#accountNumber_hid").val(result.data);
			    var trade='${param.trade}';
			    if(trade=="spzs")
			  	  addHtmlGoodsSPZS();
			    else if(trade=="dmtzl")
				   addHtmlGoodsDMTZL();
			    else if(trade=="jzsg")
				    addHtmlGoodsJZSG();
			    else if(trade=="smyl")
				    addHtmlGoodsSMYL();
			}else if(result.status==2){
				alert(result.msg);
			}
		}
	,"json");
}

function resetRegister(){
	$("#regist_div #userName").val("");
	$("#regist_div #password").val("");
	$("#regist_div #password1").val("");
}

function showRegisterBgDiv(show){
	if(show)
		$("#register_bg_div").css("display","block");
	else
		$("#register_bg_div").css("display","none");
}

function doZjdl(){
	showRegisterBgDiv(false);
	showLoginBgDiv(true);
}
</script>
<div class="register_bg_div" id="register_bg_div">
	<div class="regist_div" id="regist_div">
		<div class="closeBut_div" onclick="doZjdl();">X</div>
		<div class="title1_div">注册账号，生成的二维码将保存在你的账号后台</div>
		<div class="kssxgnr_div">可随时修改内容，二维码图案不变</div>
		<div class="main_div">
			<div class="left_div">
				<h2 class="sjhdl_h2">二维码查询商家注册</h2>
				<div class="userName_div">
					<input type="text" class="userName_inp" id="userName" placeholder="请输入手机号或邮箱" onfocus="focusRegisterUserName();" onblur="checkRegisterUserName();"/>
				</div>
				<div class="password_div">
					<input type="password" class="password_inp" id="password" placeholder="请输入密码" onblur="checkRegisterPassword();"/>
				</div>
				<div class="password1_div">
					<input type="password" class="password1_inp" id="password1" placeholder="请再次输入密码" onblur="checkRegisterPassword1();"/>
				</div>
				<div style="width: 100%;height: 38px;margin: auto;">
					<div class="submitBut_div" onclick="checkRegisterForm();">立即提交</div>
					<div class="resetBut_div" onclick="resetRegister();">重置</div>
				</div>
			</div>
			<div class="cutLine_div"></div>
			<div class="right_div">
				<h2 class="wxkjdl_h2">微信快捷登录</h2>
				<div class="wxkjdl_div">
					<!-- 
					<img class="qrcode_img" src="<%=basePath%>resource/images/009.png"/>
					 -->
	 				<img class="qrcode_img" alt="" src="${requestScope.qrcode}">
	 				<input type="hidden" id="uuid" value="${requestScope.uuid}"/>
					<div class="wxsys_div">无需验证码，快速登录</div>
				</div>
			</div>
		</div>
 		<div class="zjdl_div">已有账号？<a class="zjdl_a" onclick="doZjdl()">直接登录</a></div>
	</div>
</div>