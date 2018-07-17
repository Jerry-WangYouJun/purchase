package com.saki.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.saki.service.ProductServiceI;

public class TestSSH {
	
	//@Test
	public void test() throws Exception {
		
		ApplicationContext ac = new ClassPathXmlApplicationContext
				(new String[] { "classpath:spring.xml", "classpath:spring-hibernate.xml" });
		ProductServiceI productService = (ProductServiceI) ac.getBean("productService");
		
		productService.listAll();
		//EmailStmp stmp = new EmailStmp();
//		
//		System.out.println(stmp.getStmp("awerwaer@hotmail.com"));
		
		
		
		
//				
	}	
}
