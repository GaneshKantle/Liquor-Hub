
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
 <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<div>
     <div class="min-h-screen flex flex-col items-center justify-center bg-orange-300 p-4">
      <div class="bg-white p-6 rounded-lg shadow-md w-full max-w-sm border border-gray-200">
     <%String success1= (String) request.getAttribute("success"); %>
        <%if(success1!=null){%>
        <h1 class="text-black"><%=success1%></h1>
        <%} %>
        <%String error= (String) request.getAttribute("error"); %>
        <%if(error!=null){%>
        <h1 class="text-black"><%=error%></h1>
        <%} %>
        <%String success2= (String) request.getAttribute("success1"); %>
        <%if(success2!=null){%>
        <h1 class="text-black"><%=success2%></h1>
        <%} %>
        
     <form action="login" method="POST" class="space-y-4">     
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Enter your Email Id</label>
                <input type="email" name="mail" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
            </div>
             <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Enter Your Password</label>
                <input type="password" name="password" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
            </div>
            <div class="pt-2 flex flex-row px-6  ">
                <button type="submit" class="w-full bg-blue-600 mx-5 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-md transition duration-200 text-sm cursor-pointer shadow-sm">
                   Login
                </button>
                 <a href="forget.jsp" class="text-sm font-medium text-orange-600 hover:text-orange-700 hover:underline">
                Forget Password
              </a>
            </div>
             <div class="pt-2 flex flex-row px-6  ">
                <label class="block text-sm font-medium text-gray-700 mb-1">Didn't have Account</label>
                 <a href="register.jsp" class="text-sm font-medium text-orange-600 hover:text-orange-700 hover:underline">
                 Register
              </a>
            </div>
            </div>          
            </div>
 </form>
 </div>
            
            
</body>
</html>