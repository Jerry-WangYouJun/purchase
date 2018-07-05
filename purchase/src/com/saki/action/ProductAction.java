package com.saki.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Grid;
import com.saki.entity.Message;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUser;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;

@Namespace("/")
@Result(name="toProduceSelectTab",location="/pages/produce_select_tab.jsp")
@Action(value="productAction")
public class ProductAction  extends BaseAction implements ModelDriven<TProduct>{

	private static final Logger logger = Logger.getLogger(ProductAction.class);
	
	@Override
	public TProduct getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	public ProductServiceI getProductService() {
		return productService;
	}
	@Autowired
	public void setProductService(ProductServiceI productService) {
		this.productService = productService;
	}
	private ProductServiceI productService;
	private UserProductServiceI userProductService;
	
	public void loadAll(){
		super.writeJson(productService.listAll());
	}
	public void loadByCompanyId(){
		super.writeJson(productService.listByCompany1(Integer.valueOf(getSession().getAttribute("companyId").toString())));
	}
	
	public void loadProducntDetailByCompany(){
			Grid grid = new Grid();
			int companyId =  0 ;
			if(getSession().getAttribute("companyId")!= null){
				 companyId = Integer.valueOf(getSession().getAttribute("companyId").toString());
			}
			List<Map<String, Object>>  l = productService.searchProductDetailByCompanyId(companyId);
			//List<Map<String,Object>>  list = orderService.searchDetail(id);
			grid.setTotal(l.size());
			grid.setRows(l);
		super.writeJson(grid);
	}
	
	/**
	 * 产品选择页面 —— ztree 
	 */
	public void loadTreeByCompanyId()
	{
		super.writeJson(productService.listTreeByCompanyId(Integer.valueOf(getSession().getAttribute("companyId").toString())));
	}
	
	public void saveUserProduct(){
		Message j = new Message();
		try{
			int roleId =  0 ;
			if(getSession().getAttribute("roleId")!= null){
				roleId = Integer.valueOf(getSession().getAttribute("roleId").toString());
			}
			//userProductService.delete(Integer.valueOf(getSession().getAttribute("companyId").toString()));
			userProductService.save(Integer.valueOf(getSession().getAttribute("companyId").toString()), getParameter("productlist") , roleId);
			j.setSuccess(true);
			j.setMsg("保存成功");
		}catch(Exception e){
			j.setMsg("保存失败");
		}	
		super.writeJson(j);
	}
	
	/**
	 * 更新供应商价格
	 */
	public void updateMappingPrice(){
		Message j = new Message();
		try{
			int roleId =  0 ;
			if(getSession().getAttribute("roleId")!= null){
				roleId = Integer.valueOf(getSession().getAttribute("roleId").toString());
			}
			userProductService.updatePrice( Integer.valueOf(getSession().getAttribute("companyId").toString() )
					, Integer.valueOf(getParameter("detailId")) 
					, Double.valueOf(getParameter("price")), roleId);
			j.setSuccess(true);
			j.setMsg("保存成功");
		}catch(Exception e){
			j.setMsg("保存失败");
		}	
		super.writeJson(j);
	}
	
	/**
	 * 更新供应商价格
	 */
	public void updateMarkupPrice(){
		Message j = new Message();
		try{
			int roleId =  0 ;
			if(getSession().getAttribute("roleId")!= null){
				roleId = Integer.valueOf(getSession().getAttribute("roleId").toString());
			}
			userProductService.updateMarkupPrice(  Integer.valueOf(getParameter("mapid")) 
					, Double.valueOf(getParameter("markup")));
			j.setSuccess(true);
			j.setMsg("保存成功");
		}catch(Exception e){
			j.setMsg("保存失败");
		}	
		super.writeJson(j);
	}
	
	public void updateMappingStatus(){
		Message j = new Message();
		 String  s = getParameter("obj");
		 JSONArray jsonArray = JSONArray.parseArray(s);
		 Iterator it  = jsonArray.iterator();
		 Map<String , Object> map = new HashMap<>();
		while(it.hasNext()){
			 JSONObject  json = (JSONObject) it.next();
			 if(map.containsKey(json.getIntValue("productDetailId") + json.getString("reamrk")) ){
				 j.setSuccess(false);
				 j.setMsg("同种产品不能选择两次！");
				 super.writeJson(j);
				 return ;
			 }else{
				 map.put(json.getIntValue("productDetailId") + json.getString("reamrk"), json);
			 }
		}
		for (Object object : jsonArray) {
			 JSONObject  json = (JSONObject) object;
			 userProductService.updateStatusReset(json.getIntValue("productDetailId"), json.getString("companyId"));
			 userProductService.updateStatus(json.getIntValue("mapid"));
		}
		j.setSuccess(true);
		j.setMsg("操作成功");
		super.writeJson(j);
	}
	
	public void getUserSelectProductDetail()
	{
		super.writeJson(userProductService.getIdByCompany(Integer.valueOf(getSession().getAttribute("companyId").toString())));
	}
	
	public UserProductServiceI getUserProductService() {
		return userProductService;
	}
	@Autowired
	public void setUserProductService(UserProductServiceI userProductService) {
		this.userProductService = userProductService;
	}
	
	public String toProduceSelectTab()
	{
		this.getRequest().setAttribute("productList",  productService.searchProductAndChileProduct());
		this.getRequest().setAttribute("secProduct", productService.searchSecProductAndChild());
		return "toProduceSelectTab";
	}
	
}
