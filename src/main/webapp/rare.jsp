<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.LiquorHub.dto.RareBottle" %>
<%
  String ctx = request.getContextPath();
  List<RareBottle> rareLots = (List<RareBottle>) request.getAttribute("rareLots");
  if (rareLots == null) {
    request.getRequestDispatcher("/rare").forward(request, response);
    return;
  }
  java.text.NumberFormat inr = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
  inr.setMaximumFractionDigits(0);
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>Rare Collection | LiquorHub</title>
  <meta name="description" content="LiquorHub Rare Collection — ultra-rare bottles with origin, taste, age, and desk rates.">
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <link rel="stylesheet" href="<%= ctx %>/css/rare.css">
  <link rel="stylesheet" href="<%= ctx %>/css/footer.css">
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-rare">
    <div class="lh-shell">
      <section class="lh-rare__hero" aria-labelledby="rareTitle">
        <p class="lh-sec__kicker">Vault floor</p>
        <h1 id="rareTitle" class="lh-sec__title">Rare Collection</h1>
        <p class="lh-sec__lede">
          Not house pour. Allocation whiskies, prestige Champagne, and cellar cognacs —
          with origin, age, taste, and clear INR rates on the board.
        </p>
        <a href="#lots" class="lh-btn lh-btn--signal">Scan rare lots</a>
      </section>

      <section id="lots" class="scroll-mt-28" aria-label="Rare lots">
        <p class="lh-sec__kicker">Dossiers</p>
        <h2 class="lh-sec__title" style="font-size:clamp(1.3rem,2.8vw,1.75rem)"><%= rareLots.size() %> lots on the rare board</h2>
        <p class="lh-sec__lede">Open a dossier for tasting notes, years, ABV, and why it is scarce.</p>

        <div class="lh-rare__grid" style="margin-top:1.25rem">
          <% for (RareBottle lot : rareLots) {
               String panelId = "rare-detail-" + lot.getId();
          %>
          <article class="lh-rare-lot" id="<%= lot.getId() %>">
            <div class="lh-rare-lot__media">
              <img src="<%= lot.getImageUrl() %>" alt="" width="900" height="675" loading="lazy" decoding="async">
              <span class="lh-rare-lot__stamp"><%= lot.getSpiritType() %></span>
            </div>
            <div class="lh-rare-lot__body">
              <p class="lh-rare-lot__brand"><%= lot.getBrand() %></p>
              <h3><%= lot.getName() %></h3>
              <p class="lh-rare-lot__meta"><%= lot.getOrigin() %> · <%= lot.getAge() %></p>
              <p class="lh-rare-lot__price"><%= inr.format(lot.getPriceInr()) %></p>
              <p class="lh-rare-lot__limited"><%= lot.getLimited() %></p>
              <button type="button" class="lh-rare-lot__toggle" aria-expanded="false" aria-controls="<%= panelId %>" data-rare-toggle>
                View dossier
              </button>
            </div>
            <div id="<%= panelId %>" class="lh-rare-lot__detail" hidden>
              <dl>
                <div>
                  <dt>Origin</dt>
                  <dd><%= lot.getOrigin() %></dd>
                </div>
                <div>
                  <dt>Age / years</dt>
                  <dd><%= lot.getAge() %></dd>
                </div>
                <div>
                  <dt>Vintage / cask note</dt>
                  <dd><%= lot.getVintage() %></dd>
                </div>
                <div>
                  <dt>ABV</dt>
                  <dd><%= lot.getAbv() %></dd>
                </div>
                <div>
                  <dt>Taste</dt>
                  <dd><%= lot.getTastingNotes() %></dd>
                </div>
                <div>
                  <dt>Why it’s rare</dt>
                  <dd><%= lot.getStory() %></dd>
                </div>
                <div>
                  <dt>Desk rate</dt>
                  <dd><%= inr.format(lot.getPriceInr()) %> INR</dd>
                </div>
              </dl>
              <p style="margin:0.85rem 0 0">
                <a href="<%= ctx %>/home#contact" class="lh-btn lh-btn--chalk" style="min-height:2.2rem;padding:0.4rem 0.85rem;font-size:0.72rem">Enquire to acquire</a>
                <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--ghost" style="min-height:2.2rem;padding:0.4rem 0.85rem;font-size:0.72rem;margin-left:0.35rem">Everyday catalogue</a>
              </p>
            </div>
          </article>
          <% } %>
        </div>
      </section>

      <p class="lh-rare__foot">
        <a href="<%= ctx %>/home" class="lh-btn lh-btn--chalk">Back to home</a>
        <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--signal">Browse everyday lots</a>
      </p>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
  <script>
    document.querySelectorAll("[data-rare-toggle]").forEach(function (btn) {
      btn.addEventListener("click", function () {
        var id = btn.getAttribute("aria-controls");
        var panel = id ? document.getElementById(id) : null;
        if (!panel) return;
        var open = panel.hidden;
        panel.hidden = !open;
        btn.setAttribute("aria-expanded", open ? "true" : "false");
        btn.textContent = open ? "Hide dossier" : "View dossier";
      });
    });
  </script>
</body>
</html>
