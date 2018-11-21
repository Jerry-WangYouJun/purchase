package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * TUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_address", catalog = "order")

public class TAddress implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer cid;
	private String name;
	private String province;
	private String city;
	private String address;
	private String area;
	private String isDefault;
	// Constructors
	private TCompany company ;

	/** default constructor */
	public TAddress() {
	}

	/** full constructor */
	public TAddress(Integer cid, String name, String province, String city,
			String address, String area, String isDefault) {
		super();
		this.cid = cid;
		this.name = name;
		this.province = province;
		this.city = city;
		this.address = address;
		this.area = area;
		this.isDefault = isDefault;
	}

	public TAddress(Integer id, Integer cid, String name, String province,
			String city, String address, String area, String isDefault) {
		super();
		this.id = id;
		this.cid = cid;
		this.name = name;
		this.province = province;
		this.city = city;
		this.address = address;
		this.area = area;
		this.isDefault = isDefault;
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

	@Column(name = "cid" , nullable = false)
	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	@Column(name = "name" )
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "province" )
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	@Column(name = "city" )
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "address" )
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "area" )
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "is_default" )
	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	@Transient
	public TCompany getCompany() {
		return company;
	}

	public void setCompany(TCompany company) {
		this.company = company;
	}
	

}