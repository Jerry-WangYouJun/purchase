package com.saki.utils;

import java.util.List;

public class SystemUtil {
    public  static String  getSystemName(){
    	String osName =  System.getProperty("os.name");
    	if(osName.toUpperCase().startsWith("MAC")) {
    		return "mac";
    	}else{
    		return"win";
    	}
    }
    

	public static String getOrderResult(List<Integer> list ) {
		if(list.size() > 0){
			if(list.get(0)==null) {
				 return "001";
			}
			String resultStr = list.get(0) + "";
			if(resultStr.length() ==1  ){
				resultStr = "00" + resultStr;
			}else if(resultStr.length() == 2 ){
				resultStr = "0" + resultStr;
			}
			 return  resultStr;
		}else {
			return "001";
		}
	}
}  
