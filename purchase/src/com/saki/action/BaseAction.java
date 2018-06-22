package com.saki.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;

@ParentPackage("basePackage")
@Namespace("/")
public class BaseAction {
	
	String name = getParameter("name");
	String value = getParameter("value");
	String page = getParameter("pageNumber");
	String rows = getParameter("pageSize");
	String sort = getParameter("sort");
	String order = getParameter("order");
	
	public void writeJson(Object object){
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().write(json);
			ServletActionContext.getResponse().getWriter().flush();
			ServletActionContext.getResponse().getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	public String FormatFromParameter(String key) throws UnsupportedEncodingException{
		String s = ServletActionContext.getRequest().getParameter(key);
		return new String(s.getBytes("ISO8859_1"), "UTF8");
	}
	
	public String getParameter(String key){
		String s = ServletActionContext.getRequest().getParameter(key);
		return s;
	}
	
	/**
	 * 获得session
	 * 
	 * @return
	 */
	public HttpSession getSession() {
		getResponse().setHeader("P3P","CP='IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT'"); 
		return ServletActionContext.getRequest().getSession();
	}
	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * 获得response
	 * 
	 * @return
	 */
	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}
	
}
