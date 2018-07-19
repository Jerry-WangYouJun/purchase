package com.saki.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.xwork.StringUtils;
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
import com.saki.entity.Notice;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;

@Namespace("/")
@Result(name="toProduceSelectTab",location="/pages/produce_select_tab.jsp")
@Action(value="productAction")
public class ProductAction  extends BaseAction implements ModelDriven<TProduct>{

	private static final Logger logger = Logger.getLogger(ProductAction.class);
	
	@Override
	public TProduct getModel() {
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
	private ProductDetailServiceI productDetailService;
	
	@Autowired
	public void setProductDetailService(ProductDetailServiceI productDetailService) {
		this.productDetailService = productDetailService;
	}
	
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
			userProductService.deleteByList(Integer.valueOf(getSession().getAttribute("companyId").toString()),getParameter("productlist"));
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
			userProductService.updateMarkupPrice(  Integer.valueOf(getParameter("mapid")) 
					, Double.valueOf(getParameter("markup")));
			j.setSuccess(true);
			j.setMsg("保存成功");
		}catch(Exception e){
			j.setMsg("保存失败");
		}	
		super.writeJson(j);
	}
	
	/**
	 * 更新某种产品在系统中的默认价格
	 */
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
	
	
	public void searchProduct()
	{
		super.writeJson(productService.searchParentProduct(Integer.parseInt(getParameter("id"))));
	}
	
	public void searchProductDetail()
	{
		super.writeJson(productDetailService.searchProductDetailById(Integer.parseInt(getParameter("id"))));
	}
	//删除详情
	public void deleteProductDetailById()
	{
		productDetailService.deleteById(Integer.parseInt(getParameter("id")));
	}
	//删除类型
	public void deleteProductById()
	{
		if( getParameter("parentId")!= null && getParameter("parentId") != "")
		{
			List<TProductDetail> detailList = productDetailService.loadByProductId(Integer.parseInt(getParameter("id")));
			for (TProductDetail tProductDetail : detailList) {
				productDetailService.deleteByProductDetail(tProductDetail);
			}			
			productService.deleteByProduct(this.productService.searchParentProduct(Integer.parseInt(getParameter("id"))));			
		}
		else
		{
			List<TProduct> productList = productService.searchChildProductType(Integer.valueOf(getParameter("id")));
			for (TProduct tProduct : productList) {
				List<TProductDetail> detailList = productDetailService.loadByProductId(tProduct.getId());
				for (TProductDetail tProductDetail : detailList) {
					productDetailService.deleteByProductDetail(tProductDetail);
				}
				productService.deleteByProduct(tProduct);
			}
			TProduct product = this.productService.searchParentProduct(Integer.parseInt(getParameter("id")));
			productService.deleteByProduct(product);		
		}
		
	}
	//查询一级类型
	public void searchFirstProductType()
	{
		super.writeJson(productService.searchFirstProductType());
	}
	//查询二级类型
	public void searchChildProductType()
	{
		super.writeJson(productService.searchChildProductType(Integer.valueOf(getParameter("parentId"))));
	}
	//保存 （更新）详情
	public void saveProductDetail()
	{
		HttpServletRequest request = this.getRequest();
		String id = request.getParameter("id");
		TProductDetail detail;
		if(id==null || id=="")
		{
			 detail = new TProductDetail(null,
					   Integer.parseInt(request.getParameter("productId")), 
					   request.getParameter("subProduct"), 
					   request.getParameter("format"), 
					   request.getParameter("material"), 
					   request.getParameter("remark"));
		}
		else
		{
			 detail = new TProductDetail(Integer.parseInt(request.getParameter("id")),
					   Integer.parseInt(request.getParameter("productId")), 
					   request.getParameter("subProduct"), 
					   request.getParameter("format"), 
					   request.getParameter("material"), 
					   request.getParameter("remark"));
		}
		this.productDetailService.add(detail);
	}
	//保存（更新）类型
	public void saveProduct() {
	Message j = new Message();
		HttpServletRequest request = this.getRequest();
		String strId = request.getParameter("id");
		Integer id =null;
		
		
		String strParentId = request.getParameter("parentId");
		Integer parentId = null;
		
		if(strParentId != null && strParentId !="" ){
			parentId = Integer.valueOf(strParentId);
		}else{
			parentId = 0 ;
		}
		
		if(strId != null && strId != "") {
			id = Integer.parseInt(strId);
		}else {
			if(StringUtils.isNotEmpty(request.getParameter("product"))) {
				int num = this.productService.checkProductByName(getParameter("product"));
				if( num > 0 ) {
					j.setSuccess(false);
					j.setMsg("产品名称已存在,请确认！");
					super.writeJson(j);
					return ;
				}
			}
		}
		
		TProduct product = new TProduct(id,
				 parentId, 
				getParameter("product"), 
				getParameter("type"), 
				getParameter("unit"), 
				getParameter("base") != null
						&& StringUtils.isNotEmpty(getParameter("base")
								.toString()) ? Integer.valueOf(getParameter("base")) : 0,
				getParameter("remark"));

		this.productService.add(product);
		try {
			j.setSuccess(true);
			j.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("操作失败");
		}
		super.writeJson(j);
	}
	//加载全部ztree(不加载选中项) 
	public void loadTree()
	{
		try{
			
			super.writeJson(productService.listTree());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 统计管理员需要对商品进行加价
	 * 	  以及勾选默认产品类型的数据	
	 */
	public void countSituation(){
		try{
			List<Notice > list = new ArrayList<>();
			String roleId = getSession().getAttribute("roleId").toString();
			switch (roleId) {
			case "1":
				list =  userProductService.initAdminData();
				break;
			case "2":
				list = userProductService.initSupplierData();
				break;
			case "3":
				list = userProductService.initCustomerData();
				break;	
			}
			super.writeJson(list);
		}catch(Exception e){
			e.printStackTrace();
		} 
	}
}
