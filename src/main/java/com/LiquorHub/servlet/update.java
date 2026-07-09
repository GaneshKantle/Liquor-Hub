package com.servlet;

import java.io.IOException;

import com.dao.impl.EmployeeImplementation;
import com.dao.inf.EmployeeDAO;
import com.dto.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/update")
public class update extends HttpServlet{
            @Override
            protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            	 EmployeeDAO EDAO=new EmployeeImplementation();
            	 HttpSession session=req.getSession();
            	 Employee e=(Employee)session.getAttribute("Employee");
            	 e.setName(req.getParameter("name"));
            	 e.setMail(req.getParameter("mail"));
            	 if(e.getJob().equals("hr")) {
            		 e.setJob(req.getParameter("job"));
            		 e.setDept_no(Integer.parseInt(req.getParameter("dno")));
            		 e.setSalary(Double.parseDouble(req.getParameter("sal")));
            		 e.setPassword(req.getParameter("password"));
            	 }
            	 EDAO.updateEmployee(e);
            	 req.setAttribute("success", "Updated Successfully");
            	 req.getRequestDispatcher("update.jsp").forward(req, resp);
      }
}
