package com.saki.entity;

import java.util.ArrayList;
import java.util.List;

public class Grid implements java.io.Serializable{
	
	private int total = 0;
	private List rows = new ArrayList();
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
	
	
}
