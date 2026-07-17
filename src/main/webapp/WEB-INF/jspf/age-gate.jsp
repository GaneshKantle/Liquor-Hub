<%-- Age 13+ gate: shown once per session after login (dashboard). --%>
<div id="lhAgeGate" class="lh-gate fixed inset-0 z-[2147483645] hidden items-center justify-center bg-ink/55 p-4 backdrop-blur-sm" hidden aria-modal="true" role="dialog" aria-labelledby="lhAgeTitle">
  <div class="w-full max-w-md rounded-[1.75rem] border border-white/80 bg-[#fffcf7] p-6 shadow-2xl sm:p-8">
    <div id="lhAgeAsk">
      <p class="text-[0.65rem] font-semibold uppercase tracking-[0.14em] text-accent">Age check</p>
      <h2 id="lhAgeTitle" class="mt-2 font-display text-3xl tracking-[-0.03em] text-ink">Are you 13 or older?</h2>
      <p class="mt-3 text-sm leading-relaxed text-ink-muted">We need a quick age confirm before you use your collector account.</p>
      <div class="mt-6 flex flex-col gap-3 sm:flex-row">
        <button type="button" id="lhAgeYes" class="inline-flex min-h-11 flex-1 items-center justify-center rounded-full bg-accent px-5 text-sm font-semibold text-white hover:bg-accent-strong">Yes, I am 13+</button>
        <button type="button" id="lhAgeNo" class="inline-flex min-h-11 flex-1 items-center justify-center rounded-full border border-black/10 bg-white px-5 text-sm font-semibold text-ink hover:bg-cream">No</button>
      </div>
    </div>
    <div id="lhAgeUnder" class="hidden" hidden>
      <h2 class="font-display text-3xl tracking-[-0.03em] text-ink">Hold up</h2>
      <p class="mt-3 text-sm leading-relaxed text-ink-muted">Come back when you are 13+. Shop stays locked for this session.</p>
      <a href="<%= request.getContextPath() %>/logout" class="mt-6 inline-flex min-h-11 items-center justify-center rounded-full bg-accent px-6 text-sm font-semibold text-white hover:bg-accent-strong">Sign out</a>
    </div>
  </div>
</div>
<style>
  #lhAgeGate:not([hidden]):not(.hidden) { display: flex; }
  #lhAgeGate.is-done { opacity: 0; visibility: hidden; pointer-events: none; transition: opacity .35s ease; }
</style>
