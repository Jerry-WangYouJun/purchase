package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "t_notice", catalog = "order")
public class TNotice {
	
	private Integer id ; 
	
	private String msg ; 
	
	private String flag;

	
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name="msg" , length=200)
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Column(name="flag" , length=2)
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public TNotice(Integer id, String msg, String flag) {
		super();
		this.id = id;
		this.msg = msg;
		this.flag = flag;
	}

	public TNotice(String msg, String flag) {
		super();
		this.msg = msg;
		this.flag = flag;
	}

	public TNotice() {
		super();
	}
	
	

}
