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
@WebServlet("/resetPassword")
public class reset extends HttpServlet {
            @Override
            protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            	EmployeeDAO EDAO=new EmployeeImplementation();
            	HttpSession session=req.getSession();
            	Employee e=(Employee)session.getAttribute("Employee");
            	if(e.getPassword().equals(req.getParameter("currentPassword"))) {
            		if(req.getParameter("newPassword").equals(req.getParameter("confirmPassword"))) {
            			e.setPassword(req.getParameter("confirmPassword"));
            			EDAO.updateEmployee(e);
            			req.setAttribute("success", "updated Successfully");
            			RequestDispatcher rd=req.getRequestDispatcher("dashboard.jsp");
            			rd.forward(req, resp);
            		}
            		else {
            			req.setAttribute("error", "Password mismatch");
            			RequestDispatcher rd=req.getRequestDispatcher("reset.jsp");
            			rd.forward(req, resp);
            		}
            	}
            	else {
            		req.setAttribute("error", "Enter correct current Password");
        			RequestDispatcher rd=req.getRequestDispatcher("reset.jsp");
        			rd.forward(req, resp);
            	}
            }
}
