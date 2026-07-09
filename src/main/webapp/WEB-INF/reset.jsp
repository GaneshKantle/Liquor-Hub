<%@page import="com.dto.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdn.tailwindcss.com"></script>
<body>

<%Employee e=(Employee)session.getAttribute("employee");%>
 <div class="reset-section">
            <div class="max-w-2xl mx-auto px-4 py-8">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="bg-red-500 -m-6 mb-6 rounded-t-lg p-4">
                        <h2 class="text-xl font-bold text-white">Reset Password</h2>
                    </div>
                    
                    <%String success=(String)request.getAttribute("success"); %>
        			<%if(success!=null){%>
        			<h6 align="center" style="color:green;"><%=success%></h6>
        			<%}%>
                    
                    <%String error=(String)request.getAttribute("error"); %>
        			<%if(error!=null){%>
        			<h6 align="center" style="color:red;"><%=error%></h6>
        			<%}%>
                    
                    <form action="resetPassword" method="POST" class="mt-4 space-y-4">
                        <div>
                            <label class="block text-gray-700 font-medium mb-1">Current Password</label>
                            <input type="password" required name="currentPassword" placeholder="Enter your current password" class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500">
                        </div>
                        <div>
                            <label class="block text-gray-700 font-medium mb-1">New Password</label>
                            <input type="password" name="newPassword" required placeholder="Enter new password" class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500">
                            <p class="text-xs text-gray-400 mt-1">Minimum 6 characters</p>
                        </div>
                        <div>
                            <label class="block text-gray-700 font-medium mb-1">Confirm New Password</label>
                            <input type="password" name="confirmPassword" required placeholder="Re-enter new password" class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500">
                        </div>
                        <button type="submit" class="bg-blue-600 text-white px-5 py-2 rounded-lg hover:bg-blue-700 transition">Reset Password</button>
                        <a href="dashboard.jsp" class="bg-orange-600 text-white px-5 py-2 rounded-lg hover:bg-orange-700 transition">Back</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>