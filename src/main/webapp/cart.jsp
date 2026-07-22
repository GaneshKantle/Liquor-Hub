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
  int lines = 0;
  double total = 0;
  if (cartItems != null && cartProducts != null) {
    for (int i = 0; i < cartItems.size(); i++) {
      ProductDTO p = i < cartProducts.size() ? cartProducts.get(i) : null;
      if (p == null) continue;
      lines++;
      total += p.getPrice() * Math.max(1, cartItems.get(i).getQuantity());
    }
  }
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cart | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/toast.css">
  <link rel="stylesheet" href="<%= ctx %>/css/cart-shelf.css">
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
            display: ['-apple-system', 'BlinkMacSystemFont', 'SF Pro Display', 'SF Pro Text', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif'],
            sans: ['-apple-system', 'BlinkMacSystemFont', 'SF Pro Text', 'SF Pro Display', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif']
          }
        }
      }
    };
  </script>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      -webkit-font-smoothing: antialiased;
      background: #f5f5f7;
    }
    .font-display { font-weight: 600; letter-spacing: -0.02em; }
    .lh-cart-row {
      transform: translateZ(0);
      transition: transform 0.35s cubic-bezier(0.22, 1, 0.36, 1), box-shadow 0.35s ease;
    }
    .lh-cart-row:hover {
      transform: translateY(-2px) scale(1.01);
      box-shadow: 0 16px 40px rgba(0,0,0,0.08);
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="min-h-screen text-ink antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />

  <header class="sticky top-0 z-20 px-4 pt-3 sm:px-6">
    <div class="mx-auto flex max-w-3xl flex-wrap items-center gap-2 rounded-full border border-black/8 bg-white/90 px-3 py-2 shadow-[0_10px_40px_rgba(0,0,0,0.06)] backdrop-blur-xl sm:px-4">
      <a href="<%= ctx %>/home" class="mr-auto font-display text-xl tracking-tight sm:text-2xl">LiquorHub</a>
      <a href="<%= ctx %>/home#items" class="inline-flex min-h-10 items-center rounded-full px-3 text-sm font-semibold text-ink-muted hover:text-ink">Shop</a>
      <a href="<%= ctx %>/profile" class="inline-flex min-h-10 items-center rounded-full bg-[#1d1d1f] px-4 text-sm font-semibold text-white">Profile</a>
    </div>
  </header>

  <main class="mx-auto max-w-3xl px-4 py-8 sm:px-6 sm:py-10">
    <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Saved cart</p>
    <h1 class="mt-2 font-display text-[clamp(1.9rem,5vw,2.6rem)] tracking-[-0.03em] text-[#1d1d1f]">Your bag</h1>
    <p class="mt-2 text-sm text-ink-muted"><%= lines %> item<%= lines == 1 ? "" : "s" %> saved to your account - buy anytime.</p>

    <% if (added) { %>
    <%-- success toast shown via toast.js (?added=1) --%>
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
            String img = ImageUrls.forProduct(p.getProductName(), p.getBrand(), p.getCategoryId());
            int qty = Math.max(1, item.getQuantity());
      %>
      <article class="lh-cart-row flex gap-4 rounded-[1.35rem] border border-black/8 bg-white p-3 sm:p-4">
        <div class="h-24 w-20 shrink-0 overflow-hidden rounded-2xl bg-[#f2f2f7] sm:h-28 sm:w-24">
          <img src="<%= img %>" alt="" loading="lazy" width="96" height="112" class="h-full w-full object-cover">
        </div>
        <div class="min-w-0 flex-1">
          <p class="text-[0.62rem] font-semibold uppercase tracking-[0.14em] text-ink-muted"><%= p.getBrand() != null ? p.getBrand() : "LiquorHub" %></p>
          <h2 class="mt-1 truncate font-semibold tracking-[-0.02em] text-[#1d1d1f]"><%= p.getProductName() %></h2>
          <p class="mt-1 text-sm font-semibold tabular-nums text-[#1d1d1f]"><%= inr.format(p.getPrice()) %></p>
          <div class="mt-3 flex flex-wrap items-center gap-3">
            <form action="<%= ctx %>/cart" method="post" class="inline-flex items-center overflow-hidden rounded-full border border-black/10 bg-[#f5f5f7]">
              <input type="hidden" name="action" value="qty">
              <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
              <button type="submit" name="quantity" value="<%= qty - 1 %>" class="px-3 py-1.5 text-sm font-semibold" aria-label="Decrease">-</button>
              <span class="min-w-[2rem] text-center text-sm font-semibold tabular-nums"><%= qty %></span>
              <button type="submit" name="quantity" value="<%= qty + 1 %>" class="px-3 py-1.5 text-sm font-semibold" aria-label="Increase">+</button>
            </form>
            <form action="<%= ctx %>/cart" method="post">
              <input type="hidden" name="action" value="remove">
              <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
              <button type="submit" class="text-xs font-semibold text-red-600 hover:underline">Remove</button>
            </form>
          </div>
        </div>
      </article>
      <%
          }
        }
        if (!any) {
      %>
      <div class="rounded-[1.5rem] border border-dashed border-black/10 bg-white p-8 text-center">
        <p class="font-display text-xl text-[#1d1d1f]">Your cart is empty</p>
        <p class="mt-2 text-sm text-ink-muted">Add bottles from the shelf - they stay saved here.</p>
        <a href="<%= ctx %>/home#items" class="mt-5 inline-flex min-h-11 items-center rounded-full bg-accent px-5 text-sm font-semibold text-white hover:bg-accent-strong">Browse bottles</a>
      </div>
      <% } %>
    </div>

    <% if (any) { %>
    <div class="mt-6 rounded-[1.5rem] border border-black/8 bg-[#1d1d1f] p-5 text-white sm:p-6">
      <div class="flex items-center justify-between gap-3">
        <span class="text-sm opacity-70">Bag total</span>
        <strong class="font-display text-2xl tracking-[-0.03em]"><%= inr.format(total) %></strong>
      </div>
      <p class="mt-2 text-xs opacity-55">Items are stored in your account cart until you purchase.</p>
      <div class="mt-4 flex flex-col gap-2 sm:flex-row">
        <a href="<%= ctx %>/buy" class="inline-flex min-h-11 flex-1 items-center justify-center rounded-full bg-accent text-sm font-semibold text-white transition hover:bg-accent-strong">Buy Now</a>
        <a href="<%= ctx %>/home#items" class="inline-flex min-h-11 flex-1 items-center justify-center rounded-full border border-white/25 text-sm font-semibold text-white transition hover:bg-white/10">Continue shopping</a>
      </div>
    </div>
    <% } %>
  </main>
  <script src="<%= ctx %>/js/toast.js" defer></script>
</body>
</html>
