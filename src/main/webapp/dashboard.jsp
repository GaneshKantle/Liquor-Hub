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
  <title>Desk | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-account">
    <div class="lh-shell">
      <section class="lh-account__hero">
        <div class="lh-account__banner" aria-hidden="true">
          <img
            src="<%= ImageUrls.profileBanner() %>"
            alt=""
            width="1600"
            height="480"
            decoding="async"
            fetchpriority="high">
        </div>
        <div class="lh-account__hero-body">
          <div class="lh-account__avatar" aria-hidden="true"><%= initial %></div>
          <div>
            <p class="lh-sec__kicker">Collector desk</p>
            <h1 class="lh-sec__title" style="margin:0.2rem 0 0"><%= name %></h1>
            <p class="lh-sec__lede" style="margin:0.4rem 0 0">CUST<%= customer.getCustomerId() %> · Member on LiquorHub</p>
          </div>
          <div class="lh-account__actions">
            <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">Browse lots</a>
            <a href="<%= ctx %>/cart" class="lh-btn lh-btn--chalk">Bag</a>
            <a href="#wishlist" class="lh-btn lh-btn--ghost">Wishlist</a>
            <a href="<%= ctx %>/logout" class="lh-btn lh-btn--danger">Logout</a>
          </div>
        </div>
      </section>

      <% if (success != null) { %>
      <p class="lh-account__flash"><%= success %></p>
      <% } %>
      <% if (ordered != null) { %>
      <%-- success toast via toast.js (?ordered=) --%>
      <% } %>

      <section class="lh-account__grid" aria-label="Quick actions">
        <a href="<%= ctx %>/catalog" class="lh-account__tile">
          <p>Explore</p>
          <h2>Catalogue</h2>
          <span>Full floor of lots.</span>
        </a>
        <a href="<%= ctx %>/cart" class="lh-account__tile">
          <p>Cart</p>
          <h2>Saved bag</h2>
          <span>Items stay until you buy.</span>
        </a>
        <a href="#wishlist" class="lh-account__tile">
          <p>Wishlist</p>
          <h2>Favourites</h2>
          <span>Bottles you hearted.</span>
        </a>
        <a href="#history" class="lh-account__tile">
          <p>Orders</p>
          <h2>Buying history</h2>
          <span>Past purchases.</span>
        </a>
      </section>

      <section id="wishlist" class="lh-account__block scroll-mt-28">
        <p class="lh-sec__kicker">Wishlist</p>
        <h2 class="lh-sec__title">Your favourites</h2>
        <p class="lh-sec__lede">Tap the heart on any bottle to save it here.</p>
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
        <article class="lh-account__row">
          <div class="lh-account__row-media">
            <img src="<%= img %>" alt="<%= safeName %>" width="80" height="100" loading="lazy">
          </div>
          <div class="lh-account__row-body">
            <p class="brand"><%= brand.isEmpty() ? "LiquorHub" : brand %></p>
            <h3><%= safeName %></h3>
            <p class="price"><%= inr.format(p.getPrice()) %></p>
          </div>
          <div class="lh-account__row-actions">
            <form action="<%= ctx %>/add-to-cart" method="post">
              <input type="hidden" name="productId" value="<%= p.getProductId() %>">
              <button type="submit" class="lh-btn lh-btn--signal">Add to cart</button>
            </form>
            <a href="<%= ctx %>/buy-now?productId=<%= p.getProductId() %>" class="lh-btn lh-btn--chalk">Buy now</a>
            <form action="<%= ctx %>/wishlist" method="post">
              <input type="hidden" name="action" value="remove">
              <input type="hidden" name="wishlistItemId" value="<%= w.getWishlistItemId() %>">
              <input type="hidden" name="redirect" value="<%= ctx %>/profile#wishlist">
              <button type="submit" class="lh-btn lh-btn--danger">Remove</button>
            </form>
          </div>
        </article>
        <%
            }
          }
          if (!hasWish) {
        %>
        <div class="lh-account__empty">
          <h3>No favourites yet</h3>
          <p>Browse the floor and tap the heart on bottles you love.</p>
          <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">Browse lots</a>
        </div>
        <% } %>
      </section>

      <section id="history" class="lh-account__block scroll-mt-28">
        <p class="lh-sec__kicker">Buying history</p>
        <h2 class="lh-sec__title">Your orders</h2>
        <p class="lh-sec__lede">Every completed Buy Now shows up here.</p>
        <%
          boolean hasOrders = false;
          if (orders != null) {
            for (OrderDTO o : orders) {
              if (o == null) continue;
              hasOrders = true;
        %>
        <article class="lh-account__row">
          <div class="lh-account__row-body">
            <h3>Order #<%= o.getOrderId() %></h3>
            <p class="meta"><%= o.getOrderDate() != null ? o.getOrderDate() : "-" %> · <%= o.getStatus() != null ? o.getStatus() : "Placed" %></p>
          </div>
          <p class="price" style="margin:0"><%= inr.format(o.getTotalAmount()) %></p>
        </article>
        <%
            }
          }
          if (!hasOrders) {
        %>
        <div class="lh-account__empty">
          <h3>No purchases yet</h3>
          <p>Add bottles to cart, then Buy Now.</p>
        </div>
        <% } %>
      </section>

      <div class="lh-account__split">
        <section class="lh-account__block" aria-labelledby="overviewTitle">
          <p class="lh-sec__kicker">Overview</p>
          <h2 id="overviewTitle" class="lh-sec__title">Account details</h2>
          <p class="lh-sec__lede">What we use when you shop or update your desk.</p>
          <dl class="lh-account__dl">
            <div>
              <dt>Member ID</dt>
              <dd>CUST<%= customer.getCustomerId() %></dd>
            </div>
            <div>
              <dt>Name</dt>
              <dd><%= customer.getName() %></dd>
            </div>
            <div>
              <dt>Email</dt>
              <dd><%= customer.getEmail() %></dd>
            </div>
            <div>
              <dt>Phone</dt>
              <dd><%= customer.getPhone() %></dd>
            </div>
            <div>
              <dt>Address</dt>
              <dd><%= customer.getAddress() %></dd>
            </div>
          </dl>
        </section>

        <section id="edit" class="lh-account__block" aria-labelledby="editTitle">
          <p class="lh-sec__kicker">Edit</p>
          <h2 id="editTitle" class="lh-sec__title">Update profile</h2>
          <p class="lh-sec__lede">Change your details anytime. Password is optional.</p>
          <form action="<%= ctx %>/update" method="POST" class="lh-account__form">
            <div>
              <label for="name">Name</label>
              <input id="name" type="text" name="name" value="<%= customer.getName() %>" required>
            </div>
            <div>
              <label for="mail">Email</label>
              <input id="mail" type="email" name="mail" value="<%= customer.getEmail() %>" required>
            </div>
            <div>
              <label for="phone">Phone</label>
              <input id="phone" type="text" name="phone" value="<%= customer.getPhone() %>" required>
            </div>
            <div>
              <label for="address">Address</label>
              <input id="address" type="text" name="address" value="<%= customer.getAddress() %>" required>
            </div>
            <div>
              <label for="password">Password</label>
              <input id="password" type="password" name="password" placeholder="Leave blank to keep current">
              <p class="hint">Only fill this if you want to change your password.</p>
            </div>
            <button type="submit" class="lh-btn lh-btn--signal">Save changes</button>
          </form>
        </section>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/toast.js" defer></script>
  <script src="<%= ctx %>/js/gates.js" defer></script>
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
