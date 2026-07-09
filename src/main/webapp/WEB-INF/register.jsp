<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body >
 <div class="min-h-screen flex flex-col items-center justify-center bg-orange-300 p-4">

    <div class="bg-white p-6 rounded-lg shadow-md w-full max-w-sm border border-gray-200">
        <h2 class="text-lg text-gray-400 font-mono mb-4 text-center">Add Employee</h2>
        <%String success1= (String) request.getAttribute("success"); %>
        <%if(success1!=null){%>
        <h3 class="text-blue-300"><%=success1%></h3>
        <%} %>
        
        <form action="register" method="POST" class="space-y-4">
            <!-- Employee Name -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">EmpName</label>
                <input type="text" name="name" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
            </div>

            <!-- Job Dropdown -->
            <div >
                <label class="block text-sm font-medium text-gray-700 mb-1">Job</label>
                
                <select name="job" class="w-full px-3 py-2 border border-gray-300 rounded-md bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
                    <option value="">-- Job --</option>
                    <option value="developer">Developer</option>
                    <option value="hr">HR</option>
                    <option value="manager">Manager</option>
                    <option value="tester">Tester</option>
                    <option value="salesman">Salesman</option>
                </select>
            </div>

            <!-- Salary -->
            <div >
                <label class="block text-sm font-medium text-gray-700 mb-1">Salary</label>
                <input type="number" name="sal" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
            </div>

            <!-- Department Dropdown -->
            <div >
                <label class="block text-sm font-medium text-gray-700 mb-1">Dept:</label>
                
                <select name="Dno" class="w-full px-3 py-2 border border-gray-300 rounded-md bg-white focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
                    <option >-- Dept --</option>
                    <option value="10">IT</option>
                    <option value="20">HR</option>
                    <option value="30">Salesman</option>
                </select>
            </div>

            <!-- Mail -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">mail</label>
                <input type="email" name="mail" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
            </div>
             <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input type="password" name="password" value="1234" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm">
            </div>
            
            

            <!-- Register Button -->
            <div class="pt-2 flex flex-row px-6">
                <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-md transition duration-200 text-sm cursor-pointer shadow-sm">
                    Register
                </button>
            </div>
        </form>
    </div>
    </div>

</body>
</html>