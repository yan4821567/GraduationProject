package com.lee.model;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lee.net.DbConn;
import com.lee.view.TableVo;


public class TableModel{
	public void insertTable(TableVo tv){
		PreparedStatement ps=null;
		String sql="insert into tables(table_id,table_hasone,table_size,table_area) " +
				"values(?,?,?,?)";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1,tv.getId());
			ps.setBoolean(2, tv.isHasone());
			ps.setInt(3, tv.getSize());
			ps.setInt(4, tv.getArea());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
	}
	public void deleteTable(int id){
		PreparedStatement ps=null;
		String sql="delete from tables where table_id=?";
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
	public void updateTable(TableVo tv){
		PreparedStatement ps=null;
		String sql="update tables set table_id=?,table_hasone=?,table_size=?,table_area=? " +
				"where table_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, tv.getId());
			ps.setBoolean(2, tv.isHasone());
			ps.setInt(3, tv.getSize());
			ps.setInt(4, tv.getArea());
			ps.setInt(5, tv.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
	}
	public List<TableVo> selectTables(){
		List<TableVo> li=new ArrayList<TableVo>();
		PreparedStatement ps=null;
		String sql="select table_id,table_hasone,table_size,table_area from tables";
		ResultSet rs=null;
		TableVo tv=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				tv=new TableVo();
				tv.setId(rs.getInt(1));
				tv.setHasone(rs.getBoolean(2));
				tv.setSize(rs.getInt(3));
				tv.setArea(rs.getInt(4));
				li.add(tv);
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
	public TableVo selectOneTable(int id){
		TableVo pv=new TableVo();
		PreparedStatement ps=null;
		String sql="select table_id,table_hasone,table_size,table_area from tables where table_id=?";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				pv.setId(rs.getInt(1));
				pv.setHasone(rs.getBoolean(2));
				pv.setSize(rs.getInt(3));
				pv.setArea(rs.getInt(4));
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
		
		return pv;
	}
	public void updateSizeAndOne(TableVo tv){
		PreparedStatement ps=null;
		String sql="update tables set table_size=?,table_hasone=? where table_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, tv.getSize());
			ps.setBoolean(2, tv.isHasone());
			ps.setInt(3, tv.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
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
	}
}
