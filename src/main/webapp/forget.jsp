<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Recover access | LiquorHub</title>
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
      <h1>Forgot password</h1>
      <p class="lede">Enter your email and set a new password to get back in.</p>

      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-auth__flash lh-auth__flash--err"><%= error %></p>
      <% } %>

      <form action="<%= ctx %>/forgetPassword" method="POST" class="lh-auth__form">
        <div>
          <label for="email">Email</label>
          <input id="email" type="email" name="email" required placeholder="Account email" autocomplete="email">
        </div>
        <div>
          <label for="password">New password</label>
          <input id="password" type="password" name="password" required placeholder="New password" autocomplete="new-password">
        </div>
        <div>
          <label for="cpassword">Confirm password</label>
          <input id="cpassword" type="password" name="cpassword" required placeholder="Confirm password" autocomplete="new-password">
        </div>
        <button type="submit" class="lh-btn lh-btn--signal lh-auth__submit">Update password</button>
      </form>

      <div class="lh-auth__links">
        <a href="<%= ctx %>/login">Back to sign in</a>
        <span> · </span>
        <a href="<%= ctx %>/home">Back to shop</a>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
