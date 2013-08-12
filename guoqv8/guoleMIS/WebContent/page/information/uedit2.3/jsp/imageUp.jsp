    <%@page import="java.util.Arrays"%>
<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
    <%@ page import="ueditor.Uploader" %>

    <%
    request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
    Uploader up = new Uploader(request);
   
    String[] fileType = {".gif" , ".png" , ".jpg" , ".jpeg" , ".bmp"};
    up.setAllowFiles(fileType);
    up.setMaxSize(10000); //单位KB
    up.upload();
    String[] tmp = up.getUrl().split("/");
    System.out.println(Arrays.toString(tmp));
    response.getWriter().print("{'original':'"+up.getOriginalName()+"','url':'"+tmp[tmp.length-2]+"/"+tmp[tmp.length-1]+"','title':'"+up.getTitle()+"','state':'"+up.getState()+"'}");
    %>
