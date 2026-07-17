<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%
  String ctx = request.getContextPath();
  List<CategoryDTO> navCategories = (List<CategoryDTO>) request.getAttribute("categories");
  CustomerDTO navCustomer = (CustomerDTO) session.getAttribute("Customer");
  String profileHref = navCustomer != null ? ctx + "/dashboard" : ctx + "/login";
  String profileLabel = navCustomer != null ? "Profile" : "Sign in";
%>
<header id="siteHeader" class="fixed inset-x-0 top-0 z-50 px-4 pt-3 sm:px-6">
  <div id="navBar" class="mx-auto flex max-w-6xl items-center gap-3 rounded-full border border-black/[0.08] bg-white px-3 py-2 shadow-[0_10px_40px_rgba(38,34,29,0.06)] sm:px-3.5 sm:py-2.5">
    <a href="<%= ctx %>/home" class="flex min-h-11 shrink-0 items-center gap-2.5 pl-1">
      <img src="<%= ctx %>/assets/logo.jpeg" alt="LiquorHub" width="36" height="36" class="h-9 w-9 rounded-full object-cover">
      <span class="font-display text-[1.05rem] font-normal tracking-[-0.03em] text-ink sm:text-lg">LiquorHub</span>
    </a>

    <nav class="ml-auto hidden items-center gap-0.5 lg:flex" aria-label="Primary">
      <div class="relative">
        <button type="button" id="catToggle" class="group relative inline-flex min-h-10 items-center gap-1.5 rounded-full px-3 py-2 text-[0.8125rem] font-semibold tracking-[-0.02em] text-ink-muted transition-colors hover:text-ink" aria-expanded="false" aria-controls="catMenu">
          Categories
          <svg class="h-3 w-3" viewBox="0 0 12 12" aria-hidden="true"><path d="M2.5 4.5L6 8l3.5-3.5" fill="none" stroke="currentColor" stroke-width="1.5"/></svg>
        </button>
        <div id="catMenu" role="menu" class="absolute left-0 top-full z-[60] mt-2 hidden min-w-[12rem] rounded-2xl border border-black/[0.08] bg-white p-1.5 shadow-[0_16px_48px_rgba(38,34,29,0.1)]">
          <% if (navCategories != null) {
               for (CategoryDTO cat : navCategories) { %>
          <a href="#items" role="menuitem" data-filter-cat="<%= cat.getCategoryId() %>" class="block rounded-xl px-3 py-2.5 text-sm font-medium tracking-[-0.02em] text-ink transition hover:bg-accent-soft hover:text-accent-strong"><%= cat.getCategoryName() %></a>
          <%   }
             } %>
        </div>
      </div>
      <a href="#about" class="inline-flex min-h-10 items-center rounded-full px-3 py-2 text-[0.8125rem] font-semibold tracking-[-0.02em] text-ink-muted transition-colors hover:text-ink">About</a>
      <a href="#learn" class="inline-flex min-h-10 items-center rounded-full px-3 py-2 text-[0.8125rem] font-semibold tracking-[-0.02em] text-ink-muted transition-colors hover:text-ink">Learn</a>
      <a href="#contact" class="inline-flex min-h-10 items-center rounded-full px-3 py-2 text-[0.8125rem] font-semibold tracking-[-0.02em] text-ink-muted transition-colors hover:text-ink">Contact</a>
      <% if (navCustomer != null) { %>
      <a href="<%= ctx %>/cart" class="inline-flex min-h-10 items-center rounded-full px-3 py-2 text-[0.8125rem] font-semibold tracking-[-0.02em] text-ink-muted transition-colors hover:text-ink">Cart</a>
      <% } %>
      <a href="<%= profileHref %>" class="ml-1 inline-flex min-h-10 items-center rounded-full bg-accent px-4 py-2 text-[0.8125rem] font-semibold tracking-[-0.02em] text-white transition hover:bg-accent-strong"><%= profileLabel %></a>
    </nav>

    <div class="hidden max-w-[13rem] flex-1 lg:block">
      <label class="sr-only" for="siteSearch">Search bottles</label>
      <input id="siteSearch" type="search" placeholder="Search bottles..." autocomplete="off"
        class="w-full min-h-10 rounded-full border border-black/[0.08] bg-cream/80 px-4 text-sm tracking-[-0.02em] text-ink placeholder:text-ink-muted outline-none transition focus:border-accent/40 focus:ring-2 focus:ring-accent/15">
    </div>

    <button type="button" id="menuBtn" class="ml-auto inline-flex h-11 w-11 items-center justify-center rounded-full border border-black/[0.08] text-ink lg:hidden" aria-label="Open menu" aria-expanded="false" aria-controls="mobileNav">
      <span class="flex flex-col gap-1.5">
        <span class="block h-0.5 w-4 bg-current"></span>
        <span class="block h-0.5 w-4 bg-current"></span>
        <span class="block h-0.5 w-4 bg-current"></span>
      </span>
    </button>
  </div>

  <div id="mobileNav" class="mx-auto mt-2 hidden max-w-6xl rounded-2xl border border-black/[0.08] bg-white p-3 shadow-[0_16px_48px_rgba(38,34,29,0.1)] lg:hidden" hidden>
    <a href="#about" class="block rounded-xl px-3 py-3 text-base font-semibold tracking-[-0.02em] text-ink hover:bg-cream">About</a>
    <a href="#learn" class="block rounded-xl px-3 py-3 text-base font-semibold tracking-[-0.02em] text-ink hover:bg-cream">Learn</a>
    <a href="#contact" class="block rounded-xl px-3 py-3 text-base font-semibold tracking-[-0.02em] text-ink hover:bg-cream">Contact</a>
    <% if (navCustomer != null) { %>
    <a href="<%= ctx %>/cart" class="block rounded-xl px-3 py-3 text-base font-semibold tracking-[-0.02em] text-ink hover:bg-cream">Cart</a>
    <% } %>
    <a href="<%= profileHref %>" class="block rounded-xl px-3 py-3 text-base font-semibold tracking-[-0.02em] text-ink hover:bg-cream"><%= profileLabel %></a>
    <button type="button" id="mobileCatToggle" class="w-full rounded-xl px-3 py-3 text-left text-base font-semibold tracking-[-0.02em] text-ink hover:bg-cream">Categories</button>
    <div id="mobileCats" class="hidden space-y-0.5 px-2 pb-2" hidden>
      <% if (navCategories != null) {
           for (CategoryDTO cat : navCategories) { %>
      <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" class="block rounded-lg px-3 py-2.5 text-sm font-medium text-ink-muted hover:bg-accent-soft hover:text-ink"><%= cat.getCategoryName() %></a>
      <%   }
         } %>
    </div>
    <input id="siteSearchMobile" type="search" placeholder="Search bottles..." autocomplete="off"
      class="mt-2 w-full min-h-11 rounded-full border border-black/[0.08] bg-cream px-4 text-sm text-ink outline-none focus:border-accent/40">
  </div>
</header>
