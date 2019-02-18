package com.saki.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.saki.entity.Grid;
import com.saki.entity.Product;
import com.saki.entity.ProductType;
import com.saki.entity.TreeModel;
import com.saki.model.TProduct;

public interface ProductServiceI extends BaseServiceI{
	public ArrayList<Product> listAll();
	public ArrayList<Product> listByCompany(int companyId);
	public ArrayList<Product> listByCompany1(int companyId);
	public List<TreeModel> listTreeByCompanyId(Integer companyId);
	public TProduct searchParentProduct(Integer id);
	public ArrayList<Product> searchProductAndChileProduct();
	public ArrayList<ProductType> searchSecProductAndChild();
	public Grid searchProductDetailByCompanyId(Integer companyId , String page , String rows, Map params);
	public List<TProduct> searchFirstProductType();
	public List<TProduct> searchChildProductType(Integer parentId);
	public void deleteByProduct(TProduct product);
	public List<TreeModel> listTree();
	public int checkProductByName(String productName);
	public List getImgInfoByproductId(Integer valueOf, String parameter);
}
