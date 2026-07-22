<%@page import="com.LiquorHub.dto.CustomerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Reset password | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/auth.css">
  <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-auth">
    <div class="lh-auth__card">
      <h1>Reset password</h1>
      <p class="lede">Change the password for your LiquorHub account<% if (customer != null && customer.getName() != null) { %> (<%= customer.getName() %>)<% } %>.</p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-auth__flash"><%= success %></p>
      <% } %>
      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-auth__flash lh-auth__flash--err"><%= error %></p>
      <% } %>

      <form action="<%= ctx %>/resetPassword" method="POST" class="lh-auth__form">
        <div>
          <label for="currentPassword">Current password</label>
          <input id="currentPassword" type="password" name="currentPassword" required placeholder="Current password" autocomplete="current-password">
        </div>
        <div>
          <label for="newPassword">New password</label>
          <input id="newPassword" type="password" name="newPassword" required placeholder="New password" minlength="6" autocomplete="new-password">
        </div>
        <div>
          <label for="confirmPassword">Confirm new password</label>
          <input id="confirmPassword" type="password" name="confirmPassword" required placeholder="Confirm new password" autocomplete="new-password">
        </div>
        <div style="display:flex;flex-wrap:wrap;gap:0.5rem">
          <button type="submit" class="lh-btn lh-btn--signal" style="flex:1;justify-content:center">Save password</button>
          <a href="<%= ctx %>/profile" class="lh-btn lh-btn--chalk">Back to desk</a>
        </div>
      </form>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
