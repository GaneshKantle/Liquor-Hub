<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.ProductDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%@ page import="com.LiquorHub.utility.ImageUrls" %>
<%
  String ctx = request.getContextPath();
  List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
  List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
  Integer productTotalObj = (Integer) request.getAttribute("productTotal");
  Integer filterCat = (Integer) request.getAttribute("filterCat");
  int productTotal = productTotalObj != null ? productTotalObj.intValue() : (products != null ? products.size() : 0);
  int shown = products != null ? products.size() : 0;
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
  boolean loggedIn = customer != null;
  Set<Integer> wishlistIds = (Set<Integer>) request.getAttribute("wishlistIds");
  if (wishlistIds == null) wishlistIds = new HashSet<>();
  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);
  String accountHref = loggedIn ? ctx + "/profile" : ctx + "/login";
  String accountLabel = loggedIn ? "Profile" : "Sign in";
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Full catalogue | LiquorHub</title>
  <meta name="description" content="Browse every bottle on the LiquorHub floor.">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
  <link rel="stylesheet" href="<%= ctx %>/css/cart-shelf.css">
  <style>
    .sr-only { position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap;border:0 }
    .lh-catalog-top { padding: 6.5rem 0 1.5rem; }
    .lh-filters {
      display: flex; flex-wrap: wrap; gap: 0.45rem; margin-top: 1.25rem;
    }
    .lh-filters a {
      display: inline-flex; align-items: center; min-height: 2.2rem;
      padding: 0.35rem 0.75rem; border: 1.5px solid var(--carbon);
      background: var(--chalk); font-size: 0.68rem; font-weight: 700;
      letter-spacing: 0.08em; text-transform: uppercase;
    }
    .lh-filters a.is-on {
      background: var(--carbon); color: #e8ff6a; border-color: var(--carbon);
    }
    .lh-catalog-meta {
      margin-top: 0.85rem; font-size: 0.85rem; color: var(--smoke);
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-logged-in="<%= loggedIn ? "1" : "0" %>" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main>
    <section class="lh-catalog-top">
      <div class="lh-shell">
        <p class="lh-sec__kicker">Full floor</p>
        <h1 class="lh-sec__title">All products</h1>
        <p class="lh-sec__lede">Every lot on LiquorHub. Filter by spirit, then bag or buy.</p>
        <div class="lh-filters" role="navigation" aria-label="Filter by spirit">
          <a href="<%= ctx %>/catalog" class="<%= filterCat == null ? "is-on" : "" %>">All</a>
          <% if (categories != null) {
               for (CategoryDTO cat : categories) {
                 boolean on = filterCat != null && filterCat.intValue() == cat.getCategoryId();
          %>
          <a href="<%= ctx %>/catalog?cat=<%= cat.getCategoryId() %>" class="<%= on ? "is-on" : "" %>"><%= cat.getCategoryName() %></a>
          <%   }
             } %>
        </div>
        <p class="lh-catalog-meta">Showing <strong><%= shown %></strong> of <strong><%= productTotal %></strong> lots
          · <a href="<%= ctx %>/home" style="font-weight:700;text-decoration:underline">Back to home</a>
          · <a href="<%= accountHref %>" style="font-weight:700;text-decoration:underline"><%= accountLabel %></a>
        </p>
      </div>
    </section>

    <section class="lh-sec" style="padding-top:0.5rem">
      <div class="lh-shell">
        <div id="productGrid" class="lh-archive lh-shelf">
          <% if (products != null && !products.isEmpty()) {
               int lotN = 0;
               for (ProductDTO p : products) {
                 lotN++;
                 String brand = p.getBrand() != null ? p.getBrand() : "";
                 String nameLower = (p.getProductName() + " " + brand).toLowerCase()
                     .replace("\"", "").replace("'", "").replace("<", "").replace(">", "");
                 String img = ImageUrls.forProduct(p.getProductName(), brand, p.getCategoryId());
                 String safeName = p.getProductName() != null ? p.getProductName().replace("\"", "") : "Bottle";
                 String lotId = String.format("LH-%04d", p.getProductId() > 0 ? p.getProductId() : lotN);
                 boolean wished = wishlistIds.contains(Integer.valueOf(p.getProductId()));
          %>
          <article class="lh-lot lh-prod"
            data-cat="<%= p.getCategoryId() %>"
            data-search="<%= nameLower %>"
            data-name="<%= safeName %>">
            <span class="lh-lot__index"><%= lotId %></span>
            <div class="lh-lot__media lh-prod__media">
              <img src="<%= img %>" alt="<%= safeName %>" loading="lazy" decoding="async" width="640" height="800">
              <% if (loggedIn) { %>
              <button type="button" class="lh-wish<%= wished ? " is-active" : "" %>" data-product-id="<%= p.getProductId() %>"
                aria-label="<%= wished ? "Remove from wishlist" : "Add to wishlist" %>" aria-pressed="<%= wished ? "true" : "false" %>">
                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 21s-7.2-4.35-9.6-8.4C.7 9.6 2.1 6 5.4 6c1.8 0 3.15 1.05 3.9 2.1C10.05 7.05 11.4 6 13.2 6c3.3 0 4.7 3.6 3 6.6C19.2 16.65 12 21 12 21z"/></svg>
              </button>
              <% } else {
                   String nextWish = java.net.URLEncoder.encode(ctx + "/catalog", "UTF-8");
              %>
              <a href="<%= ctx %>/login?reason=wishlist&amp;next=<%= nextWish %>" class="lh-wish lh-wish-guest" aria-label="Sign in to save favourite">
                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 21s-7.2-4.35-9.6-8.4C.7 9.6 2.1 6 5.4 6c1.8 0 3.15 1.05 3.9 2.1C10.05 7.05 11.4 6 13.2 6c3.3 0 4.7 3.6 3 6.6C19.2 16.65 12 21 12 21z"/></svg>
              </a>
              <% } %>
            </div>
            <div class="lh-lot__body lh-prod__body">
              <span class="lh-lot__brand"><%= brand.isEmpty() ? "LiquorHub" : brand %></span>
              <h3 class="lh-lot__name"><%= p.getProductName() %></h3>
              <div class="lh-lot__price">
                <strong><%= inr.format(p.getPrice()) %></strong>
                <span>INR</span>
              </div>
              <div class="lh-lot__actions">
              <% if (loggedIn) { %>
                <form action="<%= ctx %>/add-to-cart" method="post" class="lh-atc-form">
                  <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                  <button type="submit" class="lh-btn lh-btn--signal lh-atc" style="width:100%">
                    <span class="lh-atc__label-add">Bag lot</span>
                    <span class="lh-atc__label-done">Bagged</span>
                  </button>
                </form>
                <a href="<%= ctx %>/buy-now?productId=<%= p.getProductId() %>" class="lh-btn lh-btn--chalk">Buy now</a>
              <% } else {
                   String nextCat = java.net.URLEncoder.encode(ctx + "/catalog", "UTF-8");
                   String nextBuy = java.net.URLEncoder.encode(ctx + "/buy-now?productId=" + p.getProductId(), "UTF-8");
              %>
                <a href="<%= ctx %>/login?reason=cart&amp;next=<%= nextCat %>" class="lh-btn lh-btn--chalk">Bag lot</a>
                <a href="<%= ctx %>/login?reason=buy&amp;next=<%= nextBuy %>" class="lh-btn lh-btn--carbon">Buy now</a>
              <% } %>
              </div>
            </div>
          </article>
          <%   }
             } else { %>
          <p class="lh-panel" style="grid-column:1/-1">No lots in this filter. Try All.</p>
          <% } %>
        </div>
        <p id="productEmpty" class="lh-panel hidden" style="margin-top:1rem;text-align:center">No lots match that scan.</p>
      </div>
    </section>
  </main>

  <% if (loggedIn) { %>
  <a id="lhCartDock" href="<%= ctx %>/cart" class="lh-cart-dock" aria-label="Open cart">
    <span class="lh-cart-dock__icon" aria-hidden="true">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M6 6h15l-1.5 9h-12z"/><path d="M6 6L5 3H2"/><circle cx="9" cy="20" r="1.4"/><circle cx="18" cy="20" r="1.4"/></svg>
    </span>
    <span class="lh-cart-dock__meta">
      <span class="lh-cart-dock__title">Bag</span>
      <span class="lh-cart-dock__count"><span id="lhCartCountLabel">Ready</span></span>
    </span>
  </a>
  <% } %>
  <div id="lhToast" class="lh-toast" role="status" aria-live="polite" hidden>
    <p class="lh-toast__title" id="lhToastTitle">Bagged</p>
    <p class="lh-toast__sub" id="lhToastSub"><a href="<%= ctx %>/cart">View bag</a></p>
  </div>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/toast.js" defer></script>
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
