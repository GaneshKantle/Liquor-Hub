<%@page import="com.LiquorHub.dto.CustomerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset password | LiquorHub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/liquorhub.css">
</head>
<body class="lh-body">
<% CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer"); %>
  <div class="lh-shell">
    <header class="lh-brand">
      <h1 class="lh-brand__name">LiquorHub</h1>
      <p class="lh-brand__tag">Keep your cellar account secure.</p>
    </header>

    <div class="lh-glass">
      <h2 class="lh-title">Reset password</h2>
      <p class="lh-subtitle">Change the password for your LiquorHub account.</p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-msg lh-msg--ok"><%= success %></p>
      <% } %>
      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-msg lh-msg--err"><%= error %></p>
      <% } %>

      <form action="resetPassword" method="POST" class="lh-form">
        <div class="lh-field">
          <label for="currentPassword">Current password</label>
          <input id="currentPassword" type="password" name="currentPassword" required placeholder="Current password">
        </div>
        <div class="lh-field">
          <label for="newPassword">New password</label>
          <input id="newPassword" type="password" name="newPassword" required placeholder="New password" minlength="6">
          <p class="lh-hint">At least 6 characters</p>
        </div>
        <div class="lh-field">
          <label for="confirmPassword">Confirm new password</label>
          <input id="confirmPassword" type="password" name="confirmPassword" required placeholder="Confirm new password">
        </div>
        <div class="lh-actions">
          <button type="submit" class="lh-btn">Save password</button>
          <a href="dashboard" class="lh-btn lh-btn--ghost">Back</a>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
