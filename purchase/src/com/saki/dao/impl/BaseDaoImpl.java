
package com.saki.dao.impl;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saki.dao.BaseDaoI;
import com.saki.model.TProductDetail;
import com.saki.model.TSupllierOrder;

@Repository("baseDao")
public class BaseDaoImpl<T> implements BaseDaoI<T> {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(BaseDaoImpl.class);

	private SessionFactory sessionFactory;
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	private Session getCurrentSession(){
		return this.sessionFactory.getCurrentSession();
	}
	
	@Override
	public Serializable save(T o) {
		return this.getCurrentSession().save(o);
	}

	@Override
	public T get(String hql) {
		Query q = this.getCurrentSession().createQuery(hql);
		List<T> l = q.list();
		if(l!=null && l.size()>0){
			return l.get(0);
		}
		return null;
	}

	@Override
	public T get(String hql, Map<String, Object> params) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		List<T> l = q.list();
		if (l != null && l.size() > 0) {
			return l.get(0);
		}
		return null;
	}

	@Override
	public void delete(T o) {
		this.getCurrentSession().delete(o);
	}

	@Override
	public void update(T o) {
		this.getCurrentSession().update(o);
	}

	@Override
	public void saveOrUpdate(T o) {
		this.getCurrentSession().saveOrUpdate(o);
	}

	@Override
	public List<T> find(String hql) {
		Query q = this.getCurrentSession().createQuery(hql);
		return q.list();
	}

	@Override
	public List<T> find(String hql, Map<String, Object> params) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return q.list();
	}
	
	//批量执行in语句 （  in (:list)）
	@Override
	public List<T> find(String hql, List<Object> list) {
		Query q = this.getCurrentSession().createQuery(hql);
		 q.setParameterList("list", list);
		return q.list();
	}

	@Override
	public List<T> find(String hql, Map<String, Object> params, int page,
			int rows) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return q.setFirstResult((page-1)*rows).setMaxResults(rows).list();
	}

	@Override
	public List<T> find(String hql, int page, int rows) {
		Query q = this.getCurrentSession().createQuery(hql);
		return q.setFirstResult((page-1)*rows).setMaxResults(rows).list();
	}

	@Override
	public int count(String hql) {
		Query q = this.getCurrentSession().createQuery(hql);
		
		return q.list().size();
	}

	@Override
	public Long count(String hql, Map<String, Object> params) {
		Query q = this.getCurrentSession().createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return (Long)q.uniqueResult();
	}

	@Override
	public void deleteTree(String id) {
		this.getCurrentSession().createQuery("delete from Tunit t where t.id = " + id).executeUpdate();
	}
	

	@Override
	public List<T> find(String hql, int number) {
		Query q=this.getCurrentSession().createQuery(hql);
		return q.setMaxResults(number).list();
	}

	@Override
	public int deleteSupDetailById(String orderId, String detailId) {
		return this.getCurrentSession().createQuery("delete from TSupllierOrderDetail t where t.id = "
					+ detailId + " and t.supllierOrderId = " + orderId  + "and t.status = '2'").executeUpdate();
		
	}

	@Override
	public void updateHql(String hql) {
		 this.getCurrentSession().createQuery(hql).executeUpdate();
	
	}
	
	@Override
	public void  executeUpdate(String sql){
		 this.getCurrentSession().createSQLQuery(sql).executeUpdate();
	}

	@Override
	public List executeSQLquery(String sql) {
		List<Object[]> list = this.getCurrentSession().createSQLQuery(sql).list();  
        return list; 
	}

	@Override
	public void updateSubpro(List<TProductDetail> list) {
		for (TProductDetail tProductDetail : list) {
			getSessionFactory().getCurrentSession().evict(tProductDetail);
			String subPro = tProductDetail.getSubProduct()  ;
			if(StringUtils.isNotBlank(tProductDetail.getMaterial()) ){
				subPro +=  "-" +  tProductDetail.getMaterial()  ;
			}
			if(tProductDetail.getFormatNum() != null ){
				subPro += "-" + tProductDetail.getFormatNum() + tProductDetail.getFormat();
			}
			tProductDetail.setSubProduct(subPro);
			
		}
	}
	

}
