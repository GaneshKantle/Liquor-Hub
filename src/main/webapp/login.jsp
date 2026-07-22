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
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#d9e0e6', soft: '#eef2f5' },
            ink: { DEFAULT: '#0a0c10', muted: '#3a424c' },
            accent: { DEFAULT: '#ff2d1a', soft: '#ffd4ce', strong: '#b0180c' }
          },
          fontFamily: {
            display: ['Syne', 'system-ui', 'sans-serif'],
            sans: ['Space Grotesk', 'system-ui', 'sans-serif']
          }
        }
      }
    };
  </script>
  <style>
    .rounded-full, .rounded-2xl { border-radius: 2px !important; }
    .glass-strong {
      background: rgba(238,242,245,0.92);
      border: 1.5px solid #0a0c10;
      box-shadow: 6px 6px 0 #ff2d1a;
      backdrop-filter: blur(10px);
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-4 py-10 antialiased">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <div class="pointer-events-none absolute -left-20 top-20 h-64 w-64 rounded-full bg-accent/15 blur-3xl"></div>
  <div class="pointer-events-none absolute -right-10 bottom-10 h-72 w-72 rounded-full bg-white/80 blur-3xl"></div>

  <header class="relative mb-8 text-center">
    <a href="<%= ctx %>/home" class="lh-display text-4xl uppercase tracking-tight text-ink sm:text-5xl">LiquorHub</a>
    <p class="mt-2 text-sm tracking-wide text-ink-muted">Browse the floor. Sign in to trade.</p>
  </header>

  <div class="glass-strong relative w-full max-w-md rounded-[2rem] p-6 sm:p-8">
    <h2 class="font-display text-2xl font-semibold tracking-tight">Welcome back</h2>
    <p class="mt-1 mb-5 text-sm text-ink-muted"><%= reasonMsg %></p>

    <% String success = (String) request.getAttribute("success");
       if (success != null) { %>
    <p class="mb-4 rounded-2xl border border-green-700/15 bg-green-50/70 px-3 py-2.5 text-sm text-green-800"><%= success %></p>
    <% } %>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
    <p class="mb-4 rounded-2xl border border-red-700/15 bg-red-50/70 px-3 py-2.5 text-sm text-red-800"><%= error %></p>
    <% } %>
    <% String success1 = (String) request.getAttribute("success1");
       if (success1 != null) { %>
    <p class="mb-4 rounded-2xl border border-green-700/15 bg-green-50/70 px-3 py-2.5 text-sm text-green-800"><%= success1 %></p>
    <% } %>

    <form action="<%= ctx %>/login" method="POST" class="space-y-4">
      <% if (next != null && !next.isBlank()) { %>
      <input type="hidden" name="next" value="<%= next.replace("\"", "&quot;") %>">
      <% } %>
      <% if (reason != null && !reason.isBlank()) { %>
      <input type="hidden" name="reason" value="<%= reason.replace("\"", "") %>">
      <% } %>
      <div>
        <label for="mail" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Email</label>
        <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email"
          class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="password" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Password</label>
        <input id="password" type="password" name="password" required placeholder="Your password" autocomplete="current-password"
          class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <button type="submit" class="inline-flex w-full min-h-11 items-center justify-center rounded-full bg-accent text-sm font-semibold text-white shadow-md shadow-accent/25 transition hover:bg-accent-strong">Sign in</button>
    </form>

    <div class="mt-5 text-center text-sm text-ink-muted">
      <a href="<%= ctx %>/forgetPassword" class="font-medium text-accent-strong hover:underline">Forgot password?</a>
      <span> · </span>
      <a href="<%= ctx %>/register<%= nextQs %>" class="font-medium text-accent-strong hover:underline">Create account</a>
      <span> · </span>
      <a href="<%= ctx %>/home" class="font-medium text-accent-strong hover:underline">Back to shop</a>
    </div>
  </div>
</body>
</html>
