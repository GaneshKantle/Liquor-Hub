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
<header class="lh-header lh-header--hero" id="siteHeader">
  <div class="lh-header__bar">
    <a class="lh-logo" href="<%= ctx %>/home">
      <img src="<%= ctx %>/assets/logo.jpeg" alt="LiquorHub logo" width="36" height="36">
      <span class="lh-logo__text">LiquorHub</span>
    </a>

    <nav class="lh-nav" aria-label="Primary">
      <div class="lh-nav__item">
        <button type="button" class="lh-nav__link" id="catToggle" aria-expanded="false" aria-controls="catMenu">
          Categories
          <svg width="12" height="12" viewBox="0 0 12 12" aria-hidden="true"><path d="M2.5 4.5L6 8l3.5-3.5" fill="none" stroke="currentColor" stroke-width="1.5"/></svg>
        </button>
        <div class="lh-dropdown" id="catMenu" role="menu">
          <% if (navCategories != null) {
               for (CategoryDTO cat : navCategories) { %>
          <a href="#items" role="menuitem" data-filter-cat="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a>
          <%   }
             } %>
        </div>
      </div>
      <a class="lh-nav__link" href="#about">About</a>
      <a class="lh-nav__link" href="#contact">Contact</a>
      <a class="lh-nav__link" href="<%= profileHref %>"><%= profileLabel %></a>
    </nav>

    <div class="lh-search">
      <label class="visually-hidden" for="siteSearch">Search bottles</label>
      <input id="siteSearch" type="search" placeholder="Search bottles…" autocomplete="off">
    </div>

    <button type="button" class="lh-menu-btn" id="menuBtn" aria-label="Open menu" aria-expanded="false" aria-controls="mobileNav">
      <span></span>
    </button>
  </div>

  <div class="lh-mobile" id="mobileNav" hidden>
    <a href="#about">About</a>
    <a href="#contact">Contact</a>
    <a href="<%= profileHref %>"><%= profileLabel %></a>
    <button type="button" id="mobileCatToggle">Categories</button>
    <div class="lh-mobile__cats" id="mobileCats" hidden>
      <% if (navCategories != null) {
           for (CategoryDTO cat : navCategories) { %>
      <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a>
      <%   }
         } %>
    </div>
    <div class="lh-search">
      <input id="siteSearchMobile" type="search" placeholder="Search bottles…" autocomplete="off">
    </div>
  </div>
</header>
