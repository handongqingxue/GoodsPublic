package goodsPublic.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodsPublic.util.FileUploadUtils;
import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.MethodUtil;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.HtmlGoodsGRMP;
import goodsPublic.entity.HtmlGoodsText;
import goodsPublic.service.CategoryService;
import goodsPublic.service.PublicService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/chenQi")
public class ChenQiController {
	
	@Autowired
	private PublicService publicService;
	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value="/autoLogin")
	@ResponseBody
	public void autoLogin(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			String userName=request.getParameter("userName");
			String password=request.getParameter("password");
			HttpSession session=request.getSession();
			String jsonpCallback = null;
			try {
				UsernamePasswordToken token = new UsernamePasswordToken(userName,password);  
				Subject currentUser = SecurityUtils.getSubject();  
				if (!currentUser.isAuthenticated()){
					//使用shiro来验证  
					token.setRememberMe(true);  
					currentUser.login(token);//验证角色和权限  
				}
			}catch (Exception e) {
				e.printStackTrace();
			    jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"1\\\",\\\"msg\\\":\\\"登陆失败\\\"}\")";
			}
			AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
			List<CategoryInfo> catList = categoryService.getCategory(msg.getId());
			session.setAttribute("categoryList", catList);
			session.setAttribute("user", msg);

			jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"0\\\",\\\"msg\\\":\\\"验证通过\\\",\\\"url\\\":\\\"/merchant/main/goAccountInfo\\\"}\")";
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/createQrcodeByCQSCQ")
	@ResponseBody
	public void createQrcodeByCQSCQ(HtmlGoodsText htmlGoodsText, HttpServletResponse response) {

		String accountNumber = htmlGoodsText.getAccountNumber();
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/GoodsPublic/upload/ChenQiQrcode/"+fileName;
		String path = "D:/resource/GoodsPublic/ChenQiQrcode/";
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		String url=null;
		switch (htmlGoodsText.getTextType()) {
		case HtmlGoodsText.TEXT:
			url="http://www.qrcodesy.com:8080/GoodsPublic/merchant/phone/goShowTextHtml?textType="+htmlGoodsText.getTextType()+"&uuid="+uuid+"&accountId="+accountNumber;
			break;
		case HtmlGoodsText.URL:
			url=htmlGoodsText.getText();
			break;
		}
        Qrcode.createQrCode(url, path, fileName);
        
		htmlGoodsText.setUuid(uuid);
		htmlGoodsText.setQrcode(avaPath);
		int a=publicService.addHtmlGoodsText(htmlGoodsText);
		
        String jsonpCallback="jsonpCallback(\"{\\\"qrcode\\\":\\\""+avaPath+"\\\"}\")";
        try {
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 验证后台是否已登录
	 * @param response
	 */
	@RequestMapping(value="/checkBgIfLogin")
	@ResponseBody
	public void checkBgIfLogin(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			Object userObj = session.getAttribute("user");
			String jsonpCallback=null;
			if(userObj==null)
				jsonpCallback="jsonpCallback(\"{\\\"ifLogin\\\":\\\"no\\\"}\")";
			else {
				AccountMsg user = (AccountMsg)userObj;
				jsonpCallback="jsonpCallback(\"{\\\"ifLogin\\\":\\\"ok\\\",\\\"userName\\\":\\\""+user.getUserName()+"\\\",\\\"passWord\\\":\\\""+user.getPassWord()+"\\\"}\")";
			}
			response.getWriter().print(jsonpCallback);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/addHtmlGoodsGRMP",produces="plain/text; charset=UTF-8")
	public void addHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP, @RequestParam(value="avatorImg",required=false) MultipartFile avatorImg, 
			HttpServletRequest request, HttpServletResponse response) {

        try {
			if(avatorImg.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,avatorImg,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					htmlGoodsGRMP.setAvatorUrl(dataJO.get("src").toString());
				}
			}

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String userNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			String locationHref = request.getParameter("locationHref");
			String serverName = null;
			if(locationHref.indexOf("www.qrcodesy.com")!=-1)
				serverName="http://www.qrcodesy.com/";
			else
				serverName="http://cqcode.qdhualing.com/";
			String url = serverName+"qrcodeCreate/showVCard.html?uuid="+uuid;
			String fileName = userNumber + ".jpg";
			String avaPath="/GoodsPublic/upload/ChenQiQrcode/"+fileName;
			String path = "D:/resource/GoodsPublic/ChenQiQrcode/";
			Qrcode.createQrCode(url, path, fileName);
			
			htmlGoodsGRMP.setUuid(uuid);
			htmlGoodsGRMP.setQrcode(avaPath);
			int a=publicService.addHtmlGoodsGRMP(htmlGoodsGRMP);
			
	        //String jsonpCallback="jsonpCallback(\"{\\\"qrcode\\\":\\\"1111111111\\\"}\")";
			//response.getWriter().print(jsonpCallback);
			response.sendRedirect(serverName+"qrcodeCreate/vcard.html?type=1&uuid="+uuid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/editHtmlGoodsGRMP",produces="plain/text; charset=UTF-8")
	public void editHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP, @RequestParam(value="avatorImg",required=false) MultipartFile avatorImg, 
			HttpServletRequest request, HttpServletResponse response) {
        try {
			if(avatorImg.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,avatorImg,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					htmlGoodsGRMP.setAvatorUrl(dataJO.get("src").toString());
				}
			}
			int a=publicService.editHtmlGoodsGRMP(htmlGoodsGRMP);
			String locationHref = request.getParameter("locationHref");
			String serverName = null;
			if(locationHref.indexOf("www.qrcodesy.com")!=-1)
				serverName="http://www.qrcodesy.com/";
			else
				serverName="http://cqcode.qdhualing.com/";
			response.sendRedirect(serverName+"qrcodeCreate/vcard.html?type=1&uuid="+htmlGoodsGRMP.getUuid());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/getHtmlGoodsGRMP")
	@ResponseBody
	public void getHtmlGoodsGRMP(String uuid, HttpServletResponse response) {
		
		HtmlGoodsGRMP htmlGoodsGRMP = publicService.getHtmlGoodsGRMP(uuid);
		
		String grmpStr=JSONObject.fromObject(htmlGoodsGRMP).toString().replaceAll("\"", "\\\\\"");
		String jsonpCallback="jsonpCallback(\"{\\\"htmlGoodsGRMP\\\":"+grmpStr+"}\")";
        try {
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
