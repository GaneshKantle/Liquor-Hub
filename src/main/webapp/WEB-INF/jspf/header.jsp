<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%@ page import="com.LiquorHub.daoImpl.CategoryDAOImpl" %>
<%
  String ctx = request.getContextPath();
  List<CategoryDTO> navCategories = (List<CategoryDTO>) request.getAttribute("categories");
  if (navCategories == null) {
    try {
      navCategories = new CategoryDAOImpl().getAllCategories();
      request.setAttribute("categories", navCategories);
    } catch (Exception ignored) {
      navCategories = null;
    }
  }
  CustomerDTO navCustomer = (CustomerDTO) session.getAttribute("Customer");
  boolean navLoggedIn = navCustomer != null;
  String profileHref = navLoggedIn ? ctx + "/profile" : ctx + "/login";
  String profileLabel = navLoggedIn ? "Desk" : "Sign in";
  String home = ctx + "/home";
%>
<header id="siteHeader" class="lh-desk">
  <div id="navBar" class="lh-desk__bar">
    <a href="<%= home %>" class="lh-desk__brand" aria-label="LiquorHub home">
      <img src="<%= ctx %>/assets/logo.png" alt="LiquorHub" width="152" height="52" decoding="async">
    </a>
    <span class="lh-desk__live" aria-hidden="true">Live desk</span>

    <div class="lh-desk__search">
      <form id="siteSearchForm" role="search" action="<%= ctx %>/catalog" method="get">
        <label class="sr-only" for="siteSearch">Search bottles</label>
        <input id="siteSearch" type="search" name="q" placeholder="Scan lot..." autocomplete="off">
        <button type="submit" id="siteSearchBtn">Scan</button>
      </form>
    </div>

    <nav class="lh-desk__nav" aria-label="Primary">
      <div class="lh-desk__dropdown">
        <button type="button" id="catToggle" aria-expanded="false" aria-controls="catMenu">Spirits</button>
        <div id="catMenu" role="menu" class="lh-desk__menu-panel hidden">
          <% if (navCategories != null) {
               for (CategoryDTO cat : navCategories) { %>
          <a href="<%= ctx %>/catalog?cat=<%= cat.getCategoryId() %>" role="menuitem"><%= cat.getCategoryName() %></a>
          <%   }
             } %>
        </div>
      </div>
      <a href="<%= ctx %>/catalog">Catalogue</a>
      <a href="<%= home %>#about">Manifest</a>
      <a href="<%= home %>#learn">Notes</a>
      <% if (navLoggedIn) { %>
      <a href="<%= ctx %>/profile">Desk</a>
      <a href="<%= ctx %>/cart">Bag</a>
      <% } %>
      <a href="<%= home %>#contact">Wire</a>
      <a href="<%= profileHref %>" class="lh-desk__cta"><%= profileLabel %></a>
    </nav>

    <button type="button" id="menuBtn" class="lh-desk__burger" aria-label="Open menu" aria-expanded="false" aria-controls="mobileNav">
      <span aria-hidden="true"></span>
    </button>
  </div>

  <div id="mobileNav" class="lh-desk__mobile hidden" hidden>
    <form id="siteSearchFormMobile" role="search" action="<%= ctx %>/catalog" method="get">
      <label class="sr-only" for="siteSearchMobile">Search bottles</label>
      <input id="siteSearchMobile" type="search" name="q" placeholder="Scan lot..." autocomplete="off">
      <button type="submit">Scan</button>
    </form>
    <a href="<%= ctx %>/catalog">Catalogue</a>
    <a href="<%= home %>#about">Manifest</a>
    <a href="<%= home %>#learn">Notes</a>
    <% if (navLoggedIn) { %>
    <a href="<%= ctx %>/profile">Desk</a>
    <a href="<%= ctx %>/cart">Bag</a>
    <% } %>
    <a href="<%= home %>#contact">Wire</a>
    <a href="<%= profileHref %>"><%= profileLabel %></a>
    <button type="button" id="mobileCatToggle">Spirits</button>
    <div id="mobileCats" class="hidden" hidden>
      <% if (navCategories != null) {
           for (CategoryDTO cat : navCategories) { %>
      <a href="<%= ctx %>/catalog?cat=<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a>
      <%   }
         } %>
    </div>
  </div>
</header>
