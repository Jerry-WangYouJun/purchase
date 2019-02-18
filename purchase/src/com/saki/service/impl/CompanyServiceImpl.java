package com.saki.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TColor;
import com.saki.model.TCompany;
import com.saki.model.TOrder;
import com.saki.model.TUser;
import com.saki.service.CompanyServiceI;
import com.saki.service.UserServiceI;

@Service("companyService")
public class CompanyServiceImpl implements CompanyServiceI{

	private BaseDaoI companyDao;
	private UserServiceI userService;
	
	public BaseDaoI getCompanyDao() {
		return companyDao;
	}
	@Autowired
	public void setCompanyDao(BaseDaoI companyDao) {
		this.companyDao = companyDao;
	}

	@Override
	public void add(Object object) {
		companyDao.save(object);
	}

	@Override
	public void update(Object object) {
		companyDao.update(object);
	}

	@Override
	public void deleteByKey(String key) {
		companyDao.delete(getByKey(key));
	}

	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		String hql = "from TCompany t";
		if(sort!=null && order!=null){
			hql = "from TCompany t order by " + sort + " " + order;
		}
		System.out.println(hql);
		List<TCompany> l = companyDao.find(hql);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TCompany> lp = companyDao.find(hql, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(copyToEntity(lp));
		}else{
			grid.setRows(copyToEntity(l));
      }	
		return grid;
	}
	
	@Override
	public Grid loadQuery(String sort, String order, String page, String rows , Map<String,Object> params) {
		Grid grid = new Grid();
		String hql = "from TCompany t where 1=1 ";
		if(sort!=null && order!=null){
			hql = "from TCompany t order by " + sort + " " + order;
		}
		Iterator<Map.Entry<String, Object>> it = params.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<String, Object> entry = it.next() ;
			hql +=  " and " +  entry.getKey() + " like '" + entry.getValue()  +"'";
		}
		grid.setTotal(companyDao.count(hql));
		if(page!=null && rows !=null){
			List<TCompany> lp = companyDao.find(hql,  Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(copyToEntity(lp));
		}else{
			List<TCompany> l = companyDao.find(hql  );
			grid.setRows(copyToEntity(l));
      }	
		return grid;
	}
	
	@Override
	public Grid loadColor(String sort, String order, String page, String rows , Map<String,Object> params) {
		Grid grid = new Grid();
		String hql = "from TColor t where 1=1 ";
		if(sort!=null && order!=null){
			hql = "from TColor t order by " + sort + " " + order;
		}
		Iterator<Map.Entry<String, Object>> it = params.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<String, Object> entry = it.next() ;
			hql +=  " and " +  entry.getKey() + " like '" + entry.getValue()  +"'";
		}
		grid.setTotal(companyDao.count(hql));
		if(page!=null && rows !=null){
			List<TColor> lp = companyDao.find(hql,  Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(lp);
		}else{
			List<TColor> l = companyDao.find(hql  );
			grid.setRows(l);
      }	
		return grid;
	}

	@Override
	public Object getByKey(String key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", Integer.valueOf(key));
		TCompany t = (TCompany) companyDao.get("from TCompany t where t.id = :id", params);
		return t;
	}

	@Override
	public Grid search(String row, String text, String sort, String order, String page, String rows) {
		Grid grid = new Grid();
		Map<String, Object> params = new HashMap<String, Object>();		
		String hql = "from TCompany t";
		if(row!=null && text!=null){
			params.put("text", "%" + text + "%");
			hql = hql + " where t." + row + " like :text";
		}
		if(sort!=null && order!=null){
			hql = hql + " order by " + sort + " " + order;
		}	
		List<TCompany> l = companyDao.find(hql, params);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TCompany> lp = companyDao.find(hql, params, Integer.valueOf(page),  Integer.valueOf(rows));
			grid.setRows(copyToEntity(lp));
		}else{
			grid.setRows(copyToEntity(l));
		}	
		return grid;
	}
	
	
	
	private List<TCompany> copyToEntity(List<TCompany> lc){
		for(int i=0; i<lc.size(); i++){
			TUser u = userService.getByCompanyId(lc.get(i).getId());
			if(u!=null){
				lc.get(i).setRoleId(u.getRoleId());
				lc.get(i).setUserName(u.getUserName());
			}			
		}
		return lc;		
	}
	
	@Override
	public void updateColorDelete(String id) {
		String sql = " update t_company set colorImg =  '' where id=" + id  ;
		companyDao.executeUpdate(sql);
	}
	
	@Override
	public Grid search(Map map, String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public UserServiceI getUserService() {
		return userService;
	}
	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}
}
