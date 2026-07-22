<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en" style="color-scheme: light;">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="color-scheme" content="light only">
  <title>404 · Lot not found | LiquorHub</title>
  <link rel="icon" href="<%= ctx %>/assets/favicon.png" type="image/png">
  <link rel="stylesheet" href="<%= ctx %>/css/beer-loader.css">
  <link rel="stylesheet" href="<%= ctx %>/css/exchange.css">
  <style>
    .lh-404 {
      min-height: calc(100svh - 14rem);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 6.5rem 1.25rem 3rem;
    }
    .lh-404__card {
      width: min(100%, 28rem);
      text-align: center;
      border: 1.5px solid var(--carbon, #0a0c10);
      background: var(--chalk, #eef2f5);
      padding: 2rem 1.5rem 1.75rem;
      box-shadow: 6px 6px 0 var(--signal, #ff2d1a);
    }
    .lh-404__anim {
      display: flex;
      justify-content: center;
      margin: 0 auto 0.5rem;
    }
    .lh-404__code {
      margin: 0.25rem 0 0;
      font-size: 0.62rem;
      font-weight: 700;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--signal-ink, #b0180c);
    }
    .lh-404__title {
      margin: 0.55rem 0 0;
      font-family: var(--font-display, system-ui);
      font-weight: 800;
      font-size: clamp(1.75rem, 5vw, 2.35rem);
      letter-spacing: -0.045em;
      line-height: 0.95;
      text-transform: uppercase;
    }
    .lh-404__copy {
      margin: 0.75rem auto 0;
      max-width: 28ch;
      color: var(--smoke, #3a424c);
      font-size: 0.95rem;
      line-height: 1.45;
    }
    .lh-404__actions {
      display: flex;
      flex-wrap: wrap;
      gap: 0.65rem;
      justify-content: center;
      margin-top: 1.5rem;
    }
  </style>
  <script src="https://unpkg.com/@lottiefiles/dotlottie-wc@0.9.14/dist/dotlottie-wc.js" type="module"></script>
  <script>document.documentElement.classList.add("lh-loading");</script>
</head>
<body class="lh-body overflow-x-clip antialiased" data-ctx="<%= ctx %>">
  <jsp:include page="/WEB-INF/jspf/loader.jsp" />
  <jsp:include page="/WEB-INF/jspf/header.jsp" />

  <main class="lh-404">
    <div class="lh-404__card">
      <div class="lh-404__anim">
        <dotlottie-wc
          src="https://lottie.host/34609a80-7df0-4862-b68d-58201701ed04/fNMWlPDZtn.lottie"
          style="width: 300px; height: 300px; max-width: 100%;"
          autoplay
          loop></dotlottie-wc>
      </div>
      <p class="lh-404__code">Error 404</p>
      <h1 class="lh-404__title">Lot not found</h1>
      <p class="lh-404__copy">This aisle is empty. The page you asked for is off the floor — or never listed.</p>
      <div class="lh-404__actions">
        <a href="<%= ctx %>/home" class="lh-btn lh-btn--signal">Back to desk</a>
        <a href="<%= ctx %>/catalog" class="lh-btn lh-btn--chalk">Browse lots</a>
      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/jspf/footer.jsp" />
  <script src="<%= ctx %>/js/home.js" defer></script>
</body>
</html>
