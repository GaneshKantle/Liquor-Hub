<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CartItemDTO" %>
<%@ page import="com.LiquorHub.dto.ProductDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%@ page import="com.LiquorHub.utility.ImageUrls" %>
<%
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
  if (customer == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
  String ctx = request.getContextPath();
  List<CartItemDTO> cartItems = (List<CartItemDTO>) request.getAttribute("cartItems");
  List<ProductDTO> cartProducts = (List<ProductDTO>) request.getAttribute("cartProducts");
  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);
  boolean added = "1".equals(request.getParameter("added"));
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your cart | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
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
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="min-h-screen bg-cream font-sans text-ink antialiased"
  style="background-image: radial-gradient(ellipse 60% 40% at 0% 0%, rgba(217,106,59,0.12), transparent 50%), linear-gradient(180deg, #fff, #f8f5ef);">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />

  <header class="sticky top-0 z-20 px-4 pt-3 sm:px-6">
    <div class="mx-auto flex max-w-3xl flex-wrap items-center gap-3 rounded-full border border-black/10 bg-white/80 px-4 py-2.5 backdrop-blur">
      <a href="<%= ctx %>/home" class="mr-auto font-display text-2xl tracking-tight">LiquorHub</a>
      <a href="<%= ctx %>/home" class="inline-flex min-h-10 items-center rounded-full border border-black/10 bg-cream px-4 text-sm font-semibold">Shop</a>
      <a href="<%= ctx %>/dashboard" class="inline-flex min-h-10 items-center rounded-full bg-accent px-4 text-sm font-semibold text-white">Profile</a>
    </div>
  </header>

  <main class="mx-auto max-w-3xl px-4 py-8 sm:px-6 sm:py-10">
    <h1 class="font-display text-3xl tracking-[-0.03em] sm:text-4xl">Your cart</h1>
    <p class="mt-2 text-sm text-ink-muted">Simple basket - no checkout yet.</p>

    <% if (added) { %>
    <p class="mt-4 rounded-xl border border-green-700/15 bg-green-50 px-3 py-2.5 text-sm text-green-800">Added to cart.</p>
    <% } %>

    <div class="mt-6 space-y-3">
      <%
        boolean any = false;
        if (cartItems != null && cartProducts != null) {
          for (int i = 0; i < cartItems.size(); i++) {
            CartItemDTO item = cartItems.get(i);
            ProductDTO p = i < cartProducts.size() ? cartProducts.get(i) : null;
            if (p == null) continue;
            any = true;
            String img = ImageUrls.forProduct(p.getProductName(), p.getBrand());
      %>
      <article class="flex gap-4 rounded-[1.25rem] border border-black/10 bg-white/80 p-3 sm:p-4">
        <img src="<%= img %>" alt="" loading="lazy" width="96" height="96" class="h-20 w-20 shrink-0 rounded-xl object-cover sm:h-24 sm:w-24">
        <div class="min-w-0 flex-1">
          <h2 class="truncate font-semibold tracking-[-0.02em]"><%= p.getProductName() %></h2>
          <p class="text-sm text-ink-muted"><%= p.getBrand() != null ? p.getBrand() : "" %></p>
          <p class="mt-1 text-sm font-semibold text-accent-strong"><%= inr.format(p.getPrice()) %> x <%= item.getQuantity() %></p>
          <form action="<%= ctx %>/cart" method="post" class="mt-2">
            <input type="hidden" name="action" value="remove">
            <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
            <button type="submit" class="text-xs font-semibold text-red-700 hover:underline">Remove</button>
          </form>
        </div>
      </article>
      <%
          }
        }
        if (!any) {
      %>
      <p class="rounded-[1.25rem] border border-dashed border-black/10 p-6 text-center text-ink-muted">Cart is empty. <a href="<%= ctx %>/home#items" class="font-semibold text-accent-strong underline">Browse bottles</a></p>
      <% } %>
    </div>
  </main>
</body>
</html>
