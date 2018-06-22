package com.saki.service;

import com.saki.model.TUser;

public interface UserServiceI extends BaseServiceI{
	public TUser login(TUser user);
	public TUser getByCompanyId(int companyId);
	public void deleteByCompanyId(Integer id);
}
