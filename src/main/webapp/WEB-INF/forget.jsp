<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Recover access | LiquorHub</title>
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
      <h2 class="lh-title">Forgot password</h2>
      <p class="lh-subtitle">Enter your email and set a new password to get back in.</p>

      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-msg lh-msg--err"><%= error %></p>
      <% } %>

      <form action="forgetPassword" method="POST" class="lh-form">
        <div class="lh-field">
          <label for="email">Email</label>
          <input id="email" type="email" name="email" required placeholder="Account email">
        </div>
        <div class="lh-field">
          <label for="password">New password</label>
          <input id="password" type="password" name="password" required placeholder="New password">
        </div>
        <div class="lh-field">
          <label for="cpassword">Confirm password</label>
          <input id="cpassword" type="password" name="cpassword" required placeholder="Confirm password">
        </div>
        <button type="submit" class="lh-btn">Update password</button>
      </form>

      <div class="lh-links">
        <a href="login">Back to sign in</a>
      </div>
    </div>
  </div>
</body>
</html>
