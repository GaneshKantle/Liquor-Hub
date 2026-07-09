<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
     <div class="min-h-screen flex flex-col items-center justify-center bg-orange-50 p-6">
  
  <div class="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md border-t-4 border-orange-500">
    
    <h1 class="text-2xl font-bold text-gray-800 mb-2">Forget Password</h1>
    <p class="text-sm text-gray-500 mb-6">Reset your credentials to regain access.</p>
    <%String error= (String) request.getAttribute("error"); %>
        <%if(error!=null){%>
        <h1 class=" text-red=500"><%=error%></h1>
        <%} %>
    
    <form action="forgetPassword" method="POST">
      <table class="w-full border-separate border-spacing-y-4">
        <tbody>
          <tr>
            <td class="text-sm font-medium text-gray-600 pr-4 whitespace-nowrap">Enter your Email</td>
            <td>
              <input type="email" name="email" 
                     class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-400 focus:border-transparent outline-none transition-all">
            </td>
          </tr>
          <tr>
            <td class="text-sm font-medium text-gray-600 pr-4 whitespace-nowrap">Set password</td>
            <td>
              <input type="password" name="password" 
                     class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-400 focus:border-transparent outline-none transition-all">
            </td>
          </tr>

          <tr>
            <td class="text-sm font-medium text-gray-600 pr-4 whitespace-nowrap">Confirm password</td>
            <td>
              <input type="password" name="cpassword" 
                     class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-400 focus:border-transparent outline-none transition-all">
            </td>
          </tr>

          <tr>
            <td>
              <button type="submit" 
                      class="bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 px-4 rounded-lg shadow-md transition-colors w-full">
                Update Password
              </button>
            </td>
            <td class="text-center">
              <a href="login.jsp" class="text-sm font-medium text-orange-600 hover:text-orange-700 hover:underline">
                Back
              </a>
            </td>
          </tr>
        </tbody>
      </table>
    </form>

  </div>
</div>
</body>
</html>