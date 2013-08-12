package com.guoleMIS.service.gift;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guoleMIS.util.MD5Encrypt;
import com.guoleMIS.dao.gift.GiftCardDao;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ImageUtil;
import com.guoleMIS.vo.GiftCardTypeVO;
import com.guoleMIS.vo.GiftCardVO;

public class GiftCardServiceImpl implements GiftCardService {

	private static final Config config = Config.getInstance();
	private static final Logger logger = Logger.getLogger(GiftCardServiceImpl.class);
	
	private GiftCardDao giftCardDao;
	
	
	@Override
	public Object[] getGiftCardTypes(int page) {
		// TODO Auto-generated method stub
		int pageSize = Integer.parseInt(config.getString("page.size"));
		int records = giftCardDao.getGiftCardTypesCount();
		int pageCount = records/pageSize;
		if(records%pageSize>0)pageCount++;
		if(page<=0||page>pageCount)page=1;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageIndex", (page-1)*pageSize);
		map.put("pageSize", pageSize);
		List<GiftCardTypeVO> list = giftCardDao.getGiftCardTypes(map);
		return new Object[]{records,pageCount,list};
	}
	

	@Override
	public GiftCardTypeVO getGiftCardTypeById(int id) {
		// TODO Auto-generated method stub
		try {
			return giftCardDao.qurGifyCardTypeById(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("根据Id获取礼品卡类型出错", e);
			return null;
		}
	}



	@Override
	public boolean delGiftCardTypeById(int id) {
		// TODO Auto-generated method stub
		try {
			return giftCardDao.delGiftCardTypeById(id)>0;
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("根据Id删除礼品卡类型出错", e);
			return false;
		}
	}
	
	@Override
	public boolean modifyGiftCardTypeStateById(int state, int id) {
		// TODO Auto-generated method stub
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("state", state);
			map.put("id",id);
			return giftCardDao.modifyGiftCardTypeStateById(map)>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("修改礼品卡类型状态出错", e);
			return false;
		}
	}


	@Override
	public boolean addUpdateGiftCardType(GiftCardTypeVO giftCardTypeVO) {
		// TODO Auto-generated method stub
		giftCardTypeVO.setState(2);
		if(giftCardTypeVO.getId()>0){//更新
			// 拷贝临时照片
			String tmpPath =  config.getString("resRootUrl")+config.getString("imageDir")+  Config.getInstance().getString("resTmp");
			File sFile = new File(tmpPath + "/" + giftCardTypeVO.getImg());
			if (sFile.exists()) {
				//删除主图
				String infoImagePath =config.getString("resRootUrl")+config.getString("imageDir")+config.getString("giftDir")+"/";
				File infoFile = new File(infoImagePath + giftCardTypeVO.getName()+".jpg");
				if(infoFile.exists())infoFile.delete();
				renameInfoPics(giftCardTypeVO.getImg(),giftCardTypeVO.getName());
			}
			
			giftCardTypeVO.setImg("/"+giftCardTypeVO.getName()+".jpg");
			return giftCardDao.updateGiftCardType(giftCardTypeVO)>0;
		}else{//新建
			// 拷贝临时照片
			renameInfoPics(giftCardTypeVO.getImg(),giftCardTypeVO.getName());
			giftCardTypeVO.setImg("/"+giftCardTypeVO.getName()+".jpg");
			return giftCardDao.insertGiftCardType(giftCardTypeVO)>0;
		}
	}
	
	/**
	 * 将线路临时照片copy到资源目录中
	 * @param pics
	 */
	private void renameInfoPics(String pics,String name) {
		String lineResPath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("giftDir")+"/";
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
			dFile = new File(lineResPath + "/" + name+".jpg");
			if (sFile.exists()) {
				sFile.renameTo(dFile);
				thumbPic(dFile.getName());
			}
		}
	}
	
	/**
	 *对大图进行等比压缩处理到当前目录下的thumd文件夹中
	 *
	 */
	private void thumbPic(String pic){
		String sPath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("giftDir");
		File sFile = new File(sPath + "/" + pic);
		String dPath = sPath + config.getString("thumb");
		File ddFile = new File(dPath);
		if(!ddFile.exists()){
			ddFile.mkdir();
		}
		File dFile = new File(dPath + "/" + pic);
		if (sFile.exists()) {
			try {
				if(dFile.exists())dFile.delete();
				ImageUtil.copy(sFile, dFile);
				ImageUtil.resize(dFile.getAbsolutePath(), 120, 90, true);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("压缩广告图片出错", e);
			}
		}
	}
	
	

	@Override
	public boolean addUpdateGiftCard(GiftCardVO giftCard) {
		// TODO Auto-generated method stub
		giftCard.setState(3);
		if(giftCard.getId()>0){//更新
			return giftCardDao.updateGiftCard(giftCard)>0;
		}else{//新建
			giftCard.setPwd(MD5Encrypt.getInstance().encrypt(giftCard.getPwd()));
			return giftCardDao.insertGiftCard(giftCard)>0;
		}
	}


	@Override
	public GiftCardVO getGiftCardById(int id) {
		// TODO Auto-generated method stub
		return giftCardDao.qurGifyCardById(id);
	}


	@Override
	public Object[] getGiftCards(int page) {
		// TODO Auto-generated method stub
		int pageSize = Integer.parseInt(config.getString("page.size"));
		int records = giftCardDao.getGiftCardsCount();
		int pageCount = records/pageSize;
		if(records%pageSize>0)pageCount++;
		if(page<=0||page>pageCount)page=1;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageIndex", (page-1)*pageSize);
		map.put("pageSize", pageSize);
		List<GiftCardVO> list = giftCardDao.getGiftCards(map);
		return new Object[]{records,pageCount,list};
	}


	@Override
	public boolean delGiftCardById(int id) {
		// TODO Auto-generated method stub
		return giftCardDao.delGiftCardById(id)>0;
	}


	@Override
	public boolean modifyGiftCardStateById(int state, int id) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("state", state);
		map.put("id", id);
		return giftCardDao.modifyGiftCardStateById(map)>0;
	}


	public GiftCardDao getGiftCardDao() {
		return giftCardDao;
	}

	public void setGiftCardDao(GiftCardDao giftCardDao) {
		this.giftCardDao = giftCardDao;
	}
	
	
}