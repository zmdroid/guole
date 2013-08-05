package com.guoleMIS.action;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.util.Config;
import com.guoleMIS.util.FileUtil;
import com.guoleMIS.util.ImageUtil;
import com.guoleMIS.util.ResponseUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * @author ken
 * @version 1.0
 * @createtime 2013-6-28
 *		版本		修改者	时间		修改内容
 *
 */
public class FileUploadAction extends ActionSupport implements SessionAware{
	private static final long serialVersionUID = -2742235601578176349L;

	private static Logger logger = Logger.getLogger(FileUploadAction.class);
	
	private File file;//附件对象
	private String fileFileName;//附件名
	private String fileContentType;//附件类型
	private String fileURI;//文件路径
	
	private Map<String, Object> session;
	private String errorInputName;//错误文件名
	private String errorInfo;//错误信息
	Config config = Config.getInstance();
	
	
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
	 * 上传文件
	 * @return
	 */
	public void upload(){
		if(this.errorInfo!=null && this.errorInfo.length()>0){
			if(this.errorInfo.indexOf("maximum")>-1 || this.errorInfo.indexOf("large")>-1)ResponseUtil.sendResult("0101");
			if(this.errorInfo.indexOf("Content-Type")>-1)ResponseUtil.sendResult("0102");
			return;
		}
		//文件目录
		String dir = (String)config.get("resRootUrl")+config.getString("fileDir")+config.get("resTmp")+"";
		//上传图片
		String[] fileInfo = FileUtil.upload( file, fileFileName, fileContentType,dir);
		String path = fileInfo[0];
		setFileURI(path.substring(path.lastIndexOf("/") + 1, path.length()));
		
		ResponseUtil.sendResult(fileURI+","+fileFileName);
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

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}


	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileURI() {
		return fileURI;
	}

	public void setFileURI(String fileURI) {
		this.fileURI = fileURI;
	}


}
