package com.saki.action;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Grid;
import com.saki.entity.Message;
import com.saki.model.TOrder;
import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUserProduct;
import com.saki.service.OrderServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.ExcelUtil;
import com.saki.utils.SystemUtil;

@Namespace("/")
@Action(value="orderAction")
@Result(name="print",location="/pages/print_order_manage.jsp")
public class OrderAction extends BaseAction implements ModelDriven<TOrder>{

	private static final Logger logger = Logger.getLogger(OrderAction.class);
	private TOrder order;
	@Override
	public TOrder getModel() {
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
	
	
	public void exportExcel() {
		Map<String ,Object> params  = new HashMap<>();
		getParams(params);
		Grid grid = orderService.search(params,"companyId", "desc", page, rows ,null);
		List<TOrder> list = grid.getRows();
		Map<TOrder ,List<Map<String,Object>> > resultMap = new HashMap<>();
		if(list!= null && list.size() > 0 ) {
			for(TOrder order : list) {
				List<Map<String,Object>>  detailList = orderService.searchDetail(order.getId()+"");
				resultMap.put(order, detailList);
			}
			// excel文件名
			String fileName = "订单信息表_" + DateUtil.getStringDateShort() + ".xls";
			try {
				// 创建HSSFWorkbook
				HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(resultMap);
				// 响应到客户端
				this.setResponseHeader(getResponse(), fileName);
				OutputStream os = getResponse().getOutputStream();
				wb.write(os);
				os.flush();
				os.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
	public void loadAll(){
		String page = getParameter("page");
		String rows = getParameter("rows");
		Map<String ,Object> params  = new HashMap<>();
		getParams(params);
		super.writeJson(orderService.search(params, "startDate", "desc", page, rows ,null));
	}
	
	public void loadByCompanyId() {
		String page = getParameter("page");
		String rows = getParameter("rows");
		Map<String ,Object> params  = new HashMap<>();
		getParams(params);
		super.writeJson(orderService.search(params, "startDate", "desc", page, rows ,null));
	}
	
	public String loadByOrderId() {
		getRequest().setAttribute( "amount" , getParameter("amount"));
		getRequest().setAttribute( "companyName" , getParameter("companyName"));
		getRequest().setAttribute( "orderNo" , getParameter("orderNo"));
		getRequest().setAttribute( "startDate", getParameter("startDate"));
		getRequest().setAttribute( "address" , getParameter("address"));
		getRequest().setAttribute( "status" , getParameter("status"));
		getRequest().setAttribute( "confirm" , getParameter("confirm"));
		return "print";
	}
	
	public void loadUrgentOrder(){
		String page = getParameter("page");
		String rows = getParameter("rows");
		Map<String ,Object> params  = new HashMap<>();
		getParams(params);
		super.writeJson(orderService.search(params , "startDate", "desc", page, rows , "1"));
	}

	public void update(){
		orderService.update(order);
	}
	public void delete(){
		orderService.deleteByKey(String.valueOf(order.getId()));
	}
	
	public void searchDetail() {
		String id = getParameter("id");
		if(!StringUtils.isEmpty(id)) {
			List<Map<String,Object>>  list = orderService.searchDetail(id);
			String jsonString = JSON.toJSONString(list);
			JSONArray jsonArray = JSONArray.parseArray(jsonString);
			super.writeJson(jsonArray);
		}
		
	}
	

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
	
	public void getProductBrand(){
		String detailId  = getParameter("detailId");
		List<Map<String, Object>> mapList =  orderService.searchBrandByProductDetailId(detailId);
		String jsonString = JSON.toJSONString(mapList);
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
		if(companyId=="null")//管理员用户
		{
			getAllProductType(parentId);
			return;
			
		}
		List<TProduct> list =new ArrayList<TProduct>();
		//获取 用户选择的 userDetaillist
		List<TUserProduct> userProductList = orderService.searchUserProductByCompanyId(companyId);
		String ids = "";
		String productIds = "";
		//遍历企业选择的所有产品id
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
		String companyId  = String.valueOf((Integer)getSession().getAttribute("companyId"));
		String productId = getParameter("productId");
		List<TProductDetail> list = orderService.searchDetailByProductId(productId,companyId);
		String jsonString = JSON.toJSONString(list);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		super.writeJson(jsonArray);
	}
	
	public void getChanges( ) {
		  
		 String orderId = getParameter("id");
		 String confirmId = getParameter("confirmId");
		 String addressId = getParameter("addressId");
		 String insert = getParameter("inserted");
		 String update = getParameter("updated");
		 String delete = getParameter("deleted");
		 String urgent = getParameter("urgent");
		 Message j = new Message();
		 boolean  insertFlag = checkOrderJson(insert);
		 boolean  updateFlag = checkOrderJson(update);
		 //先判断是否有相同采购日的订单
		 String companyId = getParameter("companyId");
		 if(StringUtils.isEmpty(companyId)) {
			 companyId = String.valueOf((Integer)getSession().getAttribute("companyId"));
		 }
		 Map<String,Object > params  = new HashMap<>();
		 params.put("companyId", companyId);
		 params.put("confirmId", confirmId );
		 String checkOrderDate = DateUtil.getUserDate("yyyyMM");
		 params.put("orderNo", "KH" + checkOrderDate + "%");
		 Grid grid  = orderService.search(params, "startDate", "desc", page, rows ,urgent);
			 if(StringUtils.isEmpty(orderId)) {
//				 if(grid.getTotal() > 0 ) {
//					 j.setSuccess(false);
//					 j.setMsg("该采购日已经存在订单，请在原订单上进行修改或选择其他采购日");
//					 super.writeJson(j);
//					 return ;
//				 }
				 if(insertFlag){
					 order  = new TOrder();
					 String dayOfOrderNo = DateUtil.getUserDate("yyyyMMdd");
					 order.setOrderNo("KH"  + dayOfOrderNo +  orderService.getOrderCode(dayOfOrderNo) );
					 order.setCompanyId(Integer.valueOf(companyId));
					 order.setStartDate(new Date());
					 order.setStatus("1");//新订单
					 if(StringUtils.isNotEmpty(urgent)){
						 order.setUrgent(urgent);
					 }
					 if(StringUtils.isNotBlank(confirmId)) {
						 order.setConfirmId(Integer.valueOf(confirmId));
					 }
					 Integer trans =(Integer) getSession().getAttribute("trans");
					 order.setAmount(order.getAmount() + trans);
					 orderService.add(order);
					 if(StringUtils.isNotEmpty(insert) ) {
						 insertDetail(insert);
					 }
					 
					 j.setSuccess(true);
				     j.setMsg("添加成功");
				 }else{
					 j.setSuccess(false);
				     j.setMsg("产品类型或产品的数量为必填，请仔细检查！");
				 }
				
			 }else {
				 //如果存在多条，数据异常
//				 if(grid.getTotal() > 1 ) {
//					 j.setSuccess(false);
//					 j.setMsg("该采购日已经存在多条订单，请联系管理员查看订单是否正常");
//					 super.writeJson(j);
//					 return ;
//				 }else if(grid.getTotal() ==  1) {
//					 List list = grid.getRows();
//					 TOrder t = (TOrder)list.get(0);
//					 if(t.getId()  !=  Integer.valueOf(orderId)) {
//						 j.setSuccess(false);
//						 j.setMsg("该采购日已经存在订单，请在原订单上进行修改或选择其他采购日");
//						 super.writeJson(j);
//						 return ;  
//					 }
//				 }
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
					 if(StringUtils.isNotBlank(confirmId)) {
						 order.setConfirmId(Integer.valueOf(confirmId));
					 }
				 }
				 j.setSuccess(true);
			     j.setMsg("修改成功");
			 }
			 if(StringUtils.isNotBlank(addressId)){
				 order.setAddressId(Integer.valueOf(addressId));
			 }
			 orderService.update(order);
	     super.writeJson(j);
	} 
	private void deleteDetail(String delete) {
		JSONArray jsonArr =  JSON.parseArray(delete);
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail = (TOrderDetail)orderService.getByDetailId(obj.getString("id"));
	    	    	   if(!StringUtils.isEmpty(obj.getString("amount"))){
	    	    		   detail.setAmount(obj.getDouble("amount"));
	    	    	   }
	    	    	   order.setAmount(SystemUtil.sub(order.getAmount(), detail.getAmount()));
	    	    	   orderService.delete(detail);
	     }
	}
	
	public void insertDetail(String insert)  {
		JSONArray jsonArr =  JSON.parseArray(insert);
	    // jsonArr.getJSONObject(0);
		Double sum = order.getAmount();
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail.setNum( obj.getIntValue("acount"));
	    	    	   detail.setOrderId(order.getId());
	    	    	   detail.setProductDetailId(obj.getInteger("detailId")==0?0:obj.getIntValue("detailId"));
	    	    	   detail.setBrand(obj.getString("supplierCompanyId"));
	    	    	   detail.setDefaultFlag(obj.getString("defaultFlag"));
	    	    	   if(!StringUtils.isEmpty(obj.getString("price"))){
	    	    		   detail.setPrice(obj.getDouble("price"));
	    	    	   }
	    	    	   if(!StringUtils.isEmpty(obj.getString("amount"))){
	    	    		   detail.setAmount(obj.getDouble("amount"));
	    	    	   }
	    	    	   sum = SystemUtil.add(sum , detail.getAmount());
	    	    	   detail.setRemark(obj.getString("remark"));
	    	    	   orderService.add(detail);
	     }
	     order.setAmount(sum);
	}
	
	public void updateDetail(String update) {
		JSONArray jsonArr =  JSON.parseArray(update);
		Double sum = order.getAmount();
	     //jsonArr.getJSONObject(0);
	     for(int i = 0 ; i < jsonArr.size() ; i ++) {
	    	    	   JSONObject obj = jsonArr.getJSONObject(i);
	    	    	   TOrderDetail detail = new TOrderDetail();
	    	    	   detail = (TOrderDetail)orderService.getByDetailId(obj.getString("id"));
	    	    	   if(detail != null) {
	    	    		   sum = SystemUtil.sub(sum , detail.getAmount());
	    	    		   detail.setNum(StringUtils.isEmpty(obj.getString("acount")) ? 0 : obj.getIntValue("acount"));
	    	    		   detail.setProductDetailId(obj.getInteger("detailId")==0?0:obj.getIntValue("detailId"));
	    	    		   detail.setDefaultFlag(obj.getString("defaultFlag"));
	    	    		   if(!StringUtils.isEmpty(obj.getString("price"))){
	    	    			       detail.setPrice(obj.getDouble("price"));
	    	    		   }
	    	    		   if(!StringUtils.isEmpty(obj.getString("amount"))){
		    	    		   detail.setAmount(obj.getDouble("amount"));
		    	    	   }
	    	    		   sum = SystemUtil.add(sum , detail.getAmount());
	    	    		   detail.setBrand(obj.getString("supplierCompanyId"));
	    	    		   detail.setRemark(obj.getString("remark"));
	    	    		   orderService.update(detail);
	    	    	   }
	     }
	     order.setAmount(sum);
	}
	public void deleteOrder(){
		Message j = new Message();
		try {
			String id = getParameter("id");
			orderService.deleteOrderDetailByOrderId(id);
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
			//发票状态
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
	
	public void updateBase(){
		String base = getParameter("base");
		Message j = new Message();
		try {
			orderService.updateBase(Integer.valueOf(base));
			getSession().setAttribute("base", Integer.valueOf(base));
			j.setMsg("操作成功");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg("操作失败");
			j.setSuccess(false);
		}
		super.writeJson(j);
	}
	
	public void updateTrans(){
		String base = getParameter("trans");
		Message j = new Message();
		try {
			orderService.updateTrans(Integer.valueOf(base));
			getSession().setAttribute("trans", Integer.valueOf(base));
			j.setMsg("操作成功");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg("操作失败");
			j.setSuccess(false);
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
