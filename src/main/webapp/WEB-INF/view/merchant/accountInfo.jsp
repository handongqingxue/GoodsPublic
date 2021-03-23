<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
<%@include file="js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/accountInfo.css" />
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
$(function(){
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#gsxx_div").css("width",setFitWidthInParent("body")+"px");
});

function checkEditNickName(){
	if(checkNickName()){
		var nickName=$("#nickName").val();

		$.post("editAccountInfo",
			{nickName:nickName},
			function(data){
				if(data.status==1){
					$.messager.defaults.ok = "是";
				    $.messager.defaults.cancel = "否";
				    $.messager.defaults.width = 350;//更改消息框宽度
				    $.messager.confirm(
				    	"提示",
				    	"账户信息编辑成功，重新登录生效！是否重新登录？"
				        ,function(r){    
				            if (r){    
				                location.href="../exit";
				            }
				        }); 
				}
				else{
					$.messager.alert("提示","账户信息编辑失败","warning");
				}
			}
		,"json");
	}
}

function checkEditPwd(){
	if(checkPassWord()){
		if(checkNewPwd()){
			if(checkNewPwd2()){
				var passWord = $("#newPwd").val();
				$.post("updatePwdByAccountId",
					{passWord:MD5(passWord).toUpperCase()},
					function(result){
						var json=JSON.parse(result);
						if(json.status==1){
							$.messager.defaults.ok = "是";
						    $.messager.defaults.cancel = "否";
						    $.messager.defaults.width = 350;//更改消息框宽度
						    $.messager.confirm(
						    	"提示",
						    	"修改密码成功，重新登录生效！是否重新登录？"
						        ,function(r){    
						            if (r){    
						                location.href="../exit";
						            }
						        }); 
						}
						else{
							$.messager.alert("提示","修改密码失败","warning");
						}
					}
				);
			}
		}
	}
}

function checkEditCompany(){
	if(checkCompanyName()){
		if(checkCompanyAddress()){
			if(checkPhone()){
				if(checkEmail()){
					var companyName=$("#companyName").val();
					var companyAddress=$("#companyAddress").val();
					var phone=$("#phone").val();
					var email=$("#email").val();
					
					$.post("editAccountInfo",
						{companyName:companyName,companyAddress:companyAddress,phone:phone,email:email},
						function(data){
							if(data.status==1){
								$.messager.defaults.ok = "是";
							    $.messager.defaults.cancel = "否";
							    $.messager.defaults.width = 350;//更改消息框宽度
							    $.messager.confirm(
							    	"提示",
							    	"商家编辑成功，重新登录生效！是否重新登录？"
							        ,function(r){    
							            if (r){    
							                location.href="../exit";
							            }
							        }); 
							}
							else{
								$.messager.alert("提示","商家编辑失败","warning");
							}
						}
					,"json");
				}
			}
		}
	}
}

function focusNickName(){
	var nickName = $("#nickName").val();
	if(nickName=="昵称不能为空"){
		$("#nickName").val("");
		$("#nickName").css("color", "#555555");
	}
}

//验证昵称
function checkNickName(){
	var nickName = $("#nickName").val();
	if(nickName==null||nickName==""||nickName=="昵称不能为空"){
		$("#nickName").css("color","#E15748");
    	$("#nickName").val("昵称不能为空");
    	return false;
	}
	else
		return true;
}

//验证原密码
function checkPassWord(){
	var flag=false;
	var userName='${sessionScope.user.userName}';
	var passWord = $("#passWord").val();
	if(passWord==null||passWord==""){
    	alert("原密码不能为空");
    	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post("checkPassWord",
			{passWord:MD5(passWord).toUpperCase(),userName:userName},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					alert(data.message);
					flag=false;
				}
			}
		,"json");
	}
	return flag;
}

//验证新密码
function checkNewPwd(){
	var passWord = $("#passWord").val();
	var newPwd = $("#newPwd").val();
	if(newPwd==null||newPwd==""){
    	alert("新密码不能为空");
    	return false;
	}
	if(newPwd==passWord){
		alert("新密码不能和原密码一致！");
    	return false;
	}
	else
		return true;
}

//验证确认密码
function checkNewPwd2(){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	if(newPwd2==null||newPwd2==""){
    	alert("确认密码不能为空");
    	return false;
	}
	else if(newPwd!=newPwd2){
		alert("两次密码不一致！");
    	return false;
	}
	else
		return true;
}

function focusCompanyName(){
	var companyName = $("#companyName").val();
	if(companyName=="公司名称不能为空"){
		$("#companyName").val("");
		$("#companyName").css("color", "#555555");
	}
}

//验证公司名称
function checkCompanyName(){
	var companyName = $("#companyName").val();
	if(companyName==null||companyName==""||companyName=="公司名称不能为空"){
		$("#companyName").css("color","#E15748");
    	$("#companyName").val("公司名称不能为空");
    	return false;
	}
	else
		return true;
}

function focusCompanyAddress(){
	var companyAddress = $("#companyAddress").val();
	if(companyAddress=="公司地址不能为空"){
		$("#companyAddress").val("");
		$("#companyAddress").css("color", "#555555");
	}
}

//验证公司地址
function checkCompanyAddress(){
	var companyAddress = $("#companyAddress").val();
	if(companyAddress==null||companyAddress==""||companyAddress=="公司地址不能为空"){
		$("#companyAddress").css("color","#E15748");
    	$("#companyAddress").val("公司地址不能为空");
    	return false;
	}
	else
		return true;
}

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="联系方式不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证联系方式
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="联系方式不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("联系方式不能为空");
    	return false;
	}
	else
		return true;
}

function focusEmail(){
	var email = $("#email").val();
	if(email=="邮箱不能为空"){
		$("#email").val("");
		$("#email").css("color", "#555555");
	}
}

//验证邮箱
function checkEmail(){
	var email = $("#email").val();
	if(email==null||email==""||email=="邮箱不能为空"){
		$("#email").css("color","#E15748");
    	$("#email").val("邮箱不能为空");
    	return false;
	}
	else
		return true;
}
	
function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
}

function openEditNickNameDialog(flag){
	$("#editNickNameBg_div").css("display",flag==1?"block":"none");
}

function openEditPwdDialog(flag){
	$("#editPwdBg_div").css("display",flag==1?"block":"none");
}

function openEditCompanyDialog(flag){
	$("#editCompanyBg_div").css("display",flag==1?"block":"none");
}

function openBwxQrcodeBgDiv(flag){
	$("#bwxQrcodeBg_div").css("display",flag==1?"block":"none");
}

function openRbwxQrcodeBgDiv(flag){
	$("#rbwxQrcodeBg_div").css("display",flag==1?"block":"none");
}
</script>
</head>
<body>
<div class="editNickNameBg_div" id="editNickNameBg_div">
	<div class="editNickName_div">
		<h4 class="title">修改昵称</h4>
		<div class="nc_div">
			<span>昵称</span>
			<input type="text" id="nickName" value="${requestScope.accountMsg.nickName }" onfocus="focusNickName()" onblur="checkNickName()"/>
		</div>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditNickNameDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditNickName()">提交</button>
		</div>
	</div>
</div>

<div class="editPwdBg_div" id="editPwdBg_div">
	<div class="editPwd_div">
		<div>
			<span class="close_span" onclick="openEditPwdDialog(0)">×</span>
		</div>
		<h4 class="title">修改密码</h4>
		<div class="ymm_div">
			<input type="password" id="passWord" placeholder="原密码"/>
		</div>
		<div class="xmm_div">
			<input type="password" id="newPwd" placeholder="新密码"/>
		</div>
		<div class="qrmm_div">
			<input type="password" id="newPwd2" placeholder="确认密码"/>
		</div>
		<div class="confirm_div" onclick="checkEditPwd()">确定</div>
		<div class="warn_div">注意：密码修改后需要重新登录系统</div>
	</div>
</div>

<div class="editCompanyBg_div" id="editCompanyBg_div">
	<div class="editCompany_div">
		<h4 class="title">公司信息</h4>
		<div class="gsmc_div">
			<span>公&nbsp;&nbsp;司&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称</span>
			<input type="text" id="companyName" value="${requestScope.accountMsg.companyName }" onfocus="focusCompanyName()" onblur="checkCompanyName()"/>
		</div>
		<div class="gsdz_div">
			<span>公&nbsp;&nbsp;司&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址</span>
			<input type="text" id="companyAddress" value="${requestScope.accountMsg.companyAddress }" onfocus="focusCompanyAddress()" onblur="checkCompanyAddress()"/>
		</div>
		<div class="lxdh_div">
			<span>联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话</span>
			<input type="text" id="phone" value="${requestScope.accountMsg.phone }" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
		<div class="yx_div">
			<span>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</span>
			<input type="text" id="email" value="${requestScope.accountMsg.email }" onfocus="focusEmail()" onblur="checkEmail()"/>
		</div>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditCompanyDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditCompany()">提交</button>
		</div>
	</div>
</div>

<div class="bwxQrcodeBg_div" id="bwxQrcodeBg_div">
	<div class="bwxQrcode_div">
		<div>
			<span class="close_span" onclick="openBwxQrcodeBgDiv(0)">×</span>
		</div>
		<h3 class="title_h3">成为二维码管理员</h3>
		<div class="title_div">扫描下方二维码，绑定微信后，可直接使用微信扫码登录</div>
		<div class="qrcode_div">
			<img class="qrcode_img" alt="" src="${requestScope.accountMsg.bwxQrcode }">
		</div>
		<span class="yhzs_span" onclick="openBwxQrcodeBgDiv(0)">以后再说</span>
	</div>	
</div>

<div class="rbwxQrcodeBg_div" id="rbwxQrcodeBg_div">
	<div class="rbwxQrcode_div">
		<div>
			<span class="close_span" onclick="openRbwxQrcodeBgDiv(0)">×</span>
		</div>
		<h3 class="title_h3">解除微信绑定</h3>
		<div class="title_div">扫描下方二维码，解除微信绑定。解除后，将无法使用微信扫码登录</div>
		<div class="qrcode_div">
			<img class="qrcode_img" alt="" src="${requestScope.accountMsg.rbwxQrcode }">
		</div>
		<span class="yhzs_span" onclick="openRbwxQrcodeBgDiv(0)">以后再说</span>
	</div>	
</div>

<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div class="zhxx_div" id="zhxx_div">
		<div class="title_div">账户信息</div>
		<div class="attr_div">
			<span class="nc_key_span">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
			<span class="nc_val_span">${requestScope.accountMsg.nickName }</span>
			<span class="xgnc_span" onclick="openEditNickNameDialog(1)">修改昵称</span>
		</div>
		<div class="attr_div">
			<span class="yhzh_key_span">用户账号：</span>
			<span class="yhzh_val_span">${requestScope.accountMsg.userName }</span>
			<span class="mm_key_span">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
			<span class="mm_ysz_span">已设置</span>
			<span class="xgmm_span" onclick="openEditPwdDialog(1)">修改密码</span>
		</div>
		<div class="attr_div">
			<span class="bdwx_span">绑定微信：</span>
			<c:choose>
			<c:when test="${requestScope.accountMsg.openId eq null||requestScope.accountMsg.openId eq '' }">
				<span class="wbd_span" onclick="openBwxQrcodeBgDiv(1)">未绑定</span>
			</c:when>
			<c:otherwise>
				<span class="jcbd_span" onclick="openRbwxQrcodeBgDiv(1)">解除绑定</span>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="gsxx_div" id="gsxx_div">
		<div class="title_div">公司信息</div>
		<div class="attr_div">
			<span class="gsmc_key_span">公&nbsp;&nbsp;司&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称：</span>
			<span class="gsmc_val_span">${requestScope.accountMsg.companyName }</span>
		</div>
		<div class="attr_div">
			<span class="gsdz_key_span">公&nbsp;&nbsp;司&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址：</span>
			<span class="gsdz_val_span">${requestScope.accountMsg.companyAddress }</span>
		</div>
		<div class="attr_div">
			<span class="lxdh_key_span">联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话：</span>
			<span class="lxdh_val_span">${requestScope.accountMsg.phone }</span>
		</div>
		<div class="attr_div">
			<span class="yx_key_span">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</span>
			<span class="yx_val_span">${requestScope.accountMsg.email }</span>
		</div>
		<div class="attr_div">
			<span class="xggsxx_span" onclick="openEditCompanyDialog(1)">修改公司信息</span>
		</div>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>