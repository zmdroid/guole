package com.guoleMIS.service.advert;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guoleMIS.dao.advert.AdvertDao;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ImageUtil;
import com.guoleMIS.vo.AdvertVO;
import com.guoleMIS.vo.InformationVO;

public class AdvertServiceImpl implements AdvertService {

	private AdvertDao advertDao;
	
	private static final Logger logger = Logger.getLogger(AdvertServiceImpl.class);

	private static final Config config = Config.getInstance();
	
	@Override
	public Object[] getAdvertList(int page,int state) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		if(state>0){
			sb.append(" a.state=").append(state).append(" and ");
		}
		int count = advertDao.getAdvertsCount(sb.toString());
		int pageSize = Integer.parseInt(Config.getInstance().getString("page.size"));
		int pageCount = count/pageSize;
		if(count%pageSize!=0)pageCount++;
		String paramter = sb.toString() + " 1=1 order by a.id desc limit "+(page-1)*pageSize+","+pageSize;
		List<AdvertVO> adverts = advertDao.getAdverts(paramter);
		return new Object[]{pageCount,adverts,count};
	}

	@Override
	public boolean crateAdvert(AdvertVO advertVO) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public AdvertVO getAdvertById(int id) {
		// TODO Auto-generated method stub
		return advertDao.getAdvertById(id);
	}
	

	@Override
	public boolean deleteAdvertById(int id) {
		// TODO Auto-generated method stub
		return advertDao.deleteAdvertById(id)>0;
	}

	
	@Override
	public boolean modifyAdvertById(int id, int state) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("state", state);
		return advertDao.updateAdvertStateById(map)>0;
	}

	@Override
	public boolean updateAdvert(AdvertVO advertVO) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean saveUpdateAdvert(AdvertVO advertVO) {
		// TODO Auto-generated method stub
		advertVO.setState(1);
		if(advertVO.getId()>0){//更新
			// 拷贝临时照片
			String tmpPath =  config.getString("resRootUrl")+config.getString("imageDir")+  Config.getInstance().getString("resTmp");
			File sFile = new File(tmpPath + "/" + advertVO.getAdPic());
			if (sFile.exists()) {
				//删除主图
				String infoImagePath =config.getString("resRootUrl")+config.getString("imageDir")+config.getString("advertImageDir")+"/";
				File infoFile = new File(infoImagePath + advertVO.getAdPic());
				if(infoFile.exists())infoFile.delete();
				renameInfoPics(advertVO.getAdPic());
			}
			
			return advertDao.updateAdvert(advertVO)>0;
		}else{//新建
			// 拷贝临时照片
			renameInfoPics(advertVO.getAdPic());
			return advertDao.insertAdvert(advertVO)>0;
		}
	}

	/**
	 * 将线路临时照片copy到资源目录中
	 * @param pics
	 */
	private void renameInfoPics(String pics) {
		String lineResPath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("advertImageDir")+"/";
		File ddFile = new File(lineResPath);
		if(!ddFile.exists()){
			ddFile.mkdir();
		}
		String tmpPath =  config.getString("resRootUrl")+config.getString("imageDir")+Config.getInstance().getString("resTmp");
		String[] imgs = pics.split(",");
		File sFile;
		File dFile;
		for (String pic : imgs){
			sFile = new File(tmpPath + "/" + pic);
			dFile = new File(lineResPath + "/" + pic);
			if (sFile.exists()) {
				sFile.renameTo(dFile);
				thumbPic(pic);
			}
		}
	}
	
	/**
	 *对大图进行等比压缩处理到当前目录下的thumd文件夹中
	 *
	 */
	private void thumbPic(String pic){
		String sPath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("advertImageDir");
		File sFile = new File(sPath + "/" + pic);
		String dPath = sPath + config.getString("thumb");
		File ddFile = new File(dPath);
		if(!ddFile.exists()){
			ddFile.mkdir();
		}
		File dFile = new File(dPath + "/" + pic);
		if (sFile.exists()) {
			try {
				ImageUtil.copy(sFile, dFile);
				ImageUtil.resize(dFile.getAbsolutePath(), 120, 90, true);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("压缩广告图片出错", e);
			}
		}
	}
	
	public AdvertDao getAdvertDao() {
		return advertDao;
	}

	public void setAdvertDao(AdvertDao advertDao) {
		this.advertDao = advertDao;
	}
	

	
}
