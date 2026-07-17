(function () {
  var header = document.getElementById("siteHeader");
  var menuBtn = document.getElementById("menuBtn");
  var mobileNav = document.getElementById("mobileNav");
  var catToggle = document.getElementById("catToggle");
  var catMenu = document.getElementById("catMenu");
  var mobileCatToggle = document.getElementById("mobileCatToggle");
  var mobileCats = document.getElementById("mobileCats");
  var search = document.getElementById("siteSearch");
  var searchMobile = document.getElementById("siteSearchMobile");
  var products = document.querySelectorAll(".lh-prod");
  var empty = document.getElementById("productEmpty");
  var itemsSection = document.getElementById("items");
  var loginModal = document.getElementById("lhLoginModal");
  var loginClose = document.getElementById("lhLoginModalClose");
  var activeCat = "";
  var query = "";
  var searchTimer = null;
  var didScrollSearch = false;

  function setHeaderState() {
    if (!header) return;
    header.classList.toggle("is-scrolled", (window.scrollY || 0) > 40);
  }

  function closeDesktopCat() {
    if (!catMenu || !catToggle) return;
    catMenu.classList.add("hidden");
    catToggle.setAttribute("aria-expanded", "false");
  }

  function closeMobile() {
    if (!mobileNav || !menuBtn) return;
    mobileNav.classList.add("hidden");
    mobileNav.hidden = true;
    menuBtn.setAttribute("aria-expanded", "false");
  }

  function scrollToItems() {
    if (!itemsSection) return;
    itemsSection.scrollIntoView({ behavior: "smooth", block: "start" });
  }

  function filterProducts() {
    var visible = 0;
    for (var i = 0; i < products.length; i++) {
      var el = products[i];
      var catOk = !activeCat || el.getAttribute("data-cat") === activeCat;
      var searchOk = !query || (el.getAttribute("data-search") || "").indexOf(query) !== -1;
      var show = catOk && searchOk;
      el.classList.toggle("hidden", !show);
      if (show) visible++;
    }
    if (empty) empty.classList.toggle("hidden", visible !== 0);
  }

  function applyCat(id) {
    activeCat = id || "";
    filterProducts();
    closeDesktopCat();
    closeMobile();
    scrollToItems();
  }

  function applyQuery(value, fromUser) {
    query = (value || "").trim().toLowerCase();
    if (search && document.activeElement !== search) search.value = value || "";
    if (searchMobile && document.activeElement !== searchMobile) searchMobile.value = value || "";
    filterProducts();
    if (fromUser && query) {
      if (!didScrollSearch) {
        didScrollSearch = true;
        scrollToItems();
      }
    }
    if (!query) didScrollSearch = false;
  }

  function openLoginModal() {
    if (!loginModal) return;
    loginModal.hidden = false;
    loginModal.classList.remove("hidden");
  }

  function closeLoginModal() {
    if (!loginModal) return;
    loginModal.hidden = true;
    loginModal.classList.add("hidden");
  }

  if (menuBtn && mobileNav) {
    menuBtn.addEventListener("click", function () {
      var open = mobileNav.classList.contains("hidden");
      mobileNav.classList.toggle("hidden", !open);
      mobileNav.hidden = !open;
      menuBtn.setAttribute("aria-expanded", open ? "true" : "false");
      closeDesktopCat();
    });
  }

  if (catToggle && catMenu) {
    catToggle.addEventListener("click", function (e) {
      e.stopPropagation();
      var open = catMenu.classList.contains("hidden");
      catMenu.classList.toggle("hidden", !open);
      catToggle.setAttribute("aria-expanded", open ? "true" : "false");
    });
  }

  if (mobileCatToggle && mobileCats) {
    mobileCatToggle.addEventListener("click", function () {
      var open = mobileCats.classList.contains("hidden");
      mobileCats.classList.toggle("hidden", !open);
      mobileCats.hidden = !open;
    });
  }

  document.addEventListener("click", function (e) {
    var t = e.target;
    if (catMenu && catToggle && !catMenu.contains(t) && t !== catToggle && !catToggle.contains(t)) {
      closeDesktopCat();
    }
  });

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      closeDesktopCat();
      closeMobile();
      closeLoginModal();
    }
  });

  document.addEventListener("click", function (e) {
    var link = e.target.closest("[data-filter-cat]");
    if (!link) return;
    applyCat(String(link.getAttribute("data-filter-cat")));
  });

  function onSearchInput(el) {
    clearTimeout(searchTimer);
    searchTimer = setTimeout(function () {
      applyQuery(el.value, true);
    }, 150);
  }

  if (search) search.addEventListener("input", function () { onSearchInput(search); });
  if (searchMobile) searchMobile.addEventListener("input", function () { onSearchInput(searchMobile); });

  document.querySelectorAll('#mobileNav a[href^="#"]').forEach(function (a) {
    a.addEventListener("click", closeMobile);
  });

  document.addEventListener("click", function (e) {
    var btn = e.target.closest(".lh-add-cart");
    if (!btn) return;
    e.preventDefault();
    openLoginModal();
  });

  if (loginClose) loginClose.addEventListener("click", closeLoginModal);
  if (loginModal) {
    loginModal.addEventListener("click", function (e) {
      if (e.target === loginModal) closeLoginModal();
    });
  }

  if ("IntersectionObserver" in window) {
    var io = new IntersectionObserver(function (entries) {
      for (var i = 0; i < entries.length; i++) {
        if (entries[i].isIntersecting) {
          entries[i].target.classList.add("is-in");
          io.unobserve(entries[i].target);
        }
      }
    }, { threshold: 0.12 });
    document.querySelectorAll(".lh-reveal").forEach(function (el) { io.observe(el); });
  } else {
    document.querySelectorAll(".lh-reveal").forEach(function (el) { el.classList.add("is-in"); });
  }

  window.addEventListener("scroll", setHeaderState, { passive: true });
  setHeaderState();

  if (document.querySelector("#contact .bg-green-50, #contact .bg-red-50")) {
    var contact = document.getElementById("contact");
    if (contact) contact.scrollIntoView({ behavior: "smooth", block: "start" });
  }
})();
