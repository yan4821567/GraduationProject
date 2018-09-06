package com.lee.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lee.net.DbConn;
import com.lee.view.WorkerVo;

public class WorkerModel {
	public void insertWorker(WorkerVo wv){
		PreparedStatement ps=null;
		String sql="insert into workers" +
				"(worker_name,worker_gender,worker_age,worker_tel,worker_role,worker_privilege,worker_password) " +
				"values(?,?,?,?,?,?,?)";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setString(1, wv.getName());
			ps.setInt(2, wv.getGender());
			ps.setInt(3, wv.getAge());
			ps.setString(4, wv.getTel());
			ps.setInt(5,wv.getRole());
			ps.setInt(6,wv.getPrivilege());
			ps.setString(7, wv.getPassword());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			try {
				closeTool(ps);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void deleteWorker(int id){
		PreparedStatement ps=null;
		String sql="delete from workers where worker_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			try {
				closeTool(ps);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void updateWorker(WorkerVo wv){
		PreparedStatement ps=null;
		String sql="update workers set worker_name=?,worker_gender=?," +
				"worker_age=?,worker_tel=?,worker_role=?,worker_privilege=?," +
				"worker_password=? where worker_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setString(1, wv.getName());
			ps.setInt(2, wv.getGender());
			ps.setInt(3, wv.getAge());
			ps.setString(4, wv.getTel());
			ps.setInt(5,wv.getRole());
			ps.setInt(6,wv.getPrivilege());
			ps.setString(7, wv.getPassword());
			ps.setInt(8, wv.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			try {
				closeTool(ps);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public List<WorkerVo> selectWorkers(){
		List<WorkerVo> li=new ArrayList<WorkerVo>();
		PreparedStatement ps=null;
		String sql="select worker_id,worker_name,worker_gender,worker_age," +
				"worker_tel,worker_role,worker_privilege,worker_password from workers";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				WorkerVo wv=new WorkerVo();
				wv.setId(rs.getInt(1));
				wv.setName(rs.getString(2));
				wv.setGender(rs.getInt(3));
				wv.setAge(rs.getInt(4));
				wv.setTel(rs.getString(5));
				wv.setRole(rs.getInt(6));
				wv.setPrivilege(rs.getInt(7));
				wv.setPassword(rs.getString(8));
				li.add(wv);
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
		return li;		
	}
	
	public WorkerVo selectOneWorker(int id){
		WorkerVo wv=new WorkerVo();
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select worker_name,worker_password,worker_gender,worker_age,worker_tel,worker_role," +
				"worker_privilege from workers where worker_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				wv.setId(id);
				wv.setName(rs.getString(1));
				wv.setPassword(rs.getString(2));
				wv.setGender(rs.getInt(3));
				wv.setAge(rs.getInt(4));
				wv.setTel(rs.getString(5));
				wv.setRole(rs.getInt(6));
				wv.setPrivilege(rs.getInt(7));
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
		return wv;
	}
	
	public boolean verifyWorker(WorkerVo wv){
		boolean b=false;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String password=null;
		int role;
		String sql="select worker_password,worker_role from workers where worker_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, wv.getId());
			rs=ps.executeQuery();
			while(rs.next()){
				password=rs.getString(1);
				role=rs.getInt(2);
			}
			if(wv.getPassword().equals(password)){
				b=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return b;
	}
	
	public void closeTool(PreparedStatement ps) throws SQLException{
		ps.close();
		DbConn.closeConn();
	}
	

}

