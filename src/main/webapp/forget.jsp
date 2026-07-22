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
          <div class="lh-pw">
            <input id="password" type="password" name="password" required placeholder="New password" autocomplete="new-password">
            <button type="button" class="lh-pw__toggle" data-target="password" aria-label="Show password" aria-pressed="false">
              <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 3l18 18"/><path d="M10.6 10.6a3 3 0 004.2 4.2"/><path d="M9.9 5.2A10.4 10.4 0 0112 5c6.5 0 10 7 10 7a17.6 17.6 0 01-3.1 3.9"/><path d="M6.1 6.1A17.3 17.3 0 002 12s3.5 7 10 7c1.3 0 2.5-.3 3.6-.7"/></svg>
            </button>
          </div>
        </div>
        <div>
          <label for="cpassword">Confirm password</label>
          <div class="lh-pw">
            <input id="cpassword" type="password" name="cpassword" required placeholder="Confirm password" autocomplete="new-password">
            <button type="button" class="lh-pw__toggle" data-target="cpassword" aria-label="Show password" aria-pressed="false">
              <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 3l18 18"/><path d="M10.6 10.6a3 3 0 004.2 4.2"/><path d="M9.9 5.2A10.4 10.4 0 0112 5c6.5 0 10 7 10 7a17.6 17.6 0 01-3.1 3.9"/><path d="M6.1 6.1A17.3 17.3 0 002 12s3.5 7 10 7c1.3 0 2.5-.3 3.6-.7"/></svg>
            </button>
          </div>
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
  <script>
    document.querySelectorAll(".lh-pw__toggle").forEach(function (btn) {
      btn.addEventListener("click", function () {
        var id = btn.getAttribute("data-target");
        var input = id ? document.getElementById(id) : null;
        if (!input) return;
        var show = input.type === "password";
        input.type = show ? "text" : "password";
        btn.classList.toggle("is-shown", show);
        btn.setAttribute("aria-pressed", show ? "true" : "false");
        btn.setAttribute("aria-label", show ? "Hide password" : "Show password");
      });
    });
  </script>
</body>
</html>
