<%@page import="com.LiquorHub.dto.CustomerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your account | LiquorHub</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/liquorhub.css">
</head>
<body class="lh-body">
<%
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
  if (customer == null) {
    request.setAttribute("error", "Already session Expired");
    request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    return;
  }
%>

  <header class="lh-top">
    <div class="lh-top__inner">
      <h1 class="lh-top__brand">LiquorHub</h1>
      <a href="resetPassword" class="lh-btn lh-btn--ghost">Reset password</a>
      <a href="logout" class="lh-btn lh-btn--danger">Logout</a>
    </div>
  </header>

  <main class="lh-page">
    <div class="lh-glass lh-glass--wide">
      <h2 class="lh-title">Your collector profile</h2>
      <p class="lh-hero-line">Manage the details used when you buy or sell rare liquor here.</p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-msg lh-msg--ok"><%= success %></p>
      <% } %>

      <div class="lh-grid">
        <div class="lh-info">
          <span>Member ID</span>
          <strong>CUST<%= customer.getCustomerId() %></strong>
        </div>
        <div class="lh-info">
          <span>Name</span>
          <strong><%= customer.getName() %></strong>
        </div>
        <div class="lh-info">
          <span>Email</span>
          <strong><%= customer.getEmail() %></strong>
        </div>
        <div class="lh-info">
          <span>Phone</span>
          <strong><%= customer.getPhone() %></strong>
        </div>
        <div class="lh-info" style="grid-column: 1 / -1;">
          <span>Address</span>
          <strong><%= customer.getAddress() %></strong>
        </div>
      </div>

      <hr class="lh-divider">

      <h3 class="lh-section-title">Update details</h3>
      <form action="update" method="POST" class="lh-form">
        <div class="lh-field">
          <label for="name">Name</label>
          <input id="name" type="text" name="name" value="<%= customer.getName() %>" required>
        </div>
        <div class="lh-field">
          <label for="mail">Email</label>
          <input id="mail" type="email" name="mail" value="<%= customer.getEmail() %>" required>
        </div>
        <div class="lh-field">
          <label for="phone">Phone</label>
          <input id="phone" type="text" name="phone" value="<%= customer.getPhone() %>" required>
        </div>
        <div class="lh-field">
          <label for="address">Address</label>
          <input id="address" type="text" name="address" value="<%= customer.getAddress() %>" required>
        </div>
        <div class="lh-field">
          <label for="password">Password</label>
          <input id="password" type="password" name="password" placeholder="Leave blank to keep current">
          <p class="lh-hint">Only fill this if you want to change your password here.</p>
        </div>
        <button type="submit" class="lh-btn">Save changes</button>
      </form>
    </div>
  </main>

  <footer class="lh-foot">LiquorHub — rare liquor marketplace</footer>
</body>
</html>
