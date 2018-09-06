package com.lee.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lee.model.OrderModel;
import com.lee.model.TableModel;
import com.lee.view.OrderVo;
import com.lee.view.TableVo;
import com.sun.jmx.snmp.Timestamp;

public class TableCtrl extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TableCtrl() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		doPost(request, response);
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String action=request.getParameter("action");
		if("start".equals(action)){
			String sid=request.getParameter("id");
			int id=Integer.valueOf(sid);
			TableModel tm=new TableModel();
			TableVo tv=new TableVo();
			tv=tm.selectOneTable(id);
			request.setAttribute("tv", tv);
			request.getRequestDispatcher("tbform.jsp").forward(request, response);
		}
		else if("update".equals(action)){
			int id=Integer.valueOf(request.getParameter("id"));
			TableModel tm=new TableModel();
			TableVo tv=tm.selectOneTable(id);
			int size=Integer.valueOf(request.getParameter("size"));
			tv.setSize(Integer.valueOf(request.getParameter("size")));
			tv.setHasone(true);
			tm.updateSizeAndOne(tv);
			double discount=Double.valueOf(request.getParameter("discount"));
			int count=Integer.valueOf(request.getParameter("size"));
			OrderVo ov=new OrderVo();
			ov.setTable(id);ov.setDiscount(discount);
			if(discount!=0){
				ov.setCost(size*50*discount);
			}
			else{
				ov.setCost(size*50);
			}
			ov.setCount(size);ov.setStart(new Timestamp().getDate());
			ov.setEnd(new Timestamp().getDate());
			OrderModel om=new OrderModel();
			om.insertOrder(ov);
			response.sendRedirect("index.jsp");
		}
		else if("settle".equals(action)){
			int id=Integer.valueOf(request.getParameter("id"));
			TableModel tm=new TableModel();
			TableVo tv=tm.selectOneTable(id);
			request.setAttribute("id", id);
			request.getRequestDispatcher("settle.jsp").forward(request, response);
		}
		else if("settledone".equals(action)){
			int id=Integer.valueOf(request.getParameter("id"));
			TableModel tm=new TableModel();
			TableVo tv=tm.selectOneTable(id);//查出编号为id的桌
			OrderModel om=new OrderModel();
			tv.setArea(id/1000);
			tv.setId(id);tv.setSize(0);
			if(tv.isHasone()){
				OrderVo ov=om.selectOrderByTid(id);
				ov.setEnd(new Timestamp().getDate());
				om.updateOrder(ov);
			}
			tv.setHasone(false);
			tm.updateTable(tv);
			response.sendRedirect("index.jsp");
		}
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
