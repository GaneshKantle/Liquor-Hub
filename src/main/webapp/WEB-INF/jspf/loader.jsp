<%-- Shared page loader: beer pour into glass (glass left, beer/bottle right) --%>
<div id="lhLoader" class="lh-loader" aria-live="polite" aria-busy="true" role="status">
  <div class="lh-loader__glow" aria-hidden="true"></div>
  <div class="lh-loader__card" aria-hidden="true">
    <svg class="lh-loader__svg" viewBox="0 0 340 210" xmlns="http://www.w3.org/2000/svg">
      <!-- Glass (left) -->
      <defs>
        <clipPath id="lhGlassClip">
          <path d="M88 58 L100 162 Q106 172 130 172 Q154 172 160 162 L172 58 Z"/>
        </clipPath>
        <linearGradient id="lhBeerGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#e8c45a"/>
          <stop offset="55%" stop-color="#c4a035"/>
          <stop offset="100%" stop-color="#8a5520"/>
        </linearGradient>
      </defs>

      <g>
        <!-- Outer glass rim -->
        <path d="M80 50 L94 170 Q102 182 130 182 Q158 182 166 170 L180 50 Z"
          fill="rgba(255,255,255,0.15)" stroke="rgba(19,17,13,0.28)" stroke-width="2.5" stroke-linejoin="round"/>
        <path d="M88 58 L100 162 Q106 172 130 172 Q154 172 160 162 L172 58 Z"
          fill="rgba(255,255,255,0.22)" stroke="rgba(255,255,255,0.65)" stroke-width="1.5"/>
        <path d="M98 64 L104 156" stroke="rgba(255,255,255,0.6)" stroke-width="3" stroke-linecap="round"/>

        <!-- Rising beer -->
        <g clip-path="url(#lhGlassClip)">
          <g class="lh-beer-rise">
            <rect x="86" y="58" width="88" height="120" fill="url(#lhBeerGrad)"/>
            <ellipse cx="130" cy="58" rx="34" ry="7" fill="#fff8ee"/>
          </g>
        </g>
        <ellipse class="lh-foam" cx="130" cy="78" rx="33" ry="7" fill="#fff8ee"/>
      </g>

      <!-- Pour stream from bottle to glass -->
      <path class="lh-pour" d="M218 52 C198 78 175 92 152 98" fill="none" stroke="#c4a035" stroke-width="6.5" stroke-linecap="round"/>

      <!-- Bottle (right), tilted pouring -->
      <g class="lh-bottle">
        <rect x="224" y="28" width="34" height="88" rx="7" transform="rotate(-30 241 72)" fill="#6b3f18"/>
        <rect x="228" y="36" width="26" height="68" rx="5" transform="rotate(-30 241 72)" fill="#b87333"/>
        <rect x="234" y="12" width="14" height="22" rx="3" transform="rotate(-30 241 72)" fill="#8a5520"/>
        <rect x="236" y="16" width="10" height="8" rx="2" transform="rotate(-30 241 72)" fill="#e8c45a" opacity="0.55"/>
      </g>

      <circle class="lh-drop lh-drop--1" cx="182" cy="72" r="3" fill="#c4a035"/>
      <circle class="lh-drop lh-drop--2" cx="168" cy="88" r="2.2" fill="#e8c45a"/>
    </svg>
  </div>
  <p class="lh-loader__brand">LiquorHub</p>
  <p class="lh-loader__tag">Pouring your pour…</p>
</div>

<style>
  .lh-loader {
    position: fixed;
    inset: 0;
    z-index: 9999;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 0;
    background:
      radial-gradient(ellipse 60% 50% at 18% 18%, rgba(184, 115, 51, 0.18), transparent 55%),
      radial-gradient(ellipse 50% 40% at 85% 85%, rgba(255, 255, 255, 0.95), transparent 50%),
      linear-gradient(165deg, #fffbf7 0%, #f8f5ef 48%, #f3e4d4 100%);
    transition: opacity 0.55s ease, visibility 0.55s ease;
  }
  .lh-loader.is-done {
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
  }
  .lh-loader__glow {
    position: absolute;
    width: min(300px, 70vw);
    height: min(300px, 70vw);
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.55);
    filter: blur(48px);
    animation: lh-glow 2.4s ease-in-out infinite;
  }
  .lh-loader__card {
    position: relative;
    z-index: 1;
    width: min(340px, 82vw);
    padding: 1.1rem 1.35rem 0.85rem;
    border-radius: 2rem;
    background: rgba(255, 255, 255, 0.48);
    border: 1px solid rgba(255, 255, 255, 0.78);
    box-shadow: 0 20px 56px rgba(38, 34, 29, 0.1), inset 0 1px 0 rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(22px);
    -webkit-backdrop-filter: blur(22px);
  }
  .lh-loader__svg { width: 100%; height: auto; display: block; }
  .lh-loader__brand {
    position: relative;
    z-index: 1;
    margin: 1.15rem 0 0;
    font-family: "Cormorant Garamond", Georgia, serif;
    font-size: clamp(1.75rem, 5vw, 2.35rem);
    font-weight: 600;
    letter-spacing: -0.03em;
    color: #13110d;
  }
  .lh-loader__tag {
    position: relative;
    z-index: 1;
    margin: 0.3rem 0 0;
    font-family: Outfit, system-ui, sans-serif;
    font-size: 0.72rem;
    font-weight: 600;
    letter-spacing: 0.14em;
    text-transform: uppercase;
    color: #b87333;
  }

  .lh-pour {
    stroke-dasharray: 180;
    stroke-dashoffset: 180;
    animation: lh-pour-stream 1s ease-out 0.2s forwards;
  }

  .lh-beer-rise {
    transform: translateY(115px);
    animation: lh-fill-up 1.4s cubic-bezier(0.45, 0, 0.2, 1) 0.5s forwards;
  }

  .lh-foam {
    opacity: 0;
    animation: lh-foam-in 0.45s ease 1.55s forwards;
  }

  .lh-bottle {
    transform-origin: 241px 40px;
    animation: lh-tilt 2s ease-in-out infinite;
  }

  .lh-drop { opacity: 0; }
  .lh-drop--1 { animation: lh-drip 1.15s ease-in 0.65s infinite; }
  .lh-drop--2 { animation: lh-drip 1.15s ease-in 0.95s infinite; }

  @keyframes lh-pour-stream {
    to { stroke-dashoffset: 0; }
  }
  @keyframes lh-fill-up {
    to { transform: translateY(0); }
  }
  @keyframes lh-foam-in {
    to { opacity: 0.95; }
  }
  @keyframes lh-tilt {
    0%, 100% { transform: rotate(0deg); }
    50% { transform: rotate(-6deg); }
  }
  @keyframes lh-drip {
    0% { opacity: 0; transform: translateY(0); }
    25% { opacity: 1; }
    100% { opacity: 0; transform: translateY(26px); }
  }
  @keyframes lh-glow {
    0%, 100% { opacity: 0.45; transform: scale(1); }
    50% { opacity: 0.85; transform: scale(1.06); }
  }

  @media (prefers-reduced-motion: reduce) {
    .lh-pour,
    .lh-beer-rise,
    .lh-foam,
    .lh-bottle,
    .lh-drop--1,
    .lh-drop--2,
    .lh-loader__glow { animation: none !important; }
    .lh-pour { stroke-dashoffset: 0; }
    .lh-beer-rise { transform: translateY(0); }
    .lh-foam { opacity: 0.95; }
  }
</style>

<script>
(function () {
  var loader = document.getElementById("lhLoader");
  if (!loader) return;

  var minMs = 2000;
  var start = Date.now();

  function hide() {
    var wait = Math.max(0, minMs - (Date.now() - start));
    setTimeout(function () {
      loader.classList.add("is-done");
      loader.setAttribute("aria-busy", "false");
      setTimeout(function () {
        if (loader.parentNode) loader.parentNode.removeChild(loader);
      }, 600);
    }, wait);
  }

  if (document.readyState === "complete") hide();
  else window.addEventListener("load", hide);
})();
</script>
