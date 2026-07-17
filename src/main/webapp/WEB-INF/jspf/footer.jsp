<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.CategoryDTO" %>
<%@ page import="com.LiquorHub.dto.CustomerDTO" %>
<%
  String footCtx = request.getContextPath();
  List<CategoryDTO> footCategories = (List<CategoryDTO>) request.getAttribute("categories");
  CustomerDTO footCustomer = (CustomerDTO) session.getAttribute("Customer");
  String footAccountHref = footCustomer != null ? footCtx + "/dashboard" : footCtx + "/login";
  String footAccountLabel = footCustomer != null ? "Profile" : "Sign in";
%>
<footer class="relative mt-8 border-t border-black/[0.08] bg-white/40 pb-5 pt-8 backdrop-blur-xl sm:mt-10 sm:pb-6 sm:pt-9">
  <div class="mx-auto max-w-6xl px-4 sm:px-6">
    <div class="flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between lg:gap-10">
      <div class="max-w-xs shrink-0 lg:max-w-[16rem]">
        <a href="<%= footCtx %>/home" class="font-display text-base font-normal tracking-[-0.03em] text-ink">LiquorHub</a>
        <p class="mt-2.5 text-sm leading-relaxed text-ink-muted">
          A curated liquor marketplace for collectors and hosts - find the pour, gift the bottle, keep it trusted.
        </p>
      </div>

      <nav aria-label="Footer" class="flex flex-1 flex-col gap-5 sm:flex-row sm:justify-end sm:gap-10 lg:gap-14">
        <div>
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Explore</p>
          <ul class="mt-2.5 space-y-1.5">
            <li><a href="#categories" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Categories</a></li>
            <li><a href="#collections" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Collections</a></li>
            <li><a href="#items" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Bottles</a></li>
            <li><a href="#learn" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Learn</a></li>
            <li><a href="#about" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">About</a></li>
          </ul>
        </div>
        <div>
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Categories</p>
          <ul class="mt-2.5 space-y-1.5">
            <% if (footCategories != null) {
                 int n = 0;
                 for (CategoryDTO cat : footCategories) {
                   if (n++ >= 6) break; %>
            <li><a href="#items" data-filter-cat="<%= cat.getCategoryId() %>" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink"><%= cat.getCategoryName() %></a></li>
            <%   }
               } %>
          </ul>
        </div>
        <div>
          <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Account</p>
          <ul class="mt-2.5 space-y-1.5">
            <li><a href="<%= footAccountHref %>" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink"><%= footAccountLabel %></a></li>
            <% if (footCustomer == null) { %>
            <li><a href="<%= footCtx %>/register.jsp" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Register</a></li>
            <% } else { %>
            <li><a href="<%= footCtx %>/cart" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Cart</a></li>
            <% } %>
            <li><a href="#contact" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">Contact</a></li>
            <li><a href="mailto:liquourhub@gmail.com" class="text-sm font-medium tracking-[-0.02em] text-ink-muted transition hover:text-ink">liquourhub@gmail.com</a></li>
          </ul>
        </div>
      </nav>
    </div>

    <div class="mt-6 flex flex-col gap-2 border-t border-black/[0.08] pt-4 text-xs text-ink-muted sm:flex-row sm:items-center sm:justify-between sm:text-sm">
      <span>Please drink responsibly.</span>
      <span>&copy; <%= java.time.Year.now().getValue() %> LiquorHub</span>
    </div>
  </div>
</footer>
