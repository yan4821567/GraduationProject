package com.lee.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.lee.net.DbConn;
import com.lee.view.OrderVo;
import com.lee.view.SellView;

public class OrderModel {
	public void insertOrder(OrderVo ov){
		PreparedStatement ps=null;
		String sql="insert into orders(order_discount,order_table," +
				"order_count,order_cost,order_start,order_end) values(?,?,?,?,?,?)";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setDouble(1,ov.getDiscount());
			ps.setInt(2,ov.getTable());
			ps.setInt(3, ov.getCount());
			ps.setDouble(4, ov.getCost());
			ps.setTimestamp(5,new Timestamp(ov.getStart().getTime()));
			ps.setTimestamp(6,new Timestamp(ov.getEnd().getTime()));
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			closeTool(ps);
		}
	}
	
	public void deleteOrder(int id){
		PreparedStatement ps=null;
		String sql="delete from orders where order_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
	}
	/*
	 * 不允许改账单的时间
	 */
	public void updateOrder(OrderVo ov){
		PreparedStatement ps=null;
		String sql="update orders set order_discount=?,order_table=?,order_count=?,order_cost=?," +
				"order_end=? where order_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setDouble(1, ov.getDiscount());
			ps.setInt(2, ov.getTable());
			ps.setInt(3, ov.getCount());
			ps.setDouble(4, ov.getCost());
			ps.setTimestamp(5,new Timestamp(ov.getEnd().getTime()));
			ps.setInt(6, ov.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
	}
	
	public List<OrderVo> selectOrders(){
		List<OrderVo> li=new ArrayList<OrderVo>();
		PreparedStatement ps=null;
		String sql="select order_id ,order_discount,order_table,order_count," +
				"order_cost,order_start,order_end from orders";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				OrderVo ov=new OrderVo();
				ov.setId(rs.getInt(1));
				ov.setDiscount(rs.getDouble(2));
				ov.setTable(rs.getInt(3));
				ov.setCount(rs.getInt(4));
				ov.setCost(rs.getDouble(5));
				ov.setStart(rs.getTimestamp(6));
				ov.setEnd(rs.getTimestamp(7));
				li.add(ov);
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
	
	public OrderVo selectOneOrder(int id){
		OrderVo ov=new OrderVo();
		PreparedStatement ps=null;
		String sql="select order_discount,order_table,order_count," +
				"order_cost,order_start,order_end from orders where order_id=?";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				ov.setId(id);
				ov.setDiscount(rs.getDouble(1));
				ov.setTable(rs.getInt(2));
				ov.setCount(rs.getInt(3));
				ov.setCost(rs.getDouble(4));
				ov.setStart(rs.getTimestamp(5));
				ov.setEnd(rs.getTimestamp(6));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		
		return ov;
	}
	public OrderVo selectOrderByTid(int tid){
		OrderVo ov=new OrderVo();
		PreparedStatement ps=null;
		String sql="select order_id,order_discount,order_table,order_count," +
				"order_cost,order_start,order_end from orders where order_table=?";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, tid);
			rs=ps.executeQuery();
			while(rs.next()){
				ov.setId(rs.getInt(1));
				ov.setDiscount(rs.getDouble(2));
				ov.setTable(rs.getInt(3));
				ov.setCount(rs.getInt(4));
				ov.setCost(rs.getDouble(5));
				ov.setStart(rs.getTimestamp(6));
				ov.setEnd(rs.getTimestamp(7));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return ov;
	}
	public SellView selectByTime(String dateStart,String dateEnd){
		SellView sv=new SellView();
		String sql="select count(order_id),sum(order_count),sum(order_cost) " +
				"from orders where order_start between '"+dateStart+ "' and '"+dateEnd+"'"; 
		Statement sm=null;
		ResultSet rs=null;
		try {
			sm=DbConn.getConn().createStatement();
			rs=sm.executeQuery(sql);
			while(rs.next()){
				sv.setIdCount(rs.getInt(1));
				sv.setPeopleSum(rs.getInt(2));
				sv.setCostSum(rs.getDouble(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				sm.close();
				DbConn.closeConn();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return sv;
	}
	//不了解什么原因不好使
	public SellView FallselectByTime(String dateStart,String dateEnd){
		SellView sv=new SellView();
		String sql="select count(order_id),sum(order_count),sum(order_cost) " +
				"from orders where order_start between ? and ?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		long ds=0;
		long de=0;
		try {
			ds=sdf.parse(dateStart).getTime();
			de=sdf.parse(dateEnd).getTime();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			ps=DbConn.getConn().prepareStatement(sql);
//			ps.setTimestamp(1, new Timestamp(ds));
//			ps.setTimestamp(2, new Timestamp(de));
			ps.setDate(1, new java.sql.Date(ds));
			ps.setDate(2, new java.sql.Date(de));
			rs=ps.executeQuery();
			while(rs.next()){
				sv.setIdCount(rs.getInt(1));
				sv.setPeopleSum(rs.getInt(2));
				sv.setCostSum(rs.getDouble(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				closeTool(ps);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return sv;
	}
	public void closeTool(PreparedStatement ps){
		try {
			ps.close();
			DbConn.closeConn();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		String dates="2016-3-10";
		String datee="2016-5-1";
		SellView sv=new SellView();
		sv=new OrderModel().selectByTime(dates, datee);
		System.out.println(sv.getCostSum()+","+sv.getIdCount()+","+sv.getPeopleSum());
	}
}
