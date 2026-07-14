<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%
  String footCtx = request.getContextPath();
  List<CategoryDTO> footCategories = (List<CategoryDTO>) request.getAttribute("categories");
%>
<footer class="lh-site-foot">
  <div class="lh-shell-width">
    <p class="lh-site-foot__brand">LiquorHub</p>

    <div class="lh-site-foot__grid">
      <div>
        <p class="lh-site-foot__blurb">
          A curated liquor marketplace for collectors and hosts — find the pour, gift the bottle, keep it trusted.
        </p>
      </div>
      <div>
        <h4>Explore</h4>
        <ul>
          <li><a href="#categories">Categories</a></li>
          <li><a href="#collections">Collections</a></li>
          <li><a href="#items">Bottles</a></li>
          <li><a href="#about">About</a></li>
        </ul>
      </div>
      <div>
        <h4>Categories</h4>
        <ul>
          <% if (footCategories != null) {
               int n = 0;
               for (CategoryDTO cat : footCategories) {
                 if (n++ >= 6) break; %>
          <li><a href="#items" data-filter-cat="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></a></li>
          <%   }
             } %>
        </ul>
      </div>
      <div>
        <h4>Account</h4>
        <ul>
          <li><a href="<%= footCtx %>/login">Sign in</a></li>
          <li><a href="<%= footCtx %>/register.jsp">Register</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
      </div>
    </div>

    <div class="lh-site-foot__meta">
      <span>Please drink responsibly. 21+ only.</span>
      <span>&copy; <%= java.time.Year.now().getValue() %> LiquorHub</span>
    </div>
  </div>
</footer>
