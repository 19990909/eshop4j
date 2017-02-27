package com.linkwee.tc.fee.service;

import java.util.Date;

import com.linkwee.web.service.InvestRecordAware;
/**
 * 佣金计算服务
 * 
 * @author ch
 *
 */
public interface FeeCalcService extends InvestRecordAware{
	
	 void everyDayFeeCalc(Date investTime)throws Exception;
}
