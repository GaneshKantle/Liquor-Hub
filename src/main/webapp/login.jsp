<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign in | LiquorHub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/liquorhub.css">
</head>
<body class="lh-body">
  <div class="lh-shell">
    <header class="lh-brand">
      <h1 class="lh-brand__name">LiquorHub</h1>
      <p class="lh-brand__tag">Rare bottles. Trusted exchange.</p>
    </header>

    <div class="lh-glass">
      <h2 class="lh-title">Welcome back</h2>
      <p class="lh-subtitle">Sign in to buy or list rare liquor on our platform.</p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-msg lh-msg--ok"><%= success %></p>
      <% } %>
      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-msg lh-msg--err"><%= error %></p>
      <% } %>
      <% String success1 = (String) request.getAttribute("success1");
         if (success1 != null) { %>
      <p class="lh-msg lh-msg--ok"><%= success1 %></p>
      <% } %>

      <form action="login" method="POST" class="lh-form">
        <div class="lh-field">
          <label for="mail">Email</label>
          <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email">
        </div>
        <div class="lh-field">
          <label for="password">Password</label>
          <input id="password" type="password" name="password" required placeholder="Your password" autocomplete="current-password">
        </div>
        <button type="submit" class="lh-btn">Sign in</button>
      </form>

      <div class="lh-links">
        <a href="forgetPassword">Forgot password?</a>
        <span> · </span>
        <a href="register.jsp">Create account</a>
      </div>
    </div>
  </div>
</body>
</html>
