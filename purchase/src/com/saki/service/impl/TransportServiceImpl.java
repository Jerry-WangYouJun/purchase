package com.saki.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TOrder;
import com.saki.model.TTransport;
import com.saki.service.TransportServiceI;

@Service("transService")
public class TransportServiceImpl implements TransportServiceI{

	private BaseDaoI transDao;
	
	public BaseDaoI getTransportDao() {
		return transDao;
	}
	@Autowired
	public void setTransportDao(BaseDaoI transDao) {
		this.transDao = transDao;
	}
	
	@Override
	public Grid search(Map map, String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}
	

	@Override
	public void add(Object object) {
		transDao.save(object);
	}

	@Override
	public void update(Object object) {
		transDao.update(object);
	}

	@Override
	public void deleteByKey(String key) {
		transDao.delete(getByKey(key));
	}

	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		String hql = "from TTransport t";
		if(sort!=null && order!=null){
			hql = "from TTransport t order by " + sort + " " + order;
		}
		System.out.println(hql);
		List<TTransport> l = transDao.find(hql);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TTransport> lp = transDao.find(hql, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(lp);
		}else{
			grid.setRows(l);
      }	
		return grid;
	}
	
	@Override
	public Grid loadQuery(String sort, String order, String page, String rows , Map<String,Object> params) {
		Grid grid = new Grid();
		String hql = "from TTransport t where 1=1 ";
		if(sort!=null && order!=null){
			hql = "from TTransport t order by " + sort + " " + order;
		}
		Iterator<Map.Entry<String, Object>> it = params.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<String, Object> entry = it.next() ;
			hql +=  " and " +  entry.getKey() + " like '" + entry.getValue()  +"'";
		}
		grid.setTotal(transDao.count(hql));
		if(page!=null && rows !=null){
			List<TTransport> lp = transDao.find(hql,  Integer.valueOf(page),  Integer.valueOf(rows));
			for(TTransport tran : lp) {
				  TOrder orderTemp = (TOrder)transDao.get(" from TOrder o where o.id =" + tran.getOrderid());
				  tran.setOrderName(orderTemp.getOrderNo());
			}
			grid.setRows(lp);
		}else{
			List<TTransport> l = transDao.find(hql  );
			for(TTransport tran : l) {
				  TOrder orderTemp = (TOrder)transDao.get(" from TOrder o where o.id =" + tran.getOrderid());
				  tran.setOrderName(orderTemp.getOrderNo());
			}
			grid.setRows(l);
      }	
		return grid;
	}

	@Override
	public Object getByKey(String key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", Integer.valueOf(key));
		TTransport t = (TTransport) transDao.get("from TTransport t where t.id = :id", params);
		return t;
	}

	@Override
	public Grid search(String row, String text, String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		Map<String, Object> params = new HashMap<String, Object>();		
		String hql = "from TTransport t";
		if(row!=null && text!=null){
			params.put("text", "%" + text + "%");
			hql = hql + " where t." + row + " like :text";
		}
		if(sort!=null && order!=null){
			hql = hql + " order by " + sort + " " + order;
		}	
		List<TTransport> l = transDao.find(hql, params);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TTransport> lp = transDao.find(hql, params, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(lp);
		}else{
			grid.setRows(l);
		}	
		return grid;
	}
	
	@Override
	public int checkOrderNo(String orderNo) {
		String hql = "select u.id from TOrder u  where u.orderNo =  '" + orderNo + "'";
		Object result = transDao.get(hql);
		return result == null ? 0 : (Integer)transDao.get(hql);
	}
}
