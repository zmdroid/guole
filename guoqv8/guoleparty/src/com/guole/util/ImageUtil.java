package com.guole.util;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import org.apache.log4j.Logger;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.tts.util.Config;
import com.guole.util.ImageUtil;


/**
 * 图像操作类，包括删除、裁剪等操作
 * @author ken
 * @version 1.0
 * @createtime 2012-5-21
 *		版本		修改者		时间			修改内容
 *		1.1		ken		2012-6-14		增加图像缩放操作
 *
 */
final public class ImageUtil {
	static Logger logger = Logger.getLogger(ImageUtil.class);
	static Config config = Config.getInstance();
	private static int BUFFER_SIZE;//缓冲区大小
	
	/**
	 * 调整图片尺寸
	 * @param uri 图片地址
	 * @param w 压缩宽度
	 * @param h 压缩高度
	 * @param ratio 是否等比，如果为true，按照w来进行h的调整
	 */
	public static void resize(String uri,int w,int h,boolean ratio){
		String[] tmp = uri.split("\\.");
		String extName = "jpg";
		//默认压缩类型
		int bufferType = BufferedImage.TYPE_INT_RGB;
		int newW = w;
		int newH = h;
		if(tmp!=null && tmp.length>1){
			extName = tmp[1];
		}
		if(extName.equalsIgnoreCase("png")||extName.equalsIgnoreCase("gif")){
			bufferType = BufferedImage.TYPE_INT_ARGB;
		}
				
		File imgFile = new File(uri);
		Image img = null;

		FileOutputStream out = null;
		try {
			img = ImageIO.read(imgFile);
			//等比缩放
			if(ratio){
				double rate1 = ((double) img.getWidth(null)) / (double) w;
				double rate2 = ((double) img.getHeight(null)) / (double) h;
				// 根据缩放比率大的进行缩放控制
				double rate = rate1 > rate2 ? rate1 : rate2;
				newW = (int) (((double) img.getWidth(null)) / rate);
				newH = (int) (((double) img.getHeight(null)) / rate);
			}
			BufferedImage buffImg = new BufferedImage(newW, newH,bufferType);
			buffImg.getGraphics().drawImage(img.getScaledInstance(newW, newH,Image.SCALE_SMOOTH), 0, 0, null);
			if(bufferType == BufferedImage.TYPE_INT_ARGB){
				ImageIO.write(buffImg, "png",new File(uri));  
			}else{
				out = new FileOutputStream(uri);
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				encoder.encode(buffImg);
			}
		}catch (Exception e) {
			logger.error("image resize error",e);
		}finally{
			if(out != null)
				try {
					out.close();
				} catch (IOException e) {
					logger.error("",e);
				}
		}
	  
	}
	
	/**
	 * 上传图片
	 * @param request
	 * @param imageFile struts自动获取的文件
	 * @param imageFileFileName struts自动获取的文件名
	 * @param imageFileContentType struts自动获取的文件类型
	 * @return [服务器上的真实路径|错误信息,错误码(-1)]
	 */
	public static String[] upload(File imageFile,String imageFileFileName,String imageFileContentType){
		String path = "";
		//没有传输错误并且图像已经存储到struts临时目录中
		if(imageFile.exists() && !imageFile.isDirectory()){
			File destFile = genStoreImageFile(imageFileFileName);
			
			try {
				path = destFile.getCanonicalPath();
				path = path.replace("\\", "/");
				
				//上传图像到指定目录
				copy(imageFile,destFile);
			} catch (IOException e) {
				logger.error("upload file ["+path+"] error",e);
				return new String[]{e.getMessage(),"-1"};
			}
		}else{
			return new String[]{"image is not exist","-1"};
		}
		return new String[]{path,"0"};
	}
	
	public static File genStoreImageFile(String fileFullName){
		String path = "";
		//获取根目录(临时目录)
		String rootPath = config.get("tmpDir")+"";
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
	 * 裁剪图片到指定尺寸
	 * @param uri 图片地址
	 * @param x 相对图片原点的X坐标
	 * @param y 相对图片原点的Y坐标
	 * @param w 裁剪宽度
	 * @param h 裁剪高度
	 */
	public static void cut(String uri,int x,int y,int w,int h){
		String extName = "";
		
		// 取得图片读入流 
		InputStream source = null;
		ImageInputStream iis = null;
		BufferedImage bi;
		try {
			source = new FileInputStream(uri);
			iis = ImageIO.createImageInputStream(source);
			// 取得图片读入器 
			Iterator<ImageReader> readers = ImageIO.getImageReaders(iis);
			ImageReader reader = readers.next(); 
			extName = reader.getFormatName();
			
			readers = ImageIO.getImageReadersByFormatName(extName);
			reader = readers.next(); 
			reader.setInput(iis, true);
			int imgW = reader.getWidth(0);
			int imgH = reader.getHeight(0);
			
			//测试裁剪矩形是否超出图片范围
			if(x+w>imgW){
				x -= w ;
			}
			if(y+h>imgH){
				y -= h ;
			}

			// 图片参数 
			ImageReadParam param = reader.getDefaultReadParam(); 

			Rectangle rect = new Rectangle(x, y, w, h); 

			param.setSourceRegion(rect); 
			
			bi = reader.read(0, param);
			ImageIO.write(bi,extName, new File(uri));
			reader.dispose();
		}catch (Exception e) {
			logger.error("image cut error",e);
		}finally{
			if(iis!=null){
				try {
					iis.close();
				} catch (IOException e) {
					logger.error("",e);
				}
			}
			if(source!=null){
				try {
					source.close();
				} catch (IOException e) {
					logger.error("",e);
				}
			}
		}
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
		BUFFER_SIZE = Integer.parseInt(config.get("image.bufferSize")+"");
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
