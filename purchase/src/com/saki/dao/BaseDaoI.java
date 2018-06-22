package com.saki.dao;

import java.util.List;
import java.util.Map;

public interface BaseDaoI<T> {
	
	public java.io.Serializable save(T o);
	
	public T get(String hql);
	
	public T get(String hql, Map<String, Object> params);
	
	public void delete(T o);
	
	public void deleteTree(String id);
	
	public void update(T o);
	
	public void saveOrUpdate(T o);
	
	public List<T> find(String hql);
	
	public List<T> find(String hql, Map<String, Object> params);
	
	public List<T> find(String hql, int page, int rows);
	
	public List<T> find(String hql, Map<String, Object> params, int page, int rows);
	
	public List<T> find(String hql,int number);
	
	public int count(String hql);
	
	public Long count(String hql, Map<String, Object> params);

	public int deleteSupDetailById(String orderId, String detailId);

	public void updateHql(String hql);
	
}
