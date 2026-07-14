<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Join | LiquorHub</title>
  <link rel="icon" href="<%=request.getContextPath()%>/assets/favicon.png" type="image/png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/liquorhub.css">
</head>
<body class="lh-body">
  <div class="lh-shell">
    <header class="lh-brand">
      <a href="<%=request.getContextPath()%>/home" class="lh-brand__name">LiquorHub</a>
      <p class="lh-brand__tag">Collect. Trade. Discover rare pours.</p>
    </header>

    <div class="lh-glass">
      <h2 class="lh-title">Create your account</h2>
      <p class="lh-subtitle">Join the marketplace for rare and limited liquor.</p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-msg lh-msg--ok"><%= success %></p>
      <% } %>

      <form action="register" method="POST" class="lh-form">
        <div class="lh-field">
          <label for="name">Full name</label>
          <input id="name" type="text" name="name" required placeholder="Your name">
        </div>
        <div class="lh-field">
          <label for="mail">Email</label>
          <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email">
        </div>
        <div class="lh-field">
          <label for="password">Password</label>
          <input id="password" type="password" name="password" required placeholder="Create a password" autocomplete="new-password">
        </div>
        <div class="lh-field">
          <label for="phone">Phone</label>
          <input id="phone" type="text" name="phone" required placeholder="Contact number">
        </div>
        <div class="lh-field">
          <label for="address">Address</label>
          <input id="address" type="text" name="address" required placeholder="Delivery / pickup address">
        </div>
        <button type="submit" class="lh-btn">Join LiquorHub</button>
      </form>

      <div class="lh-links">
        Already a member? <a href="login">Sign in</a>
      </div>
    </div>
  </div>
</body>
</html>
