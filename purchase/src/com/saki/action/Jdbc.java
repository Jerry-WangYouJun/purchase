package com.saki.action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Jdbc {
	  public static void main(String[] args) throws ClassNotFoundException, SQLException {
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection conn  = DriverManager.getConnection("jdbc:mysql://localhost:3306/order?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull","root","123");
		    String sql = "select" + 
		    		"        tproduct0_.id as id3_," + 
		    		"        tproduct0_.base as base3_," + 
		    		"        tproduct0_.product as product3_," + 
		    		"        tproduct0_.remark as remark3_," + 
		    		"        tproduct0_.type as type3_," + 
		    		"        tproduct0_.unit as unit3_ " + 
		    		"    from" + 
		    		"        order.t_product tproduct0_ " + 
		    		"    where" + 
		    		"        tproduct0_.product='焊丝'" + 
		    		"" ;
		    PreparedStatement ps = conn.prepareStatement(sql);
		    ResultSet rs = ps.executeQuery();
		    
		    while(rs.next()) {
		    	    String type = rs.getString("type3_");
		    	    System.out.println(type);
		    }
	}
}
