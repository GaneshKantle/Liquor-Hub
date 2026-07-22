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
  <meta name="color-scheme" content="light only">
  <title>Bag | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/account.css">
  <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-account">
    <div class="lh-shell" style="max-width:44rem">
      <p class="lh-sec__kicker">Saved cart</p>
      <h1 class="lh-sec__title" style="margin:0.25rem 0 0">Your bag</h1>
      <p class="lh-sec__lede" style="margin:0.45rem 0 0">
        <%= lines %> item<%= lines == 1 ? "" : "s" %> saved to your account — buy anytime.
      </p>

      <% if (added) { %>
      <%-- success toast via toast.js (?added=1) --%>
      <% } %>

      <div style="margin-top:1.35rem">
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
        <article class="lh-account__row">
          <div class="lh-account__row-media">
            <img src="<%= img %>" alt="" loading="lazy" width="96" height="112">
          </div>
          <div class="lh-account__row-body">
            <p class="brand"><%= p.getBrand() != null ? p.getBrand() : "LiquorHub" %></p>
            <h3><%= p.getProductName() %></h3>
            <p class="price"><%= inr.format(p.getPrice()) %></p>
            <div class="lh-account__row-actions" style="margin-top:0.65rem">
              <form action="<%= ctx %>/cart" method="post" class="lh-account__qty">
                <input type="hidden" name="action" value="qty">
                <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                <button type="submit" name="quantity" value="<%= qty - 1 %>" aria-label="Decrease">−</button>
                <span><%= qty %></span>
                <button type="submit" name="quantity" value="<%= qty + 1 %>" aria-label="Increase">+</button>
              </form>
              <form action="<%= ctx %>/cart" method="post">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                <button type="submit" class="lh-btn lh-btn--danger">Remove</button>
              </form>
            </div>
          </div>
        </article>
        <%
            }
          }
          if (!any) {
        %>
        <div class="lh-account__empty">
          <h3>Your cart is empty</h3>
          <p>Add bottles from the floor — they stay saved here.</p>
          <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">Browse lots</a>
        </div>
        <% } %>
      </div>

      <% if (any) { %>
      <div class="lh-account__total">
        <div class="row">
          <span class="label">Bag total</span>
          <strong><%= inr.format(total) %></strong>
        </div>
        <p class="note">Items stay in your account cart until you purchase.</p>
        <div class="actions">
          <a href="<%= ctx %>/buy" class="lh-btn lh-btn--signal">Buy now</a>
          <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--ghost">Continue shopping</a>
        </div>
      </div>
      <% } %>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/toast.js" defer></script>
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
