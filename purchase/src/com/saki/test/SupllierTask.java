 package com.saki.test;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.saki.model.TConfirm;
import com.saki.service.ConfirmServiceI;
import com.saki.service.OrderServiceI;
import com.saki.service.SupllierOrderServiceI;

public class SupllierTask {
	//采用Spring框架的依赖注入
    @Autowired
    private SupllierOrderServiceI supllierOrderService;
     
    @Autowired
    private OrderServiceI orderServiceI ; 
    
    @Autowired
    private ConfirmServiceI confirmService ;
	
	/**
	 *   每月固定时间生成供应商订单， 生成供应商订单的同时，获取供应商订单与客户订单的关系表 
	 *   每种产品生成一条供应商详情 （状态为主数据），页面添加产品拆分功能：
	 *   	 拆分时，像数据库中插入一条复制的数据，添加状态为添加数据  
	 *   页面删除功能，删除数据时进行判断，如果删除的详情是唯一的则不能删除 
	 *   
	 *   
	 * 1. 生成供应商订单 ：   获取所有客户订单明细，一比一生成供应商订单，
	 * 
	 *        如果是需要重新生成订单，则先修改原供应商订单，设置为作废 再生成新的供应商订单
	 * 
	 */
    public void getSupllierOrder(){  
    		List<TConfirm> t = confirmService.getWarningList();
    		LocalDateTime currentTime = LocalDateTime.now();
    		 int day = currentTime.getDayOfMonth();
    		 for(TConfirm temp : t){
    			 int betweenDays =  temp.getConfirmDate() -  day ;
    			  if(betweenDays == 0 ){
	    				supllierOrderService.getSupllierOrder(temp.getId());
    			  }
    		 }
    }  
      
    
    /**
     * @param args
     */
    public static void main(String[] args) {
    	 // 获取当前的日期时间
        LocalDateTime currentTime = LocalDateTime.now();
        System.out.println("当前时间: " + currentTime);
          
        LocalDate date1 = currentTime.toLocalDate();
        System.out.println("date1: " + date1);
          
        Month month = currentTime.getMonth();
        int day = currentTime.getDayOfMonth();
        int seconds = currentTime.getSecond();
        int hour = currentTime.getHour();
          
        System.out.println("月: " + month +", 日: " + day +",时：" + hour + " 秒: " + seconds);
          
        LocalDateTime date2 = currentTime.withDayOfMonth(10).withYear(2012);
        System.out.println("date2: " + date2);
          
        // 12 december 2014
        LocalDate date3 = LocalDate.of(2014, Month.DECEMBER, 30);
        System.out.println("date3: " + date3);
          
        // 22 小时 15 分钟
        LocalTime date4 = LocalTime.of(22, 15);
        System.out.println("date4: " + date4);
          
        // 解析字符串
        LocalTime date5 = LocalTime.parse("20:15:30");
        System.out.println("date5: " + date5);
	}
}
