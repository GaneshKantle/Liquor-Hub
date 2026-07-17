<%-- Beer pour page loader — markup + dismiss script. Styles: /css/beer-loader.css --%>
<div id="lhLoader" class="lh-loader" aria-live="polite" aria-busy="true" role="status"
  style="position:fixed;inset:0;z-index:2147483646;display:flex;align-items:center;justify-content:center;margin:0;padding:1.25rem;background:linear-gradient(165deg,#fffbf7,#f8f5ef 45%,#f4dcd1);">
  <div class="lh-loader__panel">
    <div class="lh-loader__scene">
      <div class="lh-g">
        <div class="lh-g__rim"></div>
        <div class="lh-g__body">
          <div class="lh-g__beer">
            <div class="lh-g__foam"></div>
          </div>
          <div class="lh-g__shine"></div>
        </div>
        <div class="lh-g__base"></div>
      </div>
      <div class="lh-stream"></div>
      <div class="lh-b">
        <div class="lh-b__neck"></div>
        <div class="lh-b__body">
          <div class="lh-b__label"></div>
        </div>
      </div>
    </div>
    <p class="lh-loader__brand">LiquorHub</p>
    <p class="lh-loader__tag">Pouring your pour...</p>
  </div>
</div>

<script>
(function () {
  var html = document.documentElement;
  var loader = document.getElementById("lhLoader");
  if (!loader) return;

  html.classList.add("lh-loading");

  var MIN_MS = 2600;
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
      }, 500);
    }, left);
  }

  // Don't wait for hero video / fonts — DOM ready is enough so the pour plays once then exits
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", finish);
  } else {
    finish();
  }
  setTimeout(finish, 5000);
})();
</script>
