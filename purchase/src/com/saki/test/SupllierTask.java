 package com.saki.test;

import org.springframework.beans.factory.annotation.Autowired;

import com.saki.service.OrderServiceI;
import com.saki.service.SupllierOrderServiceI;

public class SupllierTask {
	//采用Spring框架的依赖注入
    @Autowired
    private SupllierOrderServiceI supllierOrderService;
     
    @Autowired
    private OrderServiceI orderServiceI ; 
	
	/**
	 *   每月固定时间生成供应商订单， 生成供应商订单的同时，获取供应商订单与客户订单的关系表 
	 *   每种产品生成一条供应商详情 （状态为主数据），页面添加产品拆分功能：
	 *   	 拆分时，像数据库中插入一条复制的数据，添加状态为添加数据  
	 *   页面删除功能，删除数据时进行判断，如果删除的详情是唯一的则不能删除 
	 *   
	 *   
	 * 1. 生成供应商订单 ：   获取所有客户订单明细，一比一生成供应商订单，
	 * 2. 审核-如果是自动生成订单，则进行编辑-审核供应商订单；
	 *        如果是需要重新生成订单，则先修改原供应商订单，设置为作废 再生成新的供应商订单
	 * 
	 */
    public void getSupllierOrder(){  
    		supllierOrderService.getSupllierOrder();
    }  
      
    
}
