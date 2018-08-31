package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "t_transport", catalog = "order")
public class TTransport implements java.io.Serializable{
	 private Integer id ;
	 private Integer orderid;
	 private String transname;
	 private String transno;
	 private String telphone;
	 private String driver;
	 private String driverphone;
	 private Double money;
	 private String payflag;
	 private String remark;
	 
	 private String orderName ;
	 
	 public TTransport() {
		 
	 }
	 
	public TTransport(Integer orderid, String transname, String transno , String telphone, String driver, String driverphone,
			Double money, String payflag, String remark) {
		super();
		this.orderid = orderid;
		this.transname = transname;
		this.transno = transno;
		this.telphone = telphone;
		this.driver = driver;
		this.driverphone = driverphone;
		this.money = money;
		this.payflag = payflag;
		this.remark = remark;
	}
	
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
	
	@Column(name="orderid",length = 11 )
	public Integer getOrderid() {
		return orderid;
	}
	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}
	@Column(name="transname" )
	public String getTransname() {
		return transname;
	}
	public void setTransname(String transname) {
		this.transname = transname;
	}
	@Column(name="telphone" )
	public String getTelphone() {
		return telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	@Column(name="driver" )
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	@Column(name="driverphone" )
	public String getDriverphone() {
		return driverphone;
	}
	public void setDriverphone(String driverphone) {
		this.driverphone = driverphone;
	}
	@Column(name="money" )
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	@Column(name="payflag" )
	public String getPayflag() {
		return payflag;
	}
	public void setPayflag(String payflag) {
		this.payflag = payflag;
	}
	@Column(name="remark" )
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Column(name = "transno")
	public String getTransno() {
		return transno;
	}

	public void setTransno(String transno) {
		this.transno = transno;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	 
	
}
