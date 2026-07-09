package com.servlet;

import java.io.IOException;

import com.dao.impl.EmployeeImplementation;
import com.dao.inf.EmployeeDAO;
import com.dto.Employee;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/login")

public class Login extends HttpServlet{
            @Override
            protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            	 EmployeeDAO ED=new EmployeeImplementation();            	
//            	 String email=req.getParameter("mail");
//            	 String password=req.getParameter("password");
            	Employee e=ED.findByMailAndPassword(
            			req.getParameter("mail"),
            			req.getParameter("password")
            			);
            	
            	 if(e!=null) {
            		 HttpSession session=req.getSession();            		 
            		 session.setAttribute("Employee", e);
            		resp.sendRedirect("dashboard.jsp");
            	 }
            	 else {
            		 req.setAttribute("success", "Account Not Found");
            		 RequestDispatcher rd=req.getRequestDispatcher("login.jsp");          		 
            		 rd.forward(req, resp);
            	 }
            	   
            }
}
