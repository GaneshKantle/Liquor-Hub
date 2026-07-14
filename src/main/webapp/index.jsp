<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.ProductDTO" %>
<%
  if (request.getAttribute("products") == null) {
    request.getRequestDispatcher("/home").forward(request, response);
    return;
  }

  String ctx = request.getContextPath();
  List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
  List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
  List<ProductDTO> whiskyEssentials = (List<ProductDTO>) request.getAttribute("whiskyEssentials");
  List<ProductDTO> housePour = (List<ProductDTO>) request.getAttribute("housePour");
  List<ProductDTO> premiumPicks = (List<ProductDTO>) request.getAttribute("premiumPicks");

  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);

  String contactOk = (String) request.getAttribute("contactSuccess");
  String contactErr = (String) request.getAttribute("contactError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LiquorHub — Rare bottles. Trusted exchange.</title>
  <meta name="description" content="Curated whisky, wine, gin and more. Shop collections made for celebrating, gifting, and hosting.">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%= ctx %>/css/liquorhub.css">
</head>
<body class="lh-body lh-home">
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main>
    <section class="lh-hero" aria-label="Hero">
      <video class="lh-hero__video" autoplay muted loop playsinline preload="metadata">
        <source src="<%= ctx %>/assets/video/hero.mp4" type="video/mp4">
      </video>
      <div class="lh-hero__scrim" aria-hidden="true"></div>
      <div class="lh-hero__content">
        <p class="lh-hero__brand">LiquorHub</p>
        <p class="lh-hero__badge">Rare bottles · Trusted exchange</p>
        <h1 class="lh-hero__title">Find the pour that <em>belongs</em> on your table.</h1>
        <p class="lh-hero__lead">Curated spirits and wine — shop by taste, occasion, or collection in one clear scroll.</p>
        <div class="lh-hero__actions">
          <a class="lh-btn" href="#items">Shop bottles</a>
          <a class="lh-btn lh-btn--light" href="#collections">See collections</a>
        </div>
      </div>
    </section>

    <section class="lh-section lh-section--tight" id="categories">
      <div class="lh-shell-width lh-reveal">
        <p class="lh-eyebrow">Categories</p>
        <h2 class="lh-h2">Browse by spirit</h2>
        <p class="lh-lead">Eight shelves. Pick a lane and jump straight to matching bottles.</p>
        <div class="lh-cat-grid">
          <% if (categories != null) {
               int i = 0;
               for (CategoryDTO cat : categories) {
                 i++; %>
          <a class="lh-cat" href="#items" data-filter-cat="<%= cat.getCategoryId() %>">
            <span class="lh-cat__n"><%= String.format("%02d", i) %></span>
            <span class="lh-cat__name"><%= cat.getCategoryName() %></span>
          </a>
          <%   }
             } %>
        </div>
      </div>
    </section>

    <section class="lh-section lh-section--muted" id="collections">
      <div class="lh-shell-width lh-reveal">
        <p class="lh-eyebrow">Collections</p>
        <h2 class="lh-h2">Edited for how you pour</h2>
        <p class="lh-lead">Three starter sets pulled live from the catalogue.</p>
        <div class="lh-coll-grid">
          <article class="lh-coll">
            <h3 class="lh-coll__title">Whisky Essentials</h3>
            <p class="lh-coll__desc">Core whisky picks from the shelf.</p>
            <ul class="lh-coll__list">
              <% if (whiskyEssentials != null) {
                   for (ProductDTO p : whiskyEssentials) { %>
              <li><strong><%= p.getProductName() %></strong><span><%= inr.format(p.getPrice()) %></span></li>
              <%   }
                 } %>
            </ul>
          </article>
          <article class="lh-coll">
            <h3 class="lh-coll__title">House Pour</h3>
            <p class="lh-coll__desc">Everyday bottles under ₹1,500.</p>
            <ul class="lh-coll__list">
              <% if (housePour != null) {
                   for (ProductDTO p : housePour) { %>
              <li><strong><%= p.getProductName() %></strong><span><%= inr.format(p.getPrice()) %></span></li>
              <%   }
                 } %>
            </ul>
          </article>
          <article class="lh-coll">
            <h3 class="lh-coll__title">Premium Picks</h3>
            <p class="lh-coll__desc">Special bottles from ₹4,000 up.</p>
            <ul class="lh-coll__list">
              <% if (premiumPicks != null) {
                   for (ProductDTO p : premiumPicks) { %>
              <li><strong><%= p.getProductName() %></strong><span><%= inr.format(p.getPrice()) %></span></li>
              <%   }
                 } %>
            </ul>
          </article>
        </div>
      </div>
    </section>

    <section class="lh-section" id="items">
      <div class="lh-shell-width lh-reveal">
        <p class="lh-eyebrow">Catalogue</p>
        <h2 class="lh-h2">Bottles with a clear price</h2>
        <p class="lh-lead">Name, brand, and price — use search or a category to narrow the shelf.</p>
        <div class="lh-prod-grid" id="productGrid">
          <% if (products != null) {
               for (ProductDTO p : products) {
                 String initial = p.getProductName() != null && !p.getProductName().isEmpty()
                     ? p.getProductName().substring(0, 1).toUpperCase()
                     : "?";
                 String brand = p.getBrand() != null ? p.getBrand() : "";
                 String nameLower = (p.getProductName() + " " + brand).toLowerCase();
          %>
          <article class="lh-prod"
            data-cat="<%= p.getCategoryId() %>"
            data-search="<%= nameLower.replace("\"", "") %>">
            <div class="lh-prod__visual" aria-hidden="true"><%= initial %></div>
            <div class="lh-prod__body">
              <span class="lh-prod__brand"><%= brand %></span>
              <h3 class="lh-prod__name"><%= p.getProductName() %></h3>
              <div class="lh-prod__price"><%= inr.format(p.getPrice()) %></div>
            </div>
          </article>
          <%   }
             } %>
        </div>
        <p class="lh-empty" id="productEmpty">No bottles match that search.</p>
      </div>
    </section>

    <section class="lh-section lh-section--muted" id="about">
      <div class="lh-shell-width lh-reveal">
        <p class="lh-eyebrow">Occasions</p>
        <h2 class="lh-h2">What LiquorHub is for</h2>
        <p class="lh-lead">Not a random shelf — a clear path from occasion to bottle.</p>
        <div class="lh-occ-list">
          <a class="lh-occ" href="#items">
            <div>
              <div class="lh-occ__n">01</div>
              <h3 class="lh-occ__title">Celebrate</h3>
            </div>
            <p class="lh-occ__text">Mark the night with a bottle that feels intentional — whisky, sparkling, or something rare.</p>
            <span class="lh-occ__arrow" aria-hidden="true">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
            </span>
          </a>
          <a class="lh-occ" href="#collections">
            <div>
              <div class="lh-occ__n">02</div>
              <h3 class="lh-occ__title">Gift</h3>
            </div>
            <p class="lh-occ__text">Premium picks with clear pricing — easy to choose, easy to explain.</p>
            <span class="lh-occ__arrow" aria-hidden="true">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
            </span>
          </a>
          <a class="lh-occ" href="#categories">
            <div>
              <div class="lh-occ__n">03</div>
              <h3 class="lh-occ__title">Host</h3>
            </div>
            <p class="lh-occ__text">Stock the bar by category — gin for cocktails, wine for dinner, beer for the crowd.</p>
            <span class="lh-occ__arrow" aria-hidden="true">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
            </span>
          </a>
        </div>
      </div>
    </section>

    <section class="lh-section" id="testimonials">
      <div class="lh-shell-width lh-reveal">
        <p class="lh-eyebrow">Social proof</p>
        <h2 class="lh-h2">Collectors keep coming back</h2>
        <p class="lh-lead">Notes from hosts and buyers — and a few shelf stats.</p>
      </div>
      <div class="lh-marquee-wrap" aria-label="Testimonials">
        <div class="lh-marquee">
          <article class="lh-chip"><p class="lh-chip__quote">“Found a Chivas 18 for a client dinner in minutes. Price was clear, no noise.”</p><p class="lh-chip__meta">Aarav · Mumbai</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">8 categories</p><p class="lh-chip__meta">On the shelf</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“House Pour list saved our house party budget without looking cheap.”</p><p class="lh-chip__meta">Neha · Bengaluru</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">100+ bottles</p><p class="lh-chip__meta">Live catalogue</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Gifted Patrón Silver — the premium picks feel intentional.”</p><p class="lh-chip__meta">Rohan · Delhi</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">₹650+</p><p class="lh-chip__meta">Everyday pours</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Found a Chivas 18 for a client dinner in minutes. Price was clear, no noise.”</p><p class="lh-chip__meta">Aarav · Mumbai</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">8 categories</p><p class="lh-chip__meta">On the shelf</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“House Pour list saved our house party budget without looking cheap.”</p><p class="lh-chip__meta">Neha · Bengaluru</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">100+ bottles</p><p class="lh-chip__meta">Live catalogue</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Gifted Patrón Silver — the premium picks feel intentional.”</p><p class="lh-chip__meta">Rohan · Delhi</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">₹650+</p><p class="lh-chip__meta">Everyday pours</p></article>
        </div>
        <div class="lh-marquee lh-marquee--rev">
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">Trusted exchange</p><p class="lh-chip__meta">Buyer + seller ready</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Finally a liquor site that tells you the story in the first scroll.”</p><p class="lh-chip__meta">Isha · Pune</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">Gin → Tequila</p><p class="lh-chip__meta">Full spirit range</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Search by bottle name actually works. Old Monk in two taps.”</p><p class="lh-chip__meta">Kabir · Hyderabad</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">Clear INR</p><p class="lh-chip__meta">No guesswork</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Used categories for a wedding bar list — whisky, wine, beer done.”</p><p class="lh-chip__meta">Meera · Jaipur</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">Trusted exchange</p><p class="lh-chip__meta">Buyer + seller ready</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Finally a liquor site that tells you the story in the first scroll.”</p><p class="lh-chip__meta">Isha · Pune</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">Gin → Tequila</p><p class="lh-chip__meta">Full spirit range</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Search by bottle name actually works. Old Monk in two taps.”</p><p class="lh-chip__meta">Kabir · Hyderabad</p></article>
          <article class="lh-chip lh-chip--stat"><p class="lh-chip__quote">Clear INR</p><p class="lh-chip__meta">No guesswork</p></article>
          <article class="lh-chip"><p class="lh-chip__quote">“Used categories for a wedding bar list — whisky, wine, beer done.”</p><p class="lh-chip__meta">Meera · Jaipur</p></article>
        </div>
      </div>
    </section>

    <section class="lh-section lh-section--muted" id="contact">
      <div class="lh-shell-width lh-reveal">
        <div class="lh-contact">
          <div class="lh-contact__aside">
            <p class="lh-eyebrow">Contact</p>
            <h2 class="lh-h2">Talk to LiquorHub</h2>
            <p>Questions on a bottle, a collection, or your collector profile? Send a short note — we read every message.</p>
          </div>
          <form class="lh-form" action="<%= ctx %>/contact" method="post">
            <% if (contactOk != null) { %>
            <p class="lh-msg lh-msg--ok"><%= contactOk %></p>
            <% } %>
            <% if (contactErr != null) { %>
            <p class="lh-msg lh-msg--err"><%= contactErr %></p>
            <% } %>
            <div class="lh-field">
              <label for="c-name">Name</label>
              <input id="c-name" name="name" type="text" required placeholder="Your name" autocomplete="name">
            </div>
            <div class="lh-field">
              <label for="c-email">Email</label>
              <input id="c-email" name="email" type="email" required placeholder="you@email.com" autocomplete="email">
            </div>
            <div class="lh-field">
              <label for="c-message">Message</label>
              <textarea id="c-message" name="message" rows="4" required placeholder="How can we help?"></textarea>
            </div>
            <button type="submit" class="lh-btn">Send message</button>
          </form>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
