package com.guoleMIS.service.producttype;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guoleMIS.dao.producttype.ProductTypeDao;
import com.guoleMIS.service.producttype.ProductTypeService;
import com.guoleMIS.util.Config;
import com.guoleMIS.vo.ProductTypeVO;

public class ProductTypeServiceImpl implements ProductTypeService{

	private ProductTypeDao productTypeDao;
	
	@Override
	public Object[] getProductTypeList(int page,String seachkey,String ptype,int state) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		Map<String,Object> map = new HashMap<String,Object>();
		if(seachkey!=null&&!seachkey.equals("")){
			map.put("seachkey", seachkey);
		}
		if(ptype!=null&&!ptype.equals("全部")){
			map.put("ptype", ptype);
		}
		map.put("state", state);
		int count = productTypeDao.getProductTypesCount(map);
		int pageSize = Integer.parseInt(Config.getInstance().getString("page.size"));
		int pageCount = count/pageSize;
		if(count%pageSize!=0)pageCount++;
		String paramter = " 1=1 order by id desc ";
		sb.append(paramter);
		
		map.put("pageIndex", (page-1)*pageSize);
		map.put("pageSize", pageSize);
		List<ProductTypeVO> adverts = productTypeDao.getProductTypes(map);
		return new Object[]{pageCount,adverts,count};
	}
	
	@Override
	public List<Map<String, String>> getProductTypeList() {
		return productTypeDao.getProductTypeList();
	}

	@Override
	public boolean crateProductType(ProductTypeVO productType) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ProductTypeVO getProductTypeVOById(int id) {
		// TODO Auto-generated method stub
		return productTypeDao.getProductTypeById(id);
	}

	@Override
	public boolean deleteProductTypeVOById(int id) {
		// TODO Auto-generated method stub
		return productTypeDao.deleteProductTypeById(id)>0;
	}

	@Override
	public boolean modifyProductTypeVOById(int id, int state) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String , Object>();
		map.put("id", id);
		map.put("state", state);
		return productTypeDao.updateProductTypeStateById(map)>0;
	}

	@Override
	public boolean updateProductTypeVO(ProductTypeVO productType) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean saveUpdateProductTypeVO(ProductTypeVO productType) {
		// TODO Auto-generated method stub
		productType.setState(1);
		if(productType.getId()>0){
			return productTypeDao.updateProductType(productType)>0;
		}else{
			return productTypeDao.insertProductType(productType)>0;
		}
	}

	public ProductTypeDao getProductTypeDao() {
		return productTypeDao;
	}

	public void setProductTypeDao(ProductTypeDao productTypeDao) {
		this.productTypeDao = productTypeDao;
	}
	

}
