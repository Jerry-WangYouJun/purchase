package com.saki.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Message;
import com.saki.model.TOrder;
import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUserProduct;
import com.saki.service.OrderServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.SystemUtil;

@Namespace("/")
@Action(value="orderAction")
public class OrderAction extends BaseAction implements ModelDriven<TOrder>{

	private static final Logger logger = Logger.getLogger(OrderAction.class);
	private TOrder order;
	@Override
	public TOrder getModel() {
		// TODO Auto-generated method stub
		return order;
	}
	private OrderServiceI orderService;
	public OrderServiceI getOrderService() {
		return orderService;
	}
	@Autowired
	public void setOrderService(OrderServiceI orderService) {
		this.orderService = orderService;
	}
	public void loadAll(){
		String page = getParameter("page");
		String rows = getParameter("rows");
		String sort = getParameter("sort");
		String order = getParameter("order");
		super.writeJson(orderService.loadAll( "startDate", "desc", page, rows));
	}
	
	public void loadByCompanyId() {
		String page = getParameter("page");
		String rows = getParameter("rows");
		String sort = getParameter("sort");
		String order = getParameter("order");
		String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
		super.writeJson(orderService.search("companyId" , companyId , "startDate", "desc", page, rows));
	}
	public void add(){
		order.setLocked("0");
		order.setInvoice("0");
		orderService.add(order);
	}
	public void update(){
		orderService.update(order);
	}
	public void delete(){
		orderService.deleteByKey(String.valueOf(order.getId()));
	}
	
	public void updateOrderLocked(){
		String lockFlag = getParameter("locked");
		String id =getParameter("id");
		Message j = new Message();
		try {
			orderService.updateOrderLocked(lockFlag , id );
			j.setSuccess(true);
			j.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	public void search(){
		String name = getParameter("name");
		String value = getParameter("value");
		String page = getParameter("page");
		String rows = getParameter("rows");
		String sort = getParameter("sort");
		String order = getParameter("order");
		super.writeJson(orderService.search(name, value,sort, order, page, rows));
	}
	
	public void searchDetail() {
		String id = getParameter("id");
		String orderNo = getParameter("orderNo");
		if(!StringUtils.isEmpty(id)) {
			List<Map<String,Object>>  list = orderService.searchDetail(id);
			String jsonString = JSON.toJSONString(list);
			JSONArray jsonArray = JSONArray.parseArray(jsonString);
			super.writeJson(jsonArray);
		}
		
	}
	
	/*public void getProduct() {
		List<TProduct>  list = orderService.searchProduct();
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}*/
	public void getAllProduct(){
		List<TProduct> list = null;
		list = orderService.searchFirstProduct();
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
		
	}
	
	public void getAllProductType(String parentId)
	{
		List<TProduct> list = null;
		list = orderService.searchProductTypeByParentId(parentId);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
		
	}
	
	public void getProduct() {
		String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
		if(companyId =="null")
		{
			getAllProduct();
			return;
		}
		List<TProduct> list =new ArrayList<TProduct>();
		//获取 用户选择的 userDetaillist
		List<TUserProduct> userProductList = orderService.searchUserProductByCompanyId(companyId);
		String ids = "";
		String productIds = "";
		String firstProductIds = "";
		for (TUserProduct tUserProduct : userProductList) {
			ids+= tUserProduct.getProductDetailId()+",";
		}
		ids = ids.substring(0, ids.length()-1);
		//获取所有 details
		List<TProductDetail> details = orderService.searchDetailByIds(ids);
		
		for (TProductDetail tProductDetail : details) {
			productIds+= tProductDetail.getProductId()+",";
		}
		productIds = productIds.substring(0, productIds.length()-1);
		List<TProduct> secProduct = orderService.searchProductByProductIds(productIds);
		for (TProduct tProduct : secProduct) {
			firstProductIds += tProduct.getParentId()+",";
		}
		firstProductIds = firstProductIds.substring(0, firstProductIds.length()-1);
		list = orderService.searchProductByproductIds(firstProductIds);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	//获取 二级 产品类型 （也需要通过 companyId 获取 tuserProduct 中的 detail ）
	public void getProductTypeByParentId()
	{
		String  parentId = getParameter("parentId");
		try {
	    	if("mac".equals(SystemUtil.getSystemName())){
	    		parentId = new String(parentId.getBytes("ISO-8859-1"),"UTF-8");
	    	}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
		if(companyId=="null")
		{
			getAllProductType(parentId);
			return;
			
		}
		List<TProduct> list =new ArrayList<TProduct>();
		//获取 用户选择的 userDetaillist
		List<TUserProduct> userProductList = orderService.searchUserProductByCompanyId(companyId);
		String ids = "";
		String productIds = "";
		String firstProductIds = "";
		for (TUserProduct tUserProduct : userProductList) {
			ids+= tUserProduct.getProductDetailId()+",";
		}
		ids = ids.substring(0, ids.length()-1);
		//获取所有 details
		List<TProductDetail> details = orderService.searchDetailByIds(ids);
		
		for (TProductDetail tProductDetail : details) {
			productIds+= tProductDetail.getProductId()+",";
		}
		productIds = productIds.substring(0, productIds.length()-1);
		list = orderService.searchProductByProductIdsAndParentId(productIds,parentId);
		
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
		
	}
	//判断用户是否已经选择产品
	public Boolean getUserSelectDetail()
	{
		String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
		List<TUserProduct> userProductList = orderService.searchUserProductByCompanyId(companyId);
		if(userProductList==null || userProductList.size()==0)
		{
			return false;
		}
		return true;
	}
	
	public void getProductType() {
	    String  product = getParameter("product");
	    try {
	    	if("mac".equals(SystemUtil.getSystemName())){
	    		product = new String(product.getBytes("ISO-8859-1"),"UTF-8");
	    	}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		List<TProduct>  list  = orderService.searchProductType(product);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	public void getProductDetail() {
		String productId = getParameter("productId");
		List<TProductDetail> list = orderService.searchDetailByProductId(productId);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	public void getChanges( ) {
		 String orderId = getParameter("id");
		 String insert = getParameter("inserted");
		 String update = getParameter("updated");
		 String delete = getParameter("deleted");
		 Message j = new Message();
		 boolean  insertFlag = checkOrderJson(insert);
		 boolean  updateFlag = checkOrderJson(update);
			 if(StringUtils.isEmpty(orderId)) {
				 if(insertFlag){
					 String companyId = getParameter("companyId");
					 if(StringUtils.isEmpty(companyId)) {
						 companyId = String.valueOf((Integer)getSession().getAttribute("companyId"));
					 }
					 order  = new TOrder();
					 String dayOfOrderNo = DateUtil.getUserDate("yyyyMMdd");
					 order.setOrderNo("KH"  + dayOfOrderNo +  orderService.getOrderCode(dayOfOrderNo) );
					 order.setCompanyId(Integer.valueOf(companyId));
					 order.setStartDate(new Date());
					 order.setStatus("1");//新订单
					 orderService.add(order);
					 insertDetail(insert);
					 j.setSuccess(true);
				     j.setMsg("添加成功");
				 }else{
					 j.setSuccess(false);
				     j.setMsg("产品类型或产品的数量为必填，请仔细检查！");
				 }
				
			 }else {
				 if(!insertFlag || !updateFlag){
					 j.setSuccess(false);
				     j.setMsg("产品类型或产品的数量为必填，请仔细检查！");
				 }else{
					 order = (TOrder)orderService.getByKey(orderId);
					 if(StringUtils.isNotEmpty(insert) ) {
						 insertDetail(insert);
					 }
					 if(StringUtils.isNotEmpty(update)) {
						 updateDetail(update);
					 }
					 if(StringUtils.isNotEmpty(delete)) {
						 deleteDetail(delete);
					 }
				 }
			 }
	     
	     
	     super.writeJson(j);
	} 
	private void deleteDetail(String delete) {
		JSONArray jsonArr =  JSON.parseArray(delete);
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail = (TOrderDetail)orderService.getByDetailId(obj.getString("id"));
	    	    	   orderService.delete(detail);
	     }
		
	}
	public void insertDetail(String insert)  {
		JSONArray jsonArr =  JSON.parseArray(insert);
	    // jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail.setNum( obj.getIntValue("acount"));
	    	    	   detail.setOrderId(order.getId());
	    	    	   detail.setProductDetailId(obj.getInteger("detailId")==0?0:obj.getIntValue("detailId"));
	    	    	   orderService.add(detail);
	     }
	}
	
	public void updateDetail(String update) {
		JSONArray jsonArr =  JSON.parseArray(update);
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail = (TOrderDetail)orderService.getByDetailId(obj.getString("id"));
	    	    	   if(detail != null) {
	    	    		   detail.setNum(StringUtils.isEmpty(obj.getString("acount")) ? 0 : obj.getIntValue("acount"));
	    	    		   detail.setProductDetailId(obj.getInteger("detailId")==0?0:obj.getIntValue("detailId"));
	    	    		   if(!StringUtils.isEmpty(obj.getString("price"))){
	    	    			       detail.setPrice(obj.getDouble("price"));
	    	    		   }
	    	    		   orderService.update(detail);
	    	    	   }
	     }
	}
	public void deleteOrder(){
		Message j = new Message();
		try {
			String id = getParameter("id");
			orderService.deleteByKey(id);
			j.setSuccess(true);
			j.setMsg("删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("删除失败");
		}
		super.writeJson(j);
	}
	
	public void updateStatus() {
		Message j = new Message();
		try {
			String id = getParameter("id");
			String status = getParameter("status");
			TOrder order = (TOrder)orderService.getByKey(id);
			switch (status) {
			case "2":
				
				break;
			case "3":
				String percent = getParameter("percent");
				order.setPercent(percent);
				order.setPillDate(new Date());
				break;
			case "4":
				order.setEndDate(new Date());
				break;

			}
			order.setStatus(status);
			orderService.update(order);
			j.setSuccess(true);
			j.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	
	public void updateInvoiceStatus() {
		Message j = new Message();
		try {
			String id = getParameter("id");
			String invoice = getParameter("invoice");
			TOrder order = (TOrder)orderService.getByKey(id);
			switch (invoice) {
			case "1":
					order.setInvoiceDate(new Date());
				break;
			case "2":
				order.setInvoiceGet(new Date());
			break;
			}
			order.setInvoice(invoice);
			orderService.update(order);
			j.setSuccess(true);
			j.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	
	public boolean checkOrderJson(String json){
		if(StringUtils.isEmpty(json)){
			 return true;
		}
		JSONArray jsonArr =  JSON.parseArray(json);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	   if(obj.getInteger("detailId")== null ||obj.getInteger("detailId") ==0){
	    		   return false;
	    	   }
	    	   if( obj.getInteger("acount") == null  ||obj.getInteger("acount") == 0 ){
	    		     return false;
	    	   } 
	     }
	     return true;
	}
}
