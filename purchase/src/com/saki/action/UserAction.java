package com.saki.action;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TAddress;
import com.saki.model.TConfirm;
import com.saki.model.TNotice;
import com.saki.model.TUser;
import com.saki.service.AddressServiceI;
import com.saki.service.ConfirmServiceI;
import com.saki.service.NoticeServiceI;
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
	
	private NoticeServiceI noticeService ;
	
	private AddressServiceI addressService;
	
	@Autowired
	public void setNoticeService(NoticeServiceI noticeService) {
		this.noticeService = noticeService;
	}
	@Autowired
	public void setAddressService(AddressServiceI addressService) {
		this.addressService = addressService;
	}
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
	
	public void checkUserOnly() {
		String userName = getParameter("userName");
		int num = userService.searchUserOnly(userName);
		if(num > 0) {
			Message j = new Message();
			j.setSuccess(false);
			j.setMsg("用户名重复，请重新输入!");
			super.writeJson(j);
		}
	}
	
	public void login(){	
		Message j = new Message();
		TUser u =userService.login(user);
		List<TConfirm> t = confirmService.getWarningList();
		List<TConfirm> confirm = confirmService.list();
		List<TAddress> addressList = addressService.list();
	    Integer base = userService.getBase();
	    Integer trans = userService.getTrans();
		if(u != null){
			getSession().setAttribute("userName", StringUtils.isEmpty(u.getCompanyName())?"管理员":u.getCompanyName());
			getSession().setAttribute("roleId", u.getRoleId());
			getSession().setAttribute("companyId", u.getCompanyId());
			getSession().setAttribute("loged", true);
			TConfirm nextDay = getConfirmDay(confirm);
			getSession().setAttribute("warnFlag", nextDay);
			getSession().setAttribute("warnList", JSON.toJSON(t));
			getSession().setAttribute("addressList", addressList);
			getSession().setAttribute("confirm", confirm);
			getSession().setAttribute("base", base);
			getSession().setAttribute("trans", trans);
			j.setSuccess(true);
			j.setMsg("登陆成功!");
		}else{
			getSession().setAttribute("loged", false);
			j.setMsg("登陆失败，用户名或密码错误");
		}
		super.writeJson(j);
	}
	
	private TConfirm getConfirmDay(List<TConfirm> confirm) {
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
	public void checkConfirm(){	
		Message j = new Message();
		List<TConfirm> t = confirmService.list();
		TConfirm nextDay = getConfirmDay(t) ;
		if(nextDay == null) {
			j.setSuccess(false);
		}else {
			LocalDate now = LocalDate.now();
			int today =  now.getDayOfMonth();
			int month = now.getMonthValue();
			if(today > nextDay.getConfirmDate()){
				month += 1 ;
			}
			LocalDate plusTwoDay = LocalDate.of(now.getYear(), month, nextDay.getConfirmDate());
			Period between = Period.between(now, plusTwoDay);
			if(between.getDays() < 3 ) {
				j.setSuccess(true);
				j.setObj(nextDay);
			}
		}
		super.writeJson(j);
	}
	
	public void findConfirm(){	
		Message j = new Message();
		List<TNotice> list = noticeService.list();
		if(list == null || list.size() == 0) {
			j.setMsg("");
		}else {
			Iterator<TNotice> it = list.iterator();
			String msg = "";
			while (it.hasNext()) {
				TNotice t = it.next();
				if("1".equals(t.getFlag())) {
					msg += t.getMsg() + ";      ";
				}
				
			}
			//j.setMsg(msg.substring(0, msg.length()-1));
			j.setMsg(msg);
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
