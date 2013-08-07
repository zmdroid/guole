package com.guoleMIS.service.groupbuy;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guoleMIS.dao.groupbuy.GroupbuyDao;
import com.guoleMIS.service.gift.GiftCardServiceImpl;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ImageUtil;
import com.guoleMIS.vo.GroupbuyInfoVO;

/**
 * 团购商品业务处理服务
 * @author 005
 *
 */
public class GroupbuyServiceImpl implements GroupbuyService {

	private static final Config conf = Config.getInstance();
	private static final Logger logger = Logger.getLogger(GroupbuyServiceImpl.class);
	private GroupbuyDao groupbuyDao;
	
	@Override
	public Object[] getGroupbuyInfos(int onLine,int typeCode, int pageIndex) {
		// TODO Auto-generated method stub
		
		int pageSize = Integer.parseInt(conf.getString("page.size"));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("typeCode", typeCode);
		map.put("onLine", onLine);
		int record = groupbuyDao.getGoopbuyInfocCount(map);
		int pageCount = record/pageSize;
		if(record%pageSize>0)pageCount++;
		if(pageIndex<1||pageIndex>pageCount)pageIndex=1;
		map.put("pageIndex", (pageIndex-1)*pageSize);
		map.put("pageSize", pageSize);
		List<GroupbuyInfoVO> list = groupbuyDao.getGroupbuyInfo(map);
		return new Object[]{record,pageCount,list};
	}

	@Override
	public GroupbuyInfoVO getGroupbuyInfo(int recordNo) {
		// TODO Auto-generated method stub
		return groupbuyDao.getGroupbuyInfoById(recordNo);
	}
	
	
	@Override
	public boolean saveUpdateGroupbuyInfo(GroupbuyInfoVO groupbuyInfo) {
		// TODO Auto-generated method stub
		groupbuyInfo.setOnLine(2);//是否上架
		double rebate = Double.parseDouble(groupbuyInfo.getPrice())/Double.parseDouble(groupbuyInfo.getValue());
		groupbuyInfo.setRebate(rebate+"");//折扣
		double save = Double.parseDouble(groupbuyInfo.getValue())-Double.parseDouble(groupbuyInfo.getPrice());
		groupbuyInfo.setSave(save+"");//节省钱数
		groupbuyInfo.setBought(0+"");
		groupbuyInfo.setSubcategory("国内水果");
		groupbuyInfo.setTypeCode(1);
		groupbuyInfo.setCreateTime(new Date());
		if(groupbuyInfo.getRecordNo()>0){//更新
			// 拷贝临时照片
			String tmpPath =  conf.getString("resRootUrl")+conf.getString("imageDir")+ conf.getString("resTmp");
			File sFile = new File(tmpPath + "/" + groupbuyInfo.getImage());
			if (sFile.exists()) {
				//删除主图
				String infoImagePath =conf.getString("resRootUrl")+conf.getString("imageDir")+conf.getString("tuanDir")+"/";
				File infoFile = new File(infoImagePath + groupbuyInfo.getTitle()+".jpg");
				if(infoFile.exists())infoFile.delete();
				renameInfoPics(groupbuyInfo.getImage(),groupbuyInfo.getTitle());
			}
			
			groupbuyInfo.setImage("/"+groupbuyInfo.getTitle()+".jpg");
			return groupbuyDao.updateGroupbuyInfo(groupbuyInfo)>0;
		}else{//新建
			// 拷贝临时照片
			renameInfoPics(groupbuyInfo.getImage(),groupbuyInfo.getTitle());
			groupbuyInfo.setImage("/"+groupbuyInfo.getTitle()+".jpg");
			return groupbuyDao.insertGroupbuyInfo(groupbuyInfo)>0;
		}
	}
	
	/**
	 * 将线路临时照片copy到资源目录中
	 * @param pics
	 */
	private void renameInfoPics(String pics,String name) {
		String lineResPath = conf.getString("resRootUrl")+conf.getString("imageDir")+conf.getString("tuanDir")+"/";
		File ddFile = new File(lineResPath);
		if(!ddFile.exists()){
			ddFile.mkdir();
		}
		String tmpPath =  conf.getString("resRootUrl")+conf.getString("imageDir")+conf.getString("resTmp");
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
		String sPath = conf.getString("resRootUrl")+conf.getString("imageDir")+conf.getString("tuanDir");
		File sFile = new File(sPath + "/" + pic);
		String dPath = sPath + conf.getString("thumb");
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
	public boolean delGroupbuyInfoByRecordNo(int recordNo) {
		// TODO Auto-generated method stub
		try {
			return groupbuyDao.delGroupbuyInfoByRecordNo(recordNo)>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("删除团购商品信息出错,团购商品Id="+recordNo,e);
			return false;
		}
	}
	

	@Override
	public boolean modifyGroupbuyInfoOnLine(int recordNo, int onLine) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("recordNo", recordNo);
		map.put("onLine", onLine);
		try {
			return groupbuyDao.updateGroupbuyInfoOnLine(map)>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("更改团购商品的状态出错，团购商品Id="+recordNo+" 状态="+onLine, e);
			return false;
		}
	}

	public GroupbuyDao getGroupbuyDao() {
		return groupbuyDao;
	}

	public void setGroupbuyDao(GroupbuyDao groupbuyDao) {
		this.groupbuyDao = groupbuyDao;
	}
}
