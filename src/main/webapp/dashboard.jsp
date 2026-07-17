<%@page import="com.LiquorHub.dto.CustomerDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Your account | LiquorHub</title>
  <link rel="icon" href="<%=request.getContextPath()%>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/beer-loader.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Instrument+Serif&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#f8f5ef', soft: '#fffbf7' },
            ink: { DEFAULT: '#13110d', muted: '#6a655d' },
            accent: { DEFAULT: '#d96a3b', soft: '#f4dcd1', strong: '#a84822' }
          },
          fontFamily: {
            display: ['"Instrument Serif"', 'Georgia', 'serif'],
            sans: ['Manrope', 'ui-sans-serif', 'system-ui', 'sans-serif']
          }
        }
      }
    };
  </script>
  <style>
    .glass {
      background: rgba(255,255,255,0.45);
      border: 1px solid rgba(255,255,255,0.7);
      box-shadow: 0 8px 32px rgba(38,34,29,0.07), inset 0 1px 0 rgba(255,255,255,0.8);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
    }
    .glass-strong {
      background: rgba(255,255,255,0.6);
      border: 1px solid rgba(255,255,255,0.8);
      box-shadow: 0 16px 48px rgba(38,34,29,0.09), inset 0 1px 0 rgba(255,255,255,0.9);
      backdrop-filter: blur(24px);
      -webkit-backdrop-filter: blur(24px);
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="relative min-h-screen overflow-x-clip font-sans text-ink antialiased"
  style="background-color:#f8f5ef; background-image: radial-gradient(ellipse 60% 40% at 0% 0%, rgba(217,106,59,0.12), transparent 50%), linear-gradient(180deg, #fff, #f8f5ef);">
<%
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
  if (customer == null) {
    request.setAttribute("error", "Already session Expired");
    request.getRequestDispatcher("/login.jsp").forward(request, response);
    return;
  }
%>
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/age-gate.jsp" />
  <div class="pointer-events-none absolute -right-20 top-40 h-72 w-72 rounded-full bg-accent/10 blur-3xl"></div>

  <header class="sticky top-0 z-20 px-4 pt-3 sm:px-6">
    <div class="glass mx-auto flex max-w-3xl flex-wrap items-center gap-3 rounded-full px-4 py-2.5">
      <a href="<%=request.getContextPath()%>/home" class="mr-auto font-display text-2xl tracking-tight">LiquorHub</a>
      <a href="<%=request.getContextPath()%>/home" class="inline-flex min-h-10 items-center rounded-full border border-white/70 bg-white/40 px-4 text-sm font-semibold transition hover:bg-white/70">Shop</a>
      <a href="<%=request.getContextPath()%>/cart" class="inline-flex min-h-10 items-center rounded-full border border-white/70 bg-white/40 px-4 text-sm font-semibold transition hover:bg-white/70">Cart</a>
      <a href="resetPassword" class="inline-flex min-h-10 items-center rounded-full border border-white/70 bg-white/40 px-4 text-sm font-semibold transition hover:bg-white/70">Reset password</a>
      <a href="logout" class="inline-flex min-h-10 items-center rounded-full border border-red-200/80 bg-red-50/50 px-4 text-sm font-semibold text-red-700 transition hover:bg-red-50">Logout</a>
    </div>
  </header>

  <main class="relative mx-auto max-w-3xl px-4 py-8 sm:px-6 sm:py-10">
    <div class="glass-strong rounded-[2rem] p-5 sm:p-8">
      <h2 class="font-display text-2xl font-semibold tracking-tight sm:text-3xl">Your collector profile</h2>
      <p class="mt-2 mb-6 text-sm text-ink-muted">Manage the details used when you buy or sell rare liquor here.</p>

      <% String success = (String) request.getAttribute("success");
         if (success != null) { %>
      <p class="mb-5 rounded-2xl border border-green-700/15 bg-green-50/70 px-3 py-2.5 text-sm text-green-800"><%= success %></p>
      <% } %>

      <div class="mb-6 grid gap-3 sm:grid-cols-2">
        <div class="glass rounded-2xl p-4">
          <span class="block text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted">Member ID</span>
          <strong class="mt-1 block font-display text-xl font-semibold">CUST<%= customer.getCustomerId() %></strong>
        </div>
        <div class="glass rounded-2xl p-4">
          <span class="block text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted">Name</span>
          <strong class="mt-1 block font-display text-xl font-semibold"><%= customer.getName() %></strong>
        </div>
        <div class="glass rounded-2xl p-4">
          <span class="block text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted">Email</span>
          <strong class="mt-1 block font-display text-xl font-semibold break-all"><%= customer.getEmail() %></strong>
        </div>
        <div class="glass rounded-2xl p-4">
          <span class="block text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted">Phone</span>
          <strong class="mt-1 block font-display text-xl font-semibold"><%= customer.getPhone() %></strong>
        </div>
        <div class="glass rounded-2xl p-4 sm:col-span-2">
          <span class="block text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted">Address</span>
          <strong class="mt-1 block font-display text-xl font-semibold"><%= customer.getAddress() %></strong>
        </div>
      </div>

      <hr class="mb-6 border-white/60">

      <h3 class="mb-4 font-display text-xl font-semibold text-accent-strong">Update details</h3>
      <form action="update" method="POST" class="space-y-4">
        <div>
          <label for="name" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Name</label>
          <input id="name" type="text" name="name" value="<%= customer.getName() %>" required class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
        </div>
        <div>
          <label for="mail" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Email</label>
          <input id="mail" type="email" name="mail" value="<%= customer.getEmail() %>" required class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
        </div>
        <div>
          <label for="phone" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Phone</label>
          <input id="phone" type="text" name="phone" value="<%= customer.getPhone() %>" required class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
        </div>
        <div>
          <label for="address" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Address</label>
          <input id="address" type="text" name="address" value="<%= customer.getAddress() %>" required class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
        </div>
        <div>
          <label for="password" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Password</label>
          <input id="password" type="password" name="password" placeholder="Leave blank to keep current" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
          <p class="mt-1 text-xs text-ink-muted">Only fill this if you want to change your password here.</p>
        </div>
        <button type="submit" class="inline-flex min-h-11 items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold text-white shadow-md transition hover:bg-accent-strong">Save changes</button>
      </form>
    </div>
  </main>

  <footer class="py-6 text-center text-sm text-ink-muted">LiquorHub - rare liquor marketplace</footer>
  <script src="<%=request.getContextPath()%>/js/gates.js" defer></script>
</body>
</html>
