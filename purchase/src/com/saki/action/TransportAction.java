package com.saki.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TTransport;
import com.saki.service.OrderServiceI;
import com.saki.service.TransportServiceI;

@Namespace("/")
@Action(value="transAction")
public class TransportAction extends BaseAction implements ModelDriven<TTransport>{

	private static final Logger logger = Logger.getLogger(TransportAction.class);
	
	private TTransport trans = new TTransport();
	private TransportServiceI transService;
	private OrderServiceI orderService;
	public OrderServiceI getOrderService() {
		return orderService;
	}
	@Autowired
	public void setOrderService(OrderServiceI orderService) {
		this.orderService = orderService;
	}
	@Override
	public TTransport getModel() {
		return trans;
	}
	public TransportServiceI getTransportService() {
		return transService;
	}
	@Autowired
	public void setTransportService(TransportServiceI transService) {
		this.transService = transService;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void loadAll(){
		Map map = new HashMap();
		String transname = getParameter("transname");
		if(StringUtils.isNotEmpty(transname)){
			map.put("transname", "%" + transname + "%");
		}
		String transno = getParameter("transno");
		if(StringUtils.isNotEmpty(transno)) {
			map.put("transno", "%" + transno + "%");
		}
		super.writeJson(transService.loadQuery(sort, order, page, rows, map));
	}
	public void listAll(){
		super.writeJson(transService.loadAll(sort, order, page, rows).getRows());
	}
	
	public void edit(){
		Message j = new Message();
		try{
			if(trans.getId() != null && trans.getId() > 0 ){
				update();
			}else{
				add();
			}
			j.setSuccess(true);
			j.setMsg("操作成功");
		}catch(Exception e){
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	public void add(){
			transService.add(trans);
	}
	
	public void update(){
			transService.update(trans);
	}
	public void delete(){
		Message j = new Message();
		try{
			transService.deleteByKey(trans.getId().toString());
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
		super.writeJson(transService.search(name, value,sort, order, page, rows));
	}
	
	public void checkOrderNo() {
		Message j = new Message();
		int nums = 0 ;
		try{
			nums = transService.checkOrderNo(getParameter("orderNo"));
			if(nums > 0 ) {
				j.setSuccess(true);
				j.setObj(nums);
			}else {
				j.setSuccess(false);
				j.setMsg("客户订单号错误，请确认！");
			}
		}catch(Exception e){
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	
}
