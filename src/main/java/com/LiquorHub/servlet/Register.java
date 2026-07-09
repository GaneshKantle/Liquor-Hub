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
@WebServlet("/register")
public class Register extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EmployeeDAO EDAO=new EmployeeImplementation();
		Employee e=new Employee();
		e.setName(req.getParameter("name"));
		e.setJob(req.getParameter("job"));
		e.setSalary(Double.parseDouble(req.getParameter("sal")));
		e.setDept_no(Integer.parseInt(req.getParameter("Dno")));
		e.setMail(req.getParameter("mail"));
		e.setPassword("1234");
		EDAO.addEmployee(e);
		 req.setAttribute("success", "Employee Account created");
		 RequestDispatcher rd=req.getRequestDispatcher("login.jsp");
		 rd.forward(req,resp);		
	}	 
}
