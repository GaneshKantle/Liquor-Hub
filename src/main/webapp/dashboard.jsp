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
  boolean profileUpdated = "1".equals(request.getParameter("updated"));
  if (profileUpdated) {
    success = "Updated successfully.";
  }
  String formError = null;
  if ("phone".equals(request.getParameter("err"))) {
    formError = "Phone must be 10 digits or international with country code (e.g. +919876543210).";
  }
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
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/account.css">
  <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
  <link rel="stylesheet" href="<%= ctx %>/css/toast.css">
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
            <p class="lh-sec__kicker">Your profile</p>
            <h1 class="lh-sec__title" style="margin:0.2rem 0 0"><%= name %></h1>
            <p class="lh-sec__lede" style="margin:0.4rem 0 0">CUST<%= customer.getCustomerId() %> · Member on LiquorHub</p>
          </div>
          <div class="lh-account__actions">
            <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">Browse lots</a>
            <a href="<%= ctx %>/cart" class="lh-btn lh-btn--chalk">Bag</a>
            <a href="#wishlist" class="lh-btn lh-btn--ghost">Wishlist</a>
            <a href="#edit" class="lh-btn lh-btn--ghost" id="lhOpenProfileEdit">Update profile</a>
            <a href="<%= ctx %>/logout" class="lh-btn lh-btn--danger">Logout</a>
          </div>
        </div>
      </section>

      <% if (success != null) { %>
      <p class="lh-account__flash" id="lhProfileFlash"><%= success %></p>
      <% } %>
      <% if (formError != null) { %>
      <p class="lh-account__flash lh-account__flash--error"><%= formError %></p>
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
        <a href="#edit" class="lh-account__tile" data-open-profile-edit>
          <p>Account</p>
          <h2>Update profile</h2>
          <span>Name, phone, address, password.</span>
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
        <article class="lh-account__row lh-order-row" role="button" tabindex="0"
          data-order-id="<%= o.getOrderId() %>"
          data-order-date="<%= o.getOrderDate() != null ? o.getOrderDate().replace("\"", "") : "-" %>"
          data-order-status="<%= o.getStatus() != null ? o.getStatus().replace("\"", "") : "Placed" %>"
          data-order-total="<%= o.getTotalAmount() %>"
          aria-label="View order <%= o.getOrderId() %> summary">
          <div class="lh-account__row-body">
            <h3>Order #<%= o.getOrderId() %></h3>
            <p class="meta"><%= o.getOrderDate() != null ? o.getOrderDate() : "-" %> · <%= o.getStatus() != null ? o.getStatus() : "Placed" %></p>
            <p class="meta" style="margin-top:0.35rem;color:var(--signal-ink,#b0180c);font-weight:700">Tap to view items</p>
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

      <div id="edit" class="lh-profile-edit scroll-mt-28" hidden>
        <div class="lh-account__block" style="margin-bottom:1rem">
          <div style="display:flex;flex-wrap:wrap;align-items:flex-start;justify-content:space-between;gap:0.85rem">
            <div>
              <p class="lh-sec__kicker">Account</p>
              <h2 class="lh-sec__title">Update profile</h2>
              <p class="lh-sec__lede">Your details stay here until you open this panel.</p>
            </div>
            <a href="#profile-top" class="lh-btn lh-btn--ghost" id="lhCloseProfileEdit">Back to profile</a>
          </div>
        </div>
        <div class="lh-account__split">
          <section class="lh-account__block" aria-labelledby="overviewTitle">
            <p class="lh-sec__kicker">Overview</p>
            <h2 id="overviewTitle" class="lh-sec__title">Account details</h2>
            <p class="lh-sec__lede">What we use when you shop or place an order.</p>
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

          <section class="lh-account__block" aria-labelledby="editTitle">
            <p class="lh-sec__kicker">Edit</p>
            <h2 id="editTitle" class="lh-sec__title">Change details</h2>
            <p class="lh-sec__lede">Password is optional — leave blank to keep the current one.</p>
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
                <input id="phone" type="tel" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" required
                  inputmode="tel" autocomplete="tel"
                  placeholder="10 digits or +country code"
                  aria-describedby="phoneHint phoneError">
                <p id="phoneHint" class="hint">10 digits (9876543210) or international (+919876543210).</p>
                <p id="phoneError" class="lh-field-error" role="alert" hidden>Enter a valid 10-digit or international number.</p>
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
      <div id="profile-top" hidden aria-hidden="true"></div>
    </div>
  </main>

  <div id="lhOrderModal" class="lh-order-modal" hidden>
    <div class="lh-order-modal__backdrop" data-order-close></div>
    <div class="lh-order-modal__panel" role="dialog" aria-modal="true" aria-labelledby="lhOrderModalTitle">
      <div class="lh-order-modal__head">
        <div>
          <p class="lh-sec__kicker">Order summary</p>
          <h2 id="lhOrderModalTitle" class="lh-sec__title" style="font-size:1.45rem;margin:0.25rem 0 0">Order</h2>
          <p id="lhOrderModalMeta" class="lh-sec__lede" style="margin:0.35rem 0 0"></p>
        </div>
        <button type="button" class="lh-btn lh-btn--ghost" data-order-close aria-label="Close">Close</button>
      </div>
      <div id="lhOrderModalBody" class="lh-order-modal__body">
        <p class="lh-order-modal__loading">Loading items…</p>
      </div>
      <div class="lh-order-modal__foot">
        <span>Total</span>
        <strong id="lhOrderModalTotal">—</strong>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/toast.js" defer></script>
  <script src="<%= ctx %>/js/phone.js" defer></script>
  <script src="<%= ctx %>/js/gates.js" defer></script>
  <script src="<%= ctx %>/js/home.js" defer></script>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      if (window.LHPhone) {
        LHPhone.bind(
          document.querySelector(".lh-account__form"),
          document.getElementById("phone"),
          document.getElementById("phoneError")
        );
      }
    });
  </script>
  <script>
    (function () {
      var modal = document.getElementById("lhOrderModal");
      var title = document.getElementById("lhOrderModalTitle");
      var meta = document.getElementById("lhOrderModalMeta");
      var body = document.getElementById("lhOrderModalBody");
      var totalEl = document.getElementById("lhOrderModalTotal");
      var ctx = document.body.getAttribute("data-ctx") || "";
      var inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

      function openModal() {
        if (!modal) return;
        modal.hidden = false;
        document.documentElement.style.overflow = "hidden";
      }

      function closeModal() {
        if (!modal) return;
        modal.hidden = true;
        document.documentElement.style.overflow = "";
      }

      function renderItems(data) {
        if (!body) return;
        var items = (data && data.items) || [];
        if (!items.length) {
          body.innerHTML = '<p class="lh-order-modal__empty">No line items found for this order.</p>';
          return;
        }
        var html = "";
        for (var i = 0; i < items.length; i++) {
          var it = items[i];
          html +=
            '<article class="lh-order-line">' +
              '<div class="lh-order-line__media"><img src="' + (it.image || "") + '" alt="" loading="lazy" width="64" height="80"></div>' +
              '<div class="lh-order-line__body">' +
                '<p class="brand">' + escapeHtml(it.brand || "LiquorHub") + '</p>' +
                '<h3>' + escapeHtml(it.name || "Bottle") + '</h3>' +
                '<p class="meta">Qty ' + (it.qty || 1) + ' · ' + inr.format(it.price || 0) + ' each</p>' +
              '</div>' +
              '<p class="lh-order-line__total">' + inr.format(it.lineTotal || 0) + '</p>' +
            '</article>';
        }
        body.innerHTML = html;
      }

      function escapeHtml(s) {
        return String(s)
          .replace(/&/g, "&amp;")
          .replace(/</g, "&lt;")
          .replace(/>/g, "&gt;")
          .replace(/"/g, "&quot;");
      }

      function loadOrder(row) {
        var id = row.getAttribute("data-order-id");
        if (!id) return;
        if (title) title.textContent = "Order #" + id;
        if (meta) {
          meta.textContent =
            (row.getAttribute("data-order-date") || "-") +
            " · " +
            (row.getAttribute("data-order-status") || "Placed");
        }
        if (totalEl) {
          var t = parseFloat(row.getAttribute("data-order-total") || "0");
          totalEl.textContent = inr.format(isNaN(t) ? 0 : t);
        }
        if (body) body.innerHTML = '<p class="lh-order-modal__loading">Loading items…</p>';
        openModal();

        fetch(ctx + "/order-detail?orderId=" + encodeURIComponent(id), {
          credentials: "same-origin",
          headers: { Accept: "application/json" }
        })
          .then(function (res) {
            if (!res.ok) throw new Error("failed");
            return res.json();
          })
          .then(function (data) {
            if (!data || !data.ok) throw new Error("bad");
            renderItems(data);
            if (totalEl && typeof data.total === "number") {
              totalEl.textContent = inr.format(data.total);
            }
          })
          .catch(function () {
            if (body) {
              body.innerHTML = '<p class="lh-order-modal__empty">Could not load this order. Try again.</p>';
            }
          });
      }

      document.querySelectorAll(".lh-order-row").forEach(function (row) {
        row.addEventListener("click", function () { loadOrder(row); });
        row.addEventListener("keydown", function (e) {
          if (e.key === "Enter" || e.key === " ") {
            e.preventDefault();
            loadOrder(row);
          }
        });
      });

      if (modal) {
        modal.querySelectorAll("[data-order-close]").forEach(function (el) {
          el.addEventListener("click", closeModal);
        });
        document.addEventListener("keydown", function (e) {
          if (e.key === "Escape" && modal && !modal.hidden) closeModal();
        });
      }
    })();

    (function () {
      var panel = document.getElementById("edit");
      if (!panel) return;

      function showEdit(scroll) {
        panel.hidden = false;
        if (scroll) {
          requestAnimationFrame(function () {
            panel.scrollIntoView({ behavior: "smooth", block: "start" });
          });
        }
      }

      function hideEdit() {
        panel.hidden = true;
      }

      function syncFromHash() {
        var hash = (window.location.hash || "").toLowerCase();
        if (hash === "#edit") {
          showEdit(true);
        } else {
          hideEdit();
        }
      }

      window.addEventListener("hashchange", syncFromHash);
      syncFromHash();

      var closeBtn = document.getElementById("lhCloseProfileEdit");
      if (closeBtn) {
        closeBtn.addEventListener("click", function (e) {
          e.preventDefault();
          hideEdit();
          if (history.replaceState) {
            history.replaceState(null, "", window.location.pathname + window.location.search);
          } else {
            window.location.hash = "";
          }
          var hero = document.querySelector(".lh-account__hero");
          if (hero) hero.scrollIntoView({ behavior: "smooth", block: "start" });
        });
      }
    })();
  </script>
</body>
</html>
