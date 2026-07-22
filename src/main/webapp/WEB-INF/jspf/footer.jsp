<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%
  String footCtx = request.getContextPath();
  List<CategoryDTO> footCategories = (List<CategoryDTO>) request.getAttribute("categories");
  CustomerDTO footCustomer = (CustomerDTO) session.getAttribute("Customer");
  String footAccountHref = footCustomer != null ? footCtx + "/profile" : footCtx + "/login";
  String footAccountLabel = footCustomer != null ? "Desk" : "Sign in";
%>
<footer style="margin-top:2rem;border-top:1.5px solid var(--carbon,#0a0c10);background:var(--chalk,#eef2f5);padding:2rem 0 1.5rem">
  <div class="lh-shell" style="display:grid;gap:1.5rem">
    <div style="display:flex;flex-wrap:wrap;gap:2rem;justify-content:space-between">
      <div style="max-width:18rem">
        <a href="<%= footCtx %>/home" class="lh-display" style="font-size:1.25rem;text-transform:uppercase">LiquorHub</a>
        <p style="margin:0.65rem 0 0;color:var(--smoke,#3a424c);font-size:0.88rem;line-height:1.45">
          Bottle clearing house. Live lots. Hard INR. Sign in when you trade.
        </p>
      </div>
      <nav aria-label="Footer" style="display:flex;flex-wrap:wrap;gap:2rem">
        <div>
          <p class="lh-sec__kicker" style="margin:0">Floor</p>
          <ul style="list-style:none;margin:0.6rem 0 0;padding:0">
            <li style="margin:0.35rem 0"><a href="#categories" style="font-size:0.88rem;font-weight:600">Dossiers</a></li>
            <li style="margin:0.35rem 0"><a href="#collections" style="font-size:0.88rem;font-weight:600">Quote boards</a></li>
            <li style="margin:0.35rem 0"><a href="#items" style="font-size:0.88rem;font-weight:600">Lots</a></li>
            <li style="margin:0.35rem 0"><a href="#contact" style="font-size:0.88rem;font-weight:600">Wire</a></li>
          </ul>
        </div>
        <div>
          <p class="lh-sec__kicker" style="margin:0">Spirits</p>
          <ul style="list-style:none;margin:0.6rem 0 0;padding:0">
            <% if (footCategories != null) {
                 int n = 0;
                 for (CategoryDTO cat : footCategories) {
                   if (n++ >= 5) break; %>
            <li style="margin:0.35rem 0"><a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" style="font-size:0.88rem;font-weight:600;color:var(--smoke)"><%= cat.getCategoryName() %></a></li>
            <%   }
               } %>
          </ul>
        </div>
        <div>
          <p class="lh-sec__kicker" style="margin:0">Desk</p>
          <ul style="list-style:none;margin:0.6rem 0 0;padding:0">
            <li style="margin:0.35rem 0"><a href="<%= footAccountHref %>" style="font-size:0.88rem;font-weight:600"><%= footAccountLabel %></a></li>
            <li style="margin:0.35rem 0"><a href="<%= footCtx %>/login" style="font-size:0.88rem;font-weight:600">Sign in</a></li>
            <li style="margin:0.35rem 0"><a href="<%= footCtx %>/register" style="font-size:0.88rem;font-weight:600">Join</a></li>
          </ul>
        </div>
      </nav>
    </div>
    <p style="margin:0;padding-top:1rem;border-top:1px dashed var(--line,#ccc);font-size:0.72rem;letter-spacing:0.08em;text-transform:uppercase;color:var(--smoke)">
      LiquorHub clearing desk · drink responsibly
    </p>
  </div>
</footer>
