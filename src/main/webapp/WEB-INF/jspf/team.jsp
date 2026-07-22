<%--
  LiquorHub team — fill real details below.
  Fields per row: name, email, role, linkedin, github, portfolio
  Leave a URL blank ("") to hide that link.
--%>
<%
  String[][] lhTeam = {
    {
      "Ganesh Kantle",
      "ganeshkantle@gmail.com",
      "AI Web Developer",
      "https://www.linkedin.com/in/ganeshkantle",
      "https://www.github.com/ganeshkantle",
      "https://ganesh-kantle.vercel.app/"
    },
    {
      "Suraj S Atresh",
      "surajatresh30@gmail.com",
      "Database Administrator",
      "https://www.linkedin.com/in/surajatresh300/",
      "https://github.com/SurajAtresh",
      ""
    },
    {
      "Manu Adiga",
      "adigamanu4002@gmail.com",
      "Backend developer",
      "https://www.linkedin.com/in/manu-adiga/",
      "https://github.com/M69u",
      ""
    },
    {
      "Vishwas M R",
      "mrvishwas285@gmail.com",
      "Backend developer",
      "https://www.linkedin.com/in/mr-vishwas/",
      "https://github.com/Mrvishwass",
      ""
    }
  };
%>
<div class="lh-team" id="team">
  <p class="lh-sec__kicker">Creators</p>
  <h2 class="lh-sec__title" style="font-size:clamp(1.35rem,3vw,1.85rem)">The team behind LiquorHub</h2>
  <p class="lh-sec__lede">Developers, designers, and builders who shipped this clearing house.</p>
  <div class="lh-team__grid">
    <% for (int ti = 0; ti < lhTeam.length; ti++) {
         String tName = lhTeam[ti][0];
         String tEmail = lhTeam[ti][1];
         String tRole = lhTeam[ti][2];
         String tLi = lhTeam[ti][3];
         String tGh = lhTeam[ti][4];
         String tPf = lhTeam[ti][5];
         String initial = (tName != null && !tName.isBlank()) ? tName.substring(0, 1).toUpperCase() : "?";
         boolean hasLinks = (tLi != null && !tLi.isBlank()) || (tGh != null && !tGh.isBlank()) || (tPf != null && !tPf.isBlank());
    %>
    <article class="lh-mate">
      <div class="lh-mate__mark" aria-hidden="true"><%= initial %></div>
      <div>
        <p class="lh-mate__role"><%= tRole %></p>
        <h3><%= tName %></h3>
      </div>
      <% if (tEmail != null && !tEmail.isBlank()) { %>
      <p class="lh-mate__email"><a href="mailto:<%= tEmail %>"><%= tEmail %></a></p>
      <% } else { %>
      <p class="lh-mate__pending">Email coming soon</p>
      <% } %>
      <div class="lh-mate__links">
        <% if (tLi != null && !tLi.isBlank()) { %><a href="<%= tLi %>" target="_blank" rel="noopener noreferrer">LinkedIn</a><% } %>
        <% if (tGh != null && !tGh.isBlank()) { %><a href="<%= tGh %>" target="_blank" rel="noopener noreferrer">GitHub</a><% } %>
        <% if (tPf != null && !tPf.isBlank()) { %><a href="<%= tPf %>" target="_blank" rel="noopener noreferrer">Portfolio</a><% } %>
        <% if (!hasLinks) { %><span class="lh-mate__pending">Links coming soon</span><% } %>
      </div>
    </article>
    <% } %>
  </div>
</div>
