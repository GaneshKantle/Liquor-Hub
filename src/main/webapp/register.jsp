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
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#f8f5ef' },
            ink: { DEFAULT: '#13110d', muted: '#6a655d' },
            accent: { DEFAULT: '#d96a3b', soft: '#f4dcd1', strong: '#a84822' }
          },
          fontFamily: {
            display: ['-apple-system', 'BlinkMacSystemFont', 'SF Pro Display', 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif'],
            sans: ['-apple-system', 'BlinkMacSystemFont', 'SF Pro Text', 'SF Pro Display', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif']
          }
        }
      }
    };
  </script>
  <style>
    .glass-strong {
      background: rgba(255,255,255,0.55);
      border: 1px solid rgba(255,255,255,0.75);
      box-shadow: 0 20px 60px rgba(38,34,29,0.1), inset 0 1px 0 rgba(255,255,255,0.9);
      backdrop-filter: blur(24px);
      -webkit-backdrop-filter: blur(24px);
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-4 py-10 font-sans text-ink antialiased"
  style="background-color:#f8f5ef; background-image: radial-gradient(ellipse 70% 50% at 10% 0%, rgba(217,106,59,0.16), transparent 50%), linear-gradient(165deg, #fff, #f8f5ef);">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <div class="pointer-events-none absolute -left-20 top-20 h-64 w-64 rounded-full bg-accent/15 blur-3xl"></div>
  <div class="pointer-events-none absolute -right-10 bottom-10 h-72 w-72 rounded-full bg-white/80 blur-3xl"></div>

  <header class="relative mb-8 text-center">
    <a href="<%= ctx %>/home" class="font-display text-4xl font-semibold tracking-tight sm:text-5xl">LiquorHub</a>
    <p class="mt-2 text-sm text-ink-muted">Browse freely. Create an account to shop.</p>
  </header>

  <div class="glass-strong relative w-full max-w-md rounded-[2rem] p-6 sm:p-8">
    <h2 class="font-display text-2xl font-semibold tracking-tight">Create your account</h2>
    <p class="mt-1 mb-5 text-sm text-ink-muted">Sign up to add to cart, buy bottles, and save favourites.</p>

    <% String success = (String) request.getAttribute("success");
       if (success != null) { %>
    <p class="mb-4 rounded-2xl border border-green-700/15 bg-green-50/70 px-3 py-2.5 text-sm text-green-800"><%= success %></p>
    <% } %>

    <form action="<%= ctx %>/register" method="POST" class="space-y-4">
      <% if (!next.isBlank()) { %>
      <input type="hidden" name="next" value="<%= next.replace("\"", "&quot;") %>">
      <% } %>
      <div>
        <label for="name" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Full name</label>
        <input id="name" type="text" name="name" required placeholder="Your name" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="mail" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Email</label>
        <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="password" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Password</label>
        <input id="password" type="password" name="password" required placeholder="Create a password" autocomplete="new-password" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="phone" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Phone</label>
        <input id="phone" type="text" name="phone" required placeholder="Contact number" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="address" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Address</label>
        <input id="address" type="text" name="address" required placeholder="Delivery / pickup address" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <button type="submit" class="inline-flex w-full min-h-11 items-center justify-center rounded-full bg-accent text-sm font-semibold text-white shadow-md transition hover:bg-accent-strong">Join LiquorHub</button>
    </form>

    <div class="mt-5 text-center text-sm text-ink-muted">
      Already a member? <a href="<%= ctx %>/login<%= loginQs %>" class="font-medium text-accent-strong hover:underline">Sign in</a>
      <span> · </span>
      <a href="<%= ctx %>/home" class="font-medium text-accent-strong hover:underline">Back to shop</a>
    </div>
  </div>
</body>
</html>
