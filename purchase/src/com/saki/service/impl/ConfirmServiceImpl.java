package com.saki.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.model.TConfirm;
import com.saki.service.ConfirmServiceI;
@Service
public class ConfirmServiceImpl implements ConfirmServiceI{

	private BaseDaoI confirmDao;
	


	public BaseDaoI getConfirmDao() {
		return confirmDao;
	}

	@Autowired
	public void setConfirmDao(BaseDaoI confirmDao) {
		this.confirmDao = confirmDao;
	}

	@Override
	public List<TConfirm> list() {
		List<TConfirm> l = confirmDao.find("from TConfirm order by confirmDate ");
		return l;
	}

	@Override
	public void save(TConfirm record) {
			confirmDao.save(record);
		
	}

	@Override
	public void delete(int id) {
		Map<String, Object> params = new HashMap<String, Object>();	
		params.put("id", id);
		TConfirm t = (TConfirm) confirmDao.get("from TConfirm  t where t.id = :id", params);
		confirmDao.delete(t);
		
	}

	@Override
	public void update(TConfirm confirm) {
		confirmDao.update(confirm);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TConfirm> getWarningList(int start , int end ) {
		String hql = " from TConfirm t  where  " + start +" <= "
				+ "( t.confirmDate  - DATE_FORMAT(now(),'%d') ) "
				+ "   	 and   (t.confirmDate  - DATE_FORMAT(now(),'%d') "
				+ "  ) <=   " + end ;
		return confirmDao.find(hql);
	}



}
