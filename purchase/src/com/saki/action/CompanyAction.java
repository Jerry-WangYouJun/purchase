package com.saki.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TAddress;
import com.saki.model.TCompany;
import com.saki.model.TUser;
import com.saki.service.AddressServiceI;
import com.saki.service.CompanyServiceI;
import com.saki.service.UserServiceI;

@Namespace("/")

@Action(value = "companyAction" ,results = 
{@Result(name="loadCustomer",location="/pages/company_manage.jsp") ,
@Result(name="address",location="/pages/address_manage.jsp")}

)
public class CompanyAction extends BaseAction implements ModelDriven<TCompany>{

	private static final Logger logger = Logger.getLogger(CompanyAction.class);
	
	private TCompany company = new TCompany();
	private CompanyServiceI companyService;
	private UserServiceI userService;
	public UserServiceI getUserService() {
		return userService;
	}
	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
	private AddressServiceI addressService;
	public AddressServiceI getAddressService() {
		return addressService;
	}
	@Autowired
	public void setAddressService(AddressServiceI addressService) {
		this.addressService = addressService;
	}
	@Override
	public TCompany getModel() {
		return company;
	}
	public CompanyServiceI getCompanyService() {
		return companyService;
	}
	@Autowired
	public void setCompanyService(CompanyServiceI companyService) {
		this.companyService = companyService;
	}
	
	
	public String loadAddress(){
			String roleId = getSession().getAttribute("roleId").toString();
			String companyId = getParameter("companyId");
			getRequest().setAttribute("cid", companyId);
			return "address";
//			Map map = new HashMap();
//			String cname = getParameter("cname");
//			if(StringUtils.isNotEmpty(cname)){
//				map.put("name", "%" + cname + "%");
//			}
//			map.put("cid", companyId);
//			super.writeJson(addressService.loadQuery(sort, order, page, rows, map));
	}
	public void loadAll(){
		String roleId = getSession().getAttribute("roleId").toString();
		String companyId = "";
		Map map = new HashMap();
		if(!"1".equals(roleId)){
			companyId = getSession().getAttribute("companyId").toString();
			map.put("id", companyId);
		}
		String role = getParameter("roleId");
		if(StringUtils.isNotEmpty(role)){
			map.put("roleId", role);
		}
		String colName= getParameter("colName");
		String colValue=getParameter("colValue");
		
		String colName2= getParameter("colName2");
		String colValue2=getParameter("colValue2");
		if(StringUtils.isNotEmpty(colName) && StringUtils.isNotEmpty(colValue)) {
			map.put(colName, "%" + colValue + "%");
		}
		if(StringUtils.isNotEmpty(colName2) && StringUtils.isNotEmpty(colValue2)) {
			map.put(colName2, "%" + colValue2 + "%");
		}
		super.writeJson(companyService.loadQuery(sort, order, page, rows, map));
		
	}
	
	public void loadColor(){
		String roleId = getSession().getAttribute("roleId").toString();
		String companyId = "";
		Map map = new HashMap();
		String role = getParameter("roleId");
		if(StringUtils.isNotEmpty(role)){
			map.put("roleId", role);
		}
		super.writeJson(companyService.loadColor("imgUrl", "desc", page, rows, map));
		
	}
	
	public String loadCustomer(){
		String roleId = getParameter("role");
		this.getRequest().setAttribute("role", roleId);
		return "loadCustomer";
	}
	public void listAll(){
		super.writeJson(companyService.loadAll(sort, order, page, rows).getRows());
	}
	
	public void edit(){
		Message j = new Message();
		try{
			if(company.getId() != null && company.getId() > 0 ){
				update();
			}else{
				add();
			}
			j.setSuccess(true);
			j.setMsg("添加成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("添加失败");
		}
		super.writeJson(j);
	}
	public void add(){
		String roleId = getParameter("roleId");
			String userName = getParameter("userName");
			if(roleId != null){
				
				company.setRoleId(Integer.valueOf(roleId));
			}
			companyService.add(company);
			TUser user = new TUser();
			user.setRoleId(Integer.valueOf(roleId));
			user.setCompanyId(company.getId());
			user.setCompanyName(company.getName());
			user.setUserName(userName);
			user.setUserPwd(getParameter("userPwd"));
			userService.add(user);
	}
	
	public void update(){
			String roleId = getParameter("roleId");
			if(roleId != null){
				company.setRoleId(Integer.valueOf(roleId));
			}
			companyService.update(company);
			TUser user = userService.getByCompanyId(company.getId());
			String userName = getParameter("userName");
			user.setRoleId(Integer.valueOf(roleId));
			user.setCompanyId(company.getId());
			user.setUserName(userName);
			userService.update(user);
	}
	public void updateColor(){
		Message j = new Message();
		try{
			String id = getParameter("id");
			companyService.updateColorDelete(id);
			j.setSuccess(true);
			j.setMsg("添加成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("添加失败");
		}
		super.writeJson(j);
		
	}
	public void delete(){
		Message j = new Message();
		try{
			companyService.deleteByKey(company.getId().toString());
			System.out.println(company.getId());
			userService.deleteByCompanyId(company.getId());
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
		super.writeJson(companyService.search(name, value,sort, order, page, rows));
	}
	
	
	
	
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
}
