<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%
  String footCtx = request.getContextPath();
  List<CategoryDTO> footCategories = (List<CategoryDTO>) request.getAttribute("categories");
%>
<footer class="relative mt-10 overflow-hidden border-t border-white/60 pb-8 pt-14 sm:pt-16">
  <div class="pointer-events-none absolute inset-0 bg-gradient-to-b from-white/30 to-copper-soft/20"></div>
  <div class="pointer-events-none absolute -left-24 top-0 h-72 w-72 rounded-full bg-copper/15 blur-3xl"></div>
  <div class="pointer-events-none absolute -right-16 bottom-0 h-56 w-56 rounded-full bg-white/80 blur-3xl"></div>

  <div class="relative mx-auto max-w-6xl px-4 sm:px-6">
    <div class="rounded-[2rem] border border-white/70 bg-white/40 p-6 shadow-[0_8px_40px_rgba(38,34,29,0.06)] backdrop-blur-2xl sm:p-10">
      <p class="font-display text-[clamp(2.75rem,11vw,6.5rem)] font-semibold leading-[0.9] tracking-tight text-ink">LiquorHub</p>

      <div class="mt-8 grid gap-8 border-b border-black/5 pb-10 sm:grid-cols-2 lg:grid-cols-4">
        <div>
          <p class="max-w-xs text-sm leading-relaxed text-ink-muted sm:text-base">
            A curated liquor marketplace for collectors and hosts — find the pour, gift the bottle, keep it trusted.
          </p>
        </div>
        <div>
          <h4 class="mb-3 text-[0.68rem] font-bold uppercase tracking-[0.14em] text-ink-muted">Explore</h4>
          <ul class="space-y-2">
            <li><a href="#categories" class="text-sm font-medium text-ink transition hover:text-copper-strong">Categories</a></li>
            <li><a href="#collections" class="text-sm font-medium text-ink transition hover:text-copper-strong">Collections</a></li>
            <li><a href="#items" class="text-sm font-medium text-ink transition hover:text-copper-strong">Bottles</a></li>
            <li><a href="#about" class="text-sm font-medium text-ink transition hover:text-copper-strong">About</a></li>
          </ul>
        </div>
        <div>
          <h4 class="mb-3 text-[0.68rem] font-bold uppercase tracking-[0.14em] text-ink-muted">Categories</h4>
          <ul class="space-y-2">
            <% if (footCategories != null) {
                 int n = 0;
                 for (CategoryDTO cat : footCategories) {
                   if (n++ >= 6) break; %>
            <li><a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" class="text-sm font-medium text-ink transition hover:text-copper-strong"><%= cat.getCategoryName() %></a></li>
            <%   }
               } %>
          </ul>
        </div>
        <div>
          <h4 class="mb-3 text-[0.68rem] font-bold uppercase tracking-[0.14em] text-ink-muted">Account</h4>
          <ul class="space-y-2">
            <li><a href="<%= footCtx %>/login" class="text-sm font-medium text-ink transition hover:text-copper-strong">Sign in</a></li>
            <li><a href="<%= footCtx %>/register.jsp" class="text-sm font-medium text-ink transition hover:text-copper-strong">Register</a></li>
            <li><a href="#contact" class="text-sm font-medium text-ink transition hover:text-copper-strong">Contact</a></li>
          </ul>
        </div>
      </div>

      <div class="flex flex-wrap items-center justify-between gap-3 pt-5 text-xs text-ink-muted">
        <span>Please drink responsibly. 21+ only.</span>
        <span>&copy; <%= java.time.Year.now().getValue() %> LiquorHub</span>
      </div>
    </div>
  </div>
</footer>
