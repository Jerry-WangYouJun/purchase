package com.saki.service;

import java.io.InputStream;

public interface ImportExcelI {
	public  void getListByExcel(InputStream in,String fileName  , String fileType) throws Exception;

	public void updateFormat();
}
