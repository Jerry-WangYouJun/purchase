package com.saki.entity;

public class Notice implements java.io.Serializable{
	
	private String  key ;
	
	private String msg = "";
	
	private Object obj = null;

	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}
