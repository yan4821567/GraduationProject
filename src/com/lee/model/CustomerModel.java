package com.lee.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.lee.net.DbConn;
import com.lee.view.CustomerVo;

public class CustomerModel {
	public void insertCustomer(CustomerVo cv){
		PreparedStatement ps=null;
		String sql="insert into customers(customer_name,customer_gender,customer_age," +
				"customer_tel,customer_interest) values(?,?,?,?,?)";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setString(1, cv.getName());
			ps.setInt(2, cv.getGender());
			ps.setInt(3, cv.getAge());
			ps.setString(4, cv.getTel());
			ps.setString(5, cv.getInterest());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
				closeTool(ps);
		}
	}
	
	public void deleteCustomer(int id){
		PreparedStatement ps=null;
		String sql="delete from customers where customer_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
				closeTool(ps);
		}
	}
	
	public void updateWorker(CustomerVo cv){
		PreparedStatement ps=null;
		String sql="update customers set customer_name=?,customer_gender=?," +
				"customer_age=?,customer_tel=?,customer_interest=? where customer_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setString(1, cv.getName());
			ps.setInt(2, cv.getGender());
			ps.setInt(3, cv.getAge());
			ps.setString(4, cv.getTel());
			ps.setString(5, cv.getInterest());
			ps.setInt(6, cv.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
				closeTool(ps);
		}
	}
	
	public List<CustomerVo> selectCustomers(){
		List<CustomerVo> li=new ArrayList<CustomerVo>();
		PreparedStatement ps=null;
		String sql="select customer_id ,customer_name,customer_gender,customer_age," +
				"customer_tel,customer_interest from customers";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				CustomerVo cv=new CustomerVo();
				cv.setId(rs.getInt(1));
				cv.setName(rs.getString(2));
				cv.setGender(rs.getInt(3));
				cv.setAge(rs.getInt(4));
				cv.setTel(rs.getString(5));
				cv.setInterest(rs.getString(6));
				li.add(cv);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				closeTool(ps);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return li;		
	}
	
	public CustomerVo selectOneCustomer(int id){
		CustomerVo cv=new CustomerVo();
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select customer_name,customer_gender,customer_age," +
				"customer_tel,customer_interest from customers where customer_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				cv.setId(id);
				cv.setName(rs.getString(1));
				cv.setGender(rs.getInt(2));
				cv.setAge(rs.getInt(3));
				cv.setTel(rs.getString(4));
				cv.setInterest(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				closeTool(ps);
			
		}
		return cv;
	}
	
	public void closeTool(PreparedStatement ps) {
		try {
			ps.close();
			DbConn.closeConn();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * 利用相似度算法选座，输入数据为客户对象。
	 */
	public int selectSeatCos(CustomerVo cv){
		int area=0;
		char interest[]=cv.getInterest().toCharArray();
		Vector<Integer> hobby=new Vector<Integer>(interest.length);
		for (int i = 0; i < interest.length; i++) {
			hobby.add(interest[i]-48);
		}
		//顺序为川菜、冷饮、粤菜、甜点、日本料理、水果
		Vector<Integer> A=new Vector<Integer>(6);//A区川菜、冷饮
		A.add(1);A.add(1);A.add(0);A.add(0);A.add(0);A.add(0);
		Vector<Integer> B=new Vector<Integer>(6);//B区粤菜、甜点
		B.add(0);B.add(0);B.add(1);B.add(1);B.add(0);B.add(0);
		Vector<Integer> C=new Vector<Integer>(6);//C区日本料理、水果
		C.add(0);C.add(0);C.add(0);C.add(0);C.add(1);C.add(1);
		if(Math.max(cosine(hobby,A),Math.max(cosine(hobby,B), cosine(hobby,C)))==cosine(hobby,A)){
			area=1;
		}
		else if(Math.max(cosine(hobby,A),Math.max(cosine(hobby,B), cosine(hobby,C)))==cosine(hobby,B)){
			area=2;
		}
		else{
			area=3;
		}
		return area;
	}
	/*
	 * 计算余弦定理，即相似度计算
	 */
	public double cosine(Vector<Integer> X,Vector<Integer> Y){
		double x_sum=0,y_sum=0,result=0;
		double dot_product=0;  //向量的数量积
		double x_norm=0,y_norm=0; //向量的模
		//计算X,Y向量的模，以及数量积
		for (int i = 0; i < X.size(); i++) {
			x_sum+=X.elementAt(i);
			y_sum+=Y.elementAt(i);
			dot_product+=X.elementAt(i)*Y.elementAt(i);
		}
		x_norm=Math.sqrt(x_sum);
		y_norm=Math.sqrt(y_sum);
		//两向量进行余弦定理运算的结果
		result=dot_product/(x_norm*y_norm);
		return result;
	}
	public static void main(String[] args) {
		Vector<Integer> X=new Vector<Integer>(6);//客户X
		X.add(1);X.add(1);X.add(1);X.add(0);X.add(0);X.add(0);
		Vector<Integer> A=new Vector<Integer>(6);//A区川菜、冷饮
		A.add(1);A.add(1);A.add(0);A.add(0);A.add(0);A.add(0);
		Vector<Integer> B=new Vector<Integer>(6);//B区粤菜、甜点
		B.add(0);B.add(0);B.add(1);B.add(1);B.add(0);B.add(0);
		System.out.println("X="+X+" A="+A+"通过余弦定理计算的结果为：");
		System.out.println(new CustomerModel().cosine(X, A));
		System.out.println("X="+X+" B="+B+"通过余弦定理计算的结果为：");
		System.out.println(new CustomerModel().cosine(X, B));
	}

}
