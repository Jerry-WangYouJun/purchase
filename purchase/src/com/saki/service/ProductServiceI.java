package com.saki.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.saki.entity.Product;
import com.saki.entity.ProductType;
import com.saki.entity.TreeModel;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;

public interface ProductServiceI extends BaseServiceI{
	public ArrayList<Product> listAll();
	public ArrayList<Product> listByCompany(int companyId);
	public ArrayList<Product> listByCompany1(int companyId);
	public List<TreeModel> listTreeByCompanyId(Integer companyId);
	public TProduct searchParentProduct(Integer id);
	public ArrayList<Product> searchProductAndChileProduct();
	public ArrayList<ProductType> searchSecProductAndChild();
	List<Map<String, Object>> searchProductDetailByCompanyId(Integer companyId);
	public List<TProduct> searchFirstProductType();
	public List<TProduct> searchChildProductType(int parentId);
	public void deleteByProduct(TProduct product);
	public List<TreeModel> listTree();
}
