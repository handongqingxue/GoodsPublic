<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<style>
.register_bg_div{
	width:100%;height:100%;background-color:rgba(0, 0, 0, 0.3);position:fixed;
	display:none;
	z-index:6;
}
.regist_div{
	width: 830px;height:585px;background: #fafcfa;margin: 175px auto 0;padding: 1px;position: relative;
}
.regist_div .closeBut_div{
	right:10px;top:10px;color:#bbb;position: absolute;cursor: pointer;
}
.regist_div .title1_div{
	height: 34px;line-height: 34px;font-size: 24px;color: #4caf50;text-align: center;margin-top: 50px;
}
.regist_div .kssxgnr_div{
	height: 22px;line-height: 22px;color: #999;font-size: 16px;font-weight: 400;text-align: center;
}
.regist_div .main_div{
	width: 740px;height:420px;margin: 20px auto 0;background-color: #fff;padding:1px;
}
.regist_div .left_div{
	width:365px;height:340px;margin-top: 50px;
}
.regist_div .sjhdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.regist_div .userName_div,.regist_div .password_div,.regist_div .password1_div{
	width: 220px;height:50px;margin: auto;
}
.regist_div .userName_inp,.regist_div .password_inp,.regist_div .password1_inp{
	width: 210px;height: 48px;line-height: 48px;padding: 0 5px;border-top:0px;border-right:0px;border-bottom: 1px solid rgb(230,230,230);border-left:0px;
}
.regist_div input::-webkit-input-placeholder{
    color:#BEBEBE;
}
.regist_div nput::-moz-placeholder{   /* Mozilla Firefox 19+ */
    color:#BEBEBE;
}
.regist_div input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
    color:#BEBEBE;
}
.regist_div input:-ms-input-placeholder{  /* Internet Explorer 10-11 */ 
    color:#BEBEBE;
}
.regist_div .submitBut_div{
	width: 220px;
	height:38px;
	line-height:38px;
	margin:20px auto 0;
	font-size: 16px;
    color: #fff;
    text-align: center;
    background-color: #4caf50;
    border-radius: 4px;
    cursor: pointer;
}
.regist_div .resetBut_div{
	width: 218px;
	height:38px;
	line-height:38px;
	margin:20px auto 0;
	font-size: 16px;
    color: #999;
    text-align: center;
    background-color: #fff;
    border:1px solid #999;
    border-radius: 4px;
    cursor: pointer;
}
.regist_div .cutLine_div{
	width: 1px;height: 250px;left: 50%;margin-top: -295px;background-color: rgba(120,130,140,.13);position: absolute;
}
.regist_div .right_div{
	width:365px;height:220px;margin-top:-340px;margin-left:385px;position: absolute;
}
.regist_div .wxkjdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.regist_div .wxkjdl_div{
	width: 100%;height:210px;margin: 20px auto 0;text-align: center;
}
.regist_div .qrcode_img{
	width: 180px;height:180px;
}
.regist_div .wxsys_div{
	font-size: 12px;color: #9B9B9B;
}
.regist_div .zjdl_div{
	font-size: 12px;color: #9b9b9b;text-align: center;
}
.regist_div .zjdl_a{
	color: #357bb3;
}
</style>
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
					<img class="qrcode_img" src="<%=basePath%>resource/images/009.png"/>
						<div class="wxsys_div">无需验证码，快速登录</div>
				</div>
			</div>
		</div>
 		<div class="zjdl_div">已有账号？<a class="zjdl_a" onclick="doZjdl()">直接登录</a></div>
	</div>
</div>