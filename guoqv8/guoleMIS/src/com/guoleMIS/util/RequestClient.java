package com.guoleMIS.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.log4j.Logger;

/**
 * HttpClient访问
 * @author xubo.wang
 * @version V1.0
 * @createTime   2012-07-31
 * @history  版本	修改者	   时间	修改内容
 */
public class RequestClient {
	private final static Logger logger = Logger.getLogger(RequestClient.class);
	
	/**
	 * 获取请求url返回的responseText
	 * @param url 网址
	 * @return
	 */
	public static String getResponseText(String url){
		HttpClient client = new HttpClient();
		HttpMethod method = null;
        int statusCode = 0;
        String responseText = "";
        ByteArrayOutputStream baos = null;
        InputStream in = null;
		try {
            method = new GetMethod(url); 
			client.executeMethod(method);
			statusCode = method.getStatusCode();
			in = method.getResponseBodyAsStream();
			baos = new ByteArrayOutputStream(); 
			int i = -1; 
			while((i = in.read()) != -1){
		        baos.write(i);
		    } 
			
			responseText = baos.toString("UTF-8");

			if (200 == statusCode){
				return responseText;
			}else{
				logger.error("访问search工程出错，返回编码：" + statusCode);
			}
		}catch (HttpException e) {
			e.printStackTrace();
			logger.error(e);
			return "error";
		}catch (IOException e) {
			e.printStackTrace();
			logger.error(e);
			return "error";
		}catch (Exception e){
			e.printStackTrace();
			logger.error(e);
			return "error";
		}finally{
			if (null != method){
				//释放连接
			    method.releaseConnection();
			}
			
			try {
				if (null != in){
					in.close();
				}
				
				if (null != baos){
					baos.flush();
					baos.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
				logger.error("关闭流出错", e);
			}
		}

		return "error";
	}
	
	/**
	 * 获取请求url返回的byte
	 * @param url 网址
	 * @return
	 */
	public static byte[] getResponseByte(String url){
		HttpClient client = new HttpClient();
		HttpMethod method = null;
        int statusCode = 0;
        ByteArrayOutputStream baos = null;
        InputStream in = null;
		try {
            method = new GetMethod(url); 
			client.executeMethod(method);
			statusCode = method.getStatusCode();
			in = method.getResponseBodyAsStream();
			baos = new ByteArrayOutputStream(); 

			int i = -1; 
			while((i = in.read()) != -1){
		        baos.write(i);
		    }

			if (200 == statusCode){
				return baos.toByteArray();
			}else{
				logger.error("下载链接出错，返回编码：" + statusCode + ";url:" + url);
			}
		}catch (HttpException e) {
			logger.error(e);
			return null;
		}catch (IOException e) {
			logger.error(e);
			return null;
		}catch (Exception e){
			logger.error(e);
			return null;
		}finally{
			if (null != method){
				//释放连接
			    method.releaseConnection();
			}
			
			try {
				if (null != in){
					in.close();
				}
				
				if (null != baos){
					baos.flush();
					baos.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
				logger.error("关闭流出错", e);
			}
		}

		return null;
	}
	
	/**
	 * 获取跳转链接
	 * @param url
	 * @return
	 */
	public static String getRediUrl(String url){
		HttpClient client = new HttpClient();
		HttpMethod method = null;
        int statusCode = 0;
        String recUrl = "";
        String visUrl = "";
		
		try {
            method = new GetMethod(url); 
			client.executeMethod(method);
			statusCode = method.getStatusCode();
			if (200 == statusCode){
				recUrl = method.getURI().toString();
				visUrl = URLDecoder.decode(recUrl.split("tu=")[1], "iso-8859-1");
				method = new GetMethod(visUrl);
				method.setRequestHeader("Referer", recUrl);
		        method.setRequestHeader("Host", "s.click.taobao.com");
				client.executeMethod(method);
				return method.getURI().toString();
			}else{
				logger.error("淘宝推广链接转换出错" + statusCode);
			}
		}catch (Exception e){
			logger.error(e);
			return "error";
		}finally{
			if (null != method){
				//释放连接
			    method.releaseConnection();
			}
		}

		return "error";
	}

	public static void main(String[] args) {
		String url = "http://s.click.taobao.com/t?e=zGU34CA7K%2BPkqB07S4%2FK0CITy7klxxrJ35Nnc0iIO5fc1RUSnDg5308LNHkyAowkYQclKuF%2FWrlSMazs2FoTBl8GeM1tN2P%2BrrwdlJUCRZq9";
		// String url = "http://s.click.taobao.com/t_js?tu=http%3A%2F%2Fs.click.taobao.com%2Ft%3Fe%3DzGU34CA7K%252BPkqB07S4%252FK0CITy7klxxrJ35Nnc0iIO5fc1RUSnDg5308LNHkyAowkYQclKuF%252FWrlSMazs2FoTBl8GeM1tN2P%252BrrwdlJUCRZq9%26ref%3D%26et%3DjFBC6pydunt9bg%253D%253D";
		String recUrl = RequestClient.getRediUrl(url);
		System.out.println(recUrl);
	}
}
