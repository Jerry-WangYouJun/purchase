package com.saki.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.apache.commons.lang.StringUtils;

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
	 public static void main(String[] args) {
		System.out.println(round(10.5545, 2));
	}
	 private static final Integer DEF_DIV_SCALE = 2;

	    /**
	     * 提供精确的加法运算。
	     *
	     * @param value1 被加数
	     * @param value2 加数
	     * @return 两个参数的和
	     */
	    public static Double add(Double value1, Double value2) {
	    		if(value2 == null ) {
	    			value2 = 0.0;
	    		}
	    		if(value1 == null ) {
	    			value1 = 0.0;
	    		}
	        BigDecimal b1 = new BigDecimal(Double.toString(value1));
	        BigDecimal b2 = new BigDecimal(Double.toString(value2));
	        return b1.add(b2).doubleValue();
	    }

	    /**
	     * 提供精确的减法运算。
	     *
	     * @param value1 被减数
	     * @param value2 减数
	     * @return 两个参数的差
	     */
	    public static double sub(Double value1, Double value2) {
		    	if(value2 == null ) {
	    			value2 = 0.0;
	    		}
	    		if(value1 == null ) {
	    			value1 = 0.0;
	    		}
	        BigDecimal b1 = new BigDecimal(Double.toString(value1));
	        BigDecimal b2 = new BigDecimal(Double.toString(value2));
	        return b1.subtract(b2).doubleValue();
	    }

	    /**
	     * 提供精确的乘法运算。
	     *
	     * @param value1 被乘数
	     * @param value2 乘数
	     * @return 两个参数的积
	     */
	    public static Double mul(Double value1, Double value2) {
		    	if(value2 == null ) {
	    			value2 = 0.0;
	    		}
	    		if(value1 == null ) {
	    			value1 = 0.0;
	    		}
	        BigDecimal b1 = new BigDecimal(Double.toString(value1));
	        BigDecimal b2 = new BigDecimal(Double.toString(value2));
	        return b1.multiply(b2).doubleValue();
	    }

	    /**
	     * 提供（相对）精确的除法运算，当发生除不尽的情况时， 精确到小数点以后10位，以后的数字四舍五入。
	     *
	     * @param dividend 被除数
	     * @param divisor  除数
	     * @return 两个参数的商
	     */
	    public static Double divide(Double dividend, Double divisor) {
	        return divide(dividend, divisor, DEF_DIV_SCALE);
	    }

	    /**
	     * 提供（相对）精确的除法运算。 当发生除不尽的情况时，由scale参数指定精度，以后的数字四舍五入。
	     *
	     * @param dividend 被除数
	     * @param divisor  除数
	     * @param scale    表示表示需要精确到小数点以后几位。
	     * @return 两个参数的商
	     */
	    public static Double divide(Double dividend, Double divisor, Integer scale) {
	        if (scale < 0) {
	            throw new IllegalArgumentException("The scale must be a positive integer or zero");
	        }
	        BigDecimal b1 = new BigDecimal(Double.toString(dividend));
	        BigDecimal b2 = new BigDecimal(Double.toString(divisor));
	        return b1.divide(b2, scale,RoundingMode.HALF_UP).doubleValue();
	    }

	    /**
	     * 提供指定数值的（精确）小数位四舍五入处理。
	     *
	     * @param value 需要四舍五入的数字
	     * @param scale 小数点后保留几位
	     * @return 四舍五入后的结果
	     */
	    public static double round(double value,int scale){
	        if(scale<0){
	            throw new IllegalArgumentException("The scale must be a positive integer or zero");
	        }
	        BigDecimal b = new BigDecimal(Double.toString(value));
	        BigDecimal one = new BigDecimal("1");
	        return b.divide(one,scale, RoundingMode.HALF_UP).doubleValue();
	    }
	   
	    /**
	     * 从字符串中提取汉字
	     * @param str
	     */
		public static Integer getNumFromString(String str) {
			str = str.trim();
			String str2 = "";
			if (str != null && !"".equals(str)) {
				for (int i = 0; i < str.length(); i++) {
					if (str.charAt(i) >= 48 && str.charAt(i) <= 57) {
						str2 += str.charAt(i);
					}else{
						break;
					}
				}
			}
			return  StringUtils.isNotBlank(str2)?Integer.valueOf(str2):null;
		}

}  
