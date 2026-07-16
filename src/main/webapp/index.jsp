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
<html lang="en" class="scroll-smooth" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LiquorHub — Rare bottles. Trusted exchange.</title>
  <meta name="description" content="Curated whisky, wine, gin and more. Shop collections made for celebrating, gifting, and hosting.">
  <meta name="color-scheme" content="light only">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500;600&family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            cream: { DEFAULT: '#f8f5ef', soft: '#fffbf7' },
            ink: { DEFAULT: '#13110d', muted: '#6a655d' },
            copper: { DEFAULT: '#b87333', soft: '#f3e4d4', strong: '#8a5520' }
          },
          fontFamily: {
            display: ['"Cormorant Garamond"', 'Georgia', 'serif'],
            sans: ['Outfit', 'system-ui', 'sans-serif']
          },
          maxWidth: { shell: '72rem' },
          boxShadow: {
            glass: '0 8px 32px rgba(38, 34, 29, 0.08)',
            'glass-lg': '0 20px 60px rgba(38, 34, 29, 0.1)'
          }
        }
      }
    };
  </script>
  <style type="text/css">
    body { font-family: Outfit, system-ui, sans-serif; background-color: #f8f5ef; color: #13110d; }
    .font-display { font-family: "Cormorant Garamond", Georgia, serif; }
    .glass {
      background: rgba(255, 255, 255, 0.45);
      border: 1px solid rgba(255, 255, 255, 0.7);
      box-shadow: 0 8px 32px rgba(38, 34, 29, 0.07), inset 0 1px 0 rgba(255, 255, 255, 0.8);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
    }
    .glass-strong {
      background: rgba(255, 255, 255, 0.62);
      border: 1px solid rgba(255, 255, 255, 0.8);
      box-shadow: 0 12px 40px rgba(38, 34, 29, 0.08), inset 0 1px 0 rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(24px);
      -webkit-backdrop-filter: blur(24px);
    }
    .lh-reveal { opacity: 0; transform: translateY(18px); transition: opacity .6s ease, transform .6s ease; }
    .lh-reveal.is-in { opacity: 1; transform: none; }
    .lh-marquee-wrap {
      mask-image: linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent);
      -webkit-mask-image: linear-gradient(90deg, transparent, #000 8%, #000 92%, transparent);
    }
    .lh-marquee { animation: lh-marquee 42s linear infinite; }
    .lh-marquee-rev { animation: lh-marquee-rev 48s linear infinite; }
    .lh-marquee-wrap:hover .lh-marquee,
    .lh-marquee-wrap:hover .lh-marquee-rev { animation-play-state: paused; }
    @keyframes lh-marquee { from { transform: translateX(0); } to { transform: translateX(-50%); } }
    @keyframes lh-marquee-rev { from { transform: translateX(-50%); } to { transform: translateX(0); } }
    #siteHeader.is-scrolled #navBar { box-shadow: 0 16px 48px rgba(38, 34, 29, 0.12); }
    @media (prefers-reduced-motion: reduce) {
      .lh-marquee, .lh-marquee-rev { animation: none !important; flex-wrap: wrap; width: 100%; justify-content: center; }
      .lh-reveal { opacity: 1; transform: none; }
    }
  </style>
</head>
<body class="relative min-h-screen overflow-x-clip bg-cream font-sans text-ink antialiased"
  style="background-color:#f8f5ef; background-image:
    radial-gradient(ellipse 60% 50% at 0% 0%, rgba(184,115,51,0.14), transparent 55%),
    radial-gradient(ellipse 50% 40% at 100% 10%, rgba(255,255,255,0.95), transparent 50%),
    radial-gradient(ellipse 45% 35% at 80% 80%, rgba(243,228,212,0.7), transparent 55%),
    linear-gradient(180deg, #ffffff 0%, #f8f5ef 45%, #f3e4d4 100%);
    background-attachment: fixed;">

  <jsp:include page="/WEB-INF/jspf/loader.jsp" />

  <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden" aria-hidden="true">
    <div class="absolute -left-24 top-32 h-72 w-72 rounded-full bg-copper/10 blur-3xl"></div>
    <div class="absolute right-0 top-[40%] h-96 w-96 rounded-full bg-white/70 blur-3xl"></div>
  </div>

  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main>
    <!-- Hero -->
    <section class="relative flex min-h-[100svh] items-end overflow-hidden lg:items-center" aria-label="Hero">
      <video class="absolute inset-0 h-full w-full object-cover opacity-35" autoplay muted loop playsinline preload="metadata">
        <source src="<%= ctx %>/assets/video/hero.mp4" type="video/mp4">
      </video>
      <div class="absolute inset-0 bg-gradient-to-b from-cream/75 via-cream/65 to-cream" aria-hidden="true"></div>
      <div class="relative z-10 mx-auto w-full max-w-shell px-4 pb-12 pt-32 sm:px-6 sm:pb-16 md:pt-36 lg:pb-20">
        <div class="glass max-w-2xl rounded-[2rem] p-6 sm:p-9">
          <p class="font-display text-[clamp(2.5rem,7vw,4.75rem)] font-semibold leading-[0.92] tracking-tight text-ink">LiquorHub</p>
          <p class="mt-3 text-[0.7rem] font-semibold uppercase tracking-[0.14em] text-copper">Rare bottles · Trusted exchange</p>
          <h1 class="mt-4 max-w-[18ch] text-[clamp(1.5rem,3.5vw,2.35rem)] font-semibold leading-[1.15] tracking-tight text-ink">
            Find the pour that <em class="not-italic text-copper">belongs</em> on your table.
          </h1>
          <p class="mt-4 max-w-md text-base text-ink-muted sm:text-lg">Curated spirits and wine — shop by taste, occasion, or collection in one clear scroll.</p>
          <div class="mt-7 flex flex-wrap gap-3">
            <a href="#items" class="inline-flex min-h-11 items-center justify-center rounded-full bg-copper px-6 text-sm font-semibold text-white shadow-lg shadow-copper/25 transition hover:-translate-y-0.5 hover:bg-copper-strong">Shop bottles</a>
            <a href="#collections" class="inline-flex min-h-11 items-center justify-center rounded-full border border-white/80 bg-white/50 px-6 text-sm font-semibold text-ink backdrop-blur transition hover:bg-white/80">See collections</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Categories -->
    <section id="categories" class="scroll-mt-28 py-14 sm:py-16 lg:py-20">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <p class="text-[0.65rem] font-bold uppercase tracking-[0.14em] text-copper">Categories</p>
        <h2 class="mt-2 max-w-[18ch] font-display text-[clamp(1.85rem,4vw,2.75rem)] font-semibold leading-tight tracking-tight">Browse by spirit</h2>
        <p class="mt-3 max-w-xl text-ink-muted">Eight shelves. Pick a lane and jump straight to matching bottles.</p>
        <div class="mt-8 grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4 md:gap-4">
          <% if (categories != null) {
               int i = 0;
               for (CategoryDTO cat : categories) {
                 i++; %>
          <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>"
            class="glass group flex min-h-[9rem] flex-col justify-end rounded-3xl p-4 transition duration-300 hover:-translate-y-1 hover:bg-white/70 hover:shadow-glass-lg sm:p-5">
            <span class="text-[0.65rem] font-bold tracking-[0.12em] text-ink-muted"><%= String.format("%02d", i) %></span>
            <span class="mt-1 font-display text-xl font-semibold tracking-tight group-hover:text-copper-strong sm:text-2xl"><%= cat.getCategoryName() %></span>
          </a>
          <%   }
             } %>
        </div>
      </div>
    </section>

    <!-- Collections -->
    <section id="collections" class="scroll-mt-28 py-14 sm:py-16 lg:py-20">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="glass-strong rounded-[2rem] p-6 sm:p-8 lg:p-10">
          <p class="text-[0.65rem] font-bold uppercase tracking-[0.14em] text-copper">Collections</p>
          <h2 class="mt-2 max-w-[18ch] font-display text-[clamp(1.85rem,4vw,2.75rem)] font-semibold leading-tight tracking-tight">Edited for how you pour</h2>
          <p class="mt-3 max-w-xl text-ink-muted">Three starter sets pulled live from the catalogue.</p>
          <div class="mt-8 grid gap-5 md:grid-cols-3">
            <article class="glass rounded-3xl p-5">
              <h3 class="font-display text-2xl font-semibold tracking-tight">Whisky Essentials</h3>
              <p class="mt-1 text-sm text-ink-muted">Core whisky picks from the shelf.</p>
              <ul class="mt-4 space-y-0">
                <% if (whiskyEssentials != null) {
                     for (ProductDTO p : whiskyEssentials) { %>
                <li class="flex items-baseline justify-between gap-3 border-b border-black/5 py-3 text-sm last:border-0">
                  <strong class="font-semibold"><%= p.getProductName() %></strong>
                  <span class="shrink-0 tabular-nums text-copper-strong"><%= inr.format(p.getPrice()) %></span>
                </li>
                <%   }
                   } %>
              </ul>
            </article>
            <article class="glass rounded-3xl p-5">
              <h3 class="font-display text-2xl font-semibold tracking-tight">House Pour</h3>
              <p class="mt-1 text-sm text-ink-muted">Everyday bottles under ₹1,500.</p>
              <ul class="mt-4 space-y-0">
                <% if (housePour != null) {
                     for (ProductDTO p : housePour) { %>
                <li class="flex items-baseline justify-between gap-3 border-b border-black/5 py-3 text-sm last:border-0">
                  <strong class="font-semibold"><%= p.getProductName() %></strong>
                  <span class="shrink-0 tabular-nums text-copper-strong"><%= inr.format(p.getPrice()) %></span>
                </li>
                <%   }
                   } %>
              </ul>
            </article>
            <article class="glass rounded-3xl p-5">
              <h3 class="font-display text-2xl font-semibold tracking-tight">Premium Picks</h3>
              <p class="mt-1 text-sm text-ink-muted">Special bottles from ₹4,000 up.</p>
              <ul class="mt-4 space-y-0">
                <% if (premiumPicks != null) {
                     for (ProductDTO p : premiumPicks) { %>
                <li class="flex items-baseline justify-between gap-3 border-b border-black/5 py-3 text-sm last:border-0">
                  <strong class="font-semibold"><%= p.getProductName() %></strong>
                  <span class="shrink-0 tabular-nums text-copper-strong"><%= inr.format(p.getPrice()) %></span>
                </li>
                <%   }
                   } %>
              </ul>
            </article>
          </div>
        </div>
      </div>
    </section>

    <!-- Products -->
    <section id="items" class="scroll-mt-28 py-14 sm:py-16 lg:py-20">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <p class="text-[0.65rem] font-bold uppercase tracking-[0.14em] text-copper">Catalogue</p>
        <h2 class="mt-2 max-w-[18ch] font-display text-[clamp(1.85rem,4vw,2.75rem)] font-semibold leading-tight tracking-tight">Bottles with a clear price</h2>
        <p class="mt-3 max-w-xl text-ink-muted">Name, brand, and price — use search or a category to narrow the shelf.</p>
        <div id="productGrid" class="mt-8 grid grid-cols-2 gap-3 sm:gap-4 md:grid-cols-3 lg:grid-cols-4">
          <% if (products != null) {
               for (ProductDTO p : products) {
                 String initial = p.getProductName() != null && !p.getProductName().isEmpty()
                     ? p.getProductName().substring(0, 1).toUpperCase()
                     : "?";
                 String brand = p.getBrand() != null ? p.getBrand() : "";
                 String nameLower = (p.getProductName() + " " + brand).toLowerCase();
          %>
          <article class="lh-prod glass group flex flex-col overflow-hidden rounded-3xl transition duration-300 hover:-translate-y-1 hover:bg-white/70 hover:shadow-glass-lg"
            data-cat="<%= p.getCategoryId() %>"
            data-search="<%= nameLower.replace("\"", "") %>">
            <div class="flex aspect-[1/1.05] items-center justify-center bg-gradient-to-br from-copper-soft/80 via-white/40 to-transparent font-display text-4xl font-semibold tracking-tight text-copper-strong sm:text-5xl" aria-hidden="true"><%= initial %></div>
            <div class="flex flex-1 flex-col gap-0.5 p-3 sm:p-4">
              <span class="text-[0.65rem] font-bold uppercase tracking-[0.1em] text-ink-muted"><%= brand %></span>
              <h3 class="text-sm font-semibold leading-snug tracking-tight sm:text-base"><%= p.getProductName() %></h3>
              <div class="mt-auto pt-2 text-sm font-semibold tabular-nums text-copper-strong"><%= inr.format(p.getPrice()) %></div>
            </div>
          </article>
          <%   }
             } %>
        </div>
        <p id="productEmpty" class="glass mt-6 hidden rounded-3xl p-5 text-center text-ink-muted">No bottles match that search.</p>
      </div>
    </section>

    <!-- Occasions -->
    <section id="about" class="scroll-mt-28 py-14 sm:py-16 lg:py-20">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="glass-strong rounded-[2rem] p-6 sm:p-8 lg:p-10">
          <p class="text-[0.65rem] font-bold uppercase tracking-[0.14em] text-copper">Occasions</p>
          <h2 class="mt-2 max-w-[18ch] font-display text-[clamp(1.85rem,4vw,2.75rem)] font-semibold leading-tight tracking-tight">What LiquorHub is for</h2>
          <p class="mt-3 max-w-xl text-ink-muted">Not a random shelf — a clear path from occasion to bottle.</p>
          <div class="mt-8 space-y-3">
            <a href="#items" class="glass group grid gap-3 rounded-3xl p-5 transition hover:bg-white/75 sm:grid-cols-[0.85fr_1.15fr_auto] sm:items-center sm:gap-8">
              <div>
                <div class="text-[0.65rem] font-bold tracking-[0.14em] text-ink-muted">01</div>
                <h3 class="mt-1 font-display text-xl font-semibold sm:text-2xl">Celebrate</h3>
              </div>
              <p class="text-sm text-ink-muted sm:text-base">Mark the night with a bottle that feels intentional — whisky, sparkling, or something rare.</p>
              <span class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-white/80 bg-white/60 transition group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-copper" aria-hidden="true">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
              </span>
            </a>
            <a href="#collections" class="glass group grid gap-3 rounded-3xl p-5 transition hover:bg-white/75 sm:grid-cols-[0.85fr_1.15fr_auto] sm:items-center sm:gap-8">
              <div>
                <div class="text-[0.65rem] font-bold tracking-[0.14em] text-ink-muted">02</div>
                <h3 class="mt-1 font-display text-xl font-semibold sm:text-2xl">Gift</h3>
              </div>
              <p class="text-sm text-ink-muted sm:text-base">Premium picks with clear pricing — easy to choose, easy to explain.</p>
              <span class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-white/80 bg-white/60 transition group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-copper" aria-hidden="true">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
              </span>
            </a>
            <a href="#categories" class="glass group grid gap-3 rounded-3xl p-5 transition hover:bg-white/75 sm:grid-cols-[0.85fr_1.15fr_auto] sm:items-center sm:gap-8">
              <div>
                <div class="text-[0.65rem] font-bold tracking-[0.14em] text-ink-muted">03</div>
                <h3 class="mt-1 font-display text-xl font-semibold sm:text-2xl">Host</h3>
              </div>
              <p class="text-sm text-ink-muted sm:text-base">Stock the bar by category — gin for cocktails, wine for dinner, beer for the crowd.</p>
              <span class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-white/80 bg-white/60 transition group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-copper" aria-hidden="true">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M4.25 11.75L11.75 4.25"/><path d="M5.5 4.25h6.25v6.25"/></svg>
              </span>
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section id="testimonials" class="py-14 sm:py-16 lg:py-20">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <p class="text-[0.65rem] font-bold uppercase tracking-[0.14em] text-copper">Social proof</p>
        <h2 class="mt-2 max-w-[18ch] font-display text-[clamp(1.85rem,4vw,2.75rem)] font-semibold leading-tight tracking-tight">Collectors keep coming back</h2>
        <p class="mt-3 max-w-xl text-ink-muted">Notes from hosts and buyers — and a few shelf stats.</p>
      </div>
      <div class="lh-marquee-wrap mt-8 overflow-hidden" aria-label="Testimonials">
        <div class="lh-marquee flex w-max gap-4">
          <% String[] chips1 = {
               "q|Found a Chivas 18 for a client dinner in minutes. Price was clear, no noise.|Aarav · Mumbai",
               "s|8 categories|On the shelf",
               "q|House Pour list saved our house party budget without looking cheap.|Neha · Bengaluru",
               "s|100+ bottles|Live catalogue",
               "q|Gifted Patrón Silver — the premium picks feel intentional.|Rohan · Delhi",
               "s|₹650+|Everyday pours"
             };
             for (int pass = 0; pass < 2; pass++) {
               for (String chip : chips1) {
                 String[] parts = chip.split("\\|");
                 boolean isStat = "s".equals(parts[0]);
          %>
          <article class="glass w-[min(22rem,78vw)] shrink-0 rounded-3xl p-5" <%= pass == 1 ? "aria-hidden=\"true\"" : "" %>>
            <% if (isStat) { %>
            <p class="font-display text-2xl font-semibold tracking-tight"><%= parts[1] %></p>
            <% } else { %>
            <p class="text-sm leading-relaxed">“<%= parts[1] %>”</p>
            <% } %>
            <p class="mt-3 text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted"><%= parts[2] %></p>
          </article>
          <%   }
             } %>
        </div>
        <div class="lh-marquee-rev mt-4 flex w-max gap-4">
          <% String[] chips2 = {
               "s|Trusted exchange|Buyer + seller ready",
               "q|Finally a liquor site that tells you the story in the first scroll.|Isha · Pune",
               "s|Gin → Tequila|Full spirit range",
               "q|Search by bottle name actually works. Old Monk in two taps.|Kabir · Hyderabad",
               "s|Clear INR|No guesswork",
               "q|Used categories for a wedding bar list — whisky, wine, beer done.|Meera · Jaipur"
             };
             for (int pass = 0; pass < 2; pass++) {
               for (String chip : chips2) {
                 String[] parts = chip.split("\\|");
                 boolean isStat = "s".equals(parts[0]);
          %>
          <article class="glass w-[min(22rem,78vw)] shrink-0 rounded-3xl p-5" <%= pass == 1 ? "aria-hidden=\"true\"" : "" %>>
            <% if (isStat) { %>
            <p class="font-display text-2xl font-semibold tracking-tight"><%= parts[1] %></p>
            <% } else { %>
            <p class="text-sm leading-relaxed">“<%= parts[1] %>”</p>
            <% } %>
            <p class="mt-3 text-[0.7rem] font-bold uppercase tracking-wider text-ink-muted"><%= parts[2] %></p>
          </article>
          <%   }
             } %>
        </div>
      </div>
    </section>

    <!-- Contact -->
    <section id="contact" class="scroll-mt-28 py-14 sm:py-16 lg:py-20">
      <div class="lh-reveal mx-auto max-w-shell px-4 sm:px-6">
        <div class="grid gap-8 lg:grid-cols-2 lg:items-start">
          <div class="glass rounded-[2rem] p-6 sm:p-8">
            <p class="text-[0.65rem] font-bold uppercase tracking-[0.14em] text-copper">Contact</p>
            <h2 class="mt-2 max-w-[14ch] font-display text-[clamp(1.85rem,4vw,2.75rem)] font-semibold leading-tight tracking-tight">Talk to LiquorHub</h2>
            <p class="mt-4 max-w-md text-ink-muted">Questions on a bottle, a collection, or your collector profile? Send a short note — we read every message.</p>
          </div>
          <form action="<%= ctx %>/contact" method="post" class="glass-strong space-y-4 rounded-[2rem] p-5 sm:p-7">
            <% if (contactOk != null) { %>
            <p class="rounded-2xl border border-green-700/15 bg-green-50/80 px-3 py-2.5 text-sm text-green-800 backdrop-blur"><%= contactOk %></p>
            <% } %>
            <% if (contactErr != null) { %>
            <p class="rounded-2xl border border-red-700/15 bg-red-50/80 px-3 py-2.5 text-sm text-red-800 backdrop-blur"><%= contactErr %></p>
            <% } %>
            <div>
              <label for="c-name" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Name</label>
              <input id="c-name" name="name" type="text" required placeholder="Your name" autocomplete="name"
                class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
            </div>
            <div>
              <label for="c-email" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Email</label>
              <input id="c-email" name="email" type="email" required placeholder="you@email.com" autocomplete="email"
                class="w-full min-h-11 rounded-2xl border border-white/80 bg-white/50 px-3.5 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
            </div>
            <div>
              <label for="c-message" class="mb-1.5 block text-[0.72rem] font-bold uppercase tracking-wider text-ink-muted">Message</label>
              <textarea id="c-message" name="message" rows="4" required placeholder="How can we help?"
                class="w-full rounded-2xl border border-white/80 bg-white/50 px-3.5 py-3 text-sm outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15"></textarea>
            </div>
            <button type="submit" class="inline-flex min-h-11 items-center justify-center rounded-full bg-copper px-6 text-sm font-semibold text-white shadow-md shadow-copper/25 transition hover:bg-copper-strong">Send message</button>
          </form>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
