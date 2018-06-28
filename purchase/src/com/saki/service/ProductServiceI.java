package com.saki.service;

import java.util.ArrayList;
import java.util.List;

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
}
