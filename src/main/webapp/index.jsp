<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.ProductDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%@ page import="com.LiquorHub.utility.ImageUrls" %>
<%@ page import="com.LiquorHub.utility.CategoryFacts" %>
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
  CustomerDTO customer = (CustomerDTO) session.getAttribute("Customer");
  boolean loggedIn = customer != null;
  Set<Integer> wishlistIds = (Set<Integer>) request.getAttribute("wishlistIds");
  if (wishlistIds == null) wishlistIds = new HashSet<>();

  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);

  int productCount = products != null ? products.size() : 0;
  Integer productTotalObj = (Integer) request.getAttribute("productTotal");
  int productTotal = productTotalObj != null ? productTotalObj.intValue() : productCount;
  int categoryCount = categories != null ? categories.size() : 0;
  String accountHref = loggedIn ? ctx + "/profile" : ctx + "/login";
  String accountLabel = loggedIn ? "Profile" : "Sign in";
%>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LiquorHub — Bottle clearing house</title>
  <meta name="description" content="LiquorHub is a live bottle clearing house. Scan the desk, quote the lot, sign in only when you trade.">
  <meta name="color-scheme" content="light only">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/cart-shelf.css">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#d9e0e6', soft: '#eef2f5', strong: '#c5cdd4' },
            ink: { DEFAULT: '#0a0c10', muted: '#3a424c', subtle: '#6a7380' },
            accent: { DEFAULT: '#ff2d1a', soft: '#ffd4ce', strong: '#b0180c' }
          },
          fontFamily: {
            display: ['Syne', 'system-ui', 'sans-serif'],
            sans: ['Space Grotesk', 'system-ui', 'sans-serif']
          },
          maxWidth: { shell: '78rem', measure: '36rem' },
          borderRadius: { full: '2px', '2xl': '2px', '3xl': '2px', '[1.25rem]': '2px', '[1.35rem]': '2px', '[1.5rem]': '2px', '[1.75rem]': '2px' }
        }
      }
    };
  </script>
  <style>
    .sr-only { position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap;border:0 }
    .rounded-full, .rounded-2xl, .rounded-xl, .rounded-\[1\.25rem\], .rounded-\[1\.35rem\], .rounded-\[1\.5rem\], .rounded-\[1\.75rem\] { border-radius: 2px !important; }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-logged-in="<%= loggedIn ? "1" : "0" %>" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />

  <!-- First-visit liquor quiz — compact stepper -->
  <div id="lhQuizGate" class="lh-quiz" hidden role="dialog" aria-modal="true" aria-labelledby="lhQuizTitle">
    <div class="lh-quiz__card">
      <div class="lh-quiz__head">
        <p class="lh-quiz__kicker">Desk check · 4 quick hits</p>
        <h2 id="lhQuizTitle" class="lh-quiz__title">Know your pour</h2>
        <div class="lh-quiz__progress" aria-hidden="true">
          <span class="lh-quiz__dot is-on" data-dot="0"></span>
          <span class="lh-quiz__dot" data-dot="1"></span>
          <span class="lh-quiz__dot" data-dot="2"></span>
          <span class="lh-quiz__dot" data-dot="3"></span>
        </div>
        <p class="lh-quiz__step-label"><span id="lhQuizStepNum">1</span> / 4</p>
      </div>

      <form id="lhQuizForm" class="lh-quiz__form">
        <div class="lh-quiz__slide is-active" data-step="0">
          <p class="lh-quiz__q">Whisky is typically aged in what?</p>
          <div class="lh-quiz__opts">
            <label class="lh-quiz__opt"><input type="radio" name="q1" value="a"><span>Plastic bottles</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q1" value="b"><span>Steel cans</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q1" value="c"><span>Oak barrels</span></label>
          </div>
        </div>
        <div class="lh-quiz__slide" data-step="1" hidden>
          <p class="lh-quiz__q">Which spirit is juniper-forward?</p>
          <div class="lh-quiz__opts">
            <label class="lh-quiz__opt"><input type="radio" name="q2" value="a"><span>Vodka</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q2" value="b"><span>Gin</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q2" value="c"><span>Rum</span></label>
          </div>
        </div>
        <div class="lh-quiz__slide" data-step="2" hidden>
          <p class="lh-quiz__q">Tequila is traditionally made from?</p>
          <div class="lh-quiz__opts">
            <label class="lh-quiz__opt"><input type="radio" name="q3" value="a"><span>Blue agave</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q3" value="b"><span>Sugarcane</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q3" value="c"><span>Barley</span></label>
          </div>
        </div>
        <div class="lh-quiz__slide" data-step="3" hidden>
          <p class="lh-quiz__q">ABV stands for?</p>
          <div class="lh-quiz__opts">
            <label class="lh-quiz__opt"><input type="radio" name="q4" value="a"><span>Average Bottle Volume</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q4" value="b"><span>Aged Barrel Vintage</span></label>
            <label class="lh-quiz__opt"><input type="radio" name="q4" value="c"><span>Alcohol By Volume</span></label>
          </div>
        </div>

        <div class="lh-quiz__nav">
          <button type="button" id="lhQuizBack" class="lh-btn lh-btn--chalk" hidden>Back</button>
          <button type="button" id="lhQuizNext" class="lh-btn lh-btn--signal">Next</button>
          <button type="submit" id="lhQuizSubmit" class="lh-btn lh-btn--signal" hidden>Enter desk</button>
        </div>
        <p id="lhQuizHint" class="lh-quiz__hint" hidden>Pick an answer to continue.</p>
      </form>

      <div id="lhQuizFail" class="lh-quiz__fail" hidden>
        <p class="lh-quiz__fail-title">Not quite</p>
        <p class="lh-quiz__fail-copy">Oak barrels, gin, blue agave, Alcohol By Volume — then you’re in.</p>
        <button type="button" id="lhQuizRetry" class="lh-btn lh-btn--signal">Try again</button>
      </div>
    </div>
  </div>

  <!-- Guest cart login prompt (fallback) -->
  <div id="lhLoginModal" class="fixed inset-0 z-[2147483644] hidden items-center justify-center bg-ink/50 p-4 backdrop-blur-sm" hidden role="dialog" aria-modal="true" aria-labelledby="lhLoginModalTitle">
    <div class="w-full max-w-sm rounded-[1.5rem] border border-white/80 bg-white p-6 shadow-2xl">
      <h2 id="lhLoginModalTitle" class="font-display text-2xl tracking-[-0.03em]">Sign in to continue</h2>
      <p class="mt-2 text-sm text-ink-muted">Browse freely. Sign in or create an account to add to cart or buy.</p>
      <div class="mt-5 flex flex-col gap-2">
        <a href="<%= ctx %>/login?reason=cart&amp;next=<%= java.net.URLEncoder.encode(ctx + "/home#items", "UTF-8") %>" class="inline-flex min-h-11 items-center justify-center rounded-full bg-accent px-5 text-sm font-semibold text-white hover:bg-accent-strong">Sign in</a>
        <a href="<%= ctx %>/register?reason=cart&amp;next=<%= java.net.URLEncoder.encode(ctx + "/home#items", "UTF-8") %>" class="inline-flex min-h-11 items-center justify-center rounded-full border border-black/10 bg-cream px-5 text-sm font-semibold text-ink hover:bg-white">Create account</a>
        <button type="button" id="lhLoginModalClose" class="mt-1 text-sm font-semibold text-ink-muted hover:text-ink">Keep browsing</button>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main>
    <section class="lh-clearing" aria-label="Clearing house">
      <div class="lh-clearing__media" aria-hidden="true">
        <video autoplay muted loop playsinline preload="metadata">
          <source src="<%= ctx %>/assets/video/hero.mp4" type="video/mp4">
        </video>
        <div class="lh-clearing__veil"></div>
      </div>
      <div class="lh-clearing__grid lh-reveal">
        <div>
          <p class="lh-stamp" style="color:#e8ff6a;border-color:#e8ff6a">Open floor · <%= productTotal %> lots</p>
          <h1 class="lh-clearing__brand">Liquor<span>Hub</span></h1>
          <p class="lh-clearing__line">Not a pretty shop. A live desk for bottles with hard prices.</p>
          <p class="lh-clearing__sub">Scan the floor. Quote the lot. Sign in only when you bag or buy.</p>
          <div class="lh-clearing__actions">
            <a href="#items" class="lh-btn lh-btn--signal">Open the floor</a>
            <a href="#categories" class="lh-btn lh-btn--ghost" style="color:#fff;border-color:rgba(255,255,255,0.55)">Spirit dossiers</a>
          </div>
        </div>
        <aside class="lh-clearing__ticket" aria-label="Desk ticket">
          <dl>
            <dt>Session</dt>
            <dd><%= loggedIn ? "Member desk" : "Guest browse" %></dd>
            <dt>Spirit lines</dt>
            <dd><%= categoryCount %> active</dd>
            <dt>Trade rule</dt>
            <dd>Login on cart</dd>
          </dl>
        </aside>
      </div>
    </section>

    <div class="lh-ticker" aria-hidden="true">
      <div class="lh-ticker__track">
        <% String ticker = "";
           if (products != null) {
             for (int ti = 0; ti < products.size() && ti < 12; ti++) {
               ProductDTO tp = products.get(ti);
               ticker += "<span><b>" + (tp.getProductName() != null ? tp.getProductName() : "LOT") + "</b> · <em>" + inr.format(tp.getPrice()) + "</em></span>";
             }
           }
           if (ticker.isEmpty()) ticker = "<span><b>LiquorHub</b> · <em>DESK OPEN</em></span>";
        %>
        <%= ticker + ticker %>
      </div>
    </div>

    <section class="lh-sec" id="about">
      <div class="lh-shell lh-reveal">
        <p class="lh-sec__kicker">Manifest</p>
        <h2 class="lh-sec__title">Prices on the board. Stories in the dossier.</h2>
        <p class="lh-sec__lede">LiquorHub runs like a clearing house — cold paper, live lots, no boutique fluff. Browse free. Trade after you sign in.</p>
      </div>
    </section>

    <section id="categories" class="lh-sec scroll-mt-28" style="padding-top:0">
      <div class="lh-shell lh-reveal">
        <p class="lh-sec__kicker">Spirit dossiers</p>
        <h2 class="lh-sec__title">Pick a line. Read the stamp.</h2>
        <p class="lh-sec__lede">Each dossier is a working note — origin, fame, how to choose — then jump to matching lots.</p>
        <div class="lh-dossiers">
          <% if (categories != null && !categories.isEmpty()) {
               for (CategoryDTO cat : categories) {
                 String catImg = ImageUrls.forCategory(cat.getCategoryName());
                 String origin = CategoryFacts.origin(cat.getCategoryName());
          %>
          <article class="lh-dossier">
            <img src="<%= catImg %>" alt="" loading="lazy" decoding="async" width="800" height="1000">
            <div class="lh-dossier__shade"></div>
            <div class="lh-dossier__body">
              <h3><%= cat.getCategoryName() %></h3>
              <p class="lh-dossier__meta"><%= origin %></p>
              <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" class="lh-dossier__link">Shop <%= cat.getCategoryName() %></a>
            </div>
          </article>
          <%   }
             } else { %>
          <p class="lh-panel">Categories load with the catalogue.</p>
          <% } %>
        </div>
      </div>
    </section>

    <section id="collections" class="lh-sec scroll-mt-28" style="background:rgba(238,242,245,0.55);border-block:1.5px solid var(--carbon)">
      <div class="lh-shell lh-reveal">
        <p class="lh-sec__kicker">Quote boards</p>
        <h2 class="lh-sec__title">Three boards. Live lots.</h2>
        <p class="lh-sec__lede">Starter sets pulled straight from the desk — essentials, house pour, premium.</p>
        <div class="lh-boards">
          <article class="lh-board">
            <h3>Whisky Essentials</h3>
            <p>Core whisky picks from the shelf.</p>
            <ul>
              <% if (whiskyEssentials != null && !whiskyEssentials.isEmpty()) {
                   for (ProductDTO p : whiskyEssentials) { %>
              <li><strong><%= p.getProductName() %></strong><span><%= inr.format(p.getPrice()) %></span></li>
              <%   }
                 } else { %>
              <li><strong>Empty board</strong><span>—</span></li>
              <% } %>
            </ul>
          </article>
          <article class="lh-board">
            <h3>House Pour</h3>
            <p>Everyday bottles under Rs 1,500.</p>
            <ul>
              <% if (housePour != null && !housePour.isEmpty()) {
                   for (ProductDTO p : housePour) { %>
              <li><strong><%= p.getProductName() %></strong><span><%= inr.format(p.getPrice()) %></span></li>
              <%   }
                 } else { %>
              <li><strong>Empty board</strong><span>—</span></li>
              <% } %>
            </ul>
          </article>
          <article class="lh-board">
            <h3>Premium Picks</h3>
            <p>Special bottles from Rs 4,000 up.</p>
            <ul>
              <% if (premiumPicks != null && !premiumPicks.isEmpty()) {
                   for (ProductDTO p : premiumPicks) { %>
              <li><strong><%= p.getProductName() %></strong><span><%= inr.format(p.getPrice()) %></span></li>
              <%   }
                 } else { %>
              <li><strong>Empty board</strong><span>—</span></li>
              <% } %>
            </ul>
          </article>
        </div>
      </div>
    </section>

    <section id="items" class="lh-sec scroll-mt-28">
      <div class="lh-shell lh-reveal">
        <div style="display:flex;flex-wrap:wrap;gap:1rem;align-items:end;justify-content:space-between">
          <div>
            <p class="lh-sec__kicker">Archive floor</p>
            <h2 class="lh-sec__title">Featured lots</h2>
            <p class="lh-sec__lede">A short pull of <%= productCount %> bottles. Open the full floor for every lot.</p>
          </div>
          <div style="display:flex;flex-wrap:wrap;gap:0.5rem">
            <% if (loggedIn) { %>
            <a href="<%= ctx %>/cart" class="lh-btn lh-btn--carbon">Open bag</a>
            <% } %>
            <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">See all <%= productTotal %></a>
          </div>
        </div>

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
          <article class="lh-lot lh-prod lh-prod-3d"
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
                   String nextWish = java.net.URLEncoder.encode(ctx + "/home#items", "UTF-8");
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
                   String nextHome = java.net.URLEncoder.encode(ctx + "/home#items", "UTF-8");
                   String nextBuy = java.net.URLEncoder.encode(ctx + "/buy-now?productId=" + p.getProductId(), "UTF-8");
              %>
                <a href="<%= ctx %>/login?reason=cart&amp;next=<%= nextHome %>" class="lh-btn lh-btn--chalk">Bag lot</a>
                <a href="<%= ctx %>/login?reason=buy&amp;next=<%= nextBuy %>" class="lh-btn lh-btn--carbon">Buy now</a>
              <% } %>
              </div>
            </div>
          </article>
          <%   }
             } else { %>
          <p class="lh-panel" style="grid-column:1/-1">No lots on the floor yet.</p>
          <% } %>
        </div>
        <p id="productEmpty" class="lh-panel hidden" style="margin-top:1rem;text-align:center">No lots match that scan.</p>
        <div style="margin-top:1.5rem;text-align:center">
          <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--ghost" style="border-color:var(--carbon);color:var(--carbon)">See all products →</a>
        </div>
      </div>
    </section>

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

    <!-- Know your pour -->
    <section id="learn" class="scroll-mt-28 border-y border-black/[0.08] bg-cream-strong/40 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Know your pour</p>
          <h2 class="mt-2 font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Liquor basics, short and clear</h2>
          <p class="mt-3 max-w-xl text-ink-muted">A little knowledge makes the shelf easier to read.</p>
        </div>
        <div class="mt-8 grid gap-0 border-t border-black/[0.08]">
          <div class="grid gap-3 border-b border-black/[0.08] py-6 sm:grid-cols-[minmax(0,0.85fr)_minmax(0,1.15fr)] sm:gap-8 sm:py-7">
            <h3 class="font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">Whisky vs wine</h3>
            <p class="text-sm text-ink-muted sm:text-base">Whisky is distilled grain spirit, usually aged in oak. Wine is fermented grape juice. Different strength, different glass, different night.</p>
          </div>
          <div class="grid gap-3 border-b border-black/[0.08] py-6 sm:grid-cols-[minmax(0,0.85fr)_minmax(0,1.15fr)] sm:gap-8 sm:py-7">
            <h3 class="font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">Gin and juniper</h3>
            <p class="text-sm text-ink-muted sm:text-base">Gin must taste of juniper. That botanical spine is why gin and tonic works - bright, dry, and built for mixing.</p>
          </div>
          <div class="grid gap-3 border-b border-black/[0.08] py-6 sm:grid-cols-[minmax(0,0.85fr)_minmax(0,1.15fr)] sm:gap-8 sm:py-7">
            <h3 class="font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">ABV and pour size</h3>
            <p class="text-sm text-ink-muted sm:text-base">ABV is alcohol by volume. Higher ABV means a smaller pour goes further. Read the label before you host.</p>
          </div>
          <div class="grid gap-3 border-b border-black/[0.08] py-6 sm:grid-cols-[minmax(0,0.85fr)_minmax(0,1.15fr)] sm:gap-8 sm:py-7">
            <h3 class="font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">Glass tips</h3>
            <p class="text-sm text-ink-muted sm:text-base">Tulip for whisky aroma, stemware for wine, highball for long drinks. The right glass is half the experience.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Occasions -->
    <section id="occasions" class="scroll-mt-28 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="lh-sec__kicker">Occasions</p>
          <h2 class="lh-sec__title" style="font-size:clamp(1.85rem,4vw,2.65rem)">What LiquorHub is for</h2>
          <p class="lh-sec__lede">A clear path from occasion to bottle.</p>
        </div>
        <div class="mt-8 grid gap-0 border-t border-black/[0.08]">
          <a href="#items" class="group grid gap-3 border-b border-black/[0.08] py-6 transition-colors duration-300 hover:bg-white/50 sm:grid-cols-[minmax(0,0.9fr)_minmax(0,1.1fr)_auto] sm:items-center sm:gap-8 sm:py-7">
            <div>
              <div class="text-[0.65rem] font-semibold uppercase tracking-[0.16em] text-ink-muted">01</div>
              <h3 class="mt-2 font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">Celebrate</h3>
            </div>
            <p class="max-w-xl text-sm text-ink-muted sm:text-base">Mark the night with a bottle that feels intentional - whisky, sparkling, or something rare.</p>
            <span class="inline-flex h-10 w-10 items-center justify-center justify-self-start rounded-full border border-black/[0.1] bg-white text-ink transition duration-300 group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:border-accent/30 group-hover:text-accent sm:justify-self-end" aria-hidden="true">
              <svg viewBox="0 0 16 16" class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
            </span>
          </a>
          <a href="#collections" class="group grid gap-3 border-b border-black/[0.08] py-6 transition-colors duration-300 hover:bg-white/50 sm:grid-cols-[minmax(0,0.9fr)_minmax(0,1.1fr)_auto] sm:items-center sm:gap-8 sm:py-7">
            <div>
              <div class="text-[0.65rem] font-semibold uppercase tracking-[0.16em] text-ink-muted">02</div>
              <h3 class="mt-2 font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">Gift</h3>
            </div>
            <p class="max-w-xl text-sm text-ink-muted sm:text-base">Premium picks with clear pricing - easy to choose, easy to explain.</p>
            <span class="inline-flex h-10 w-10 items-center justify-center justify-self-start rounded-full border border-black/[0.1] bg-white text-ink transition duration-300 group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:border-accent/30 group-hover:text-accent sm:justify-self-end" aria-hidden="true">
              <svg viewBox="0 0 16 16" class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
            </span>
          </a>
          <a href="#categories" class="group grid gap-3 border-b border-black/[0.08] py-6 transition-colors duration-300 hover:bg-white/50 sm:grid-cols-[minmax(0,0.9fr)_minmax(0,1.1fr)_auto] sm:items-center sm:gap-8 sm:py-7">
            <div>
              <div class="text-[0.65rem] font-semibold uppercase tracking-[0.16em] text-ink-muted">03</div>
              <h3 class="mt-2 font-display text-[1.25rem] tracking-[-0.02em] sm:text-[1.4rem]">Host</h3>
            </div>
            <p class="max-w-xl text-sm text-ink-muted sm:text-base">Stock the bar by category - gin for cocktails, wine for dinner, beer for the crowd.</p>
            <span class="inline-flex h-10 w-10 items-center justify-center justify-self-start rounded-full border border-black/[0.1] bg-white text-ink transition duration-300 group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:border-accent/30 group-hover:text-accent sm:justify-self-end" aria-hidden="true">
              <svg viewBox="0 0 16 16" class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
            </span>
          </a>
        </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section id="testimonials" class="py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Social proof</p>
          <h2 class="mt-2 font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Collectors keep coming back</h2>
          <p class="mt-3 max-w-xl text-ink-muted">Notes from hosts and buyers.</p>
        </div>
      </div>
      <div class="lh-marquee-wrap mt-8 overflow-hidden" aria-label="Testimonials">
        <div class="lh-marquee flex w-max gap-4">
          <% String[] row1 = {
               "q|Found a Chivas 18 for a client dinner in minutes. Price was clear, no noise.|Aarav - Mumbai",
               "s|8 categories|On the shelf",
               "q|House Pour list saved our house party budget without looking cheap.|Neha - Bengaluru",
               "s|100+ bottles|Live catalogue",
               "q|Gifted Patron Silver - the premium picks feel intentional.|Rohan - Delhi",
               "s|Rs 650+|Everyday pours"
             };
             for (int pass = 0; pass < 2; pass++) {
               for (String chip : row1) {
                 String[] parts = chip.split("\\|");
                 boolean isStat = "s".equals(parts[0]);
          %>
          <article class="w-[min(22rem,78vw)] shrink-0 rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5" <%= pass == 1 ? "aria-hidden=\"true\"" : "" %>>
            <% if (isStat) { %><p class="font-display text-2xl tracking-[-0.03em]"><%= parts[1] %></p>
            <% } else { %><p class="text-sm leading-relaxed tracking-[-0.01em]">"<%= parts[1] %>"</p><% } %>
            <p class="mt-3 text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted"><%= parts[2] %></p>
          </article>
          <%   } } %>
        </div>
        <div class="lh-marquee-rev mt-4 flex w-max gap-4">
          <% String[] row2 = {
               "s|Trusted exchange|Buyer + seller ready",
               "q|Finally a liquor site that tells you the story in the first scroll.|Isha - Pune",
               "s|Gin to Tequila|Full spirit range",
               "q|Search by bottle name actually works. Old Monk in two taps.|Kabir - Hyderabad",
               "s|Clear INR|No guesswork",
               "q|Used categories for a wedding bar list - whisky, wine, beer done.|Meera - Jaipur"
             };
             for (int pass = 0; pass < 2; pass++) {
               for (String chip : row2) {
                 String[] parts = chip.split("\\|");
                 boolean isStat = "s".equals(parts[0]);
          %>
          <article class="w-[min(22rem,78vw)] shrink-0 rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5" <%= pass == 1 ? "aria-hidden=\"true\"" : "" %>>
            <% if (isStat) { %><p class="font-display text-2xl tracking-[-0.03em]"><%= parts[1] %></p>
            <% } else { %><p class="text-sm leading-relaxed tracking-[-0.01em]">"<%= parts[1] %>"</p><% } %>
            <p class="mt-3 text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted"><%= parts[2] %></p>
          </article>
          <%   } } %>
        </div>
      </div>
    </section>

    <!-- Profile -->
    <section id="profile" class="scroll-mt-28 border-t border-black/[0.08] bg-white/50 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">

        <% if (loggedIn) {
             String pName = customer.getName() != null ? customer.getName() : "Collector";
             String pInitial = pName.isEmpty() ? "L" : pName.substring(0, 1).toUpperCase();
        %>
        <div class="mt-8 overflow-hidden rounded-[1.75rem] border border-black/[0.08] bg-white shadow-[0_16px_48px_rgba(38,34,29,0.06)]">
          <div class="h-28 bg-[linear-gradient(135deg,#d96a3b,#a84822_50%,#13110d)] sm:h-32" aria-hidden="true"></div>
          <div class="relative px-5 pb-6 sm:px-8 sm:pb-8">
            <div class="-mt-10 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
              <div class="flex items-end gap-4">
                <div class="flex h-20 w-20 items-center justify-center rounded-full border-4 border-white bg-accent-soft font-display text-2xl text-accent-strong shadow-md"><%= pInitial %></div>
                <div class="pb-1">
                  <h3 class="font-display text-2xl tracking-[-0.03em]"><%= pName %></h3>
                  <p class="mt-1 text-sm text-ink-muted">CUST<%= customer.getCustomerId() %> · <%= customer.getEmail() %></p>
                </div>
              </div>
              <div class="flex flex-wrap gap-2">
                <a href="<%= ctx %>/profile" class="inline-flex min-h-10 items-center rounded-full bg-accent px-4 text-sm font-semibold text-white hover:bg-accent-strong">Open profile</a>
                <a href="<%= ctx %>/cart" class="inline-flex min-h-10 items-center rounded-full border border-black/10 bg-cream px-4 text-sm font-semibold text-ink hover:bg-white">Cart</a>
              </div>
            </div>
            <div class="mt-6 grid gap-3 border-t border-black/[0.08] pt-5 sm:grid-cols-3">
              <div>
                <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Phone</p>
                <p class="mt-1 font-semibold"><%= customer.getPhone() %></p>
              </div>
              <div class="sm:col-span-2">
                <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Address</p>
                <p class="mt-1 font-semibold"><%= customer.getAddress() %></p>
              </div>
            </div>
          </div>
        </div>
        <% } else { %>
        <div class="mt-8 grid gap-4 lg:grid-cols-[1.1fr_0.9fr]">
          <div class="rounded-[1.75rem] border border-black/[0.08] bg-[linear-gradient(165deg,rgba(217,106,59,0.12),rgba(255,255,255,0.95)_42%)] p-6 sm:p-8">
            <h3 class="font-display text-[clamp(1.5rem,3vw,2rem)] tracking-[-0.03em]">Build your collector profile</h3>
            <p class="mt-3 max-w-md text-sm text-ink-muted sm:text-base">Browse freely. Create an account when you are ready to add bottles to cart, save your details, and manage your LiquorHub profile.</p>
            <ul class="mt-5 space-y-2 text-sm text-ink">
              <li class="flex gap-2"><span class="text-accent font-semibold">01</span> Clear INR prices on every bottle</li>
              <li class="flex gap-2"><span class="text-accent font-semibold">02</span> Cart only after you sign in</li>
              <li class="flex gap-2"><span class="text-accent font-semibold">03</span> Update name, email, phone, and address anytime</li>
            </ul>
            <div class="mt-6 flex flex-wrap gap-3">
              <a href="<%= ctx %>/register" class="inline-flex min-h-11 items-center rounded-full bg-accent px-5 text-sm font-semibold text-white hover:bg-accent-strong">Create account</a>
              <a href="<%= ctx %>/login" class="inline-flex min-h-11 items-center rounded-full border border-black/10 bg-white/80 px-5 text-sm font-semibold text-ink hover:bg-white">Sign in</a>
            </div>
          </div>
          <div class="rounded-[1.75rem] border border-black/[0.08] bg-white/80 p-6 sm:p-8">
            <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">What you get</p>
            <div class="mt-4 space-y-4">
              <div class="border-b border-black/[0.06] pb-4">
                <h4 class="font-display text-lg tracking-[-0.02em]">Profile dashboard</h4>
                <p class="mt-1 text-sm text-ink-muted">Avatar, member ID, and editable account details.</p>
              </div>
              <div class="border-b border-black/[0.06] pb-4">
                <h4 class="font-display text-lg tracking-[-0.02em]">Cart ready</h4>
                <p class="mt-1 text-sm text-ink-muted">Add bottles once you are signed in.</p>
              </div>
              <div>
                <h4 class="font-display text-lg tracking-[-0.02em]">Secure access</h4>
                <p class="mt-1 text-sm text-ink-muted">Reset password and update contact info in one place.</p>
              </div>
            </div>
          </div>
        </div>
        <% } %>
      </div>
    </section>

    <!-- Contact -->
    <section id="contact" class="scroll-mt-28 border-t border-black/[0.08] py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="overflow-hidden rounded-[1.75rem] border border-black/[0.08] bg-[linear-gradient(165deg,rgba(217,106,59,0.12),rgba(255,255,255,0.92)_40%)] p-6 sm:p-8 lg:p-10">
          <div class="grid gap-8 lg:grid-cols-2 lg:items-start lg:gap-12">
            <div>
              <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Contact</p>
              <h2 class="mt-2 max-w-[14ch] font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Talk to LiquorHub</h2>
              <p class="mt-3 max-w-md text-ink-muted">Questions on a bottle, a collection, or your collector profile? Email us directly or send a short note below.</p>
              <p class="mt-4">
                <span class="block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Direct email</span>
                <a href="mailto:contact.liqourhub@gmail.com" class="mt-1 inline-block text-sm font-semibold text-accent-strong underline decoration-accent/40 underline-offset-4 hover:text-accent">contact.liqourhub@gmail.com</a>
              </p>
              <div class="mt-6 flex flex-wrap gap-3">
                <a href="#items" class="inline-flex min-h-11 items-center rounded-full bg-accent px-5 text-sm font-semibold text-white transition hover:bg-accent-strong">Browse bottles</a>
                <a href="<%= accountHref %>" class="inline-flex min-h-11 items-center rounded-full border border-black/[0.1] bg-white/80 px-5 text-sm font-semibold text-ink transition hover:bg-white"><%= accountLabel %></a>
              </div>
            </div>
            <form id="lhContactForm" action="https://api.web3forms.com/submit" method="POST" class="space-y-4 rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 sm:p-6">
              <input type="hidden" name="access_key" value="dd25e6c0-5976-4bdc-84c9-0e7090f32f59">
              <input type="hidden" name="subject" value="New message from LiquorHub">
              <input type="hidden" name="from_name" value="LiquorHub Contact">
              <input type="checkbox" name="botcheck" class="hidden" style="display:none" tabindex="-1" autocomplete="off" aria-hidden="true">

              <p id="lhContactStatus" class="rounded-xl border px-3 py-2.5 text-sm" hidden></p>

              <div>
                <label for="c-name" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Name</label>
                <input id="c-name" name="name" type="text" required placeholder="Your name" autocomplete="name"
                  class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/60 px-4 text-sm outline-none transition focus:border-accent/40 focus:ring-2 focus:ring-accent/15">
              </div>
              <div>
                <label for="c-email" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Email</label>
                <input id="c-email" name="email" type="email" required placeholder="you@email.com" autocomplete="email"
                  class="w-full min-h-11 rounded-full border border-black/[0.08] bg-cream/60 px-4 text-sm outline-none transition focus:border-accent/40 focus:ring-2 focus:ring-accent/15">
              </div>
              <div>
                <label for="c-message" class="mb-1.5 block text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Message</label>
                <textarea id="c-message" name="message" rows="4" required placeholder="How can we help?"
                  class="w-full rounded-2xl border border-black/[0.08] bg-cream/60 px-4 py-3 text-sm outline-none transition focus:border-accent/40 focus:ring-2 focus:ring-accent/15"></textarea>
              </div>
              <button type="submit" id="lhContactSubmit" class="inline-flex min-h-11 items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold text-white transition hover:bg-accent-strong disabled:opacity-60">Send message</button>
            </form>
          </div>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/gates.js" defer></script>
  <script src="<%= ctx %>/js/toast.js" defer></script>
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
