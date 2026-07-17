<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Recover access | LiquorHub</title>
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
            cream: { DEFAULT: '#f8f5ef' },
            ink: { DEFAULT: '#13110d', muted: '#6a655d' },
            accent: { DEFAULT: '#d96a3b', strong: '#a84822' }
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

  <header class="relative mb-8 text-center">
    <a href="<%=request.getContextPath()%>/home" class="font-display text-4xl font-semibold tracking-tight sm:text-5xl">LiquorHub</a>
    <p class="mt-2 text-sm text-ink-muted">Rare bottles. Trusted exchange.</p>
  </header>

  <div class="glass-strong relative w-full max-w-md rounded-[2rem] p-6 sm:p-8">
    <h2 class="font-display text-2xl font-semibold tracking-tight">Forgot password</h2>
    <p class="mt-1 mb-5 text-sm text-ink-muted">Enter your email and set a new password to get back in.</p>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
    <p class="mb-4 rounded-2xl border border-red-700/15 bg-red-50/70 px-3 py-2.5 text-sm text-red-800"><%= error %></p>
    <% } %>

    <form action="forgetPassword" method="POST" class="space-y-4">
      <div>
        <label for="email" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Email</label>
        <input id="email" type="email" name="email" required placeholder="Account email" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="password" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">New password</label>
        <input id="password" type="password" name="password" required placeholder="New password" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <div>
        <label for="cpassword" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Confirm password</label>
        <input id="cpassword" type="password" name="cpassword" required placeholder="Confirm password" class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-accent/40 focus:bg-white/80 focus:ring-2 focus:ring-accent/15">
      </div>
      <button type="submit" class="inline-flex w-full min-h-11 items-center justify-center rounded-full bg-accent text-sm font-semibold text-white shadow-md transition hover:bg-accent-strong">Update password</button>
    </form>

    <div class="mt-5 text-center text-sm">
      <a href="login" class="font-medium text-accent-strong hover:underline">Back to sign in</a>
    </div>
  </div>
</body>
</html>
