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
  <div id="navBar" class="mx-auto flex max-w-6xl items-center gap-3 rounded-full border border-white/70 bg-white/45 px-3 py-2 shadow-[0_8px_32px_rgba(38,34,29,0.08)] backdrop-blur-2xl transition-shadow duration-300 sm:px-4">
    <a href="<%= ctx %>/home" class="flex min-h-11 shrink-0 items-center gap-2.5 pl-1">
      <img src="<%= ctx %>/assets/logo.jpeg" alt="LiquorHub" width="36" height="36" class="h-9 w-9 rounded-full object-cover ring-1 ring-white/80 shadow-sm">
      <span class="font-display text-xl font-semibold tracking-tight text-ink sm:text-2xl">LiquorHub</span>
    </a>

    <nav class="ml-auto hidden items-center gap-1 lg:flex" aria-label="Primary">
      <div class="relative">
        <button type="button" id="catToggle" class="inline-flex min-h-10 items-center gap-1.5 rounded-full px-3 py-2 text-sm font-semibold text-ink-muted transition hover:bg-white/60 hover:text-ink" aria-expanded="false" aria-controls="catMenu">
          Categories
          <svg class="h-3 w-3" viewBox="0 0 12 12" aria-hidden="true"><path d="M2.5 4.5L6 8l3.5-3.5" fill="none" stroke="currentColor" stroke-width="1.5"/></svg>
        </button>
        <div id="catMenu" role="menu" class="absolute left-0 top-full z-[60] mt-2 hidden min-w-[12rem] rounded-2xl border border-white/70 bg-white/70 p-1.5 shadow-[0_16px_48px_rgba(38,34,29,0.12)] backdrop-blur-2xl">
          <% if (navCategories != null) {
               for (CategoryDTO cat : navCategories) { %>
          <a href="#items" role="menuitem" data-filter-cat="<%= cat.getCategoryId() %>" class="block rounded-xl px-3 py-2.5 text-sm font-medium text-ink transition hover:bg-copper-soft/80 hover:text-copper-strong"><%= cat.getCategoryName() %></a>
          <%   }
             } %>
        </div>
      </div>
      <a href="#about" class="inline-flex min-h-10 items-center rounded-full px-3 py-2 text-sm font-semibold text-ink-muted transition hover:bg-white/60 hover:text-ink">About</a>
      <a href="#contact" class="inline-flex min-h-10 items-center rounded-full px-3 py-2 text-sm font-semibold text-ink-muted transition hover:bg-white/60 hover:text-ink">Contact</a>
      <a href="<%= profileHref %>" class="inline-flex min-h-10 items-center rounded-full bg-copper/90 px-4 py-2 text-sm font-semibold text-white shadow-md shadow-copper/20 backdrop-blur transition hover:bg-copper-strong"><%= profileLabel %></a>
    </nav>

    <div class="hidden max-w-[14rem] flex-1 lg:block">
      <label class="sr-only" for="siteSearch">Search bottles</label>
      <input id="siteSearch" type="search" placeholder="Search bottles…" autocomplete="off"
        class="w-full min-h-10 rounded-full border border-white/80 bg-white/50 px-4 text-sm text-ink placeholder:text-ink-muted outline-none backdrop-blur transition focus:border-copper/40 focus:bg-white/80 focus:ring-2 focus:ring-copper/15">
    </div>

    <button type="button" id="menuBtn" class="ml-auto inline-flex h-11 w-11 items-center justify-center rounded-full border border-white/70 bg-white/40 text-ink backdrop-blur lg:hidden" aria-label="Open menu" aria-expanded="false" aria-controls="mobileNav">
      <span class="flex flex-col gap-1.5">
        <span class="block h-0.5 w-4 bg-current"></span>
        <span class="block h-0.5 w-4 bg-current"></span>
        <span class="block h-0.5 w-4 bg-current"></span>
      </span>
    </button>
  </div>

  <div id="mobileNav" class="mx-auto mt-2 hidden max-w-6xl rounded-3xl border border-white/70 bg-white/60 p-3 shadow-[0_16px_48px_rgba(38,34,29,0.1)] backdrop-blur-2xl lg:hidden" hidden>
    <a href="#about" class="block rounded-2xl px-3 py-3 text-base font-semibold text-ink hover:bg-white/70">About</a>
    <a href="#contact" class="block rounded-2xl px-3 py-3 text-base font-semibold text-ink hover:bg-white/70">Contact</a>
    <a href="<%= profileHref %>" class="block rounded-2xl px-3 py-3 text-base font-semibold text-ink hover:bg-white/70"><%= profileLabel %></a>
    <button type="button" id="mobileCatToggle" class="w-full rounded-2xl px-3 py-3 text-left text-base font-semibold text-ink hover:bg-white/70">Categories</button>
    <div id="mobileCats" class="hidden space-y-0.5 px-2 pb-2" hidden>
      <% if (navCategories != null) {
           for (CategoryDTO cat : navCategories) { %>
      <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" class="block rounded-xl px-3 py-2.5 text-sm font-medium text-ink-muted hover:bg-copper-soft/70 hover:text-ink"><%= cat.getCategoryName() %></a>
      <%   }
         } %>
    </div>
    <input id="siteSearchMobile" type="search" placeholder="Search bottles…" autocomplete="off"
      class="mt-2 w-full min-h-11 rounded-full border border-white/80 bg-white/70 px-4 text-sm text-ink outline-none backdrop-blur focus:border-copper/40">
  </div>
</header>
