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
  <meta name="color-scheme" content="light only">
  <title>Buy Now | LiquorHub</title>
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
    <div class="lh-shell">
      <p class="lh-sec__kicker">Checkout</p>
      <h1 class="lh-sec__title" style="margin:0.25rem 0 0">Buy now</h1>
      <p class="lh-sec__lede" style="margin:0.45rem 0 0">Confirm delivery, pick payment, and place the order.</p>

      <% if (buyError != null) { %>
      <p class="lh-account__flash" style="margin-top:1rem;border-color:#b0180c;background:#ffe8e5;color:#b0180c"><%= buyError %></p>
      <% } %>

      <form action="<%= ctx %>/buy" method="post" class="lh-buy-grid">
        <div>
          <section class="lh-account__block">
            <p class="lh-sec__kicker">Delivering to</p>
            <h2 class="lh-sec__title">Profile details</h2>
            <div class="lh-buy-meta">
              <div>
                <p>Name</p>
                <strong><%= customer.getName() %></strong>
              </div>
              <div>
                <p>Phone</p>
                <strong><%= phone %></strong>
              </div>
              <div class="wide">
                <p>Address</p>
                <strong><%= addr %></strong>
                <a href="<%= ctx %>/profile#edit" style="display:inline-block;margin-top:0.5rem;font-size:0.8rem;font-weight:700;text-decoration:underline">Edit in profile</a>
              </div>
            </div>
          </section>

          <section class="lh-account__block">
            <p class="lh-sec__kicker">Payment</p>
            <h2 class="lh-sec__title">Method</h2>
            <div style="margin-top:0.75rem">
              <input class="lh-pay" type="radio" name="paymentMethod" id="payUpi" value="UPI" checked>
              <label for="payUpi"><span>UPI</span><span>GPay / PhonePe / Paytm</span></label>
              <input class="lh-pay" type="radio" name="paymentMethod" id="payCard" value="Card">
              <label for="payCard"><span>Card</span><span>Debit / Credit</span></label>
              <input class="lh-pay" type="radio" name="paymentMethod" id="payCod" value="COD">
              <label for="payCod"><span>Cash on delivery</span><span>Pay at door</span></label>
            </div>
          </section>

          <section class="lh-account__block">
            <p class="lh-sec__kicker">Lots</p>
            <h2 class="lh-sec__title">Order items</h2>
            <%
              if (cartItems != null && cartProducts != null) {
                for (int i = 0; i < cartItems.size(); i++) {
                  CartItemDTO item = cartItems.get(i);
                  ProductDTO p = i < cartProducts.size() ? cartProducts.get(i) : null;
                  if (p == null) continue;
                  String img = ImageUrls.forProduct(p.getProductName(), p.getBrand(), p.getCategoryId());
            %>
            <article class="lh-account__row">
              <div class="lh-account__row-media">
                <img src="<%= img %>" alt="" width="56" height="64" loading="lazy">
              </div>
              <div class="lh-account__row-body">
                <h3><%= p.getProductName() %></h3>
                <p class="meta"><%= p.getBrand() %> · Qty <%= item.getQuantity() %></p>
                <p class="price"><%= inr.format(p.getPrice() * item.getQuantity()) %></p>
              </div>
            </article>
            <%   }
              } %>
          </section>
        </div>

        <aside class="lh-account__total lh-buy-aside">
          <p class="label">Order summary</p>
          <div class="row" style="margin-top:0.75rem">
            <span class="label" style="opacity:0.7">Total payable</span>
            <strong><%= inr.format(total) %></strong>
          </div>
          <p class="note">Saved cart becomes an order · Shown in Profile → Buying history · Demo payment marked Paid</p>
          <div class="actions">
            <button type="submit" class="lh-btn lh-btn--signal">Place order</button>
            <a href="<%= ctx %>/cart" class="lh-btn lh-btn--ghost">Back to bag</a>
          </div>
        </aside>
      </form>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
