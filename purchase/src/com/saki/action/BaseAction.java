package com.saki.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.saki.model.TConfirm;

@ParentPackage("basePackage")
@Namespace("/")
public class BaseAction {
	
	String name = getParameter("name");
	String value = getParameter("value");
	String page = getParameter("page");
	String rows = getParameter("rows");
	String sort = getParameter("sort");
	String order = getParameter("order");
	
	public void writeJson(Object object){
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss",SerializerFeature.DisableCircularReferenceDetect);

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
	
	// 发送响应流方法
		public void setResponseHeader(HttpServletResponse response, String fileName) {
			try {
				try {
					fileName = new String(fileName.getBytes(), "ISO8859-1");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				response.setContentType("application/octet-stream;charset=ISO8859-1");
				response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
				response.addHeader("Pargam", "no-cache");
				response.addHeader("Cache-Control", "no-cache");
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		
		public void getParams(Map<String, Object> params){
			String cno = getParameter("ono");
			String cstatus = getParameter("ostatue");
			String colName= getParameter("colName");
			String colValue=getParameter("colValue");
			String oinvoice = getParameter("oinvoice");
			
			String colName2= getParameter("colName2");
			String colValue2=getParameter("colValue2");
			if(StringUtils.isNotEmpty(colName) && StringUtils.isNotEmpty(colValue)) {
				params.put(colName, "%" + colValue + "%");
			}
			if(StringUtils.isNotEmpty(colName2) && StringUtils.isNotEmpty(colValue2)) {
				params.put(colName2, "%" + colValue2 + "%");
			}
			if(StringUtils.isNotEmpty(cno)) {
				params.put("orderNo", "%" + cno + "%");
			}
			if(StringUtils.isNotEmpty(cstatus)) {
				params.put("status", cstatus);
			}
			if(StringUtils.isNotEmpty(oinvoice)) {
				params.put("invoice", oinvoice);
			}
			String roleId = getSession().getAttribute("roleId").toString();
			if(!"1".equals(roleId)){
				String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
				params.put("companyId", companyId);
			}
		}
		
		
		public TConfirm getConfirmDay(List<TConfirm> confirm) {
			 LocalDateTime currentTime = LocalDateTime.now();
				int today =  currentTime.getDayOfMonth();
				TConfirm nextDay =  null ;
				for(TConfirm con : confirm) {
					 if(con.getConfirmDate() > today ) {
						 nextDay = con  ;
						 break;
					 }
				}
				if(nextDay == null  && confirm.size() > 0) {
					nextDay = confirm.get(0);
				}
				return nextDay;
		}
		
		
		public TConfirm getLastConfirmDay(List<TConfirm> confirm) {
			 LocalDateTime currentTime = LocalDateTime.now();
				int today =  currentTime.getDayOfMonth();
				TConfirm now =  null ;
				for(int i = 1 ; i <=  confirm.size(); i  ++) {
					if(confirm.get(i).getConfirmDate()  == today ) {
						now = confirm.get(i);
						break;
					}else if(confirm.get(i).getConfirmDate()  > today ) {
						now = confirm.get(i-1);
						break;
					}
				}
				
				if(now ==null && confirm.size() > 0) {
					 now = confirm.get(confirm.size() -1);
				}
				return now;
		}
}
