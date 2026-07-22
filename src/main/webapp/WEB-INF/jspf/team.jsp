<%--
  LiquorHub team
  Fields: name, email, role, linkedin, github, portfolio, avatarSeed
  Avatar CDN: DiceBear Avataaars (male cartoon)
--%>
<%
  String[][] lhTeam = {
    {
      "Ganesh Kantle",
      "ganeshkantle@gmail.com",
      "AI Web Developer",
      "https://www.linkedin.com/in/ganeshkantle",
      "https://www.github.com/ganeshkantle",
      "https://ganesh-kantle.vercel.app/",
      "GaneshKantle"
    },
    {
      "Suraj S Atresh",
      "surajatresh30@gmail.com",
      "Database Administrator",
      "https://www.linkedin.com/in/surajatresh300/",
      "https://github.com/SurajAtresh",
      "",
      "SurajAtresh"
    },
    {
      "Manu Adiga",
      "adigamanu4002@gmail.com",
      "Backend developer",
      "https://www.linkedin.com/in/manu-adiga/",
      "https://github.com/M69u",
      "",
      "ManuAdiga"
    },
    {
      "Vishwas M R",
      "mrvishwas285@gmail.com",
      "Backend developer",
      "https://www.linkedin.com/in/mr-vishwas/",
      "https://github.com/Mrvishwass",
      "",
      "VishwasMR"
    }
  };
%>
<div class="lh-team" id="team">
  <p class="lh-sec__kicker">Creators</p>
  <h2 class="lh-sec__title" style="font-size:clamp(1.35rem,3vw,1.85rem)">The team behind LiquorHub</h2>
  <p class="lh-sec__lede">Four builders who shipped this clearing house — listed below.</p>
  <div class="lh-team__grid">
    <% for (int ti = 0; ti < lhTeam.length; ti++) {
         String tName = lhTeam[ti][0];
         String tEmail = lhTeam[ti][1];
         String tRole = lhTeam[ti][2];
         String tLi = lhTeam[ti][3];
         String tGh = lhTeam[ti][4];
         String tPf = lhTeam[ti][5];
         String seed = lhTeam[ti][6];
         String avatar = "https://api.dicebear.com/9.x/avataaars/png?seed="
             + java.net.URLEncoder.encode(seed, "UTF-8")
             + "&gender=male&size=256&backgroundColor=eef2f5";
         boolean hasLinks = (tLi != null && !tLi.isBlank()) || (tGh != null && !tGh.isBlank()) || (tPf != null && !tPf.isBlank());
    %>
    <article class="lh-mate">
      <img class="lh-mate__face" src="<%= avatar %>" alt="<%= tName %>" width="112" height="112" loading="lazy" decoding="async">
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
