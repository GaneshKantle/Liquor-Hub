<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Join | LiquorHub</title>
  <link rel="icon" href="<%=request.getContextPath()%>/assets/favicon.png" type="image/png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#f8f5ef' },
            ink: { DEFAULT: '#13110d', muted: '#6a655d' },
            copper: { DEFAULT: '#b87333', soft: '#f3e4d4', strong: '#8a5520' }
          },
          fontFamily: {
            display: ['"Cormorant Garamond"', 'Georgia', 'serif'],
            sans: ['Outfit', 'system-ui', 'sans-serif']
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
</head>
<body class="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-4 py-10 font-sans text-ink antialiased"
  style="background-color:#f8f5ef; background-image: radial-gradient(ellipse 70% 50% at 10% 0%, rgba(184,115,51,0.16), transparent 50%), linear-gradient(165deg, #fff, #f8f5ef);">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <div class="pointer-events-none absolute -left-20 top-20 h-64 w-64 rounded-full bg-copper/15 blur-3xl"></div>
  <div class="pointer-events-none absolute -right-10 bottom-10 h-72 w-72 rounded-full bg-white/80 blur-3xl"></div>

  <header class="relative mb-8 text-center">
    <a href="<%=request.getContextPath()%>/home" class="font-display text-4xl font-semibold tracking-tight sm:text-5xl">LiquorHub</a>
    <p class="mt-2 text-sm text-ink-muted">Collect. Trade. Discover rare pours.</p>
  </header>

  <div class="glass-strong relative w-full max-w-md rounded-[2rem] p-6 sm:p-8">
    <h2 class="font-display text-2xl font-semibold tracking-tight">Create your account</h2>
    <p class="mt-1 mb-5 text-sm text-ink-muted">Join the marketplace for rare and limited liquor.</p>

    <% String success = (String) request.getAttribute("success");
       if (success != null) { %>
    <p class="mb-4 rounded-2xl border border-green-700/15 bg-green-50/70 px-3 py-2.5 text-sm text-green-800"><%= success %></p>
    <% } %>

    <form action="register" method="POST" class="space-y-4">
      <div>
        <label for="name" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Full name</label>
        <input id="name" type="text" name="name" required placeholder="Your name" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
      </div>
      <div>
        <label for="mail" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Email</label>
        <input id="mail" type="email" name="mail" required placeholder="you@email.com" autocomplete="email" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
      </div>
      <div>
        <label for="password" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Password</label>
        <input id="password" type="password" name="password" required placeholder="Create a password" autocomplete="new-password" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
      </div>
      <div>
        <label for="phone" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Phone</label>
        <input id="phone" type="text" name="phone" required placeholder="Contact number" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
      </div>
      <div>
        <label for="address" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Address</label>
        <input id="address" type="text" name="address" required placeholder="Delivery / pickup address" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
      </div>
      <button type="submit" class="inline-flex w-full min-h-11 items-center justify-center rounded-full bg-copper text-sm font-semibold text-white shadow-md transition hover:bg-copper-strong">Join LiquorHub</button>
    </form>

    <div class="mt-5 text-center text-sm text-ink-muted">
      Already a member? <a href="login" class="font-medium text-copper-strong hover:underline">Sign in</a>
    </div>
  </div>
</body>
</html>
