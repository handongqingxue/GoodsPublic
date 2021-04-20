package goodsPublic.entity;

import java.io.Serializable;

public class AccountPayRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int FREE_TRIAL=1;
	public static final int JI_CHU=2;
	public static final int GAO_JI=3;
	public static final int HANG_YE=4;
	
	public static final int SHI_YONG_ZHONG=1;
	public static final int JI_JIANG_DAO_QI=2;
	public static final int YI_DAO_QI=3;
	
	private Integer id;
	private String outTradeNo;
	private String accountNumber;
	private String payTime;
	private String endTime;
	private Integer state;//状态 1.使用中 2.即将到期 3.已到期 4.已退款
	private Integer vipType;//会员类型 1.免费版 2.基础版 3.高级版 4.行业版
	private Integer payType;
	private Float money;
	private String phone;
	private Boolean allowRefund;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getPayTime() {
		return payTime;
	}
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getVipType() {
		return vipType;
	}
	public void setVipType(Integer vipType) {
		this.vipType = vipType;
	}
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	public Float getMoney() {
		return money;
	}
	public void setMoney(Float money) {
		this.money = money;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Boolean getAllowRefund() {
		return allowRefund;
	}
	public void setAllowRefund(Boolean allowRefund) {
		this.allowRefund = allowRefund;
	}
}
