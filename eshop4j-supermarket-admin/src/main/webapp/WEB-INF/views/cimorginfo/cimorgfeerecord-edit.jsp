<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
	.span-hint{
		padding-top: 10px;
		display: inline-block;
		color: blue;
		font-size: 10px;
	}
	.span-unit{
		padding-top: 10px;
		display: inline-block;
		font-size: 10px;
	}

</style>
<!-- cpa/cps 收费类型 复选框状态 -->
<input type="hidden" id="cpaFeeTypeCode" value="${cpaFeeTypeCode}" />
<input type="hidden" id="cpsFeeTypeCode" value="${cpsFeeTypeCode}" />
<!-- cpa/cps 收费类型类别 单选框状态 -->
<input type="hidden" id="cpaFeeTypeAttr" value="${cpaFeeAttr}" />
<input type="hidden" id="cpsFeeTypeAttr" value="${cpsFeeAttr}" />
<div class="container">
	<form id="orgFeeForm" action="/rest/cim/cimorginfo/updateOrgFee" method="post">
		<input type="hidden" name="orgNumber" value="${orgNumber}" /><!-- 机构编码 -->
		<!-- 收费模式记录主键id -->
		<c:if test="${cpaFeeAttr eq 'fixed' or cpaFeeAttr eq 'propertion'}">
			<input type="hidden" name="id" value="${feeRecordId}" />
		</c:if>
		<div class="row">
				<div class="page-header">
					<span  style="color: blue;font-size: 15px;">该机构旗下的所有产品都按以下方式对机构进行收费、对理财师进行结佣。CPA + CPS模式同时选中时按CPS模式计算佣金。</span>
				</div>
	                  
				<div class="row">
					<div class="col-md-12 page-header">
		                      <div class="form-group">
		                          <label class="col-md-9"><strong>CPA &nbsp;(按投资人数量进行收费)</strong></label>
		                      </div>
		             </div>
	   		    </div> 
	   		    
	   		    <div class="row">
					<div class="col-md-12">
						<div class="form-group">
							  <label class="col-md-2"></label>
		                      <div class="col-md-9 page-header checkbox">
		                      		<label>
		                          		<input type="checkbox" id="cpacbo" name="cpaFeeType" value="cpa" /><strong>CPA收费方式</strong>
		                          	</label>
		                      </div>
		                  </div>
		             </div>
				</div>
				
				
		         <div class="row" id="cpaMenu" name="cpaMenu" style="display: none;">
						<div class="col-md-12">
		                      <label class="col-md-2"></label>
		                          <div class="col-md-10">
		                          		<div class="row">
												<label class="col-md-3 form-group radio">
												   <input type="radio" name="cpaFeeAttr" id="fixed" value="fixed" />每个新投资人固定费用：
												</label>
												<div id="fixedContent" style="display: none;">
													<span  class="span-unit">元</span>
													<div class="form-group col-md-2" style="margin-left: -60px">
													  	<input type="text" class="form-control" name="fixedMoney" value="<fmt:formatNumber value="${cpaFeeVal}" pattern="#" />" autocomplete="off"  />
													</div>
												</div>
										</div>
										
										<div class="row">
												 <label class="col-md-4 form-group radio">
												   <input type="radio" name="cpaFeeAttr" id="propertion" value="propertion" />根据首投金额的比例进行收费：
												</label>
												<div id="propertionContent" style="display: none;">
													<span  class="span-unit">%</span>
													<div class="form-group col-md-2" style="margin-left: -100px">
													  	<input type="text" class="form-control" name="fixedMoneyRatio" value="<fmt:formatNumber value="${cpaFeeRatio}" pattern="#.00" minFractionDigits="0" />" autocomplete="off"  />
													</div>
												</div>
										</div>
										
										<div class="row">
												<label class="col-md-3 form-group radio">
												  <input type="radio" name="cpaFeeAttr" id="float_fixed" value="float_fixed">
												  	按首投金额，填写以下表格：
												</label>
										</div>
										<div class="row" id="firstInvestTab"  style="display: none;">
											<div class="col-md-9">
												<table class="table table-bordered table-hover" id="firstInvestTable">
												 <span style="color:red;">*请输入合法的首投金额区间,否则会导致收费计算异常。</span>
												  <thead>
												    <tr class="success">
												      <th class="text-center">输入首投金额区间&nbsp(元)</th>
												      <th class="text-center">输入收费金额&nbsp(元)</th>
												      <th class="text-center">操作</th>
												    </tr>
												  </thead>
												  <tbody>
												  	<!-- 判断是否为 cpa按首投金额区间收费 -->
												  	<c:forEach var="feeRecord" items="${orgFeeList}" varStatus="idx">
												  		<c:if test="${feeRecord.feeAttr eq 'float_fixed'}">
														    <tr id="feeRecords-${idx.count}">
													  		  <input type="hidden" name="orgFeeRecords_feeRecords${idx.count}.feeRecordId" value="${feeRecord.feeRecordId}"/><!-- 收费模式记录主键id -->
														      <td class="col-md-8">
															      <div class="form-group col-md-4" style="margin: 10px 0px 0px 50px;">
															      		<!-- maxFractionDigits="0"(不保留小数) pattern="#.00"(保留两位小数) pattern="#"(去掉数字1,000默认的逗号","分隔符 )-->
																      <input type="text" class="form-control text-center" min="1" digits="true" name="orgFeeRecords_feeRecords${idx.count}.intervalMinVal" value="<fmt:formatNumber value="${feeRecord.intervalMinVal}" maxFractionDigits="0" pattern="#" />" autocomplete="off" required="required"/>
																  </div>
																  <div class="col-md-1" style="margin-top: 18px;">
																   &#126;
																  </div>
																  <div class="form-group col-md-4" style="margin-top: 10px;">
																      <input type="text" class="form-control text-center" min="1" digits="true" name="orgFeeRecords_feeRecords${idx.count}.intervalMaxVal" value="<fmt:formatNumber value="${feeRecord.intervalMaxVal}" maxFractionDigits="0" pattern="#" />" autocomplete="off" />
																  </div>
														      </td>
														      <td>
														      		<div class="form-group" style="margin-top: 10px;">
																      <input type="text" class="form-control text-center" min="0" number="true" name="orgFeeRecords_feeRecords${idx.count}.feeVal" value="<fmt:formatNumber value="${feeRecord.feeVal}" pattern="#.00" minFractionDigits="0" />" autocomplete="off"  required="required"/>
																    </div>
																    
														      </td>
														      <td>
														      		<div style="margin-top: 10px;">
											                          <button type="button" class="btn btn-default btn-danger" onclick="deleteFirstInvestRow(this);" data-feerowid="feeRecords-${idx.count}" data-feeid="${feeRecord.feeRecordId}"><i class="fa fa-trash-o"></i> 删除</button>
											                        </div>
														      </td>
														    </tr>
													    </c:if>
												    </c:forEach>
												  </tbody>
												</table>
											</div>
											
											
											<div class="row" id="addFirstInvest">
												<div class="col-md-12">
									                      <div class="form-group">
									                          <label class="col-md-4"></label>
									                          <div class="col-md-8">
									                               <button type="button" class="btn btn-default" onclick="addFirstInvestRow(this);"><i class="fa fa-plus"></i> 新增</button>
									                          </div>
									                      </div>
									             </div>
									  		 </div> 
									  		 
										</div>
										
										
		                          </div>
			             </div>
			             
			             
			    <div class="row">
					<div class="col-md-12">
							  <label class="col-md-1"></label>
		                      <div class="col-md-9 page-header">
		                          		<strong>限投条件设置<span style="color: red;">(注意：CPA和CPS同时被选中时则可以不设置...)</span></strong>
		                      </div>
		             </div>
	   		    </div> 
	   		    
	   		    <div class="row" >
	   		    	<div class="col-md-12">
	                      <label class="col-md-2"></label>
	                      <div class="col-md-10">
	                      	 <div class="row" >
								 	<label class="col-md-2" style="margin-top: 8px;">限投金额：</label>
								 	<span  class="span-hint">超过该金额，给理财师结算时按该金额计算</span>
									<div class="form-group col-md-2" style="margin-left: -60px">
									  <input type="text" class="form-control" name="orgAmountLimit" autocomplete="off"  value="<fmt:formatNumber value="${orgFeeInfo.orgAmountLimit}" maxFractionDigits="0" pattern="#" />" />
									</div>
									<div class="form-group col-md-1" style="margin: 10px 0px 0px -15px">元</div>
							 </div>
							 
							 <div class="row" >
								 	<label class="col-md-2" style="margin-top: 8px;">限投期限：</label>
								 	<span  class="span-hint">超过该期限，给理财师结算时按该期限计算</span>
									<div class="form-group col-md-2" style="margin-left: -60px">
									  <input type="text" class="form-control" name="orgInvestdeadlineLimit" autocomplete="off" value="<fmt:formatNumber value="${orgFeeInfo.orgInvestdeadlineLimit}" maxFractionDigits="0" pattern="#" />" />
									</div>
									<div class="form-group col-md-1" style="margin: 10px 0px 0px -15px">天</div>
									
							 </div>
						 </div>
					</div>
				</div>
			             
			             
	   		</div> 
	   		    
	   		    
	   		     
				
				<div class="row" style="margin-top: 80px;">
					<div class="col-md-12 page-header">
		                      <div class="form-group">
		                          <label class="col-md-9"><strong>CPS &nbsp;(根据年化投资金额，按比例进行收费)</strong></label>
		                      </div>
		             </div>
	   		    </div> 
	   		    
	   		    <div class="row">
					<div class="col-md-12">
						<div class="form-group">
							  <label class="col-md-2"></label>
		                      <div class="col-md-9 page-header checkbox">
		                      		<label>
		                          		<input type="checkbox" id="cpscbo" name="cpsFeeType" value="cps"/><strong>CPS收费方式</strong>
		                          	</label>
		                      </div>
		                  </div>
		             </div>
				</div>
				
				
		         <div class="row" id="cpsMenu" name="cpsMenu" style="display: none;">
						<div class="col-md-12">
		                      <label class="col-md-2"></label>
		                          <div class="col-md-10">
										
										<div class="row">
												<label class="col-md-3 radio">
												  <input type="radio" name="cpsFeeAttr" id="year_propertion" value="year_propertion">
												  	按产品期限，填写以下表格：
												</label>
										</div>
										
										<div class="row" id="productDeadlineTab" style="display: none;">
											<div class="col-md-9">
												<table class="table table-bordered table-hover" id="productDeadlineTable">
												<span style="color:red;">*请输入合法的产品期限区间,否则会导致收费计算异常。</span>
												  <thead>
												    <tr class="success">
												      <th class="text-center">输入产品期限区间&nbsp(天)</th>
												      <th class="text-center">输入收费比例&nbsp(%)</th>
												      <th class="text-center">操作</th>
												    </tr>
												  </thead>
												  <tbody>
												  	<!-- 判断是否为 cps按产品期限区间收费 -->
												  	<c:forEach var="feeRecord" items="${orgFeeList}" varStatus="idx">
												  		<c:if test="${feeRecord.feeAttr eq 'year_propertion'}">
												  			<tr id="feeRecords-100${idx.count}">
												  				<input type="hidden" name="orgFeeRecords_feeRecords100${idx.count}.feeRecordId" value="${feeRecord.feeRecordId}"/><!-- 收费模式记录主键id -->
															    <td class="col-md-8">
																      <div class="form-group col-md-4" style="margin: 10px 0px 0px 50px;">
																	      <input type="text" class="form-control text-center" min="1" digits="true" required="required" name="orgFeeRecords_feeRecords100${idx.count}.intervalMinVal" value="<fmt:formatNumber value="${feeRecord.intervalMinVal}" maxFractionDigits="0" pattern="#" />" autocomplete="off"  />
																	  </div>
																	  <div class="col-md-1" style="margin-top: 18px;">
																	   &#126;
																	  </div>
																	  <div class="form-group col-md-4" style="margin-top: 10px;">
																	      <input type="text" class="form-control text-center" min="1" digits="true" name="orgFeeRecords_feeRecords100${idx.count}.intervalMaxVal" value="<fmt:formatNumber value="${feeRecord.intervalMaxVal}" maxFractionDigits="0" pattern="#" />" autocomplete="off"  />
																	  </div>
															      </td>
															      
															      <td>
															      		<div class="form-group" style="margin-top: 10px;">
																	      <input type="text" class="form-control text-center" min="0" number="true" required="required" name="orgFeeRecords_feeRecords100${idx.count}.moneyRatio" value="<fmt:formatNumber value="${feeRecord.feeRatio}" pattern="#.00" minFractionDigits="0" />" autocomplete="off"  />
																	    </div>
																	    
															      </td>
															      <td>
															      		<div style="margin-top: 10px;">
												                          <button type="button" class="btn btn-default btn-danger" onclick="deleteProductDeadlineRow(this);" data-feerowid="feeRecords-100${idx.count}" data-feeid="${feeRecord.feeRecordId}"><i class="fa fa-trash-o"></i> 删除</button>
												                        </div>
															      </td>
														    </tr>
												  		</c:if>
												  	</c:forEach>
												    
												  </tbody>
												</table>
											</div>
											<div class="row" id="addProductDeadline">
												<div class="col-md-12">
									                      <div class="form-group">
									                          <label class="col-md-4"></label>
									                          <div class="col-md-8">
									                               <button type="button" class="btn btn-default" onclick="addProductDeadlineRow(this);"><i class="fa fa-plus"></i> 新增</button>
									                          </div>
									                      </div>
									             </div>
									    	</div>
									    
										</div>
										
										 
										
										<div class="row">
												<label class="col-md-3 radio">
												  <input type="radio" name="cpsFeeAttr" id="month_amount_propertion" value="month_amount_propertion">
												  	按月销售总额，填写以下表格：
												</label>
										</div>
										
										<div class="row" id="monthSaleTotalTab" style="display: none;">
											<div class="col-md-9">
												<table class="table table-bordered table-hover" id="monthSaleTotalTable">
												<span style="color:red;">*请输入合法的月销售总额区间,否则会导致收费计算异常。</span>
												  <thead>
												    <tr class="success">
												      <th class="text-center">输入月销售总额区间&nbsp(元)</th>
												      <th class="text-center">输入收费比例&nbsp(%)</th>
												      <th class="text-center">操作</th>
												    </tr>
												  </thead>
												  <tbody>
												  <!-- 判断是否为 cps按月销售总额区间收费 -->
												  	<c:forEach var="feeRecord" items="${orgFeeList}" varStatus="idx">
												  		<c:if test="${feeRecord.feeAttr eq 'month_amount_propertion'}">
													  		<tr id="feeRecords-200${idx.count}">
													  			<input type="hidden" name="orgFeeRecords_feeRecords200${idx.count}.feeRecordId" value="${feeRecord.feeRecordId}"/><!-- 收费模式记录主键id -->
															      <td class="col-md-8">
																      <div class="form-group col-md-4" style="margin: 10px 0px 0px 50px;">
																	      <input type="text" class="form-control text-center" min="1" digits="true" required="required" name="orgFeeRecords_feeRecords200${idx.count}.intervalMinVal" value="<fmt:formatNumber value="${feeRecord.intervalMinVal}" maxFractionDigits="0" pattern="#" />" autocomplete="off" />
																	  </div>
																	  <div class="col-md-1" style="margin-top: 18px;">
																	   &#126;
																	  </div>
																	  <div class="form-group col-md-4" style="margin-top: 10px;">
																	      <input type="text" class="form-control text-center" min="1" digits="true" name="orgFeeRecords_feeRecords200${idx.count}.intervalMaxVal" <c:if test="${not empty feeRecord.intervalMaxVal}">value="<fmt:formatNumber value="${feeRecord.intervalMaxVal}" maxFractionDigits="0" pattern="#" />"</c:if> autocomplete="off"  />
																	  </div>
															      </td>
															      <td>
															      		<div class="form-group" style="margin-top: 10px;">
																	      <input type="text" class="form-control text-center" min="0" number="true" required="required" name="orgFeeRecords_feeRecords200${idx.count}.moneyRatio" value="<fmt:formatNumber value="${feeRecord.feeRatio}" pattern="#.00" minFractionDigits="0" />" autocomplete="off"  />
																	    </div>
															      </td>
															      <td>
																	    <div style="margin-top: 10px;">
												                          <button type="button" class="btn btn-default btn-danger" onclick="deleteMonthSaleTotalRow(this);" data-feerowid="feeRecords-200${idx.count}" data-feeid="${feeRecord.feeRecordId}"><i class="fa fa-trash-o"></i> 删除</button>
												                        </div>
															      </td>
															    </tr>
												  		</c:if>
												  	</c:forEach>
												  </tbody>
												</table>
											</div>
											
											<div class="row" id="addMonthSaleTotal">
												<div class="col-md-12">
									                      <div class="form-group">
									                          <label class="col-md-4"></label>
									                          <div class="col-md-8">
									                               <button type="button" class="btn btn-default" onclick="addMonthSaleTotalRow(this);"><i class="fa fa-plus"></i> 新增</button>
									                          </div>
									                      </div>
									             </div>
									   		</div> 
										</div>
										
		                         </div>
			             </div>
	   		    </div> 
	   		    
	   	</div> 

	   	
	    <div class="row" style="padding-top: 100px;">
				<div class="col-md-12">
	                      <div class="form-group">
	                          <label class="col-md-5"></label>
	                          <div class="col-md-7">
	                               <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> 保存</button>
	                               &nbsp&nbsp&nbsp
	                               <button type="button" class="btn btn-default" onclick='javascript:$.switchPage("合作机构列表","rest/cim/cimorginfo/list");'><i class="fa fa-arrow-left"></i> 返回</button>
	                          </div>
	                      </div>
	             </div>
	    </div>                   	
	
	</form>	
	
</div>

<script type="text/javascript" src="app/cimorginfo/formdata-convert-tojson.js"></script>
<script type="text/javascript" src="app/cimorginfo/cimorgfeerecord-edit.js"></script>