package com.lee.ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lee.model.CustomerModel;
import com.lee.view.CustomerVo;

public class CustomerCtrl extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CustomerCtrl() {
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
		doPost(request,response);
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
		if("insert".equals(action)){
			CustomerModel cm=new CustomerModel();
			CustomerVo cv=new CustomerVo();
			String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");
//			String name=request.getParameter("name");
			int age=Integer.valueOf(request.getParameter("age"));
			int gender=Integer.valueOf(request.getParameter("gender"));
			String tel=request.getParameter("tel");
			String interest=request.getParameter("interest");
			cv.setAge(age);cv.setName(name);cv.setGender(gender);
			cv.setInterest(interest);cv.setTel(tel);
			cm.insertCustomer(cv);
			response.sendRedirect("customerlist.jsp");
		}
		else if("delete".equals(action)){
			CustomerModel cm=new CustomerModel();
			int id=Integer.valueOf(request.getParameter("id"));
			cm.deleteCustomer(id);
			response.sendRedirect("customerlist.jsp");
		}
		else if("updateshow".equals(action)){
			CustomerModel cm=new CustomerModel();
			int id=Integer.valueOf(request.getParameter("id"));
			CustomerVo cv=cm.selectOneCustomer(id);
			request.setAttribute("cv", cv);
			request.getRequestDispatcher("updatecustomer.jsp").forward(request, response);
		}
		else if("update".equals(action)){
			CustomerModel cm=new CustomerModel();
			int id=Integer.valueOf(request.getParameter("id"));
			CustomerVo cv=cm.selectOneCustomer(id);
			String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");
			int age=Integer.valueOf(request.getParameter("age"));
			int gender=Integer.valueOf(request.getParameter("gender"));
			String tel=request.getParameter("tel");
			String interest=request.getParameter("interest");
			cv.setAge(age);cv.setName(name);cv.setGender(gender);
			cv.setInterest(interest);cv.setTel(tel);
			cm.updateWorker(cv);
			response.sendRedirect("customerlist.jsp");
		}
		else if("selectseat".equals(action)){
			CustomerModel cm=new CustomerModel();
			int id=Integer.valueOf(request.getParameter("id"));
			CustomerVo cv=cm.selectOneCustomer(id);
			int area=cm.selectSeatCos(cv);
			request.setAttribute("area", area);
			request.setAttribute("cv", cv);
			request.getRequestDispatcher("customerseat.jsp").forward(request, response);
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
