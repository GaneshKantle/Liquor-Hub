<%@page import="com.LiquorHub.dto.CustomerDTO"%>
<%@page import="com.LiquorHub.dto.OrderDTO"%>
<%@page import="com.LiquorHub.dto.ProductDTO"%>
<%@page import="com.LiquorHub.dto.WishlistItemDTO"%>
<%@page import="com.LiquorHub.utility.ImageUrls"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
  if (customer == null) {
    request.setAttribute("error", "Already session Expired");
    request.getRequestDispatcher("/login.jsp").forward(request, response);
    return;
  }
  String ctx = request.getContextPath();
  String name = customer.getName() != null ? customer.getName() : "Collector";
  String initial = name.isEmpty() ? "L" : name.substring(0, 1).toUpperCase();
  String success = (String) request.getAttribute("success");
  String ordered = request.getParameter("ordered");
  List<OrderDTO> orders = (List<OrderDTO>) request.getAttribute("orders");
  List<WishlistItemDTO> wishlistItems = (List<WishlistItemDTO>) request.getAttribute("wishlistItems");
  List<ProductDTO> wishlistProducts = (List<ProductDTO>) request.getAttribute("wishlistProducts");
  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Profile | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/toast.css">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#f8f5ef', soft: '#fffcf7', strong: '#f1ece4' },
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
    }
    .font-display {
      font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      font-weight: 600;
      letter-spacing: -0.02em;
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="min-h-screen overflow-x-clip bg-cream font-sans text-ink antialiased" data-ctx="<%= ctx %>"
  style="background-image: radial-gradient(ellipse 70% 45% at 10% 0%, rgba(217,106,59,0.14), transparent 50%), radial-gradient(ellipse 50% 40% at 100% 100%, rgba(255,255,255,0.9), transparent 45%), linear-gradient(180deg, #fff, #f8f5ef);">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/age-gate.jsp" />

  <header class="sticky top-0 z-30 px-4 pt-3 sm:px-6">
    <div class="mx-auto flex max-w-5xl flex-wrap items-center gap-2 rounded-full border border-black/[0.08] bg-white/90 px-3 py-2 shadow-[0_10px_40px_rgba(38,34,29,0.06)] backdrop-blur-xl sm:gap-3 sm:px-4 sm:py-2.5">
      <a href="<%= ctx %>/home" class="mr-auto font-display text-xl tracking-tight sm:text-2xl">LiquorHub</a>
      <a href="<%= ctx %>/home" class="inline-flex min-h-10 items-center rounded-full px-3 text-sm font-semibold text-ink-muted transition hover:text-ink">Shop</a>
      <a href="<%= ctx %>/cart" class="inline-flex min-h-10 items-center rounded-full px-3 text-sm font-semibold text-ink-muted transition hover:text-ink">Cart</a>
      <a href="<%= ctx %>/dashboard" class="inline-flex min-h-10 items-center rounded-full bg-accent px-4 text-sm font-semibold text-white">Profile</a>
      <a href="<%= ctx %>/logout" class="inline-flex min-h-10 items-center rounded-full border border-red-200 bg-red-50/60 px-3 text-sm font-semibold text-red-700 transition hover:bg-red-50">Logout</a>
    </div>
  </header>

  <main class="relative mx-auto max-w-5xl px-4 pb-16 pt-8 sm:px-6 sm:pt-10">
    <!-- Profile hero -->
    <section class="overflow-hidden rounded-[1.75rem] border border-black/[0.08] bg-white shadow-[0_20px_60px_rgba(38,34,29,0.06)]">
      <div class="relative h-36 bg-[linear-gradient(135deg,#d96a3b_0%,#a84822_45%,#13110d_100%)] sm:h-44" aria-hidden="true">
        <div class="absolute inset-0 opacity-30"
          style="background-image:radial-gradient(circle at 20% 30%, rgba(255,255,255,0.45), transparent 40%), radial-gradient(circle at 80% 70%, rgba(255,255,255,0.2), transparent 35%);"></div>
      </div>
      <div class="relative px-5 pb-6 sm:px-8 sm:pb-8">
        <div class="-mt-12 flex flex-col gap-4 sm:-mt-14 sm:flex-row sm:items-end sm:justify-between">
          <div class="flex items-end gap-4">
            <div class="flex h-24 w-24 items-center justify-center rounded-full border-4 border-white bg-accent-soft font-display text-3xl text-accent-strong shadow-md sm:h-28 sm:w-28 sm:text-4xl" aria-hidden="true"><%= initial %></div>
            <div class="pb-1">
              <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Collector profile</p>
              <h1 class="font-display text-[clamp(1.75rem,4vw,2.35rem)] tracking-[-0.03em]"><%= name %></h1>
              <p class="mt-1 text-sm text-ink-muted">CUST<%= customer.getCustomerId() %> · Member on LiquorHub</p>
            </div>
          </div>
          <div class="flex flex-wrap gap-2 pb-1">
            <a href="<%= ctx %>/home#items" class="inline-flex min-h-10 items-center rounded-full bg-accent px-4 text-sm font-semibold text-white transition hover:bg-accent-strong">Browse bottles</a>
            <a href="<%= ctx %>/cart" class="inline-flex min-h-10 items-center rounded-full border border-black/10 bg-cream px-4 text-sm font-semibold text-ink transition hover:bg-white">View cart</a>
            <a href="#wishlist" class="inline-flex min-h-10 items-center rounded-full border border-black/10 bg-cream px-4 text-sm font-semibold text-ink transition hover:bg-white">Wishlist</a>
          </div>
        </div>
      </div>
    </section>

    <% if (success != null) { %>
    <p class="mt-5 rounded-2xl border border-green-700/15 bg-green-50 px-4 py-3 text-sm text-green-800"><%= success %></p>
    <% } %>
    <% if (ordered != null) { %>
    <%-- success toast shown via toast.js (?ordered=) --%>
    <% } %>

    <!-- Quick links -->
    <section class="mt-6 grid gap-3 sm:grid-cols-2 lg:grid-cols-4" aria-label="Quick actions">
      <a href="<%= ctx %>/home#collections" class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white hover:shadow-[0_10px_40px_rgba(38,34,29,0.06)]">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Explore</p>
        <h2 class="mt-2 font-display text-xl tracking-[-0.02em]">Collections</h2>
        <p class="mt-1 text-sm text-ink-muted">Edited sets for how you pour.</p>
      </a>
      <a href="<%= ctx %>/cart" class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white hover:shadow-[0_10px_40px_rgba(38,34,29,0.06)]">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Cart</p>
        <h2 class="mt-2 font-display text-xl tracking-[-0.02em]">Saved bag</h2>
        <p class="mt-1 text-sm text-ink-muted">Items stay here until you buy.</p>
      </a>
      <a href="#wishlist" class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white hover:shadow-[0_10px_40px_rgba(38,34,29,0.06)]">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Wishlist</p>
        <h2 class="mt-2 font-display text-xl tracking-[-0.02em]">Favourites</h2>
        <p class="mt-1 text-sm text-ink-muted">Bottles you hearted to buy later.</p>
      </a>
      <a href="#history" class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white hover:shadow-[0_10px_40px_rgba(38,34,29,0.06)]">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Orders</p>
        <h2 class="mt-2 font-display text-xl tracking-[-0.02em]">Buying history</h2>
        <p class="mt-1 text-sm text-ink-muted">Past purchases on LiquorHub.</p>
      </a>
    </section>

    <!-- Wishlist -->
    <section id="wishlist" class="mt-6 scroll-mt-28 rounded-[1.5rem] border border-black/[0.08] bg-white/80 p-5 sm:p-6">
      <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Wishlist</p>
      <h2 class="mt-2 font-display text-2xl tracking-[-0.03em]">Your favourites</h2>
      <p class="mt-2 text-sm text-ink-muted">Tap the heart on any bottle to save it here — just like Flipkart or Amazon.</p>
      <div class="mt-5 space-y-3">
        <%
          boolean hasWish = false;
          if (wishlistItems != null && wishlistProducts != null) {
            for (int i = 0; i < wishlistItems.size(); i++) {
              WishlistItemDTO w = wishlistItems.get(i);
              ProductDTO p = i < wishlistProducts.size() ? wishlistProducts.get(i) : null;
              if (w == null || p == null) continue;
              hasWish = true;
              String brand = p.getBrand() != null ? p.getBrand() : "";
              String img = ImageUrls.forProduct(p.getProductName(), brand, p.getCategoryId());
              String safeName = p.getProductName() != null ? p.getProductName() : "Bottle";
        %>
        <article class="flex flex-col gap-4 rounded-2xl border border-black/[0.06] bg-cream/60 p-4 sm:flex-row sm:items-center">
          <div class="flex min-w-0 flex-1 items-center gap-4">
            <div class="h-20 w-16 shrink-0 overflow-hidden rounded-xl bg-white">
              <img src="<%= img %>" alt="<%= safeName %>" class="h-full w-full object-cover" width="80" height="100" loading="lazy">
            </div>
            <div class="min-w-0">
              <p class="text-[0.62rem] font-semibold uppercase tracking-[0.14em] text-ink-muted"><%= brand.isEmpty() ? "LiquorHub" : brand %></p>
              <h3 class="mt-0.5 truncate font-semibold tracking-[-0.02em]"><%= safeName %></h3>
              <p class="mt-1 font-display text-lg tabular-nums text-accent-strong"><%= inr.format(p.getPrice()) %></p>
            </div>
          </div>
          <div class="flex flex-wrap items-center gap-2 sm:justify-end">
            <form action="<%= ctx %>/add-to-cart" method="post">
              <input type="hidden" name="productId" value="<%= p.getProductId() %>">
              <button type="submit" class="inline-flex min-h-10 items-center rounded-full bg-accent px-4 text-sm font-semibold text-white transition hover:bg-accent-strong">Add to Cart</button>
            </form>
            <a href="<%= ctx %>/buy-now?productId=<%= p.getProductId() %>" class="inline-flex min-h-10 items-center rounded-full border border-black/10 bg-white px-4 text-sm font-semibold text-ink transition hover:bg-cream">Buy Now</a>
            <form action="<%= ctx %>/wishlist" method="post">
              <input type="hidden" name="action" value="remove">
              <input type="hidden" name="wishlistItemId" value="<%= w.getWishlistItemId() %>">
              <input type="hidden" name="redirect" value="<%= ctx %>/profile#wishlist">
              <button type="submit" class="inline-flex min-h-10 items-center rounded-full px-3 text-sm font-semibold text-red-700 transition hover:bg-red-50">Remove</button>
            </form>
          </div>
        </article>
        <%
            }
          }
          if (!hasWish) {
        %>
        <p class="rounded-2xl border border-dashed border-black/10 p-5 text-sm text-ink-muted">No favourites yet. Browse the shelf and tap the heart on bottles you love.</p>
        <a href="<%= ctx %>/home#items" class="mt-3 inline-flex min-h-10 items-center rounded-full bg-accent px-5 text-sm font-semibold text-white transition hover:bg-accent-strong">Browse bottles</a>
        <% } %>
      </div>
    </section>

    <!-- Buying history -->
    <section id="history" class="mt-6 scroll-mt-28 rounded-[1.5rem] border border-black/[0.08] bg-white/80 p-5 sm:p-6">
      <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Buying history</p>
      <h2 class="mt-2 font-display text-2xl tracking-[-0.03em]">Your orders</h2>
      <p class="mt-2 text-sm text-ink-muted">Every completed Buy Now shows up here.</p>
      <div class="mt-5 space-y-3">
        <%
          boolean hasOrders = false;
          if (orders != null) {
            for (OrderDTO o : orders) {
              if (o == null) continue;
              hasOrders = true;
        %>
        <article class="flex flex-col gap-2 rounded-2xl border border-black/[0.06] bg-cream/60 p-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p class="font-semibold tracking-[-0.02em]">Order #<%= o.getOrderId() %></p>
            <p class="mt-1 text-sm text-ink-muted"><%= o.getOrderDate() != null ? o.getOrderDate() : "-" %> · <%= o.getStatus() != null ? o.getStatus() : "Placed" %></p>
          </div>
          <p class="font-display text-xl tabular-nums tracking-[-0.03em] text-accent-strong"><%= inr.format(o.getTotalAmount()) %></p>
        </article>
        <%
            }
          }
          if (!hasOrders) {
        %>
        <p class="rounded-2xl border border-dashed border-black/10 p-5 text-sm text-ink-muted">No purchases yet. Add bottles to cart, then Buy Now.</p>
        <% } %>
      </div>
    </section>

    <div class="mt-6 grid gap-6 lg:grid-cols-[minmax(0,0.95fr)_minmax(0,1.05fr)]">
      <!-- Overview -->
      <section class="rounded-[1.5rem] border border-black/[0.08] bg-white/80 p-5 sm:p-6" aria-labelledby="overviewTitle">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Overview</p>
        <h2 id="overviewTitle" class="mt-2 font-display text-2xl tracking-[-0.03em]">Account details</h2>
        <p class="mt-2 text-sm text-ink-muted">What we use when you shop or update your collector profile.</p>

        <dl class="mt-6 space-y-0 divide-y divide-black/[0.06] border-t border-black/[0.08]">
          <div class="flex flex-col gap-1 py-4 sm:flex-row sm:items-baseline sm:justify-between sm:gap-4">
            <dt class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Member ID</dt>
            <dd class="font-semibold tracking-[-0.02em]">CUST<%= customer.getCustomerId() %></dd>
          </div>
          <div class="flex flex-col gap-1 py-4 sm:flex-row sm:items-baseline sm:justify-between sm:gap-4">
            <dt class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Name</dt>
            <dd class="font-semibold tracking-[-0.02em]"><%= customer.getName() %></dd>
          </div>
          <div class="flex flex-col gap-1 py-4 sm:flex-row sm:items-baseline sm:justify-between sm:gap-4">
            <dt class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Email</dt>
            <dd class="break-all font-semibold tracking-[-0.02em]"><%= customer.getEmail() %></dd>
          </div>
          <div class="flex flex-col gap-1 py-4 sm:flex-row sm:items-baseline sm:justify-between sm:gap-4">
            <dt class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Phone</dt>
            <dd class="font-semibold tracking-[-0.02em]"><%= customer.getPhone() %></dd>
          </div>
          <div class="flex flex-col gap-1 py-4 sm:flex-row sm:items-baseline sm:justify-between sm:gap-4">
            <dt class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Address</dt>
            <dd class="text-right font-semibold tracking-[-0.02em] sm:max-w-[60%]"><%= customer.getAddress() %></dd>
          </div>
        </dl>
      </section>

      <!-- Edit form — same fields / action as before -->
      <section id="edit" class="rounded-[1.5rem] border border-black/[0.08] bg-white/80 p-5 sm:p-6" aria-labelledby="editTitle">
        <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Edit</p>
        <h2 id="editTitle" class="mt-2 font-display text-2xl tracking-[-0.03em]">Update profile</h2>
        <p class="mt-2 text-sm text-ink-muted">Change your details anytime. Password is optional.</p>

        <form action="update" method="POST" class="mt-6 space-y-4">
          <div>
            <label for="name" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Name</label>
            <input id="name" type="text" name="name" value="<%= customer.getName() %>" required
              class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/70 px-4 text-sm outline-none transition focus:border-accent/40 focus:bg-white focus:ring-2 focus:ring-accent/15">
          </div>
          <div>
            <label for="mail" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Email</label>
            <input id="mail" type="email" name="mail" value="<%= customer.getEmail() %>" required
              class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/70 px-4 text-sm outline-none transition focus:border-accent/40 focus:bg-white focus:ring-2 focus:ring-accent/15">
          </div>
          <div>
            <label for="phone" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Phone</label>
            <input id="phone" type="text" name="phone" value="<%= customer.getPhone() %>" required
              class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/70 px-4 text-sm outline-none transition focus:border-accent/40 focus:bg-white focus:ring-2 focus:ring-accent/15">
          </div>
          <div>
            <label for="address" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Address</label>
            <input id="address" type="text" name="address" value="<%= customer.getAddress() %>" required
              class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/70 px-4 text-sm outline-none transition focus:border-accent/40 focus:bg-white focus:ring-2 focus:ring-accent/15">
          </div>
          <div>
            <label for="password" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Password</label>
            <input id="password" type="password" name="password" placeholder="Leave blank to keep current"
              class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/70 px-4 text-sm outline-none transition focus:border-accent/40 focus:bg-white focus:ring-2 focus:ring-accent/15">
            <p class="mt-1.5 text-xs text-ink-muted">Only fill this if you want to change your password here.</p>
          </div>
          <button type="submit" class="inline-flex min-h-11 w-full items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold text-white transition hover:bg-accent-strong sm:w-auto">Save changes</button>
        </form>
      </section>
    </div>
  </main>

  <footer class="border-t border-black/[0.08] py-6 text-center text-sm text-ink-muted">
    <a href="<%= ctx %>/home" class="font-semibold text-ink hover:text-accent">Back to shop</a>
    <span class="mx-2">·</span>
    LiquorHub profile
  </footer>
  <script src="<%= ctx %>/js/toast.js" defer></script>
  <script src="<%= ctx %>/js/gates.js" defer></script>
</body>
</html>
