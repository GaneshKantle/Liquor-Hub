<%--
  LiquorHub team
  Fields: name, email, role, linkedin, github, portfolio, avatarUrl
  Avatars: modern young cartoon faces via jsDelivr (alohe/avatars toon set)
--%>
<%
  String mentorName = "Punith B";
  String mentorEmail = "punithbasavaraj16@gmail.com";
  String mentorRole = "Spring Boot Trainer (All-Rounder)";
  String mentorLi = "https://www.linkedin.com/in/punith-b-644579218/";
  String mentorGh = "https://github.com/PunithB1601/";
  String mentorAvatar = "https://cdn.jsdelivr.net/gh/alohe/avatars/png/toon_2.png";

  /* name, email, role, linkedin, github, portfolio, cartoon CDN — male young toons only */
  String[][] lhTeam = {
    {
      "Ganesh Kantle",
      "ganeshkantle@gmail.com",
      "AI Web Developer",
      "https://www.linkedin.com/in/ganeshkantle",
      "https://www.github.com/ganeshkantle",
      "https://ganesh-kantle.vercel.app/",
      "https://cdn.jsdelivr.net/gh/alohe/avatars/png/toon_9.png"
    },
    {
      "Suraj S Atresh",
      "surajatresh30@gmail.com",
      "Database Administrator",
      "https://www.linkedin.com/in/surajatresh300/",
      "https://github.com/SurajAtresh",
      "",
      "https://cdn.jsdelivr.net/gh/alohe/avatars/png/toon_4.png"
    },
    {
      "Manu Adiga",
      "adigamanu4002@gmail.com",
      "Backend developer",
      "https://www.linkedin.com/in/manu-adiga/",
      "https://github.com/M69u",
      "",
      "https://cdn.jsdelivr.net/gh/alohe/avatars/png/toon_5.png"
    },
    {
      "Vishwas M R",
      "mrvishwas285@gmail.com",
      "Backend developer",
      "https://www.linkedin.com/in/mr-vishwas/",
      "https://github.com/Mrvishwass",
      "",
      "https://cdn.jsdelivr.net/gh/alohe/avatars/png/toon_1.png"
    }
  };
%>
<div class="lh-team" id="team">
  <p class="lh-sec__kicker">Creators</p>
  <h2 class="lh-sec__title" style="font-size:clamp(1.35rem,3vw,1.85rem)">The team behind LiquorHub</h2>
  <p class="lh-sec__lede">Guided by our mentor, built by four teammates.</p>

  <article class="lh-mate lh-mate--mentor">
    <img class="lh-mate__face" src="<%= mentorAvatar %>" alt="<%= mentorName %>" width="128" height="128" loading="lazy" decoding="async" referrerpolicy="no-referrer">
    <div class="lh-mate__mentor-body">
      <p class="lh-mate__badge">Mentor</p>
      <p class="lh-mate__role"><%= mentorRole %></p>
      <h3><%= mentorName %></h3>
      <p class="lh-mate__email"><a href="mailto:<%= mentorEmail %>"><%= mentorEmail %></a></p>
      <div class="lh-mate__links">
        <a href="<%= mentorLi %>" target="_blank" rel="noopener noreferrer">LinkedIn</a>
        <a href="<%= mentorGh %>" target="_blank" rel="noopener noreferrer">GitHub</a>
      </div>
    </div>
  </article>

  <div class="lh-team__grid">
    <% for (int ti = 0; ti < lhTeam.length; ti++) {
         String tName = lhTeam[ti][0];
         String tEmail = lhTeam[ti][1];
         String tRole = lhTeam[ti][2];
         String tLi = lhTeam[ti][3];
         String tGh = lhTeam[ti][4];
         String tPf = lhTeam[ti][5];
         String avatar = lhTeam[ti][6];
         boolean hasLinks = (tLi != null && !tLi.isBlank()) || (tGh != null && !tGh.isBlank()) || (tPf != null && !tPf.isBlank());
    %>
    <article class="lh-mate">
      <img class="lh-mate__face" src="<%= avatar %>" alt="<%= tName %>" width="128" height="128" loading="lazy" decoding="async" referrerpolicy="no-referrer">
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
