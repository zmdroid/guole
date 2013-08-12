package com.guoleMIS.action.producttype;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.advert.AdvertService;
import com.guoleMIS.service.info.InformationService;
import com.guoleMIS.service.producttype.ProductTypeService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.AdvertVO;
import com.guoleMIS.vo.InformationVO;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.MemberInfoVO;
import com.guoleMIS.vo.ProductTypeVO;
import com.opensymphony.xwork2.ActionSupport;

public class ProductTypeAction  extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 7332666825441809737L;
	private static final Logger logger = Logger.getLogger(ProductTypeAction.class);
	
	private Map<String,Object> session;
	
	private ProductTypeService productTypeService;
	
	private ProductTypeVO productTypeVO;
	private String result;
	private Integer productTypeId;
	private Integer pageIndex;
	private Integer state;
	private String seachkey;
	private String ptype;
	
	public void saveUpdateProductType(){
		try {
			boolean rs = productTypeService.saveUpdateProductTypeVO(productTypeVO);
			if(rs){
				ResponseUtil.sendResult("success");
			}else{
				ResponseUtil.sendResult("error");
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("保存或更新产品类型信息出错", e);
			ResponseUtil.sendResult("error");
		}
	}
	/**
	 * 读取所有产品类型
	 */
	public void getAllProductTypes(){
		List<Map<String, String>> rs = productTypeService.getProductTypeList();
		ResponseUtil.sendResult(JSONArray.fromObject(rs).toString());
	}
	
	public void getProductTypes(){
		try {
			Object[] rs = productTypeService.getProductTypeList(pageIndex,seachkey,ptype,state);
			result = JSONArray.fromObject(rs).toString();
			ResponseUtil.sendResult(result);
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("获取产品类型列表信息出错", e);
		}
	}

	public void deleteProductType(){
		try {
			boolean rs = productTypeService.deleteProductTypeVOById(productTypeId);
			if(rs){
				ResponseUtil.sendResult("success");
			}else{
				ResponseUtil.sendResult("error");
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("删除产品类型信息出错", e);
			ResponseUtil.sendResult("error");
		}
	}
	
	public void getProductTypeById(){
		try {
			productTypeVO = productTypeService.getProductTypeVOById(productTypeId);
			result = JSONArray.fromObject(new Object[]{productTypeVO}).toString();
			ResponseUtil.sendResult(result);
		} catch (Exception e) {
			// TODO: handle exception
			ResponseUtil.sendResult("");
		}
	}
	
	public void modifyProductTypeState(){
		boolean rs = productTypeService.modifyProductTypeVOById(productTypeId, state);
		if(rs){
			ResponseUtil.sendResult("success");
		}else{
			ResponseUtil.sendResult("error");
		}
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session=session;
	}



	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public ProductTypeService getProductTypeService() {
		return productTypeService;
	}

	public void setProductTypeService(ProductTypeService productTypeService) {
		this.productTypeService = productTypeService;
	}

	public ProductTypeVO getProductTypeVO() {
		return productTypeVO;
	}

	public void setProductTypeVO(ProductTypeVO productTypeVO) {
		this.productTypeVO = productTypeVO;
	}

	public Integer getProductTypeId() {
		return productTypeId;
	}

	public void setProductTypeId(Integer productTypeId) {
		this.productTypeId = productTypeId;
	}
	public String getSeachkey() {
		return seachkey;
	}
	public void setSeachkey(String seachkey) {
		this.seachkey = seachkey;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	
}
