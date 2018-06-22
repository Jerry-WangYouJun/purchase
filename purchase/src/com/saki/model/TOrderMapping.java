package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "t_order_mapping", catalog = "order")
public class TOrderMapping implements java.io.Serializable{
	   private Integer id;
	   private Integer orderId;
	   private Integer suppilerOrderId;
	   
	public TOrderMapping() {
		
	}
	
	public TOrderMapping(Integer orderId , Integer suppilerOrderId) {
		 this.orderId = orderId ; 
		 this.suppilerOrderId = suppilerOrderId;
	}
	   
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
	
	@Column(name = "order_id")
	   
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	
	@Column(name = "supllier_order_id")
	
	public Integer getSuppilerOrderId() {
		return suppilerOrderId;
	}
	public void setSuppilerOrderId(Integer suppilerOrderId) {
		this.suppilerOrderId = suppilerOrderId;
	}
	   
	   
}
