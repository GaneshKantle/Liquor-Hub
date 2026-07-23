<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%@ page import="com.LiquorHub.daoImpl.CategoryDAOImpl" %>
<%
  String footCtx = request.getContextPath();
  List<CategoryDTO> footCategories = (List<CategoryDTO>) request.getAttribute("categories");
  if (footCategories == null) {
    try {
      footCategories = new CategoryDAOImpl().getAllCategories();
      request.setAttribute("categories", footCategories);
    } catch (Exception ignored) {
      footCategories = null;
    }
  }
  CustomerDTO footCustomer = (CustomerDTO) session.getAttribute("Customer");
  String footAccountHref = footCustomer != null ? footCtx + "/profile" : footCtx + "/login";
  String footAccountLabel = footCustomer != null ? "Profile" : "Sign in";
  String footHome = footCtx + "/home";
%>
<link rel="stylesheet" href="<%= footCtx %>/css/footer.css">
<footer class="lh-site-footer">
  <div class="lh-site-footer__inner">
    <div class="lh-site-footer__top">
      <div class="lh-site-footer__brand">
        <a href="<%= footHome %>" class="lh-display">LiquorHub</a>
        <p>Bottle clearing house. Live lots. Hard INR. Sign in when you trade.</p>
      </div>
      <nav aria-label="Footer" class="lh-site-footer__nav">
        <div>
          <p class="lh-sec__kicker">Floor</p>
          <ul>
            <li><a href="<%= footCtx %>/catalog">All products</a></li>
            <li><a href="<%= footCtx %>/rare">Rare collection</a></li>
            <li><a href="<%= footHome %>#categories">Dossiers</a></li>
            <li><a href="<%= footHome %>#collections">Quote boards</a></li>
            <li><a href="<%= footHome %>#items">Featured</a></li>
            <li><a href="<%= footCtx %>/about">About &amp; team</a></li>
            <li><a href="<%= footHome %>#contact">Contact</a></li>
          </ul>
        </div>
        <div>
          <p class="lh-sec__kicker">Spirits</p>
          <ul>
            <% if (footCategories != null) {
                 int n = 0;
                 for (CategoryDTO cat : footCategories) {
                   if (n++ >= 5) break; %>
            <li><a href="<%= footCtx %>/catalog?cat=<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a></li>
            <%   }
               } %>
          </ul>
        </div>
        <div>
          <p class="lh-sec__kicker">Account</p>
          <ul>
            <li><a href="<%= footAccountHref %>"><%= footAccountLabel %></a></li>
            <% if (footCustomer == null) { %>
            <li><a href="<%= footCtx %>/register">Join</a></li>
            <% } else { %>
            <li><a href="<%= footCtx %>/logout">Logout</a></li>
            <% } %>
            <li><a href="mailto:contact.liqourhub@gmail.com">contact.liqourhub@gmail.com</a></li>
          </ul>
        </div>
      </nav>
    </div>
    <p class="lh-site-footer__copy">LiquorHub - Drink Responsibly.</p>
  </div>
</footer>
