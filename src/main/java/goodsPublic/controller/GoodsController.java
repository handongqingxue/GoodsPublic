package goodsPublic.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.MethodUtil;
import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AccountPayRecord;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.LoginVisitRecord;
import goodsPublic.service.CategoryService;
import goodsPublic.service.PublicService;
import goodsPublic.service.UserService;
import goodsPublic.service.UtilService;

@Controller
@RequestMapping("/merchant")
public class GoodsController {
	@Autowired
	private UtilService utilService;
	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PublicService publicService;
	private SimpleDateFormat timeSDF=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat loginQrcodeSDF=new SimpleDateFormat("yyyyMMddHHmmss");

	/**
	 * 跳转至登录页面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(HttpServletRequest request) {
		
		try {
			createLoginQrcode(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/merchant/login";
	}
	
	public void createLoginQrcode(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		publicService.deleteLimitedLoginVisitRecord();
		
		Date date = new Date();
		String path = "D:/resource/GoodsPublic/LoginQrcode";
		String uuid=loginQrcodeSDF.format(date)+UUID.randomUUID().toString().replaceAll("-", "");
		String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/phone/goAdminCreateQrcode?fromWebSite=cqCodePh&uuid="+uuid;
		String fileName = uuid+".jpg";
		String avaPath="/GoodsPublic/upload/LoginQrcode/"+fileName;
        Qrcode.createQrCode(url, path, fileName);
        
        LoginVisitRecord lvr=new LoginVisitRecord();
        lvr.setUuid(uuid);
        lvr.setQrcode(avaPath);
        int count=publicService.addLoginVisitRecord(lvr);
        if(count>0) {
        	request.setAttribute("qrcode", avaPath);
        	request.setAttribute("uuid", uuid);
        }
	}
	
	@RequestMapping(value="/synchronizeLogin",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String synchronizeLogin(String uuid) {
		PlanResult plan=publicService.phoneAlreadyLogin(uuid);
		return JsonUtil.getJsonFromObject(plan);
	}

	/**
	 * 登录接口
	 * @param model
	 * @param userName
	 * @param password
	 * @param rememberMe
	 * @param role
	 * @param loginVCode
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String login(Model model,String userName,String password,String from,
			String rememberMe,String loginVCode,HttpServletRequest request) {
		System.out.println("===登录接口===");
		//返回值的json
		PlanResult plan=new PlanResult();
		HttpSession session=request.getSession();
		/*
		String verifyCode = (String) session.getAttribute("验证码");
		System.out.println("verifyCode==="+verifyCode);
		System.out.println("loginVCode==="+loginVCode);
		if(verifyCode.equals(loginVCode)) {
		*/
			//TODO在这附近添加登录储存信息步骤，将用户的账号以及密码储存到shiro框架的管理配置当中方便后续查询
			try {
				//System.out.println("验证码一致");
				UsernamePasswordToken token = new UsernamePasswordToken(userName,password);  
				Subject currentUser = SecurityUtils.getSubject();  
				if (!currentUser.isAuthenticated()){
					//使用shiro来验证  
					token.setRememberMe(true);  
					currentUser.login(token);//验证角色和权限  
				}
			}catch (Exception e) {
				e.printStackTrace();
				plan.setStatus(1);
				plan.setMsg("登陆失败");
				return JsonUtil.getJsonFromObject(plan);
			}
			AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
			List<CategoryInfo> catList = categoryService.getCategory(msg.getId());
			session.setAttribute("categoryList", catList);
			session.setAttribute("user", msg);
			
			plan.setStatus(0);
			plan.setMsg("验证通过");
			switch (from) {
			case "jfdhjp":
				plan.setUrl("/merchant/main/goAddModule?trade=jfdhjp");
				break;
			case "cqCodePh":
				plan.setUrl("/merchant/phone/goAdminCreateQrcode");
				break;
			default:
				plan.setUrl("/merchant/main/goAccountInfo");
				break;
			}
			return JsonUtil.getJsonFromObject(plan);
			/*
		}
		plan.setStatus(1);
		plan.setMsg("验证码错误");
		return JsonUtil.getJsonFromObject(plan);
		*/
	}
	
	/**
	 * 登录接口，供添写完商品信息但未登录时调用，保证之前填写的商品信息不丢失（这个接口本来是辰麒端页面调用，后来辰麒端页面挪到后台里了，就在后台里调用）
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/loginQL",method=RequestMethod.GET,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public void loginQL(HttpServletRequest request,HttpServletResponse response) {
		String jsonpCallback=null;
		AccountMsg msg=null;
		try {
			String userName = request.getParameter("userName");
			String password = request.getParameter("password");
			String action = request.getParameter("action");
			System.out.println("userName==="+userName);
			System.out.println("password==="+password);
			//HttpSession session=request.getSession();
			UsernamePasswordToken token = new UsernamePasswordToken(userName,password);
			Subject currentUser = SecurityUtils.getSubject();  
			if (!currentUser.isAuthenticated()){
				//使用shiro来验证  
				token.setRememberMe(true);  
				currentUser.login(token);//验证角色和权限  
			}
			
			if("addModule".equals(action)) {
				msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
				List<CategoryInfo> catList = categoryService.getCategory(msg.getId());
				HttpSession session=request.getSession();
				session.setAttribute("categoryList", catList);
				session.setAttribute("user", msg);
			}
			
			jsonpCallback="jsonpCallback(\"{\\\"status\\\":0,\\\"msg\\\":\\\"验证通过\\\",\\\"accountNumber\\\":\\\""+msg.getId()+"\\\"}\")";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonpCallback="jsonpCallback(\"{\\\"status\\\":1,\\\"msg\\\":\\\"登陆失败\\\"}\")";
		}
		finally {
			try {
				response.getWriter().print(jsonpCallback);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value="/checkIfLogin",method=RequestMethod.GET,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public void checkIfLogin(HttpSession session,HttpServletResponse response) {
		
		String jsonpCallback=null;
		Object user = session.getAttribute("user");
		if(user==null) {
			jsonpCallback="jsonpCallback(\"{\\\"status\\\":1,\\\"msg\\\":\\\"用户未登陆\\\"}\")";
		}
		else {
			jsonpCallback="jsonpCallback(\"{\\\"status\\\":0,\\\"msg\\\":\\\"用户已登陆\\\"}\")";
		}
		try {
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/saveQLUser",method=RequestMethod.GET,produces="plain/text; charset=UTF-8")
	public String saveQLUser(String userName,String password,HttpServletRequest request) {

		try {
			HttpSession session=request.getSession();
			UsernamePasswordToken token = new UsernamePasswordToken(userName,password);  
			Subject currentUser = SecurityUtils.getSubject();  
			if (!currentUser.isAuthenticated()){
				//使用shiro来验证  
				token.setRememberMe(true);  
				currentUser.login(token);//验证角色和权限  
			}
			AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
			List<CategoryInfo> catList = categoryService.getCategory(msg.getId());
			session.setAttribute("categoryList", catList);
			session.setAttribute("user", msg);
			
		} catch (AuthenticationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/merchant/fee/buy";
	}
	
	/**
	 * 为登录页面获取验证码
	 * @param session
	 * @param identity
	 * @param response
	 */
	@RequestMapping("/login/captcha")
	public void getKaptchaImageByMerchant(HttpSession session, String identity, HttpServletResponse response) {
		utilService.getKaptchaImageByMerchant(session, identity, response);
	}

	//注册页面
	@RequestMapping(value = "/regist" , method = RequestMethod.GET)
	public String regist() {
		System.out.println("===注册页面===");
		return "/merchant/regist";
	}

	//注册信息处理接口
	@RequestMapping(value = "/regist" , method = RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String subRegist(AccountMsg msg, String action, HttpServletRequest request) {
		System.out.println("===注册信息处理接口===");
		System.out.println(msg);
		PlanResult plan=new PlanResult();
		int status=userService.saveUser(msg);
		if(status==2) {
			plan.setStatus(status);
			plan.setMsg("注册失败，用户已存在");
			return JsonUtil.getJsonFromObject(plan);
		}else if(status==0) {
			plan.setStatus(status);
			plan.setMsg("系统错误，请联系维护人员");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(0);
		plan.setMsg("注册成功");
		plan.setData(msg);
		//plan.setUrl("/merchant/login");
		if("buy".equals(action))
			plan.setUrl("/merchant/saveQLUser?price="+request.getParameter("price"));
		else
			plan.setUrl("/merchant/main/goAccountInfo");
		
		//这里是注册完成后添加50个自定义标签
		AccountMsg resultUser=userService.checkUser(msg);
		publicService.initGoodsLabelSet(resultUser.getId());
		
		//这里是注册完成后，自动开通7天免费试用，过期要继续使用就得付费
		AccountPayRecord apr = new AccountPayRecord();
		apr.setAccountNumber(resultUser.getId());
		Date date = new Date();
		apr.setPayTime(timeSDF.format(date));
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, 7);
		apr.setEndTime(timeSDF.format(calendar.getTime()));
		apr.setVipType(AccountPayRecord.FREE_TRIAL);
		apr.setMoney((float)0.00);
		apr.setPhone(resultUser.getPhone());
		publicService.addAccountPayRecord(apr);
		
		saveQLUser(resultUser.getUserName(),resultUser.getPassWord(),request);
		
		return JsonUtil.getJsonFromObject(plan);
	}

	/**
	 * 注册接口，供添写完商品信息但未注册时调用，保证之前填写的商品信息不丢失
	 * @param msg
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/registQL",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String registQL(AccountMsg msg, HttpServletRequest request,HttpServletResponse response) {
		PlanResult plan=new PlanResult();
		int status=userService.saveUser(msg);
		if(status==2) {
			plan.setStatus(status);
			plan.setMsg("注册失败，用户已存在");
			return JsonUtil.getJsonFromObject(plan);
		}else if(status==0) {
			plan.setStatus(status);
			plan.setMsg("系统错误，请联系维护人员");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(0);
		plan.setMsg("注册成功");

		//这里是注册完成后添加50个自定义标签
		AccountMsg resultUser=userService.checkUser(msg);
		publicService.initGoodsLabelSet(resultUser.getId());
		
		//这里是注册完成后，自动开通7天免费试用，过期要继续使用就得付费
		AccountPayRecord apr = new AccountPayRecord();
		apr.setAccountNumber(resultUser.getId());
		Date date = new Date();
		apr.setPayTime(timeSDF.format(date));
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, 7);
		apr.setEndTime(timeSDF.format(calendar.getTime()));
		apr.setVipType(AccountPayRecord.FREE_TRIAL);
		apr.setMoney((float)0.00);
		apr.setPhone(resultUser.getPhone());
		publicService.addAccountPayRecord(apr);
		
		saveQLUser(resultUser.getUserName(),resultUser.getPassWord(),request);
		//plan.setStatus(0);
		//saveQLUser("202103080001","E10ADC3949BA59ABBE56E057F20F883E",request);
		
		HttpSession session = request.getSession();
		AccountMsg user=(AccountMsg)session.getAttribute("user");
		plan.setData(user.getId());
		
		return JsonUtil.getJsonFromObject(plan);
	}
	
	@RequestMapping(value="/exit")
	public String exit(HttpServletRequest request) {
		System.out.println("退出接口");
		Subject currentUser = SecurityUtils.getSubject();       
	    currentUser.logout();    

		try {
			createLoginQrcode(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/merchant/login";
	}
}
