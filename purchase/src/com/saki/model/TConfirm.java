package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TConfirm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_confirm", catalog = "order")

public class TConfirm implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer confirmDate;
	private String remark;
	private String remark2;
	
	// Constructors

	/** default constructor */
	public TConfirm() {
	}

	/** full constructor */
	public TConfirm(String remark, String remark2, Integer confirmDate) {
		this.confirmDate = confirmDate;
		this.remark2 = remark2;
		this.remark = remark;
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
	
	@Column(name="confirmDate" , length=2)

	public Integer getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(Integer confirmDate) {
		this.confirmDate = confirmDate;
	}

	@Column(name="remark" , length=10)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name="remark2" , length=10)
	public String getRemark2() {
		return remark2;
	}

	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}

	
}