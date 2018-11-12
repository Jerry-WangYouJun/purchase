package com.saki.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.model.TNotice;
import com.saki.service.NoticeServiceI;
@Service
public class NoticeServiceImpl implements NoticeServiceI{

	private BaseDaoI noticeDao;
	


	public BaseDaoI getNoticeDao() {
		return noticeDao;
	}

	@Autowired
	public void setNoticeDao(BaseDaoI noticeDao) {
		this.noticeDao = noticeDao;
	}

	@Override
	public List<TNotice> list() {
		List<TNotice> l = noticeDao.find("from TNotice  ");
		return l;
	}

	@Override
	public void save(TNotice record) {
			noticeDao.save(record);
		
	}

	@Override
	public void delete(int id) {
		Map<String, Object> params = new HashMap<String, Object>();	
		params.put("id", id);
		TNotice t = (TNotice) noticeDao.get("from TNotice  t where t.id = :id", params);
		noticeDao.delete(t);
		
	}

	@Override
	public void update(TNotice notice) {
		noticeDao.update(notice);
	}




}
