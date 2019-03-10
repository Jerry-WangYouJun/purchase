package com.saki.service;

import java.util.List;

import com.saki.model.TConfirm;

public interface ConfirmServiceI{
	public List<TConfirm> list();
	public void save(TConfirm record);
	public void delete(int id);
	public void update(TConfirm confirm);
	public List<TConfirm> getWarningList(int start , int end);
}
