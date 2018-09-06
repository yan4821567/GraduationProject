package com.lee.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lee.net.DbConn;
import com.lee.view.ProductVo;

public class ProductModel {
	public void insertProduct(ProductVo pv){
		PreparedStatement ps=null;
		String sql="insert into products(product_name,product_type," +
				"product_count,product_price) values(?,?,?,?)";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setString(1, pv.getName());
			ps.setInt(2, pv.getType());
			ps.setInt(3, pv.getCount());
			ps.setDouble(4, pv.getPrice());
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
	}
	public void deleteProduct(int id){
		PreparedStatement ps=null;
		String sql="delete from products where product_id=?";
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
	public void updateProduct(ProductVo pv){
		PreparedStatement ps=null;
		String sql="update products set product_name=?,product_type=?,product_count=?,product_price=?," +
				"where product_id=?";
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setString(1, pv.getName());
			ps.setInt(2, pv.getType());
			ps.setInt(3, pv.getCount());
			ps.setDouble(4, pv.getPrice());
			ps.setInt(5, pv.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeTool(ps);
		}
	}
	public List<ProductVo> selectProducts(){
		List<ProductVo> li=new ArrayList<ProductVo>();
		PreparedStatement ps=null;
		String sql="select product_id,product_name,product_type,product_count,product_price " +
				"from products";
		ResultSet rs=null;
		ProductVo pv=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				pv=new ProductVo();
				pv.setId(rs.getInt(1));
				pv.setName(rs.getString(2));
				pv.setType(rs.getInt(3));
				pv.setCount(rs.getInt(4));
				pv.setPrice(rs.getDouble(5));
				li.add(pv);
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
	public ProductVo selectOneProduct(int id){
		ProductVo pv=new ProductVo();
		PreparedStatement ps=null;
		String sql="select product_name,product_type,product_count,product_price " +
				"from products where product_id=?";
		ResultSet rs=null;
		try {
			ps=DbConn.getConn().prepareStatement(sql);
			ps.setInt(1, id);
			rs=ps.executeQuery();
			while(rs.next()){
				pv.setName(rs.getString(1));
				pv.setType(rs.getInt(2));
				pv.setCount(rs.getInt(3));
				pv.setPrice(rs.getDouble(4));
				pv.setId(id);
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
	public void closeTool(PreparedStatement ps){
		try {
			ps.close();
			DbConn.closeConn();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
