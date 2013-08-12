package com.guoleMIS.service.info;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.output.FileWriterWithEncoding;
import org.apache.log4j.Logger;

import com.guoleMIS.dao.info.InformationDao;
import com.guoleMIS.service.info.InformationService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ImageUtil;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.InformationVO;

public class InformationServiceImpl implements InformationService {

	private InformationDao informationDao;
	
	private static final Logger logger = Logger.getLogger(InformationService.class);
	
	private static final Config config = Config.getInstance();
	
	@Override
	public Object[] getInformationList(int page,int type) {
		// TODO Auto-generated method stub
		int count = informationDao.getInformationsCount(type);
		int pageSize = Integer.parseInt(Config.getInstance().getString("page.size"));
		int pageCount = count/pageSize;
		if(count%pageSize!=0)pageCount++;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("type", type);
		map.put("pageIndex", (page-1)*pageSize);
		map.put("pageSize", pageSize);
		List<InformationVO> infors = informationDao.getInformations(map);
		
		return new Object[]{pageCount,infors,count};
	}

	@Override
	public InformationVO getInformationById(int id) {
		// TODO Auto-generated method stub
		InformationVO info = informationDao.getInformationByinfoId(id);
		String content = readFile(config.getString("resRootUrl")+config.getString("fileDir")+config.getString("infoUrl")+"/"+info.getContent());
		info.setContent(content);
		return info;
	}
	
	private String readFile(String path){
		StringBuffer sb = new StringBuffer();
		try {
            String encoding="UTF-8";
            File file=new File(path);
            if(file.isFile() && file.exists()){ //判断文件是否存在
                InputStreamReader read = new InputStreamReader(
                new FileInputStream(file),encoding);//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                while((lineTxt = bufferedReader.readLine()) != null){
                    sb.append(lineTxt);
                }
                read.close();
		    }else{
		    	logger.info("找不到指定的文件");
		    }
		    } catch (Exception e) {
		    	logger.error("找不到指定的文件",e);
		    }
		return sb.toString();
	}
	
	

	@Override
	public boolean saveUpdateInfo(InformationVO information) {
		// TODO Auto-generated method stub
		String infoDir =config.getString("resRootUrl")+config.getString("fileDir")+config.getString("infoUrl")+"/";
		File infoDirF = new File(infoDir);
		if(!infoDirF.exists())infoDirF.mkdirs();
		FileWriterWithEncoding writer = null;
		
		if(information.getId()>0){//更新
			
			//删除资讯内容
			String infoContentPath = config.getString("resRootUrl")+config.getString("fileDir")+config.getString("infoUrl")+"/";
			File infoContentFile = new File(infoContentPath + information.getContent());
			if(infoContentFile.exists())infoContentFile.delete();
			
			String filepath = createInforText(infoDir,information.getTitle(),information.getContent(),writer);
			information.setContent(filepath);
			// 拷贝临时照片
			String tmpPath =config.getString("resRootUrl")+config.getString("imageDir")+  Config.getInstance().getString("resTmp");
			File sFile = new File(tmpPath + "/" + information.getPicUrl());
			if (sFile.exists()) {
				//删除主图
				String infoImagePath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("infoUrl")+"/";
				File infoFile = new File(infoImagePath + information.getPicUrl());
				if(infoFile.exists())infoFile.delete();
				renameInfoPics(information.getPicUrl());
			}
			
			return informationDao.updateInformation(information)>0;
		}else{//新建
			String filepath = createInforText(infoDir,information.getTitle(),information.getContent(),writer);
			if(filepath==null)return false;
			information.setContent(filepath);
			// 拷贝临时照片
			if(information.getType()==1){
				renameInfoPics(information.getPicUrl());
			}
			return informationDao.insertInformation(information)>0;
		}
	}

	@Override
	public boolean crateInformation(InformationVO information) {
		// TODO Auto-generated method stub
		String infoDir = config.getString("resRootUrl")+config.getString("fileDir")+config.getString("infoUrl")+"/";
		File infoDirF = new File(infoDir);
		if(!infoDirF.exists())infoDirF.mkdirs();
		FileWriterWithEncoding writer = null;
		String filepath = createInforText(infoDir,information.getTitle(),information.getContent(),writer);
		if(filepath==null)return false;
		information.setContent(filepath);
		// 拷贝临时照片
		renameInfoPics(information.getPicUrl());
		return informationDao.insertInformation(information)>0;
	}
	
	private String createInforText(String fileDir,String fileName,String content,FileWriterWithEncoding writer){
		//写资讯文件
		File dir = new File(fileDir);
		if(!dir.exists()){
			dir.mkdirs();
		}
		File infoFile = new File(fileDir +fileName + ".text");
		
		try {
			infoFile.createNewFile();
			writer = new FileWriterWithEncoding(infoFile, "UTF-8");
			writer.write(content);
			writer.flush();
		} catch (IOException e) {
			logger.error("写文件错误",e);
			ResponseUtil.sendResult("写文件错误");
			return null;
		}finally{
			try {
				writer.close();
				writer = null;
			} catch (IOException e) {
				logger.error("关闭输出流错误",e);
			}
			return infoFile.getName();
		}
	}
	/**
	 * 将线路临时照片copy到资源目录中
	 * @param pics
	 */
	private void renameInfoPics(String pics) {
		String lineResPath =config.getString("resRootUrl")+config.getString("imageDir")+config.getString("infoUrl")+"/";
		String tmpPath = config.getString("resRootUrl")+config.getString("imageDir")+ Config.getInstance().getString("resTmp");
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
		String sPath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("infoUrl");
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

	@Override
	public boolean deleteInformationById(int id) {
		// TODO Auto-generated method stub
		//删除主图
		InformationVO info = informationDao.getInformationByinfoId(id);
		String infoImagePath = config.getString("resRootUrl")+config.getString("imageDir")+config.getString("infoUrl")+"/";
		File infoFile = new File(infoImagePath + info.getPicUrl());
		if(infoFile.exists())infoFile.delete();
		
		//删除资讯内容
		String infoContentPath =  config.getString("resRootUrl")+config.getString("fileDir")+config.getString("infoUrl")+"/";
		File infoContentFile = new File(infoContentPath + info.getContent());
		if(infoContentFile.exists())infoContentFile.delete();
		
		return informationDao.deleteInformationByinfoId(id)>0;
	}
	

	@Override
	public boolean updateInformation(InformationVO information) {
		// TODO Auto-generated method stub
		return informationDao.updateInformation(information)>0;
	}
	
	@Override
	public boolean modifyInformationStateById(int id, int state) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("state", state);
		return informationDao.updateInformationStateById(map)>0;
	}

	public InformationDao getInformationDao() {
		return informationDao;
	}

	public void setInformationDao(InformationDao informationDao) {
		this.informationDao = informationDao;
	}
	

}
