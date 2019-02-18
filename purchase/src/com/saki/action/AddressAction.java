package com.saki.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TAddress;
import com.saki.service.AddressServiceI;
import com.saki.service.UserServiceI;

@Namespace("/")
@Action(value="addressAction")
public class AddressAction extends BaseAction implements ModelDriven<TAddress>{

	private static final Logger logger = Logger.getLogger(AddressAction.class);
	
	private TAddress address = new TAddress();
	private AddressServiceI addressService;
	private UserServiceI userService;
	public UserServiceI getUserService() {
		return userService;
	}
	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
	@Override
	public TAddress getModel() {
		return address;
	}
	public AddressServiceI getAddressService() {
		return addressService;
	}
	@Autowired
	public void setAddressService(AddressServiceI addressService) {
		this.addressService = addressService;
	}
	public void loadAll(){
		try {
			String roleId = getSession().getAttribute("roleId").toString();
			String companyId = getParameter("cid");
			Map map = new HashMap();
			if("0".equals(companyId)){
				companyId = getSession().getAttribute("companyId").toString();
				map.put("cid", companyId);
			}
			map.put("cid", companyId);
			super.writeJson(addressService.loadQuery(sort, order, page, rows, map));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void edit(){
		Message j = new Message();
		try{
			if(address.getId() != null && address.getId() > 0 ){
				addressService.update(address);
			}else{
				String companyId = getParameter("cid");
				address.setCid(Integer.valueOf(companyId));
				Map map = new HashMap();
				map.put("cid", companyId);
				int num = addressService.loadQuery(sort, order, page, rows, map).getTotal();
				if(num < 3) {
					addressService.save(address);
				}else {
					j.setSuccess(false);
					j.setMsg("地址最多填写三条");
					super.writeJson(j);
					return ;
				}
			}
			List<TAddress> addressList = addressService.list();
			getSession().setAttribute("addressList", addressList);
			j.setSuccess(true);
			j.setMsg("操作成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("操作失败");
			e.printStackTrace();
		}
		super.writeJson(j);
	}
	
	public void delete(){
		Message j = new Message();
		try{
			addressService.delete(address.getId());
			j.setSuccess(true);
			j.setMsg("删除成功");
		}catch(Exception e){
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
		
	}
	
}
