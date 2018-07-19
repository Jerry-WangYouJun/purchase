package com.saki.action;

import java.io.IOException;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TConfirm;
import com.saki.service.ConfirmServiceI;

@Namespace("/")
@Action(value="confirm")
public class ConfirmAction extends BaseAction implements ModelDriven<TConfirm>{

	private TConfirm confirm = new TConfirm();
	private ConfirmServiceI confirmService;
	public ConfirmServiceI getConfirmService() {
		return confirmService;
	}
	@Autowired
	public void setConfirmService(ConfirmServiceI confirmService) {
		this.confirmService = confirmService;
	}
	@Override
	public TConfirm getModel() {
		return confirm;
	}
	public void loadAll(){
		super.writeJson(confirmService.list());
	}
	
	public void add(){
		Message j = new Message();
		try{
			confirmService.save(confirm);
			updateSessionConfirm();
			j.setSuccess(true);
			j.setMsg("添加成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("添加失败");
		}
		super.writeJson(j);
	}
	
	public void update(){
		Message j = new Message();
		try{
			confirmService.update(confirm);
			updateSessionConfirm();
			j.setSuccess(true);
			j.setMsg("修改成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("操作失败，请联系管理员");
		}
		super.writeJson(j);
	}
	public void delete(){
		Message j = new Message();
		try{
			confirmService.delete(confirm.getId());
			updateSessionConfirm();
			j.setSuccess(true);
			j.setMsg("删除成功");
		}catch(Exception e){
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
		
	}
	
	public void updateSessionConfirm() {
		List<TConfirm> confirm = confirmService.list();
		getSession().setAttribute("confirm", confirm);
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
