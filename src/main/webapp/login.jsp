<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
  String next = request.getParameter("next");
  if (next == null || next.isBlank()) {
    Object nextAttr = request.getAttribute("next");
    next = nextAttr != null ? String.valueOf(nextAttr) : "";
  }
  String reason = request.getParameter("reason");
  String reasonMsg = "Sign in to continue shopping on LiquorHub.";
  if ("cart".equals(reason)) reasonMsg = "Sign in or create an account to add bottles to your cart.";
  else if ("buy".equals(reason)) reasonMsg = "Sign in or create an account to buy this bottle.";
  else if ("wishlist".equals(reason) || "favourite".equals(reason)) reasonMsg = "Sign in or create an account to save favourites.";
  String nextQs = (next != null && !next.isBlank())
      ? ("?next=" + java.net.URLEncoder.encode(next, "UTF-8") + (reason != null ? "&reason=" + java.net.URLEncoder.encode(reason, "UTF-8") : ""))
      : (reason != null ? ("?reason=" + java.net.URLEncoder.encode(reason, "UTF-8")) : "");
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Sign in | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-auth">
    <div class="lh-auth__card">
      <h1>Welcome back</h1>
      <p class="lede"><%= reasonMsg %></p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-auth__flash"><%= success %></p>
      <% } %>
      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-auth__flash lh-auth__flash--err"><%= error %></p>
      <% } %>
      <% String success1 = (String) request.getAttribute("success1");
         if (success1 != null) { %>
      <p class="lh-auth__flash"><%= success1 %></p>
      <% } %>

      <form action="<%= ctx %>/login" method="POST" class="lh-auth__form">
        <% if (next != null && !next.isBlank()) { %>
        <input type="hidden" name="next" value="<%= next.replace("\"", "&quot;") %>">
        <% } %>
        <% if (reason != null && !reason.isBlank()) { %>
        <input type="hidden" name="reason" value="<%= reason.replace("\"", "") %>">
        <% } %>
        <div>
          <label for="mail">Email</label>
          <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email">
        </div>
        <div>
          <label for="password">Password</label>
          <input id="password" type="password" name="password" required placeholder="Your password" autocomplete="current-password">
        </div>
        <button type="submit" class="lh-btn lh-btn--signal" style="width:100%;justify-content:center">Sign in</button>
      </form>

      <div class="lh-auth__links">
        <a href="<%= ctx %>/forgetPassword">Forgot password?</a>
        <span> · </span>
        <a href="<%= ctx %>/register<%= nextQs %>">Create account</a>
        <span> · </span>
        <a href="<%= ctx %>/home">Back to shop</a>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
