package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TCompany entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_company", catalog = "order")

public class TCompany implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String contacts;
	private String address;
	private String business;
	private String level;
	private String remark;

	private Integer roleId;
	private String userName;
	
	private String telphone;
	private String tax ;
	private String card;
	
	// Constructors

	/** default constructor */
	public TCompany() {
	}

	/** full constructor */
	public TCompany(String name, String contacts, String address, String business, 
			String level, String remark,String telphone ,String tax , String card) {
		this.name = name;
		this.contacts = contacts;
		this.address = address;
		this.business = business;
		this.level = level;
		this.remark = remark;
		this.telphone=telphone;
		this.tax=tax;
		this.card=card;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "id", unique = true, nullable = false)

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", length = 80)

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "contacts", length = 20)

	public String getContacts() {
		return this.contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	@Column(name = "address", length = 100)

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "business", length = 100)

	public String getBusiness() {
		return this.business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}

	@Column(name = "level", length = 10)

	public String getLevel() {
		return this.level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	@Column(name = "roleId")

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	@Column(name = "telphone", length = 20)
	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	@Column(name = "tax", length = 30)
	public String getTax() {
		return tax;
	}

	public void setTax(String tax) {
		this.tax = tax;
	}
	@Column(name = "card", length = 30)
	public String getCard() {
		return card;
	}

	
	public void setCard(String card) {
		this.card = card;
	}
	
	

}