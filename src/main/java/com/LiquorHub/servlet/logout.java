package com.servlet;

import java.io.IOException;

import com.dto.Employee;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/logout")
public class logout extends HttpServlet{
               @Override
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            	   HttpSession session=req.getSession();
            	   Employee e=(Employee)session.getAttribute("Employee");
            	   if(e!=null) {
            		   session.invalidate();
            		   req.setAttribute("success","logged Out Successfully");
            		   req.getRequestDispatcher("login.jsp").forward(req,resp);
            	   }
            	   else {
            		   req.setAttribute("error","session Already Expired");
            		   req.getRequestDispatcher("login.jsp").forward(req,resp);
            	   }
            }
}
