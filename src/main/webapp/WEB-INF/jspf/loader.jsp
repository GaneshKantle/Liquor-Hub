<%-- Refined page loader — Apple-quiet. Styles: /css/beer-loader.css --%>
<div id="lhLoader" class="lh-loader" aria-live="polite" aria-busy="true" role="status">
  <div class="lh-loader__core">
    <div class="lh-loader__mark" aria-hidden="true">
      <svg class="lh-loader__ring" viewBox="0 0 48 48" width="40" height="40">
        <circle class="lh-loader__ring-track" cx="24" cy="24" r="20" fill="none" stroke-width="1.5"/>
        <circle class="lh-loader__ring-arc" cx="24" cy="24" r="20" fill="none" stroke-width="1.5"
          stroke-linecap="round" pathLength="100"/>
      </svg>
    </div>
    <p class="lh-loader__brand">LiquorHub</p>
    <div class="lh-loader__bar" aria-hidden="true"><span></span></div>
  </div>
</div>

<script>
(function () {
  var html = document.documentElement;
  var loader = document.getElementById("lhLoader");
  if (!loader) return;

  html.classList.add("lh-loading");

  var MIN_MS = 900;
  var started = Date.now();
  var finished = false;

  function finish() {
    if (finished) return;
    finished = true;
    var left = Math.max(0, MIN_MS - (Date.now() - started));
    setTimeout(function () {
      loader.classList.add("is-done");
      loader.setAttribute("aria-busy", "false");
      html.classList.remove("lh-loading");
      setTimeout(function () {
        if (loader && loader.parentNode) loader.parentNode.removeChild(loader);
      }, 520);
    }, left);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", finish);
  } else {
    finish();
  }
  window.addEventListener("load", finish, { once: true });
  setTimeout(finish, 2800);
})();
</script>
