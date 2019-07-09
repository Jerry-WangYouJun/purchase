package com.saki.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Grid;
import com.saki.entity.Message;
import com.saki.model.TCompany;
import com.saki.model.TUserProduct;
import com.saki.service.CompanyServiceI;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;
import com.saki.utils.SystemUtil;
@Namespace("/")
@Action(value="userProAction")
public class UserProAction  extends BaseAction implements ModelDriven<TUserProduct>{
	
	TUserProduct userPro = new TUserProduct();
	
	private ProductServiceI productService;
	private UserProductServiceI userProductService;
	private ProductDetailServiceI productDetailService;
	private  CompanyServiceI companyService;
	
	
	public void loadByCompanyId(){
		Message j = new Message();
		String roleId = getSession().getAttribute("roleId").toString();
		String companyId   = "0" ; 
		if(!"1".equals(roleId)){
			companyId = (String)getSession().getAttribute("companyId" );
		}
		
		super.writeJson(j);
	}
	
	public void updateMapperBrand() {
		Message j = new Message();
		String mapid = getParameter("mapid");
		String brand = getParameter("brand");
		TUserProduct  mapper = userProductService.getByKey(Integer.valueOf(mapid));
		mapper.setBrand(brand);
		userProductService.update(mapper);
		j.setSuccess(true);
		super.writeJson(j);
	}
	
	
	public void updateMapperBrandMany() {
		Message j = new Message();
		String brand = getParameter("brand");
		try{
			Grid  com = companyService.search("brand",  brand, null, null, "1", "10");
			if(com.getTotal() <= 0) {
				j.setMsg("保存失败,该品牌不存在");
				j.setSuccess(false);
			}else {
				String  s = getParameter("obj");
				JSONArray jsonArray = JSONArray.parseArray(s);
				for (Object object : jsonArray) {
					JSONObject  json = (JSONObject) object;
					Integer mapid = json.getIntValue("mapid");
					TUserProduct  mapper = userProductService.getByKey(Integer.valueOf(mapid));
					mapper.setBrand(brand);
					userProductService.update(mapper);
				}
				j.setSuccess(true);
				j.setMsg("保存成功");
			}
		}catch(Exception e){
			j.setMsg("保存失败");
		}	
		super.writeJson(j);
	}
	
	@Override
	public TUserProduct getModel() {
		return userPro;
	}
	
	@Autowired
	public void setProductService(ProductServiceI productService) {
		this.productService = productService;
	}
	
	@Autowired
	public void setCompanyService(CompanyServiceI companyService) {
		this.companyService = companyService;
	}
	@Autowired
	public void setProductDetailService(ProductDetailServiceI productDetailService) {
		this.productDetailService = productDetailService;
	}

	public TUserProduct getUserPro() {
		return userPro;
	}

	public void setUserPro(TUserProduct userPro) {
		this.userPro = userPro;
	}

	public UserProductServiceI getUserProductService() {
		return userProductService;
	}

	public void setUserProductService(UserProductServiceI userProductService) {
		this.userProductService = userProductService;
	}

	public ProductServiceI getProductService() {
		return productService;
	}

	public ProductDetailServiceI getProductDetailService() {
		return productDetailService;
	}

	public CompanyServiceI getCompanyService() {
		return companyService;
	}
	
}
