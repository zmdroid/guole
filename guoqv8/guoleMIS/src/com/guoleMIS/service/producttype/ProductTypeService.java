package com.guoleMIS.service.producttype;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.ProductTypeVO;



public interface ProductTypeService {

	Object[] getProductTypeList(int page,String seachkey,String ptype,int state);
	
	public List<Map<String, String>> getProductTypeList();
	
	boolean crateProductType(ProductTypeVO productType);
	
	ProductTypeVO getProductTypeVOById(int id);
	
	boolean deleteProductTypeVOById(int id);
	
	boolean modifyProductTypeVOById(int id,int state);
	
	boolean updateProductTypeVO(ProductTypeVO productType);
	
	boolean saveUpdateProductTypeVO(ProductTypeVO productType);
}
