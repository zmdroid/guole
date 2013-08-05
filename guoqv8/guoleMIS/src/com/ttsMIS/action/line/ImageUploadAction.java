package com.ttsMIS.action.line;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.util.Config;
import com.guoleMIS.util.ImageUtil;
import com.guoleMIS.util.ResponseUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 进行图像上传,并把路径保存在session中
 * @author ken
 * @version 1.0
 * @createtime 2012-5-21
 *		版本		修改者	时间		修改内容
 *
 */
public class ImageUploadAction extends ActionSupport implements SessionAware{
	private static Logger logger = Logger.getLogger(ImageUploadAction.class);
	
	private File imageFile;//附件对象
	private String imageFileFileName;//附件名
	private String imageFileContentType;//附件类型
	private String imageURI;
	
	/**
	 * 用于多附件上传
	 */
	private File[] imageFiles;//附件对象
	private String[] imageFilesFileName;//附件名
	private String[] imageFilesContentType;//附件类型
	
	private Map<String, Object> session;
	private String errorInputName;//错误文件名
	private String errorInfo;//错误信息
	
	private int width;
	private int height;
	
	
	/**
	 * 上传错误信息异步返回
	 */
	public void uploadErrorRedirect(){
		ActionContext context = ActionContext.getContext();
		HttpServletResponse  response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);
		try {
			response.getWriter().print(this.errorInfo);
		} catch (IOException e) {
			logger.error("",e);
		}
	}
	
	/**
	 * 上传卖家营业执照/经营许可证图片
	 * @return
	 */
	public String uploadPicture(){
		//上传图片
		String[] imageURI = ImageUtil.upload( imageFile, imageFileFileName, imageFileContentType);
		setImageURI(imageURI[0]);
		BufferedImage sourceImg;
		InputStream is = null;
		String msg="";
		try{
			is= new FileInputStream(imageURI[0]);
			sourceImg = javax.imageio.ImageIO.read(is);
			if(sourceImg==null){
				ResponseUtil.sendResult("0103");
				return null;
			}
			width = sourceImg.getWidth();
			height = sourceImg.getHeight(); 
			int photoPreviewSize = Integer.parseInt(Config.getInstance().get("image.photoPreviewSize")+"");
			int pic_width = width;
			if(width > photoPreviewSize)pic_width = photoPreviewSize;
			ImageUtil.resize(imageURI[0], pic_width, pic_width, true);
			msg = imageURI[0].substring(imageURI[0].lastIndexOf("/")+1,imageURI[0].length());
		} catch (FileNotFoundException e) {
			logger.error("",e);
		} catch (IOException e) {
			logger.error("",e);
		} finally{
			if(is != null)
				try {
					is.close();
				} catch (IOException e) {
					logger.error("",e);
				}
			ResponseUtil.sendResult(msg);
		}
		return null;
	}
	
	/**
	 * 上传线路图片
	 */
	public void uploadLinePic() {
		if(this.errorInfo!=null && this.errorInfo.length()>0){
			if(this.errorInfo.indexOf("maximum")>-1 || this.errorInfo.indexOf("large")>-1)ResponseUtil.sendResult("0101");
			if(this.errorInfo.indexOf("Content-Type")>-1)ResponseUtil.sendResult("0102");
			return;
		}
		//上传图片
		String[] imageURI = ImageUtil.upload( imageFile, imageFileFileName, imageFileContentType);
		String path = "";
		if (null != imageURI && imageURI.length > 0) {
			path = imageURI[0];
			ResponseUtil.sendResult(path.substring(path.lastIndexOf("/") + 1, path.length()));
		}else{
			ResponseUtil.sendResult(ERROR);
		}
	}
	
	public File getImageFile() {
		return imageFile;
	}

	public void setImageFile(File imageFile) {
		this.imageFile = imageFile;
	}

	public String getImageFileFileName() {
		return imageFileFileName;
	}

	public void setImageFileFileName(String imageFileFileName) {
		this.imageFileFileName = imageFileFileName;
	}

	public String getImageFileContentType() {
		return imageFileContentType;
	}

	public void setImageFileContentType(String imageFileContentType) {
		this.imageFileContentType = imageFileContentType;
	}

	public String getImageURI() {
		return imageURI;
	}

	public void setImageURI(String imageURI) {
		this.imageURI = imageURI;
	}

	@Override
	public void setSession(Map session) {
		 this.session = session;
	}

	public String getErrorInfo() {
		return errorInfo;
	}

	public void setErrorInfo(String errorInfo) {
		this.errorInfo = errorInfo;
	}
	
	public String getErrorInputName() {
		return errorInputName;
	}
	
	public void setErrorInputName(String errorInputName) {
		this.errorInputName = errorInputName;
	}
	
	@Override
	public void addFieldError(String fieldName, String errorMessage) {
		this.errorInfo = errorMessage;
		this.errorInputName = fieldName;
	}
	
	@Override
	public void addActionError(String anErrorMessage) {
		this.errorInfo = anErrorMessage;
		
	}

	public File[] getImageFiles() {
		return imageFiles;
	}

	public void setImageFiles(File[] imageFiles) {
		this.imageFiles = imageFiles;
	}

	public String[] getImageFilesFileName() {
		return imageFilesFileName;
	}

	public void setImageFilesFileName(String[] imageFilesFileName) {
		this.imageFilesFileName = imageFilesFileName;
	}

	public String[] getImageFilesContentType() {
		return imageFilesContentType;
	}

	public void setImageFilesContentType(String[] imageFilesContentType) {
		this.imageFilesContentType = imageFilesContentType;
	}

}
