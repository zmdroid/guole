package com.guoleMIS.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import org.apache.log4j.Logger;

import com.guoleMIS.util.Config;
import com.guoleMIS.util.MD5Encrypt;


/**
 * 图像操作类，包括删除、裁剪等操作
 * @author ken
 * @version 1.0
 * @createtime 2012-5-21
 *		版本		修改者		时间			修改内容
 *		1.1		ken		2012-6-14		增加图像缩放操作
 *
 */
final public class FileUtil {
	static Logger logger = Logger.getLogger(FileUtil.class);
	static Config config = Config.getInstance();
	private static int BUFFER_SIZE=16384;//缓冲区大小
	
	/**
	 * 上传文件
	 * @param request
	 * @param file struts自动获取的文件
	 * @param fileFileName struts自动获取的文件名
	 * @param fileContentType struts自动获取的文件类型
	 * @param destDir 上传目的目录
	 * @return [服务器上的真实路径|错误信息,错误码(-1)]
	 */
	public static String[] upload(File file,String fileFileName,String fileContentType,String destDir){
		String path = "";
		//没有传输错误并且图像已经存储到struts临时目录中
		if(file.exists() && !file.isDirectory()){
			File destFile = genStoreImageFile(fileFileName,destDir);
			
			try {
				path = destFile.getCanonicalPath();
				path = path.replace("\\", "/");
				
				//上传图像到指定目录
				copy(file,destFile);
			} catch (IOException e) {
				logger.error("upload file ["+path+"] error",e);
				return new String[]{e.getMessage(),"-1"};
			}
		}else{
			return new String[]{"image is not exist","-1"};
		}
		return new String[]{path,"0"};
	}
	
	public static File genStoreImageFile(String fileFullName,String dir){
		String path = "";
		//获取根目录(临时目录)
		String rootPath = dir;
		//获取全路径
		String fullPath = getFullPath();
		//构造目标路径
		File destDir = new File(rootPath + "/" + fullPath);
		//验证目的是否存在,不存在就创建
		if(!destDir.exists()){
			destDir.mkdirs();
		}
		//保存名称
		//String fileName = "";
		String fileExtName = "";
		
		if(fileFullName.lastIndexOf(".") != -1){
			//fileName = imageFileFileName.substring(0,imageFileFileName.lastIndexOf("."));
			fileExtName = fileFullName.substring(fileFullName.lastIndexOf("."),fileFullName.length());
		}
		//构造存储名称
		String storeName = String.valueOf(System.currentTimeMillis());
		//MD5加密
		storeName = MD5Encrypt.getInstance().encrypt(storeName);
		path = rootPath + fullPath + "/" + storeName + fileExtName;
		File destFile = new File(path);
		return destFile;
	}
	
	
	/**
	 * 删除图片
	 * @param uri 图片物理地址
	 * @return 文件不存在或者删除失败返回false，否则 true
	 */
	public static boolean delete(String uri){
		if(uri == null || "".equals(uri))return false;
		File imageFile = new File(uri);
		if (imageFile.isFile() && imageFile.exists()) {
			return imageFile.delete();
		}
		return false;
	}
	
	/**
	 * 复制文件
	 * @param src 源文件
	 * @param dst 目标文件
	 * @throws IOException 
	 */
	public static void copy(File src, File dst) throws IOException {
		InputStream in = null;
		OutputStream out = null;
		try {
			in = new BufferedInputStream(new FileInputStream(src),
					BUFFER_SIZE);
			
			out = new BufferedOutputStream(new FileOutputStream(dst),
					BUFFER_SIZE);
			byte[] buffer = new byte[BUFFER_SIZE];
			int readByte;
			while ((readByte = in.read(buffer)) > 0) {
				out.write(buffer,0,readByte);
			}
			out.flush();
		} finally {
			if (null != in) {
				in.close();
				in = null;
			}
			if (null != out) {
				out.close();
				out = null;
			}
		}
	}
	
	/**
	 * 获取当前分类的所有父分类路径(待实现)
	 * @return 全路径
	 */
	private static String getFullPath(){
		StringBuffer sb = new StringBuffer();
		return sb.toString();
	}
	
	
	public static void main(String[] args) {
		System.out.println("\\sdfadsfsdf\\adsfadsfasdf\\adsfadsfsa\\fasdf".replace("\\", "/"));
	}
}
