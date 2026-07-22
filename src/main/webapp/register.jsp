<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
  String next = request.getParameter("next");
  if (next == null) next = "";
  String reason = request.getParameter("reason");
  if (reason == null) reason = "";
  String loginQs = "";
  if (!next.isBlank() || !reason.isBlank()) {
    loginQs = "?";
    if (!next.isBlank()) loginQs += "next=" + java.net.URLEncoder.encode(next, "UTF-8");
    if (!reason.isBlank()) loginQs += (loginQs.length() > 1 ? "&" : "") + "reason=" + java.net.URLEncoder.encode(reason, "UTF-8");
  }
  String reasonMsg = "Sign up to add to cart, buy bottles, and save favourites.";
  if ("cart".equals(reason)) reasonMsg = "Create an account to add bottles to your cart.";
  else if ("buy".equals(reason)) reasonMsg = "Create an account to buy this bottle.";
  else if ("wishlist".equals(reason) || "favourite".equals(reason)) reasonMsg = "Create an account to save favourites.";
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Join | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <style>
    .lh-pw { position: relative; }
    .lh-pw input { padding-right: 2.75rem; }
    .lh-pw__toggle {
      position: absolute; right: 0.35rem; top: 50%; transform: translateY(-50%);
      display: inline-flex; align-items: center; justify-content: center;
      width: 2.25rem; height: 2.25rem; border: 0; background: transparent;
      color: var(--smoke); cursor: pointer;
    }
    .lh-pw__toggle:hover { color: var(--carbon); }
    .lh-pw__toggle svg { width: 1.15rem; height: 1.15rem; }
    .lh-pw__toggle .eye-off { display: none; }
    .lh-pw__toggle.is-shown .eye-on { display: none; }
    .lh-pw__toggle.is-shown .eye-off { display: block; }
    .lh-field-error {
      margin: 0.4rem 0 0; font-size: 0.78rem; font-weight: 600; color: var(--signal-ink);
    }
    .lh-field-error[hidden] { display: none !important; }
    input.is-invalid {
      border-color: rgba(176, 24, 12, 0.55) !important;
      box-shadow: 0 0 0 2px rgba(255, 45, 26, 0.12);
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-auth">
    <div class="lh-auth__card">
      <h1>Create your account</h1>
      <p class="lede"><%= reasonMsg %></p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="lh-auth__flash"><%= success %></p>
      <% } %>
      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
      <p class="lh-auth__flash lh-auth__flash--err"><%= error %></p>
      <% } %>

      <form action="<%= ctx %>/register" method="POST" class="lh-auth__form" id="registerForm">
        <% if (!next.isBlank()) { %>
        <input type="hidden" name="next" value="<%= next.replace("\"", "&quot;") %>">
        <% } %>
        <% if (!reason.isBlank()) { %>
        <input type="hidden" name="reason" value="<%= reason.replace("\"", "") %>">
        <% } %>
        <div>
          <label for="name">Full name</label>
          <input id="name" type="text" name="name" required placeholder="Your name" autocomplete="name">
        </div>
        <div>
          <label for="mail">Email</label>
          <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email">
        </div>
        <div>
          <label for="password">Password</label>
          <div class="lh-pw">
            <input id="password" type="password" name="password" required minlength="4" placeholder="Create a password" autocomplete="new-password">
            <button type="button" class="lh-pw__toggle" data-target="password" aria-label="Show password" aria-pressed="false">
              <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 3l18 18"/><path d="M10.6 10.6a3 3 0 004.2 4.2"/><path d="M9.9 5.2A10.4 10.4 0 0112 5c6.5 0 10 7 10 7a17.6 17.6 0 01-3.1 3.9"/><path d="M6.1 6.1A17.3 17.3 0 002 12s3.5 7 10 7c1.3 0 2.5-.3 3.6-.7"/></svg>
            </button>
          </div>
        </div>
        <div>
          <label for="cpassword">Confirm password</label>
          <div class="lh-pw">
            <input id="cpassword" type="password" name="cpassword" required minlength="4" placeholder="Re-enter password" autocomplete="new-password" aria-describedby="pwMatchError">
            <button type="button" class="lh-pw__toggle" data-target="cpassword" aria-label="Show password" aria-pressed="false">
              <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 3l18 18"/><path d="M10.6 10.6a3 3 0 004.2 4.2"/><path d="M9.9 5.2A10.4 10.4 0 0112 5c6.5 0 10 7 10 7a17.6 17.6 0 01-3.1 3.9"/><path d="M6.1 6.1A17.3 17.3 0 002 12s3.5 7 10 7c1.3 0 2.5-.3 3.6-.7"/></svg>
            </button>
          </div>
          <p id="pwMatchError" class="lh-field-error" role="alert" hidden>Passwords do not match</p>
        </div>
        <div>
          <label for="phone">Phone</label>
          <input id="phone" type="text" name="phone" required placeholder="Contact number" autocomplete="tel">
        </div>
        <div>
          <label for="address">Address</label>
          <input id="address" type="text" name="address" required placeholder="Delivery / pickup address" autocomplete="street-address">
        </div>
        <button type="submit" id="registerSubmit" class="lh-btn lh-btn--signal" style="width:100%;justify-content:center">Join LiquorHub</button>
      </form>

      <div class="lh-auth__links">
        Already a member? <a href="<%= ctx %>/login<%= loginQs %>">Sign in</a>
        <span> · </span>
        <a href="<%= ctx %>/home">Back to shop</a>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
  <script>
    (function () {
      var pw = document.getElementById("password");
      var cpw = document.getElementById("cpassword");
      var err = document.getElementById("pwMatchError");
      var submit = document.getElementById("registerSubmit");
      var form = document.getElementById("registerForm");

      function passwordsMatch() {
        if (!pw || !cpw) return true;
        if (!cpw.value) return true;
        return pw.value === cpw.value;
      }

      function syncMatch() {
        var ok = passwordsMatch();
        if (err) err.hidden = ok;
        if (cpw) cpw.classList.toggle("is-invalid", !ok);
        if (submit) submit.disabled = !ok && !!cpw.value;
        return ok;
      }

      if (pw) pw.addEventListener("input", syncMatch);
      if (cpw) cpw.addEventListener("input", syncMatch);
      if (form) {
        form.addEventListener("submit", function (e) {
          if (!passwordsMatch() || !cpw.value) {
            e.preventDefault();
            if (err) err.hidden = false;
            if (cpw) { cpw.classList.add("is-invalid"); cpw.focus(); }
            if (submit) submit.disabled = true;
          }
        });
      }
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
    })();
  </script>
</body>
</html>
