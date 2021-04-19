package com.goodsPublic.util.alipay;

import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String APP_ID = "2019072265971163";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String MERCHANT_PRIVATE_KEY = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCZRbsoxY4IQ1veTFX5Z+sdhlBT9lRMk8aFuQfS1Z3dejkiPFbTlssli/ZQi4lUnpwPQBCvxgbmkkHtBg19/l74AZu2M5x/m/69cg/p8ltVPCBITFnJfYByrKPoAts2JFLmLOvi/Xebc6MsZkXxfC1QhrsnpBKv5rTRa/383zyPj0Vzie0zyOWyXNO/BJDlOA1R8MSycljQF7VRR77QbU3ryQALylfZoaP3RcfFDGmW148aJdWTfzgO8vZ0/bfVIItRPj2M//S9HIe7KuM34sZ0KlzBkJGVZCsJSmN3jcZXBI6UCRr9dh+oEXTNA9UlVI4WZeccVajGyEWR0ZrA5c67AgMBAAECggEBAImuuQRUClVj5MeY/PYQooSgHdJ+iZVMfd2rq9p5p9jHLUGSwFBLuerdgoMyBUgtPnT4kMTE93fx1CTN9hrDAJ56G10dmayL/dZB+welfOPhIgKwC0vTYCoi6Q3GWxKUqJ85pR//nozW4LJGoPffG3mlvcNLQLogXTducfbQtb8ih9XQv+lwaUhRejet1HJS47hctD1mHRo72aO7qKGoHycl63Jb0iQo4MD2pkGmyENFBpOcQEX9+SUrTni6QvaceMZiTw7sf1yg0Zy4eXcj/vrkon9Y0RlHRREtf2y/MLc14edajnBYl82dRH8nO3dtkZRjl1pDH0l7EYIuBQ6IEvECgYEA2TKr6Iykv92xI4kSvcvXJGuZRDnIMH0iVkBhxY2SWNpfaYLyZVU46zhJKkwqWtkcMjGjGE4zgEWlcflExrd9j1Q8dATokap/zxrA8NAVwbWzJfYPtTCUxdsqcQIx8lDpBAW3EJEtVeWI0w6cDLqtywLalOu9rtamuhUXIulMM2MCgYEAtKd9NXs0/Z34110lZI9RHaiuxf+5EPm6R78ylXQGVrL8ErM8XoQ0YRcAuTbZ3YrGZ4diMP76x2Na1YsZj/Qh/TBqGwjLql2cHZ9QNRY/S90yuT7R0tKFXXJVL/m4QN1mFSMQHTjQwY7IMpO+WHh1LRe9Ycr3pSPLPYxS+jUhkskCgYBPxxTtrfs1njBaZRbFMAIuFneNX8vwQ4ZBOBSxg3alvFAfaUGvhsYJX/s/1goYpHZ+2UyWuOKh0vMaEfz5IJy18LLjyonCN2YKpEEKMuRK6nqLDv5mBxoeMoo8SBogbyenmpHLPAfy7QR8wXkAE/GSB9JRsOVTOvSylNySri6XEQKBgEAqlZCfeIz0xWRJk3SKazdrqNhvIl7jNMUzJlZrZaz52gsSWsj/kFNEBl/DGdNU7W/saHYauxyDL8pVo/i7sC7sOWPs1dpncYIcCjMw+b6KjO+7Xm/RkslESPnHayiu+wla8OhQO+XkPzunup5V+tjPa9cGbrvbYN81rmts38XxAoGAE/0w8Tc37CODVo+Z7lheFwPmjQtMPEW594eP6QNKHobHCat+4ddg6qRCU496z4oYjQxnLwmrl6zmnwzcLbBLj42GsMJ9bldyUlYOkrzw94LYGvsMdTUgVc8gOhxssknszO3XLStVK3W6zmVYPyyDBqKsmq6XIXP4j9WI23Pvkcg=";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg3R04pFb/esO+7EZ0zzSUAWmk7mm1b7R2886RSSuf+NC4ahhSYsB0bBVaGf6OjEqNhRJrBWenOyy/sXI+JYlq++HAlNrN5s4KLuVHMg8u5/3mbWFih2TY6xs1s88Mupvv8hQjJKrMRwscob26150YH95DCyYyQk3dKY3mRaebctrimcYDwkUPUNDK13oEjcWXQ64Y7Qqu4X7NxutU8uE/5DUO4i8afu4IeVLkPHA4bfb/ovvM1SW54c7RAQZhwMa+wC9SLh6+qKMHRenqQs+mOWmxJreNmxy9nkc59Uq/aeV6jY0nuG8qPnSpVe5C5L0VPXVhQCRnB0FrO+UtpdKYQIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	//public static String NOTIFY_URL = "http://工程公网访问地址/alipay.trade.page.pay-JAVA-UTF-8/notify_url.jsp";
	public static String NOTIFY_URL = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/kaiTongByAlipay";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	//public static String RETURN_URL = "http://工程公网访问地址/alipay.trade.page.pay-JAVA-UTF-8/return_url.jsp";
	public static String RETURN_URL = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/login";

	// 签名方式
	//public static String SIGN_TYPE = "SHA256";
	public static String SIGN_TYPE = "RSA2";
	
	// 字符编码格式
	public static String CHARSET = "utf-8";
	
	public static String FORMAT="json";
	
	// 支付宝网关
	//public static String GATEWAY_URL = "https://openapi.alipaydev.com/gateway.do";
	public static String GATEWAY_URL = "https://openapi.alipay.com/gateway.do";
	
	// 支付宝网关
	//public static String LOG_PATH = "C:\\";
	public static String LOG_PATH = "/log";
	
	public static String CERT_PATH="D:/resource/GoodsPublic/appCertPublicKey_2019072265971163.crt";
	public static String ALIPAY_PUBLIC_CERT_PATH="D:/resource/GoodsPublic/alipayCertPublicKey_RSA2.crt";
	public static String ROOT_CERT_PATH="D:/resource/GoodsPublic/alipayRootCert.crt";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(LOG_PATH + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
}

