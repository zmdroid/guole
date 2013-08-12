package com.guoleMIS.dao.producttype;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.ProductTypeVO;

public interface ProductTypeDao {

	int insertProductType(ProductTypeVO productType);
	
	int updateProductType(ProductTypeVO productType);
	
	int deleteProductTypeById(int id);
	
	int updateProductTypeStateById(Map map);
	
	ProductTypeVO getProductTypeById(int id);
	
	List<ProductTypeVO> getProductTypes(Map map);
	int getProductTypesCount(Map map);
	
	public List<Map<String,String>> getProductTypeList();
}
