<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%
  String ctx = request.getContextPath();
  List<CategoryDTO> navCategories = (List<CategoryDTO>) request.getAttribute("categories");
  CustomerDTO navCustomer = (CustomerDTO) session.getAttribute("Customer");
  boolean navLoggedIn = navCustomer != null;
  String profileHref = navLoggedIn ? ctx + "/profile" : ctx + "/login";
  String profileLabel = navLoggedIn ? "Desk" : "Sign in";
  String midProfileHref = navLoggedIn ? ctx + "/profile" : "#profile";
%>
<header id="siteHeader" class="lh-desk">
  <div id="navBar" class="lh-desk__bar">
    <a href="<%= ctx %>/home" class="lh-desk__brand">
      <img src="<%= ctx %>/assets/logo.jpeg" alt="" width="32" height="32">
      <span>LiquorHub</span>
    </a>
    <span class="lh-desk__live" aria-hidden="true">Live desk</span>

    <div class="lh-desk__search">
      <form id="siteSearchForm" role="search">
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
          <a href="#items" role="menuitem" data-filter-cat="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a>
          <%   }
             } %>
        </div>
      </div>
      <a href="#about">Manifest</a>
      <a href="#learn">Notes</a>
      <a href="<%= midProfileHref %>"><%= navLoggedIn ? "Desk" : "Profile" %></a>
      <a href="#contact">Wire</a>
      <% if (navLoggedIn) { %>
      <a href="<%= ctx %>/cart">Bag</a>
      <% } %>
      <a href="<%= profileHref %>" class="lh-desk__cta"><%= profileLabel %></a>
    </nav>

    <button type="button" id="menuBtn" class="lh-desk__burger" aria-label="Open menu" aria-expanded="false" aria-controls="mobileNav">
      <span aria-hidden="true"></span>
    </button>
  </div>

  <div id="mobileNav" class="lh-desk__mobile hidden" hidden>
    <form id="siteSearchFormMobile" role="search">
      <label class="sr-only" for="siteSearchMobile">Search bottles</label>
      <input id="siteSearchMobile" type="search" name="q" placeholder="Scan lot..." autocomplete="off">
      <button type="submit">Scan</button>
    </form>
    <a href="#about">Manifest</a>
    <a href="#learn">Notes</a>
    <a href="<%= midProfileHref %>"><%= navLoggedIn ? "Desk" : "Profile" %></a>
    <a href="#contact">Wire</a>
    <% if (navLoggedIn) { %>
    <a href="<%= ctx %>/cart">Bag</a>
    <% } %>
    <a href="<%= profileHref %>"><%= profileLabel %></a>
    <button type="button" id="mobileCatToggle">Spirits</button>
    <div id="mobileCats" class="hidden" hidden>
      <% if (navCategories != null) {
           for (CategoryDTO cat : navCategories) { %>
      <a href="#items" data-filter-cat="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a>
      <%   }
         } %>
    </div>
  </div>
</header>
