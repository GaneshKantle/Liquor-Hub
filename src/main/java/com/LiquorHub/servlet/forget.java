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
@WebServlet("/forgetPassword")
public class forget extends HttpServlet{
             @Override
            protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            	// TODO Auto-generated method stub
            	EmployeeDAO EDAO=new EmployeeImplementation();
            	Employee e=EDAO.findbyMail(req.getParameter("email"));
            	if(e!=null) {
            		if(req.getParameter("password").equals(req.getParameter("cpassword"))){
            			e.setPassword(req.getParameter("password"));
            			EDAO.updateEmployee(e);
            			req.setAttribute("success1","Password updated Successfully");
            			RequestDispatcher rd=req.getRequestDispatcher("login.jsp");
            			rd.forward(req, resp);
            			
            		}
            		else {
            			req.setAttribute("error","Password mismatch");
            			RequestDispatcher rd=req.getRequestDispatcher("forget.jsp");
            			rd.forward(req, resp);
            			
            		}
            	}
            	
            	else {
            		req.setAttribute("error","user not found");
        			RequestDispatcher rd=req.getRequestDispatcher("forget.jsp");
        			rd.forward(req, resp);
            	}
            	
            }
}
