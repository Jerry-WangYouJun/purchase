package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TAddress;
import com.saki.model.TCompany;
import com.saki.model.TAddress;
import com.saki.service.AddressServiceI;
@Service
public class AddressServiceImpl implements AddressServiceI{

	private BaseDaoI addressDao;
	


	public BaseDaoI getAddressDao() {
		return addressDao;
	}

	@Autowired
	public void setAddressDao(BaseDaoI addressDao) {
		this.addressDao = addressDao;
	}
	
	@Override
	public Grid loadQuery(String sort, String order, String page, String rows , Map<String,Object> params) {
		Grid grid = new Grid();
		String hql = "from TAddress t where 1=1 ";
		if(sort!=null && order!=null){
			hql = "from TAddress t order by " + sort + " " + order;
		}
		Iterator<Map.Entry<String, Object>> it = params.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<String, Object> entry = it.next() ;
			hql +=  " and " +  entry.getKey() + " like '" + entry.getValue()  +"'";
		}
		grid.setTotal(addressDao.count(hql));
		List<TAddress> lp = new ArrayList<>();
		if(page!=null && rows !=null){
			 lp = addressDao.find(hql,  Integer.valueOf(page),  Integer.valueOf(rows));
		}else{
			 lp = addressDao.find(hql  );
      }	
		for(TAddress ad : lp) {
			String hqlDetail =  "from TCompany where id = "  + ad.getCid() ;
			TCompany com =(TCompany) addressDao.get(hqlDetail); 
			ad.setCompany(com);
		}
		grid.setRows(lp);
		return grid;
	}

	@Override
	public List<TAddress> list() {
		List<TAddress> l = addressDao.find("from TAddress order by isDefault desc ");
		return l;
	}

	@Override
	public void save(TAddress record) {
		if("1".equals(record.getIsDefault())) {
			String hql = "update TAddress  set isDefault = '0' where cid =  " +  record.getCid();
			addressDao.updateHql(hql);
		}
			addressDao.save(record);
		
	}

	@Override
	public void delete(int id) {
		Map<String, Object> params = new HashMap<String, Object>();	
		params.put("id", id);
		TAddress t = (TAddress) addressDao.get("from TAddress  t where t.id = :id", params);
		addressDao.delete(t);
	}

	@Override
	public void update(TAddress address) {
		if("1".equals(address.getIsDefault())) {
			String hql = "update TAddress  set isDefault = '0' where cid =  " +  address.getCid();
			addressDao.updateHql(hql);
		}
		addressDao.update(address);
	}



}
