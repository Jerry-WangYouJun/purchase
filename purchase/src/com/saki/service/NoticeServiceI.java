package com.saki.service;

import java.util.List;

import com.saki.model.TNotice;

public interface NoticeServiceI{
	public List<TNotice> list();
	public void save(TNotice record);
	public void delete(int id);
	public void update(TNotice confirm);
}
