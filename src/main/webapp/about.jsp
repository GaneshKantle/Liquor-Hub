<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>About | LiquorHub</title>
  <meta name="description" content="About LiquorHub — a live bottle clearing house built by a four-person team.">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/about.css">
  <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-about-page">
    <div class="lh-shell">
      <p class="lh-sec__kicker">About</p>
      <h1 class="lh-sec__title">LiquorHub is a live bottle clearing house.</h1>
      <p class="lh-sec__lede lh-about-page__lede">
        Clear INR prices, honest product notes, and a shop that stays out of the way until you are ready to buy.
        Browse the floor as a guest. Sign in only when you add to bag, save favourites, or place an order.
      </p>

      <div class="lh-about">
        <div class="lh-about__copy">
          <ul class="lh-about__points">
            <li>
              <strong>What we sell</strong>
              <span>Whisky, gin, rum, vodka, wine, beer, and more — organised as dossiers with origin notes and live lots.</span>
            </li>
            <li>
              <strong>How it works</strong>
              <span>Scan the catalogue, quote a board, bag what you want. Checkout is simple demo-payment for now — orders land in your profile history.</span>
            </li>
            <li>
              <strong>How we trade</strong>
              <span>No boutique fluff. Hard prices, steel UI, drink responsibly. Built as a student project for a real shopping flow on Jakarta + MySQL.</span>
            </li>
          </ul>
        </div>
        <aside class="lh-about__aside" aria-label="Project note">
          <p>Project</p>
          <h3>Mentor + four builders.</h3>
          <p class="body">
            LiquorHub is guided by our Spring Boot mentor and shipped by a four-person team — from home floor to profile.
          </p>
          <a href="#team">Meet the team ↓</a>
        </aside>
      </div>

      <section class="lh-about-section lh-stack" aria-labelledby="stack-heading">
        <p class="lh-sec__kicker">Stack</p>
        <h2 id="stack-heading" class="lh-sec__title">From browser to MySQL.</h2>
        <p class="lh-sec__lede">
          One path end to end — JSP in the browser, Jakarta servlets on Tomcat, JDBC into MySQL.
        </p>
        <ol class="lh-stack__layers">
          <li>
            <strong>Frontend</strong>
            <span>JSP views, custom CSS design system (Syne / Space Grotesk), vanilla JS.</span>
          </li>
          <li>
            <strong>Server</strong>
            <span>Jakarta Servlet 5.0 (<code>@WebServlet</code>), RequestDispatcher → JSP, session auth.</span>
          </li>
          <li>
            <strong>Data access</strong>
            <span>JDBC + DAO / DTO pattern — <code>Connector</code> and DAOImpl classes.</span>
          </li>
          <li>
            <strong>Database</strong>
            <span>MySQL schema <code>liquorhub</code>, mysql-connector-j 8.0.33.</span>
          </li>
          <li>
            <strong>Runtime</strong>
            <span>Apache Tomcat 10+, Java 19 (Eclipse Dynamic Web Project).</span>
          </li>
        </ol>
      </section>

      <section class="lh-about-section lh-schema" aria-labelledby="schema-heading">
        <p class="lh-sec__kicker">Schema</p>
        <h2 id="schema-heading" class="lh-sec__title">Nine tables that run the shop.</h2>
        <p class="lh-sec__lede">
          Primary keys and foreign keys that wire catalogue, bag, wishlist, and orders together.
        </p>
        <ul class="lh-schema__tables">
          <li>
            <code>Customer</code>
            <span>Accounts — PK <code>customer_id</code></span>
          </li>
          <li>
            <code>Category</code>
            <span>Drink types — PK <code>category_id</code></span>
          </li>
          <li>
            <code>Product</code>
            <span>Catalogue lots — PK <code>product_id</code>, FK → Category</span>
          </li>
          <li>
            <code>Cart</code>
            <span>One bag per shopper — PK <code>cart_id</code>, FK → Customer</span>
          </li>
          <li>
            <code>CartItem</code>
            <span>Lines in the bag — PK <code>cart_item_id</code>, FK → Cart, Product</span>
          </li>
          <li>
            <code>Orders</code>
            <span>Placed orders — PK <code>order_id</code>, FK → Customer</span>
          </li>
          <li>
            <code>OrderItem</code>
            <span>Lines on an order — PK <code>order_item_id</code>, FK → Orders, Product</span>
          </li>
          <li>
            <code>Payment</code>
            <span>Demo checkout — PK <code>payment_id</code>, FK → Orders</span>
          </li>
          <li>
            <code>WishlistItem</code>
            <span>Saved favourites — PK <code>wishlist_item_id</code>, FK → Customer, Product</span>
          </li>
        </ul>
        <div class="lh-schema__diagram">
          <img
            src="<%= ctx %>/assets/schema-er.svg"
            alt="Entity-relationship diagram: Category to Product; Customer to Cart, CartItem, Orders, OrderItem, Payment, and WishlistItem, with foreign keys into Product."
            width="920"
            height="560"
            loading="lazy"
          >
        </div>
      </section>

      <section class="lh-about-section lh-source" aria-labelledby="source-heading">
        <div class="lh-source__panel">
          <p>Source</p>
          <h2 id="source-heading">Browse the repo.</h2>
          <p class="body">
            Full stack lives on GitHub — servlets, JSPs, SQL, and the shop UI. Fork it, read it, ship your own floor.
          </p>
          <a
            href="https://github.com/GaneshKantle/Liquor-Hub"
            target="_blank"
            rel="noopener noreferrer"
          >Open Liquor-Hub on GitHub →</a>
        </div>
      </section>

      <jsp:include page="/WEB-INF/jspf/team.jsp" />

      <p class="lh-about-page__back">
        <a href="<%= ctx %>/home" class="lh-btn lh-btn--chalk">Back to home</a>
        <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">Browse catalogue</a>
      </p>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
