package com.lee.net;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * 数据库连接类
 */
public class DbConn {
	static Connection conn;
	public static Connection getConn() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/restaurant";
			conn=DriverManager.getConnection(url,"root","root");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void closeConn() throws SQLException{
		conn.close();
	}
	
	public static void main(String[] args) throws SQLException {
		System.out.println(getConn());
		closeConn();
	}
}
