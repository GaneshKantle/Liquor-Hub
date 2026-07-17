<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.ProductDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%@ page import="com.LiquorHub.utility.ImageUrls" %>
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

  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);

  String contactOk = (String) request.getAttribute("contactSuccess");
  String contactErr = (String) request.getAttribute("contactError");
  int productCount = products != null ? products.size() : 0;
  int categoryCount = categories != null ? categories.size() : 0;
  String accountHref = loggedIn ? ctx + "/dashboard" : ctx + "/login";
  String accountLabel = loggedIn ? "Profile" : "Sign in";
%>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LiquorHub - Curated bottles. Clear prices. Trusted exchange.</title>
  <meta name="description" content="LiquorHub is a curated liquor marketplace. Browse whisky, wine, gin and more with clear INR prices. Shop freely; sign in only to add to cart.">
  <meta name="color-scheme" content="light only">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Instrument+Serif&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#f8f5ef', soft: '#fffcf7', strong: '#f1ece4' },
            ink: { DEFAULT: '#13110d', muted: '#6a655d', subtle: '#89847b' },
            accent: { DEFAULT: '#d96a3b', soft: '#f4dcd1', strong: '#a84822' }
          },
          fontFamily: {
            display: ['"Instrument Serif"', 'Georgia', 'serif'],
            sans: ['Manrope', 'ui-sans-serif', 'system-ui', 'sans-serif']
          },
          maxWidth: { shell: '72rem', measure: '36rem' }
        }
      }
    };
  </script>
  <style type="text/css">
    body {
      font-family: Manrope, ui-sans-serif, system-ui, sans-serif;
      background-color: #f8f5ef;
      color: #13110d;
      background-image:
        radial-gradient(circle at top left, rgba(217, 106, 59, 0.08), transparent 24%),
        radial-gradient(circle at right 20%, rgba(255, 255, 255, 0.72), transparent 30%),
        linear-gradient(180deg, rgba(255, 255, 255, 0.65), rgba(248, 245, 239, 0.95));
      background-attachment: fixed;
    }
    .font-display { font-family: "Instrument Serif", Georgia, serif; }
    .lh-reveal { opacity: 0; transform: translateY(16px); transition: opacity .55s ease, transform .55s ease; }
    .lh-reveal.is-in { opacity: 1; transform: none; }
    .lh-marquee-wrap {
      mask-image: linear-gradient(90deg, transparent, #000 6%, #000 94%, transparent);
      -webkit-mask-image: linear-gradient(90deg, transparent, #000 6%, #000 94%, transparent);
    }
    .lh-marquee { animation: lh-marquee 40s linear infinite; }
    .lh-marquee-rev { animation: lh-marquee-rev 46s linear infinite; }
    .lh-marquee-wrap:hover .lh-marquee,
    .lh-marquee-wrap:hover .lh-marquee-rev { animation-play-state: paused; }
    @keyframes lh-marquee { from { transform: translateX(0); } to { transform: translateX(-50%); } }
    @keyframes lh-marquee-rev { from { transform: translateX(-50%); } to { transform: translateX(0); } }
    #siteHeader.is-scrolled #navBar { box-shadow: 0 12px 40px rgba(38, 34, 29, 0.1); }
    html.lh-quiz-lock, html.lh-quiz-lock body { overflow: hidden !important; }
    #lhQuizGate:not([hidden]):not(.hidden) { display: flex; }
    #lhQuizGate.is-done { opacity: 0; visibility: hidden; pointer-events: none; transition: opacity .4s ease; }
    #lhLoginModal:not([hidden]):not(.hidden) { display: flex; }
    @media (prefers-reduced-motion: reduce) {
      .lh-marquee, .lh-marquee-rev { animation: none !important; flex-wrap: wrap; width: 100%; justify-content: center; }
      .lh-reveal { opacity: 1; transform: none; }
    }
  </style>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="min-h-screen overflow-x-clip font-sans text-ink antialiased" data-logged-in="<%= loggedIn ? "1" : "0" %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />

  <!-- First-visit liquor quiz -->
  <div id="lhQuizGate" class="fixed inset-0 z-[2147483645] hidden items-center justify-center overflow-y-auto bg-[#13110d]/92 p-4 backdrop-blur-md" hidden role="dialog" aria-modal="true" aria-labelledby="lhQuizTitle">
    <div class="my-6 w-full max-w-lg rounded-[1.75rem] border border-white/20 bg-cream-soft p-5 shadow-2xl sm:p-8">
      <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Entry quiz</p>
      <h2 id="lhQuizTitle" class="mt-2 font-display text-[clamp(1.75rem,5vw,2.4rem)] leading-tight tracking-[-0.03em] text-ink">Prove you know your pour</h2>
      <p class="mt-2 text-sm text-ink-muted">Four basics. First visit only. Get them right to enter LiquorHub.</p>

      <form id="lhQuizForm" class="mt-6 space-y-5">
        <fieldset class="space-y-2">
          <legend class="text-sm font-semibold text-ink">1. Whisky is typically aged in what?</legend>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q1" value="a" required class="mt-0.5 accent-[#d96a3b]"> Plastic bottles</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q1" value="b" class="mt-0.5 accent-[#d96a3b]"> Steel cans</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q1" value="c" class="mt-0.5 accent-[#d96a3b]"> Oak barrels</label>
        </fieldset>
        <fieldset class="space-y-2">
          <legend class="text-sm font-semibold text-ink">2. Which spirit is juniper-forward?</legend>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q2" value="a" required class="mt-0.5 accent-[#d96a3b]"> Vodka</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q2" value="b" class="mt-0.5 accent-[#d96a3b]"> Gin</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q2" value="c" class="mt-0.5 accent-[#d96a3b]"> Rum</label>
        </fieldset>
        <fieldset class="space-y-2">
          <legend class="text-sm font-semibold text-ink">3. Tequila is traditionally made from what plant?</legend>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q3" value="a" required class="mt-0.5 accent-[#d96a3b]"> Blue agave</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q3" value="b" class="mt-0.5 accent-[#d96a3b]"> Sugarcane</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q3" value="c" class="mt-0.5 accent-[#d96a3b]"> Barley</label>
        </fieldset>
        <fieldset class="space-y-2">
          <legend class="text-sm font-semibold text-ink">4. ABV stands for?</legend>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q4" value="a" required class="mt-0.5 accent-[#d96a3b]"> Average Bottle Volume</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q4" value="b" class="mt-0.5 accent-[#d96a3b]"> Aged Barrel Vintage</label>
          <label class="flex gap-2 text-sm text-ink-muted"><input type="radio" name="q4" value="c" class="mt-0.5 accent-[#d96a3b]"> Alcohol By Volume</label>
        </fieldset>
        <button type="submit" class="inline-flex min-h-11 w-full items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold text-white hover:bg-accent-strong">Enter LiquorHub</button>
      </form>

      <div id="lhQuizFail" class="mt-6 hidden" hidden>
        <p class="font-display text-2xl tracking-[-0.03em] text-ink">Bro first learn the basics you kid</p>
        <p class="mt-2 text-sm text-ink-muted">Come back when oak, juniper, agave, and ABV make sense.</p>
        <button type="button" id="lhQuizRetry" class="mt-5 inline-flex min-h-11 items-center justify-center rounded-full border border-black/10 bg-white px-6 text-sm font-semibold text-ink hover:bg-cream">Try again</button>
      </div>
    </div>
  </div>

  <!-- Guest cart login prompt -->
  <div id="lhLoginModal" class="fixed inset-0 z-[2147483644] hidden items-center justify-center bg-ink/50 p-4 backdrop-blur-sm" hidden role="dialog" aria-modal="true" aria-labelledby="lhLoginModalTitle">
    <div class="w-full max-w-sm rounded-[1.5rem] border border-white/80 bg-white p-6 shadow-2xl">
      <h2 id="lhLoginModalTitle" class="font-display text-2xl tracking-[-0.03em]">Sign in to add to cart</h2>
      <p class="mt-2 text-sm text-ink-muted">Browse freely. Cart needs an account.</p>
      <div class="mt-5 flex flex-col gap-2">
        <a href="<%= ctx %>/login" class="inline-flex min-h-11 items-center justify-center rounded-full bg-accent px-5 text-sm font-semibold text-white hover:bg-accent-strong">Sign in</a>
        <a href="<%= ctx %>/register.jsp" class="inline-flex min-h-11 items-center justify-center rounded-full border border-black/10 bg-cream px-5 text-sm font-semibold text-ink hover:bg-white">Create account</a>
        <button type="button" id="lhLoginModalClose" class="mt-1 text-sm font-semibold text-ink-muted hover:text-ink">Keep browsing</button>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main>
    <section class="relative flex min-h-[100svh] items-end overflow-hidden text-white lg:items-center" aria-label="Hero">
      <video class="absolute inset-0 h-full w-full object-cover" autoplay muted loop playsinline preload="metadata">
        <source src="<%= ctx %>/assets/video/hero.mp4" type="video/mp4">
      </video>
      <div class="absolute inset-0 bg-gradient-to-b from-ink/45 via-ink/55 to-ink/80" aria-hidden="true"></div>
      <div class="relative z-[1] mx-auto flex min-h-[100svh] w-full max-w-shell flex-col justify-end px-4 pb-12 pt-32 sm:px-6 sm:pb-16 md:pt-36 lg:justify-center lg:pb-20">
        <div class="lh-reveal max-w-measure space-y-5 text-left">
          <div class="space-y-3">
            <p class="font-display text-[clamp(2.75rem,8vw,5.5rem)] leading-[0.92] tracking-[-0.04em] text-white">LiquorHub</p>
            <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-white/65">Curated liquor marketplace</p>
          </div>
          <div class="space-y-3">
            <h1 class="max-w-[20ch] text-[clamp(1.65rem,3.8vw,2.65rem)] font-semibold leading-[1.12] tracking-[-0.04em] text-white">
              Shop rare and everyday bottles with <span class="text-accent">clear prices</span> - no guesswork.
            </h1>
            <p class="max-w-md text-pretty text-base text-white/78 sm:text-lg">Browse whisky, wine, gin and more from the live catalogue. Sign in only when you add to cart.</p>
          </div>
          <div class="flex flex-col gap-3 sm:flex-row sm:flex-wrap">
            <a href="#items" class="inline-flex min-h-11 w-full items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold tracking-[-0.02em] text-white transition hover:bg-accent-strong sm:w-auto">Browse bottles</a>
            <a href="#categories" class="inline-flex min-h-11 w-full items-center justify-center rounded-full border border-white/55 bg-white/20 px-6 text-sm font-semibold tracking-[-0.02em] text-white transition hover:border-white/40 hover:bg-white/12 sm:w-auto">Explore categories</a>
          </div>
        </div>
      </div>
    </section>

    <section class="border-b border-black/[0.08] pt-10 sm:pt-12">
      <div class="lh-reveal mx-auto max-w-shell space-y-7 px-4 pb-10 sm:space-y-8 sm:px-6 sm:pb-12">
        <div class="flex flex-col gap-5 sm:gap-6 lg:flex-row lg:items-end lg:justify-between">
          <div class="max-w-xl text-left">
            <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">What we do</p>
            <h2 class="mt-2 font-display text-[clamp(1.75rem,3.5vw,2.35rem)] font-normal leading-tight tracking-[-0.03em]">Live catalogue. Honest INR. Trusted exchange.</h2>
          </div>
          <div class="flex flex-wrap items-center gap-3 sm:gap-4">
            <div class="min-w-[4.5rem] border-l border-black/[0.12] pl-3">
              <div class="text-sm font-semibold tracking-[-0.03em]"><%= categoryCount %></div>
              <div class="mt-0.5 text-[0.6rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Categories</div>
            </div>
            <div class="min-w-[4.5rem] border-l border-black/[0.12] pl-3">
              <div class="text-sm font-semibold tracking-[-0.03em]"><%= productCount %>+</div>
              <div class="mt-0.5 text-[0.6rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Bottles</div>
            </div>
            <div class="min-w-[4.5rem] border-l border-black/[0.12] pl-3">
              <div class="text-sm font-semibold tracking-[-0.03em]">Free browse</div>
              <div class="mt-0.5 text-[0.6rem] font-semibold uppercase tracking-[0.14em] text-ink-muted">Login for cart</div>
            </div>
          </div>
        </div>
        <div class="flex flex-col gap-3 border-y border-black/[0.08] py-4 sm:flex-row sm:flex-wrap sm:items-center sm:gap-x-5 sm:py-5" role="list">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Spirits we stock</p>
          <span class="hidden h-4 w-px shrink-0 bg-black/10 sm:block" aria-hidden="true"></span>
          <div class="flex flex-wrap items-center gap-x-4 gap-y-2.5">
            <% if (categories != null) {
                 for (CategoryDTO cat : categories) { %>
            <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" role="listitem" class="text-[0.8rem] font-semibold uppercase tracking-[0.12em] text-ink transition hover:text-accent"><%= cat.getCategoryName() %></a>
            <%   }
               } %>
          </div>
        </div>
      </div>
    </section>

    <!-- Categories - magazine tiles -->
    <section id="categories" class="scroll-mt-28 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Categories</p>
          <h2 class="mt-2 font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Pick a spirit. Jump to bottles.</h2>
          <p class="mt-3 max-w-xl text-ink-muted">Image-led shelves from the live catalogue.</p>
        </div>
        <div class="mt-8 grid gap-3 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          <% if (categories != null && !categories.isEmpty()) {
               for (CategoryDTO cat : categories) {
                 String catImg = ImageUrls.forCategory(cat.getCategoryName());
          %>
          <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>"
            class="group relative aspect-[4/5] overflow-hidden rounded-[1.5rem] border border-black/[0.08] bg-ink">
            <img src="<%= catImg %>" alt="" loading="lazy" decoding="async" width="800" height="1000"
              class="absolute inset-0 h-full w-full object-cover transition duration-500 group-hover:scale-[1.04]">
            <div class="absolute inset-0 bg-gradient-to-t from-ink/85 via-ink/25 to-transparent"></div>
            <div class="absolute inset-x-0 bottom-0 p-4 sm:p-5">
              <h3 class="font-display text-[1.35rem] tracking-[-0.02em] text-white sm:text-[1.5rem]"><%= cat.getCategoryName() %></h3>
              <p class="mt-1 text-sm text-white/70">Shop <%= cat.getCategoryName().toLowerCase() %></p>
            </div>
          </a>
          <%   }
             } else { %>
          <p class="col-span-full rounded-[1.25rem] border border-dashed border-black/10 p-5 text-ink-muted">Categories will appear when the catalogue is loaded.</p>
          <% } %>
        </div>
      </div>
    </section>

    <!-- Collections -->
    <section id="collections" class="scroll-mt-28 border-y border-black/[0.08] bg-white/50 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Collections</p>
          <h2 class="mt-2 font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Edited for how you pour</h2>
          <p class="mt-3 max-w-xl text-ink-muted">Three starter sets pulled live from the catalogue.</p>
        </div>
        <div class="mt-8 grid gap-3 md:grid-cols-3">
          <article class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white">
            <h3 class="font-display text-[1.35rem] tracking-[-0.03em]">Whisky Essentials</h3>
            <p class="mt-1.5 text-sm text-ink-muted">Core whisky picks from the shelf.</p>
            <ul class="mt-4 space-y-0">
              <% if (whiskyEssentials != null && !whiskyEssentials.isEmpty()) {
                   for (ProductDTO p : whiskyEssentials) { %>
              <li class="flex items-baseline justify-between gap-3 border-b border-black/[0.06] py-2.5 text-sm last:border-0">
                <strong class="font-semibold tracking-[-0.02em]"><%= p.getProductName() %></strong>
                <span class="shrink-0 tabular-nums text-ink-muted"><%= inr.format(p.getPrice()) %></span>
              </li>
              <%   }
                 } else { %>
              <li class="py-2.5 text-sm text-ink-muted">No bottles in this set yet.</li>
              <% } %>
            </ul>
          </article>
          <article class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white">
            <h3 class="font-display text-[1.35rem] tracking-[-0.03em]">House Pour</h3>
            <p class="mt-1.5 text-sm text-ink-muted">Everyday bottles under Rs 1,500.</p>
            <ul class="mt-4 space-y-0">
              <% if (housePour != null && !housePour.isEmpty()) {
                   for (ProductDTO p : housePour) { %>
              <li class="flex items-baseline justify-between gap-3 border-b border-black/[0.06] py-2.5 text-sm last:border-0">
                <strong class="font-semibold tracking-[-0.02em]"><%= p.getProductName() %></strong>
                <span class="shrink-0 tabular-nums text-ink-muted"><%= inr.format(p.getPrice()) %></span>
              </li>
              <%   }
                 } else { %>
              <li class="py-2.5 text-sm text-ink-muted">No bottles in this set yet.</li>
              <% } %>
            </ul>
          </article>
          <article class="rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 transition hover:bg-white">
            <h3 class="font-display text-[1.35rem] tracking-[-0.03em]">Premium Picks</h3>
            <p class="mt-1.5 text-sm text-ink-muted">Special bottles from Rs 4,000 up.</p>
            <ul class="mt-4 space-y-0">
              <% if (premiumPicks != null && !premiumPicks.isEmpty()) {
                   for (ProductDTO p : premiumPicks) { %>
              <li class="flex items-baseline justify-between gap-3 border-b border-black/[0.06] py-2.5 text-sm last:border-0">
                <strong class="font-semibold tracking-[-0.02em]"><%= p.getProductName() %></strong>
                <span class="shrink-0 tabular-nums text-ink-muted"><%= inr.format(p.getPrice()) %></span>
              </li>
              <%   }
                 } else { %>
              <li class="py-2.5 text-sm text-ink-muted">No bottles in this set yet.</li>
              <% } %>
            </ul>
          </article>
        </div>
      </div>
    </section>

    <!-- Products -->
    <section id="items" class="scroll-mt-28 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Catalogue</p>
          <h2 class="mt-2 font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Bottles with a clear price</h2>
          <p class="mt-3 max-w-xl text-ink-muted">Search or pick a category. Add to cart when you are ready (login required).</p>
        </div>
        <div id="productGrid" class="mt-8 grid grid-cols-2 gap-3 sm:gap-3 md:grid-cols-3 xl:grid-cols-4">
          <% if (products != null && !products.isEmpty()) {
               for (ProductDTO p : products) {
                 String brand = p.getBrand() != null ? p.getBrand() : "";
                 String nameLower = (p.getProductName() + " " + brand).toLowerCase().replace("\"", "");
                 String img = ImageUrls.forProduct(p.getProductName(), brand);
          %>
          <article class="lh-prod group overflow-hidden rounded-[1.25rem] border border-black/[0.08] bg-white/80 transition duration-300 hover:bg-white hover:shadow-[0_10px_40px_rgba(38,34,29,0.06)]"
            data-cat="<%= p.getCategoryId() %>"
            data-search="<%= nameLower %>">
            <div class="relative aspect-[4/3] overflow-hidden bg-cream">
              <img src="<%= img %>" alt="" loading="lazy" decoding="async" width="640" height="480"
                class="h-full w-full object-cover transition duration-500 group-hover:scale-[1.03]">
            </div>
            <div class="space-y-1 p-4">
              <span class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-ink-muted"><%= brand %></span>
              <h3 class="text-[0.95rem] font-semibold leading-snug tracking-[-0.02em] sm:text-base"><%= p.getProductName() %></h3>
              <div class="pt-1 text-sm font-semibold tabular-nums tracking-[-0.02em] text-accent-strong"><%= inr.format(p.getPrice()) %></div>
              <% if (loggedIn) { %>
              <form action="<%= ctx %>/add-to-cart" method="post" class="pt-2">
                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                <button type="submit" class="inline-flex min-h-9 w-full items-center justify-center rounded-full bg-accent px-3 text-xs font-semibold text-white hover:bg-accent-strong">Add to cart</button>
              </form>
              <% } else { %>
              <button type="button" class="lh-add-cart mt-2 inline-flex min-h-9 w-full items-center justify-center rounded-full border border-black/10 bg-cream px-3 text-xs font-semibold text-ink hover:bg-white" data-product-id="<%= p.getProductId() %>">Add to cart</button>
              <% } %>
            </div>
          </article>
          <%   }
             } else { %>
          <p class="col-span-full rounded-[1.25rem] border border-dashed border-black/10 p-5 text-center text-ink-muted">No bottles in the catalogue yet.</p>
          <% } %>
        </div>
        <p id="productEmpty" class="mt-6 hidden rounded-[1.25rem] border border-dashed border-black/[0.12] p-5 text-center text-ink-muted">No bottles match that search.</p>
      </div>
    </section>

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
    <section id="about" class="scroll-mt-28 py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="max-w-3xl text-left">
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Occasions</p>
          <h2 class="mt-2 font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">What LiquorHub is for</h2>
          <p class="mt-3 max-w-xl text-ink-muted">A clear path from occasion to bottle.</p>
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

    <!-- Contact -->
    <section id="contact" class="scroll-mt-28 border-t border-black/[0.08] py-12 sm:py-14 lg:py-16">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="overflow-hidden rounded-[1.75rem] border border-black/[0.08] bg-[linear-gradient(165deg,rgba(217,106,59,0.12),rgba(255,255,255,0.92)_40%)] p-6 sm:p-8 lg:p-10">
          <div class="grid gap-8 lg:grid-cols-2 lg:items-start lg:gap-12">
            <div>
              <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Contact</p>
              <h2 class="mt-2 max-w-[14ch] font-display text-[clamp(1.85rem,4vw,2.65rem)] font-normal leading-tight tracking-[-0.03em]">Talk to LiquorHub</h2>
              <p class="mt-3 max-w-md text-ink-muted">Questions on a bottle, a collection, or your collector profile? Send a short note.</p>
              <p class="mt-4">
                <a href="mailto:liquourhub@gmail.com" class="text-sm font-semibold text-accent-strong underline decoration-accent/40 underline-offset-4 hover:text-accent">liquourhub@gmail.com</a>
              </p>
              <div class="mt-6 flex flex-wrap gap-3">
                <a href="#items" class="inline-flex min-h-11 items-center rounded-full bg-accent px-5 text-sm font-semibold text-white transition hover:bg-accent-strong">Browse bottles</a>
                <a href="<%= accountHref %>" class="inline-flex min-h-11 items-center rounded-full border border-black/[0.1] bg-white/80 px-5 text-sm font-semibold text-ink transition hover:bg-white"><%= accountLabel %></a>
              </div>
            </div>
            <form action="<%= ctx %>/contact" method="post" class="space-y-4 rounded-[1.25rem] border border-black/[0.08] bg-white/80 p-5 sm:p-6">
              <% if (contactOk != null) { %>
              <p class="rounded-xl border border-green-700/15 bg-green-50 px-3 py-2.5 text-sm text-green-800"><%= contactOk %></p>
              <% } %>
              <% if (contactErr != null) { %>
              <p class="rounded-xl border border-red-700/15 bg-red-50 px-3 py-2.5 text-sm text-red-800"><%= contactErr %></p>
              <% } %>
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
              <button type="submit" class="inline-flex min-h-11 items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold text-white transition hover:bg-accent-strong">Send message</button>
            </form>
          </div>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/gates.js" defer></script>
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
