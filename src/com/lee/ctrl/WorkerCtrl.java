package com.lee.ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lee.model.WorkerModel;
import com.lee.view.WorkerVo;

public class WorkerCtrl extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public WorkerCtrl() {
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
		if("login".equals(action)){
			WorkerModel wm=new WorkerModel();
			WorkerVo wv=new WorkerVo();
			wv.setId(Integer.valueOf(request.getParameter("id")));
			wv.setPassword(request.getParameter("password"));
			if(wm.verifyWorker(wv)){
				HttpSession hs=request.getSession();
				wv=wm.selectOneWorker(wv.getId());
				hs.setAttribute("worker_name",wv.getName());
				response.sendRedirect("index.jsp");
			}
			else{
				response.sendRedirect("login.jsp");
			}
		}
		else if("updateshow".equals(action)){
			int id=Integer.valueOf(request.getParameter("id"));
			WorkerModel wm=new WorkerModel();
			WorkerVo wv=wm.selectOneWorker(id);
			request.setAttribute("wv", wv);
			request.getRequestDispatcher("oneworker.jsp").forward(request, response);
		}
		else if("update".equals(action)){
			int id=Integer.valueOf(request.getParameter("id"));
			String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");
			int age=Integer.valueOf(request.getParameter("age"));
			String tel=request.getParameter("tel");
			String password=request.getParameter("password");
			int gender=Integer.valueOf(request.getParameter("gender"));
			WorkerModel wm=new WorkerModel();
			WorkerVo wv=wm.selectOneWorker(id);
			wv.setName(name);wv.setAge(age);wv.setGender(gender);
			wv.setTel(tel);wv.setPassword(password);
			wm.updateWorker(wv);
			response.sendRedirect("workerlist.jsp");
		}
		else if("insert".equals(action)){
			String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");
			int age=Integer.valueOf(request.getParameter("age"));
			String tel=request.getParameter("tel");
			String password=request.getParameter("password");
			int gender=Integer.valueOf(request.getParameter("gender"));
			WorkerModel wm=new WorkerModel();
			WorkerVo wv=new WorkerVo();
			wv.setAge(age);wv.setGender(gender);wv.setName(name);wv.setPassword(password);
			wv.setPrivilege(2);wv.setRole(2);wv.setTel(tel);
			wm.insertWorker(wv);
			response.sendRedirect("workerlist.jsp");
		}
		else if("delete".equals(action)){
			int id=Integer.valueOf(request.getParameter("id"));
			WorkerModel wm=new WorkerModel();
			wm.deleteWorker(id);
			response.sendRedirect("workerlist.jsp");
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
