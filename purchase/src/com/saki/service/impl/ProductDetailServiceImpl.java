package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TProductDetail;
import com.saki.service.ProductDetailServiceI;

@Service("productDetailService")
public class ProductDetailServiceImpl implements ProductDetailServiceI{

	private BaseDaoI productDetailDao;
	
	@Override
	public void add(Object object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Object object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteByKey(String key) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getByKey(String key) {
		
		return null;
	}

	@Override
	public Grid search(String row, String text, String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TProductDetail> loadByProductId(int productId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("productId", productId);
		String hql = "from TProductDetail t where t.productId = :productId";
		List<TProductDetail> lp = productDetailDao.find(hql, params);
		return lp;
	}

	public BaseDaoI getProductDetailDao() {
		return productDetailDao;
	}
	@Autowired
	public void setProductDetailDao(BaseDaoI productDetailDao) {
		this.productDetailDao = productDetailDao;
	}


	
	@Override
	public List<TProductDetail> searchAllProductDetail() {
		// TODO Auto-generated method stub
		String hql =" from  TProductDetail detail  where detail.productId is not null ";		
		return productDetailDao.find(hql);
	}

}
