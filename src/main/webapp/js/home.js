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
  var searchForm = document.getElementById("siteSearchForm");
  var searchFormMobile = document.getElementById("siteSearchFormMobile");
  var products = document.querySelectorAll(".lh-prod");
  var empty = document.getElementById("productEmpty");
  var itemsSection = document.getElementById("items");
  var loginModal = document.getElementById("lhLoginModal");
  var loginClose = document.getElementById("lhLoginModalClose");
  var activeCat = "";
  var query = "";
  var searchTimer = null;

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
      var hay = (el.getAttribute("data-search") || "").toLowerCase();
      var searchOk = !query || hay.indexOf(query) !== -1;
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

  function applyQuery(value, opts) {
    opts = opts || {};
    query = (value || "").trim().toLowerCase();
    if (opts.clearCat) activeCat = "";
    if (search && document.activeElement !== search) search.value = value || "";
    if (searchMobile && document.activeElement !== searchMobile) searchMobile.value = value || "";
    filterProducts();
    if (opts.scroll) {
      closeMobile();
      scrollToItems();
    }
  }

  function runSearch(value) {
    var q = (value || "").trim();
    if (!products.length) {
      var ctx = document.body.getAttribute("data-ctx") || "";
      window.location.href = ctx + "/catalog" + (q ? ("?q=" + encodeURIComponent(q)) : "");
      return;
    }
    applyQuery(value, { clearCat: true, scroll: true });
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
      applyQuery(el.value, { clearCat: true, scroll: false });
    }, 150);
  }

  if (search) search.addEventListener("input", function () { onSearchInput(search); });
  if (searchMobile) searchMobile.addEventListener("input", function () { onSearchInput(searchMobile); });

  if (searchForm) {
    searchForm.addEventListener("submit", function (e) {
      e.preventDefault();
      runSearch(search ? search.value : "");
    });
  }
  if (searchFormMobile) {
    searchFormMobile.addEventListener("submit", function (e) {
      e.preventDefault();
      runSearch(searchMobile ? searchMobile.value : "");
    });
  }

  try {
    var bootQ = new URLSearchParams(window.location.search).get("q");
    if (bootQ && products.length) {
      applyQuery(bootQ, { clearCat: true, scroll: false });
    }
  } catch (err) {}


  document.querySelectorAll('#mobileNav a[href^="#"]').forEach(function (a) {
    a.addEventListener("click", closeMobile);
  });

  /* ---- Mild 3D tilt (cached rect — avoids hover swing feedback) ---- */
  var reduceMotion = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var finePointer = window.matchMedia && window.matchMedia("(hover: hover) and (pointer: fine)").matches;
  var cards = document.querySelectorAll(".lh-prod-3d");
  if (!reduceMotion && finePointer && cards.length) {
    for (var c = 0; c < cards.length; c++) {
      (function (card) {
        var baseRect = null;
        var raf = 0;
        var nextX = 0;
        var nextY = 0;

        function applyTilt() {
          raf = 0;
          if (!baseRect) return;
          var x = (nextX - baseRect.left) / baseRect.width;
          var y = (nextY - baseRect.top) / baseRect.height;
          x = Math.max(0, Math.min(1, x));
          y = Math.max(0, Math.min(1, y));
          var rotY = (x - 0.5) * 6;
          var rotX = (0.5 - y) * 4;
          card.classList.add("is-tilting");
          card.style.transform =
            "perspective(900px) rotateX(" + rotX.toFixed(2) + "deg) rotateY(" + rotY.toFixed(2) + "deg)";
        }

        card.addEventListener("pointerenter", function () {
          baseRect = card.getBoundingClientRect();
        });
        card.addEventListener("pointermove", function (e) {
          nextX = e.clientX;
          nextY = e.clientY;
          if (!baseRect) baseRect = card.getBoundingClientRect();
          if (!raf) raf = requestAnimationFrame(applyTilt);
        });
        card.addEventListener("pointerleave", function () {
          baseRect = null;
          if (raf) {
            cancelAnimationFrame(raf);
            raf = 0;
          }
          card.classList.remove("is-tilting");
          card.style.transform = "";
        });
      })(cards[c]);
    }
  }

  var cartDock = document.getElementById("lhCartDock");
  var cartCountLabel = document.getElementById("lhCartCountLabel");
  var addedCount = 0;

  function showToast(title, subHtml) {
    if (window.LHToast && typeof window.LHToast.show === "function") {
      window.LHToast.show(title, subHtml);
      return;
    }
  }

  function bumpCartDock() {
    if (!cartDock) return;
    addedCount += 1;
    if (cartCountLabel) {
      cartCountLabel.textContent = addedCount === 1 ? "1 item added" : addedCount + " items added";
    }
    cartDock.classList.remove("is-bump");
    void cartDock.offsetWidth;
    cartDock.classList.add("is-bump");
  }

  function markAdded(btn) {
    if (!btn) return;
    btn.classList.add("is-added");
    setTimeout(function () { btn.classList.remove("is-added", "is-adding"); }, 1600);
  }

  document.addEventListener("click", function (e) {
    var guestWish = e.target.closest(".lh-wish-guest");
    if (guestWish && guestWish.tagName === "A") {
      return; // let browser go to login/signup
    }
    if (guestWish) {
      e.preventDefault();
      e.stopPropagation();
      var ctxWish = document.body.getAttribute("data-ctx") || "";
      window.location.href = ctxWish + "/login?reason=wishlist&next=" + encodeURIComponent(ctxWish + "/home#items");
      return;
    }

    var wishBtn = e.target.closest(".lh-wish:not(.lh-wish-guest)");
    if (wishBtn) {
      e.preventDefault();
      e.stopPropagation();
      var wishPid = wishBtn.getAttribute("data-product-id");
      if (!wishPid) return;
      var card = wishBtn.closest(".lh-prod");
      var wishName = card ? (card.getAttribute("data-name") || "Bottle") : "Bottle";
      var ctx = document.body.getAttribute("data-ctx") || "";
      var body = new URLSearchParams();
      body.set("productId", wishPid);
      body.set("action", "toggle");
      body.set("ajax", "1");
      fetch(ctx + "/wishlist", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: body.toString(),
        credentials: "same-origin"
      }).then(function (res) {
        if (res.status === 401) {
          window.location.href = ctx + "/login?reason=wishlist&next=" + encodeURIComponent(ctx + "/home#items");
          throw new Error("login");
        }
        if (!res.ok) throw new Error("wish failed");
        return res.json();
      }).then(function (data) {
        var on = !!(data && data.favourited);
        wishBtn.classList.toggle("is-active", on);
        wishBtn.setAttribute("aria-pressed", on ? "true" : "false");
        wishBtn.setAttribute("aria-label", on ? "Remove from wishlist" : "Add to wishlist");
        showToast(
          on ? "Saved to wishlist" : "Removed from wishlist",
          on
            ? wishName + ' · <a href="' + ctx + '/profile#wishlist">View favourites</a>'
            : wishName + " removed from favourites"
        );
      }).catch(function (err) {
        if (err && err.message === "login") return;
      });
      return;
    }

    var guestBtn = e.target.closest(".lh-add-cart");
    if (!guestBtn) return;
    e.preventDefault();
    var ctxGuest = document.body.getAttribute("data-ctx") || "";
    var pid = guestBtn.getAttribute("data-product-id");
    var reason = (guestBtn.textContent || "").toLowerCase().indexOf("buy") >= 0 ? "buy" : "cart";
    var next = reason === "buy" && pid
      ? ctxGuest + "/buy-now?productId=" + pid
      : ctxGuest + "/home#items";
    window.location.href = ctxGuest + "/login?reason=" + reason + "&next=" + encodeURIComponent(next);
  });

  document.addEventListener("submit", function (e) {
    var form = e.target.closest(".lh-atc-form");
    if (!form) return;
    e.preventDefault();
    var btn = form.querySelector(".lh-atc");
    var card = form.closest(".lh-prod");
    var name = card ? (card.getAttribute("data-name") || "Bottle") : "Bottle";
    if (btn) btn.classList.add("is-adding");

    var body = new URLSearchParams();
    var pid = form.querySelector('input[name="productId"]');
    if (pid) body.set("productId", pid.value);
    body.set("ajax", "1");

    fetch(form.getAttribute("action"), {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: body.toString(),
      credentials: "same-origin"
    }).then(function (res) {
      if (!res.ok) throw new Error("add failed");
      return res.json();
    }).then(function () {
      markAdded(btn);
      bumpCartDock();
      showToast(
        "Added to cart successfully",
        name + ' is in your bag · <a href="' + (document.body.getAttribute("data-ctx") || "") + '/cart">View cart</a>'
      );
    }).catch(function () {
      if (btn) btn.classList.remove("is-adding");
      form.submit();
    });
  });

  if (loginClose) loginClose.addEventListener("click", closeLoginModal);
  if (loginModal) {
    loginModal.addEventListener("click", function (e) {
      if (e.target === loginModal) closeLoginModal();
    });
  }

  if ("IntersectionObserver" in window) {
    var reveals = document.querySelectorAll(".lh-reveal");
    var io = new IntersectionObserver(function (entries) {
      for (var i = 0; i < entries.length; i++) {
        if (entries[i].isIntersecting) {
          entries[i].target.classList.add("is-in");
          entries[i].target.classList.remove("lh-pending");
          io.unobserve(entries[i].target);
        }
      }
    }, { threshold: 0, rootMargin: "40px 0px 0px 0px" });

    for (var r = 0; r < reveals.length; r++) {
      var el = reveals[r];
      var top = el.getBoundingClientRect().top;
      // Only hide sections clearly below the fold; keep visible content visible
      if (top > window.innerHeight * 0.85) {
        el.classList.add("lh-pending");
        io.observe(el);
      } else {
        el.classList.add("is-in");
      }
    }

    // Fail-open so tall catalogue blocks never stay blank forever
    setTimeout(function () {
      document.querySelectorAll(".lh-reveal.lh-pending").forEach(function (el) {
        el.classList.add("is-in");
        el.classList.remove("lh-pending");
      });
    }, 700);
  } else {
    document.querySelectorAll(".lh-reveal").forEach(function (el) {
      el.classList.add("is-in");
    });
  }

  window.addEventListener("scroll", setHeaderState, { passive: true });
  setHeaderState();

  /* Touch-friendly category flip toggle */
  document.querySelectorAll(".lh-flip").forEach(function (card) {
    card.addEventListener("click", function (e) {
      if (e.target.closest(".lh-flip__shop")) return;
      if (window.matchMedia && window.matchMedia("(hover: hover)").matches) return;
      card.classList.toggle("is-flipped");
    });
  });

  if (document.querySelector("#contact .bg-green-50, #contact .bg-red-50")) {
    var contact = document.getElementById("contact");
    if (contact) contact.scrollIntoView({ behavior: "smooth", block: "start" });
  }

  var contactForm = document.getElementById("lhContactForm");
  if (contactForm) {
    contactForm.addEventListener("submit", function (e) {
      e.preventDefault();
      var btn = document.getElementById("lhContactSubmit");
      var status = document.getElementById("lhContactStatus");
      var data = new FormData(contactForm);

      if (btn) {
        btn.disabled = true;
        btn.textContent = "Sending…";
      }
      if (status) {
        status.hidden = true;
        status.textContent = "";
        status.className = "rounded-xl border px-3 py-2.5 text-sm";
      }

      fetch(contactForm.action, {
        method: "POST",
        body: data,
        headers: { Accept: "application/json" }
      })
        .then(function (res) { return res.json().then(function (json) { return { ok: res.ok, json: json }; }); })
        .then(function (result) {
          if (!result.ok || !(result.json && result.json.success)) {
            throw new Error((result.json && result.json.message) || "Could not send message");
          }
          contactForm.reset();
          if (status) {
            status.hidden = false;
            status.className = "rounded-xl border border-green-700/15 bg-green-50 px-3 py-2.5 text-sm text-green-800";
            status.textContent = "Message sent. We’ll get back to you soon.";
          }
          showToast("Message sent successfully", 'Or email us at <a href="mailto:contact.liqourhub@gmail.com">contact.liqourhub@gmail.com</a>');
        })
        .catch(function () {
          if (status) {
            status.hidden = false;
            status.className = "rounded-xl border border-red-700/15 bg-red-50 px-3 py-2.5 text-sm text-red-800";
            status.textContent = "Couldn’t send right now. Email contact.liqourhub@gmail.com instead.";
          }
        })
        .finally(function () {
          if (btn) {
            btn.disabled = false;
            btn.textContent = "Send message";
          }
        });
    });
  }
})();
