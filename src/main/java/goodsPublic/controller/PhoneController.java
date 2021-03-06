package goodsPublic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodsPublic.util.MethodUtil;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.entity.*;
import goodsPublic.service.PublicService;
import goodsPublic.service.UserService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/phone")
public class PhoneController {

	@Autowired
	private PublicService publicService;
	@Autowired
	private UserService userService;

	@RequestMapping(value="/openJPDHJFRedBagByJC")
	@ResponseBody
	public Map<String, Object> openJPDHJFRedBagByJC(ScoreQrcode sq) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		boolean bool = publicService.openJPDHJFRedBagByJC(sq);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "打开红包失败！");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/createPrizeCode")
	@ResponseBody
	public Map<String, Object> createPrizeCode(PrizeCode pz, Integer dhjpScore, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		pz.setCodeNo(new Random().nextInt(10000)+"");
		
		int count=publicService.addPrizeCode(pz,dhjpScore,openId);
		
		if(count>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("codeNo", pz.getCodeNo());
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "生成兑奖码失败！");
		}
		
		return jsonMap;
	}
	
	@RequestMapping(value="/addScoreTakeRecord")
	@ResponseBody
	public Map<String, Object> addScoreTakeRecord(ScoreTakeRecord str) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();

		int count=publicService.addScoreTakeRecord(str);
		
		if(count>0) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "添加积分消费记录失败！");
		}
		
		return jsonMap;
	}
	
	@RequestMapping(value="/goAdminCreateQrcode")
	public String goAdminCreateQrcode(HttpServletRequest request) {

		Map<String, Object> resultMap = checkAdminAccount("goAdminCreateQrcode",request);
		String status = resultMap.get("status").toString();
		if("noCode".equals(status)) {
			String getCodeUrl = resultMap.get("getCodeUrl").toString();
			return "redirect:"+getCodeUrl;
		}
		else if("unBind".equals(status)) {
			String message = resultMap.get("message").toString();
			request.setAttribute("message", message);
			return "/merchant/phoneAdmin/unBind";
		}
		else
			return "/merchant/phoneAdmin/createQrcode";
	}
	
	@RequestMapping(value="/goAdminQrcodeList")
	public String goAdminQrcodeList(HttpServletRequest request) {

		Map<String, Object> resultMap = checkAdminAccount("goAdminQrcodeList",request);
		String status = resultMap.get("status").toString();
		if("noCode".equals(status)) {
			String getCodeUrl = resultMap.get("getCodeUrl").toString();
			return "redirect:"+getCodeUrl;
		}
		else if("unBind".equals(status)) {
			String message = resultMap.get("message").toString();
			request.setAttribute("message", message);
			return "/merchant/phoneAdmin/unBind";
		}
		else
			return "/merchant/phoneAdmin/qrcodeList";
	}
	
	@RequestMapping(value="/goAdminMine")
	public String goAdminMine(HttpServletRequest request) {

		Map<String, Object> resultMap = checkAdminAccount("goAdminMine",request);
		String status = resultMap.get("status").toString();
		if("noCode".equals(status)) {
			String getCodeUrl = resultMap.get("getCodeUrl").toString();
			return "redirect:"+getCodeUrl;
		}
		else if("unBind".equals(status)) {
			String message = resultMap.get("message").toString();
			request.setAttribute("message", message);
			return "/merchant/phoneAdmin/unBind";
		}
		else
			return "/merchant/phoneAdmin/mine";
	}
	
	@RequestMapping(value="/goBindWX")
	public String goBindWX() {
		
		return "/merchant/phoneAdmin/bindWX";
	}
	
	@RequestMapping(value="/goCQCodePhLogin")
	public String goCQCodePhLogin() {
		
		return "/merchant/phoneAdmin/cqCodePhLogin";
	}
	
	@RequestMapping(value="/goCQCodePhRegister")
	public String goCQCodePhRegister() {
		
		return "/merchant/phoneAdmin/cqCodePhRegister";
	}
	
	@RequestMapping(value="/goWxScanLogin")
	public String goWxScanLogin() {
		
		return "/merchant/phoneAdmin/wxScanLogin";
	}
	
	@RequestMapping(value="/goRemoveBind")
	public String goRemoveBind(HttpServletRequest request) {
		
		String accountId = request.getParameter("accountId");
		AccountMsg user = publicService.getAccountById(accountId);
		request.setAttribute("user", user);
		return "/merchant/phoneAdmin/removeBind";
	}
	
	@RequestMapping(value="/goShowTextHtml",method=RequestMethod.GET)
	public String goShowTextHtml(String textType, String uuid, String accountId, HttpServletRequest request) {
		
		String url=null;
		HtmlGoodsText htmlGoodsText=publicService.getHtmlGoodsText(textType,uuid,accountId);
		request.setAttribute("htmlGoodsText", htmlGoodsText);
		if((HtmlGoodsText.TEXT+"").equals(textType))
			url = "/merchant/text/showTextHtml";
	    return  url;
	}
	
	public Map<String, Object> checkAdminAccount(String fromUrl, HttpServletRequest request) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		Object userObj = session.getAttribute("user");
		//System.out.println("userObj==="+userObj);
		String uuid=request.getParameter("uuid");
		if(userObj==null) {
			String code = request.getParameter("code");
			Object openIdObj = session.getAttribute("openId");
			//Object openIdObj = "oNFEuwzkbP4OTTjBucFgBTWE5Bqg";
			String openId = null;
			String fromWebSite = request.getParameter("fromWebSite");
			if(openIdObj==null&&StringUtils.isEmpty(code)) {
				jsonMap.put("status", "noCode");
				jsonMap.put("getCodeUrl", "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&redirect_uri=http://www.qrcodesy.com/getCode.asp?params=checkPhoneAdmin,"+fromUrl+","+fromWebSite+","+uuid+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect");
			}
			else {
				if(openIdObj!=null&&StringUtils.isEmpty(code)) {
					openId = openIdObj.toString();
				}
				else {
					JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&secret="+com.goodsPublic.util.StringUtils.APP_SECRET+"&code="+code+"&grant_type=authorization_code"));
					openId = obj.getString("openid");
					System.out.println("openId======"+openId);
					session.setAttribute("openId", openId);
					//openId = "oNFEuwzkbP4OTTjBucFgBTWE5Bqg";
				}
				int exist=publicService.checkAccountOpenIdExist(openId);
				if(exist==0) {
					if("cqCodePh".equals(fromWebSite)) {
						AccountMsg msg = new AccountMsg();
						msg.setUserName(openId);
						userService.saveUser(msg);
						
						AccountMsg user = userService.checkUser(msg);
						session.setAttribute("user", user);
						
						jsonMap.put("status", "ok");
					}
					else if("admin".equals(fromWebSite)) {
						jsonMap.put("status", "unBind");
						jsonMap.put("message", "该微信号未绑定辰麒账号，请先进后台绑定微信！");
					}
				}
				else if(exist==2) {
					AccountMsg msg = new AccountMsg();
					msg.setUserName(openId);

					AccountMsg user = userService.checkUser(msg);
					session.setAttribute("user", user);
					
					jsonMap.put("status", "ok");
				}
				else {
					AccountMsg user=publicService.getAccountByOpenId(openId);
					session.setAttribute("user", user);
					
					publicService.updateLVRLoginByUuid(openId,uuid);//更新微信号的登录记录
					
					jsonMap.put("status", "ok");
				}
			}
		}
		else {
			AccountMsg user=(AccountMsg)userObj;
			String openId = user.getOpenId();
			if(!StringUtils.isEmpty(openId))//这种情况是虽然用户登录了，但只是手机端账号登录的，openId未绑定电脑端账号，openId必须与用户绑定才允许电脑端同步登录
				publicService.updateLVRLoginByUuid(openId,uuid);
			jsonMap.put("status", "ok");
		}
		
		/*
		Object userObj = session.getAttribute("user");
		if(userObj==null) {
			if(StringUtils.isEmpty(code)) {
				jsonMap.put("status", "noCode");
				jsonMap.put("getCodeUrl", "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&redirect_uri=http://www.qrcodesy.com/getCode.asp?params=checkPhoneAdmin,"+fromUrl+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect");
			}
			else {
				JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&secret="+com.goodsPublic.util.StringUtils.APP_SECRET+"&code="+code+"&grant_type=authorization_code"));
				String openId = obj.getString("openid");
				System.out.println("openId======"+openId);
				boolean bool=publicService.checkAccountOpenIdExist(openId);
				if(!bool) {
					jsonMap.put("status", "unBind");
					jsonMap.put("message", "该微信号未绑定辰麒账号，请先进后台绑定微信！");
				}
				else {
					AccountMsg user=publicService.getAccountByOpenId(openId);
					session.setAttribute("user", user);
					
					jsonMap.put("status", "ok");
				}
			}
		}
		else {
			jsonMap.put("status", "ok");
		}
		*/
		return jsonMap;
	}

	@RequestMapping(value="/bindWX")
	public String bindWX(HttpServletRequest request) {

		String url=null;
		String code = request.getParameter("code");
		String accountId = request.getParameter("accountId");
		if(StringUtils.isEmpty(code)) {
			url="redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&redirect_uri=http://www.qrcodesy.com/getCode.asp?params=bindWX,"+accountId+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		}
		else {
			JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&secret="+com.goodsPublic.util.StringUtils.APP_SECRET+"&code="+code+"&grant_type=authorization_code"));
			String openId = obj.getString("openid");
			System.out.println("openId======"+openId);
			int exist=publicService.checkAccountOpenIdExist(openId);
			if(exist==1) {
				request.setAttribute("status", "no");
				request.setAttribute("message", "你的微信号已绑定其他辰麒账号");
			}
			if(exist==2) {
				publicService.syncUserNameOpenIdById(openId,accountId);

				request.setAttribute("status", "ok");
				request.setAttribute("message", "你已成功绑定辰麒账号");
			}
			else {//exist=0
				publicService.updateAccountOpenIdById(openId,accountId);
				
				request.setAttribute("status", "ok");
				request.setAttribute("message", "你已成功绑定辰麒账号");
			}
			url="/merchant/phoneAdmin/bindStatus";
		}
		return url;
	}
	
	@RequestMapping(value="/unBindAccountWX")
	@ResponseBody
	public Map<String, Object> unBindAccountWX(String accountId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=publicService.updateAccountOpenIdById(null,accountId);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "解除绑定成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "解除绑定失败！");
		}
		return jsonMap;
	}

	@RequestMapping(value="/selectAdminQrcodeList")
	@ResponseBody
	public Map<String, Object> selectAdminQrcodeList(String searchTxt, String accountId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> qrcodeList=publicService.selectAdminQrcodeList(searchTxt,accountId);
		
		if(qrcodeList.size()>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("list", qrcodeList);
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "暂无数据");
		}
		return jsonMap;
	}

	@RequestMapping(value="/goShortMsgQrcode")
	public String goShortMsgQrcode(ShortMsgQrcode smq, HttpServletRequest request) {
		String path = "D:/resource/GoodsPublic/ShortMsgQrcode";
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		//String url = "http://www.qrcodesy.com/tyalHtml/redWine.html";
		//smq.setUrl(url);
		String fileName = uuid + ".jpg";
		String avaPath="/GoodsPublic/upload/ShortMsgQrcode/"+fileName;
        Qrcode.createQrCode(smq.getUrl(), path, fileName);
		smq.setUuid(uuid);
		smq.setQrcode(avaPath);
		int count=publicService.addShortMsgQrcode(smq);
		if(count>0) {
			ShortMsgQrcode smq1=publicService.getShortMsgQrcodeByUuid(uuid);
			request.setAttribute("status", "ok");
			request.setAttribute("qrcode", smq1.getQrcode());
		}
		return "/merchant/shortMsgQrcode";
	}

	@RequestMapping(value="/goShortMsgQrcodeInfo")
	public String goShortMsgQrcodeInfo(HttpServletRequest request) {
		publicService.deleteLimitedShortMsgQrcode();
		
		String uuid=request.getParameter("uuid");
		ShortMsgQrcode smq=publicService.getShortMsgQrcodeByUuid(uuid);
		if(smq==null) {
			request.setAttribute("status", "no");
			request.setAttribute("message", "此码已过期，若想长期有效，请联系客服15712773653（微信同号）");
			return "/merchant/shortMsgQrcode";
		}
		else
			return "redirect:"+smq.getUrl();
	}
}
