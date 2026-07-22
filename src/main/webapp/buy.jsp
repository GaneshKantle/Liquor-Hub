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
  Double cartTotalObj = (Double) request.getAttribute("cartTotal");
  double total = cartTotalObj != null ? cartTotalObj.doubleValue() : 0;
  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);
  String buyError = (String) request.getAttribute("buyError");
  String addr = customer.getAddress() != null ? customer.getAddress() : "";
  String phone = customer.getPhone() != null ? customer.getPhone() : "";
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Buy Now | LiquorHub</title>
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
    body {
      font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      -webkit-font-smoothing: antialiased;
      background: #f5f5f7;
    }
    .font-display { font-weight: 600; letter-spacing: -0.02em; }
    .lh-pay:checked + label {
      border-color: #d96a3b;
      background: rgba(217,106,59,0.08);
      box-shadow: 0 0 0 1px #d96a3b;
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="min-h-screen text-ink antialiased">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />

  <header class="sticky top-0 z-20 px-4 pt-3 sm:px-6">
    <div class="mx-auto flex max-w-5xl flex-wrap items-center gap-2 rounded-full border border-black/8 bg-white/90 px-3 py-2 shadow-[0_10px_40px_rgba(0,0,0,0.06)] backdrop-blur-xl sm:px-4">
      <a href="<%= ctx %>/home" class="mr-auto font-display text-xl tracking-tight sm:text-2xl">LiquorHub</a>
      <a href="<%= ctx %>/cart" class="inline-flex min-h-10 items-center rounded-full px-3 text-sm font-semibold text-ink-muted hover:text-ink">Cart</a>
      <a href="<%= ctx %>/profile" class="inline-flex min-h-10 items-center rounded-full bg-[#1d1d1f] px-4 text-sm font-semibold text-white">Profile</a>
    </div>
  </header>

  <main class="mx-auto max-w-5xl px-4 py-8 sm:px-6 sm:py-10">
    <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Checkout</p>
    <h1 class="mt-2 font-display text-[clamp(1.9rem,5vw,2.75rem)] tracking-[-0.03em] text-[#1d1d1f]">Buy Now</h1>
    <p class="mt-2 max-w-xl text-sm text-ink-muted">Confirm delivery, pick a payment method, and place your order. Cart items stay saved until you buy.</p>

    <% if (buyError != null) { %>
    <p class="mt-4 rounded-2xl border border-red-700/15 bg-red-50 px-4 py-3 text-sm text-red-800"><%= buyError %></p>
    <% } %>

    <form action="<%= ctx %>/buy" method="post" class="mt-8 grid gap-6 lg:grid-cols-[1.15fr_0.85fr]">
      <div class="space-y-4">
        <section class="rounded-[1.5rem] border border-black/8 bg-white p-5 sm:p-6">
          <h2 class="font-display text-xl tracking-[-0.02em] text-[#1d1d1f]">Delivering to</h2>
          <div class="mt-4 grid gap-3 sm:grid-cols-2">
            <div class="rounded-2xl bg-[#f5f5f7] p-4">
              <p class="text-[0.62rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Name</p>
              <p class="mt-1 font-semibold"><%= customer.getName() %></p>
            </div>
            <div class="rounded-2xl bg-[#f5f5f7] p-4">
              <p class="text-[0.62rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Phone</p>
              <p class="mt-1 font-semibold"><%= phone %></p>
            </div>
            <div class="rounded-2xl bg-[#f5f5f7] p-4 sm:col-span-2">
              <p class="text-[0.62rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Address</p>
              <p class="mt-1 font-semibold"><%= addr %></p>
              <a href="<%= ctx %>/profile#edit" class="mt-2 inline-block text-xs font-semibold text-accent-strong hover:underline">Edit in profile</a>
            </div>
          </div>
        </section>

        <section class="rounded-[1.5rem] border border-black/8 bg-white p-5 sm:p-6">
          <h2 class="font-display text-xl tracking-[-0.02em] text-[#1d1d1f]">Payment method</h2>
          <div class="mt-4 grid gap-2">
            <div>
              <input class="lh-pay peer sr-only" type="radio" name="paymentMethod" id="payUpi" value="UPI" checked>
              <label for="payUpi" class="flex cursor-pointer items-center justify-between rounded-2xl border border-black/10 bg-[#fbfbfd] px-4 py-3.5 transition">
                <span class="font-semibold">UPI</span>
                <span class="text-xs text-ink-muted">GPay / PhonePe / Paytm</span>
              </label>
            </div>
            <div>
              <input class="lh-pay peer sr-only" type="radio" name="paymentMethod" id="payCard" value="Card">
              <label for="payCard" class="flex cursor-pointer items-center justify-between rounded-2xl border border-black/10 bg-[#fbfbfd] px-4 py-3.5 transition">
                <span class="font-semibold">Card</span>
                <span class="text-xs text-ink-muted">Debit / Credit</span>
              </label>
            </div>
            <div>
              <input class="lh-pay peer sr-only" type="radio" name="paymentMethod" id="payCod" value="COD">
              <label for="payCod" class="flex cursor-pointer items-center justify-between rounded-2xl border border-black/10 bg-[#fbfbfd] px-4 py-3.5 transition">
                <span class="font-semibold">Cash on delivery</span>
                <span class="text-xs text-ink-muted">Pay at door</span>
              </label>
            </div>
          </div>
        </section>

        <section class="rounded-[1.5rem] border border-black/8 bg-white p-5 sm:p-6">
          <h2 class="font-display text-xl tracking-[-0.02em] text-[#1d1d1f]">Order items</h2>
          <div class="mt-4 space-y-3">
            <%
              if (cartItems != null && cartProducts != null) {
                for (int i = 0; i < cartItems.size(); i++) {
                  CartItemDTO item = cartItems.get(i);
                  ProductDTO p = i < cartProducts.size() ? cartProducts.get(i) : null;
                  if (p == null) continue;
                  String img = ImageUrls.forProduct(p.getProductName(), p.getBrand());
            %>
            <article class="flex gap-3 rounded-2xl bg-[#f5f5f7] p-3">
              <img src="<%= img %>" alt="" class="h-16 w-14 rounded-xl object-cover" width="56" height="64" loading="lazy">
              <div class="min-w-0 flex-1">
                <p class="truncate font-semibold tracking-[-0.02em]"><%= p.getProductName() %></p>
                <p class="text-xs text-ink-muted"><%= p.getBrand() %> · Qty <%= item.getQuantity() %></p>
                <p class="mt-1 text-sm font-semibold tabular-nums"><%= inr.format(p.getPrice() * item.getQuantity()) %></p>
              </div>
            </article>
            <%   }
              } %>
          </div>
        </section>
      </div>

      <aside class="h-fit rounded-[1.5rem] border border-black/8 bg-[#1d1d1f] p-5 text-white shadow-[0_24px_60px_rgba(0,0,0,0.18)] sm:p-6 lg:sticky lg:top-24">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-white/55">Order summary</p>
        <div class="mt-4 flex items-end justify-between gap-3 border-b border-white/10 pb-4">
          <span class="text-sm text-white/70">Total payable</span>
          <strong class="font-display text-3xl tracking-[-0.03em]"><%= inr.format(total) %></strong>
        </div>
        <ul class="mt-4 space-y-2 text-sm text-white/65">
          <li>Saved cart converted to an order</li>
          <li>Shown later in Profile → Buying history</li>
          <li>Demo payment marked as Paid</li>
        </ul>
        <button type="submit" class="mt-6 inline-flex min-h-12 w-full items-center justify-center rounded-full bg-accent text-sm font-semibold text-white transition hover:bg-accent-strong">
          Place order
        </button>
        <a href="<%= ctx %>/cart" class="mt-3 inline-flex min-h-11 w-full items-center justify-center rounded-full border border-white/20 text-sm font-semibold text-white/90 transition hover:bg-white/10">Back to cart</a>
      </aside>
    </form>
  </main>
</body>
</html>
