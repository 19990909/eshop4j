package com.linkwee.web.response;

import java.io.Serializable;
import java.util.List;

import com.linkwee.web.model.CimProductEdit;
import com.linkwee.web.model.InRecordLogEntry;

public class CimProductEditResponse extends CimProductEdit implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3843635756156019083L;
	/**
	 * 机构名称
	 */
	private String orgName;
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
}