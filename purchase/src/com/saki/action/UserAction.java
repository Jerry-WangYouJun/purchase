package com.saki.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TConfirm;
import com.saki.model.TUser;
import com.saki.service.ConfirmServiceI;
import com.saki.service.UserServiceI;
import com.saki.utils.MD5Util;

@Results({
	@Result(name="password",location="/pages/password.jsp")
})
@Namespace("/")
@Action(value="userAction")
public class UserAction extends BaseAction implements ModelDriven<TUser>{

	TUser user = new TUser();
	
	
	@Override
	public TUser getModel() {
		return user;
	}
	public UserServiceI getUserService() {
		return userService;
	}
	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
	private UserServiceI userService;
	
	@Autowired
	public void setConfirmService(ConfirmServiceI confirmService) {
		this.confirmService = confirmService;
	}
	private ConfirmServiceI confirmService ;
	
	
	public void loadAll(){
		String roleId = getSession().getAttribute("roleId").toString();
		if(!"1".equals(roleId)){
			value = getSession().getAttribute("companyId").toString();
			name = "companyId";
		}
		super.writeJson(userService.search(name, value,sort, order, page, rows));
	}
	public void add(){
		Message j = new Message();
		try{
			userService.add(user);
			j.setSuccess(true);
			j.setMsg("添加成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("添加失败");
		}
		super.writeJson(j);
	}
	public void update(){
		String pwd = getParameter("newPwd");
		Message j = new Message();
		try{
			user.setUserPwd(MD5Util.md5(pwd));
			userService.update(user);
			j.setSuccess(true);
			j.setMsg("更新成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("更新失败");
		}
		super.writeJson(j);
		
	}
	public void delete(){
		Message j = new Message();
		try{
			userService.deleteByKey(user.getId().toString());
			j.setSuccess(true);
			j.setMsg("删除成功");
		}catch(Exception e){
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
		
	}
	public void search(){
		String roleId = getSession().getAttribute("roleId").toString();
		if(!"1".equals(roleId)){
			value = getSession().getAttribute("companyId").toString();
			name = "companyId";
		}
		super.writeJson(userService.search(name, value,sort, order, page, rows));
	}
	public void login(){	
		Message j = new Message();
		TUser u =userService.login(user);
		List<TConfirm> t = confirmService.getWarningList();
		if(u != null){
			getSession().setAttribute("userName", StringUtils.isEmpty(u.getCompanyName())?"管理员":u.getCompanyName());
			getSession().setAttribute("roleId", u.getRoleId());
			getSession().setAttribute("companyId", u.getCompanyId());
			getSession().setAttribute("loged", true);
			getSession().setAttribute("warnFlag",t.size());
			getSession().setAttribute("warnList", JSON.toJSON(t));
			j.setSuccess(true);
			j.setMsg("登陆成功!");
		}else{
			getSession().setAttribute("loged", false);
			j.setMsg("登陆失败，用户名或密码错误");
		}
		super.writeJson(j);
	}
	
	public void checkConfirm(){	
		Message j = new Message();
		List<TConfirm> t = confirmService.getWarningList();
		if(t != null){
			getSession().setAttribute("warnFlag",t.size());
			getSession().setAttribute("warnList",t);
			j.setObj(t);
		}
		super.writeJson(j);
	}
	public void logout(){
		Message j = new Message();
		try{		
			getSession().setAttribute("userName", null);
			getSession().setAttribute("roleId", null);
			getSession().setAttribute("companyId", null);
			getSession().setAttribute("loged", false);
			j.setSuccess(true);
			j.setMsg("注销成功，将返回系统登录界面!");
		}catch(Exception e){
			j.setMsg("注销失败");
		}		
		super.writeJson(j);
	}
	
	 public String updatePasswordInit() {
		  return "password" ;
	 }
	 
	  public void updatePwd() {
		  Message j = new Message();
			TUser u =userService.login(user);
			String newPwd = getParameter("newPwd");
			if(u != null){
				u.setUserPwd(MD5Util.md5(newPwd));
				try {
					userService.update(u);
				} catch (Exception e) {
					getSession().setAttribute("loged", false);
					j.setMsg("操作失败," + e.getMessage());
				}
				j.setSuccess(true);
				j.setMsg("操作成功!");
			}else{
				getSession().setAttribute("loged", false);
				j.setMsg("操作失败，用户名或密码错误");
			}
			super.writeJson(j);
	  }
}
