package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TUser;
import com.saki.model.TUserProduct;
import com.saki.service.UserProductServiceI;
@Service("userProductService")
public class UserProductServiceImpl implements UserProductServiceI{

	private BaseDaoI userProductDao;
	
	public BaseDaoI getUserProductDao() {
		return userProductDao;
	}

	@Autowired
	public void setUserProductDao(BaseDaoI userProductDao) {
		this.userProductDao = userProductDao;
	}


	@Override
	public ArrayList<Integer> getIdByCompany(int companyId) {
		ArrayList<Integer> lp = new ArrayList<Integer>();
		List<TUserProduct> l = listByCompanyId(companyId);
		if(l.size() > 0){
			for(TUserProduct t : l){
				lp.add(t.getProductDetailId());
			}
			return lp;
		}else{
			return null;
		}		
		
	}


	@Override
	public void save(int companyId, String productlist) {
		//delete(companyId);
		String[] ap = productlist.split(",");
		for(int i=0;i<ap.length;i++){
			TUserProduct t = new TUserProduct();
			t.setCompanyId(companyId);
			t.setProductDetailId(Integer.valueOf(ap[i]));
			userProductDao.save(t);
		}
	}

	@Override
	public void delete(int companyId) {
		List<TUserProduct> l = listByCompanyId(companyId);
		for(TUserProduct t : l){
			userProductDao.delete(t);
		}
		
	}

	@Override
	public List<TUserProduct> listByCompanyId(int companyId) {
		Map<String, Object> params = new HashMap<String, Object>();	
		System.out.println("------------------- " + companyId);
		params.put("companyId", companyId);
		List<TUserProduct> l = userProductDao.find("from TUserProduct t where t.companyId = :companyId", params);
		return l;
	}

}
