package com.linkwee.api.request.crm;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

/**
 * 
 * @描述：理财师注册
 *
 * @author Bob
 * @时间 2015年7月31日上午10:34:59
 *
 */
public class RegisterRequest {

	/**
	 * 手机号码
	 */
	@NotNull(message = "手机号码不能为空")
	@Pattern(regexp = "^1\\d{10}$", message = "手机号码格式不对")
	private String mobile;

	/**
	 * 密码
	 */
	@NotNull(message = "密码不能为空")
	private String password;
	
	/**
	 * 推荐码
	 */
	private String recommendCode;
	
	/**
	 * 验证码
	 */
	private String vcode;
	
	/**
	 * 来源地址
	 */
	private String fromUrl;
	
	/**
	 * 受访地址
	 */
	private String accessUrl;
	
	/**
	 * 销售机构编码
	 */
	private String saleOrgCode;
	

	public String getRecommendCode() {
		return recommendCode;
	}

	public void setRecommendCode(String recommendCode) {
		this.recommendCode = recommendCode;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getVcode() {
		return vcode;
	}

	public void setVcode(String vcode) {
		this.vcode = vcode;
	}

	@Override
	public String toString() {
		return JSON.toJSONString(this, SerializerFeature.UseISO8601DateFormat);
	}

	public String getFromUrl() {
		return fromUrl;
	}

	public void setFromUrl(String fromUrl) {
		this.fromUrl = fromUrl;
	}

	public String getAccessUrl() {
		return accessUrl;
	}

	public void setAccessUrl(String accessUrl) {
		this.accessUrl = accessUrl;
	}

	public String getSaleOrgCode() {
		return saleOrgCode;
	}

	public void setSaleOrgCode(String saleOrgCode) {
		this.saleOrgCode = saleOrgCode;
	}

}
