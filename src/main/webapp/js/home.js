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
  var activeCat = "";
  var query = "";

  function setHeaderState() {
    if (!header) return;
    var y = window.scrollY || 0;
    header.classList.toggle("lh-header--scrolled", y > 40);
    header.classList.toggle("lh-header--hero", y < window.innerHeight * 0.72);
  }

  function closeDesktopCat() {
    if (!catMenu || !catToggle) return;
    catMenu.classList.remove("is-open");
    catToggle.setAttribute("aria-expanded", "false");
  }

  function closeMobile() {
    if (!mobileNav || !menuBtn) return;
    mobileNav.classList.remove("is-open");
    mobileNav.hidden = true;
    menuBtn.setAttribute("aria-expanded", "false");
  }

  function filterProducts() {
    var visible = 0;
    for (var i = 0; i < products.length; i++) {
      var el = products[i];
      var catOk = !activeCat || el.getAttribute("data-cat") === activeCat;
      var searchOk = !query || (el.getAttribute("data-search") || "").indexOf(query) !== -1;
      var show = catOk && searchOk;
      el.classList.toggle("is-hidden", !show);
      if (show) visible++;
    }
    if (empty) empty.classList.toggle("is-show", visible === 0);
  }

  function applyCat(id) {
    activeCat = id || "";
    filterProducts();
    closeDesktopCat();
    closeMobile();
  }

  function applyQuery(value) {
    query = (value || "").trim().toLowerCase();
    if (search && search.value !== value && document.activeElement !== search) {
      search.value = value || "";
    }
    if (searchMobile && searchMobile.value !== value && document.activeElement !== searchMobile) {
      searchMobile.value = value || "";
    }
    filterProducts();
  }

  if (menuBtn && mobileNav) {
    menuBtn.addEventListener("click", function () {
      var open = !mobileNav.classList.contains("is-open");
      mobileNav.classList.toggle("is-open", open);
      mobileNav.hidden = !open;
      menuBtn.setAttribute("aria-expanded", open ? "true" : "false");
      closeDesktopCat();
    });
  }

  if (catToggle && catMenu) {
    catToggle.addEventListener("click", function (e) {
      e.stopPropagation();
      var open = !catMenu.classList.contains("is-open");
      catMenu.classList.toggle("is-open", open);
      catToggle.setAttribute("aria-expanded", open ? "true" : "false");
    });
  }

  if (mobileCatToggle && mobileCats) {
    mobileCatToggle.addEventListener("click", function () {
      var open = mobileCats.hidden;
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
    }
  });

  document.addEventListener("click", function (e) {
    var link = e.target.closest("[data-filter-cat]");
    if (!link) return;
    applyCat(String(link.getAttribute("data-filter-cat")));
  });

  if (search) {
    search.addEventListener("input", function () {
      applyQuery(search.value);
    });
  }

  if (searchMobile) {
    searchMobile.addEventListener("input", function () {
      applyQuery(searchMobile.value);
    });
  }

  document.querySelectorAll('.lh-mobile a[href^="#"]').forEach(function (a) {
    a.addEventListener("click", closeMobile);
  });

  if ("IntersectionObserver" in window) {
    var io = new IntersectionObserver(
      function (entries) {
        for (var i = 0; i < entries.length; i++) {
          if (entries[i].isIntersecting) {
            entries[i].target.classList.add("is-in");
            io.unobserve(entries[i].target);
          }
        }
      },
      { threshold: 0.12 }
    );
    document.querySelectorAll(".lh-reveal").forEach(function (el) {
      io.observe(el);
    });
  } else {
    document.querySelectorAll(".lh-reveal").forEach(function (el) {
      el.classList.add("is-in");
    });
  }

  window.addEventListener("scroll", setHeaderState, { passive: true });
  setHeaderState();

  if (document.querySelector("#contact .lh-msg")) {
    var contact = document.getElementById("contact");
    if (contact) contact.scrollIntoView({ behavior: "smooth", block: "start" });
  }
})();
