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
