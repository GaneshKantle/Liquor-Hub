(function (w) {
  "use strict";

  var hideTimer = null;
  var removeTimer = null;

  function ctx() {
    return document.body.getAttribute("data-ctx") || "";
  }

  function ensureToast() {
    var el = document.getElementById("lhToast");
    if (el) return el;

    el = document.createElement("div");
    el.id = "lhToast";
    el.className = "lh-toast";
    el.setAttribute("role", "status");
    el.setAttribute("aria-live", "polite");
    el.hidden = true;
    el.innerHTML =
      '<p class="lh-toast__title" id="lhToastTitle"></p>' +
      '<p class="lh-toast__sub" id="lhToastSub"></p>';
    document.body.appendChild(el);
    return el;
  }

  function show(title, subHtml) {
    var toast = ensureToast();
    var titleEl = document.getElementById("lhToastTitle");
    var subEl = document.getElementById("lhToastSub");

    if (titleEl) titleEl.textContent = title || "";
    if (subEl) {
      if (subHtml) {
        subEl.innerHTML = subHtml;
        subEl.hidden = false;
      } else {
        subEl.innerHTML = "";
        subEl.hidden = true;
      }
    }

    clearTimeout(hideTimer);
    clearTimeout(removeTimer);
    toast.hidden = false;
    toast.classList.remove("is-on");
    void toast.offsetWidth;
    requestAnimationFrame(function () {
      toast.classList.add("is-on");
    });

    hideTimer = setTimeout(function () {
      toast.classList.remove("is-on");
      removeTimer = setTimeout(function () {
        toast.hidden = true;
      }, 380);
    }, 3200);
  }

  function bootFromQuery() {
    var params = new URLSearchParams(w.location.search);
    var ordered = params.get("ordered");
    if (ordered) {
      var historyHref = "#history";
      var path = (w.location.pathname || "").toLowerCase();
      if (path.indexOf("/profile") < 0 && path.indexOf("/dashboard") < 0) {
        historyHref = ctx() + "/profile#history";
      }
      show(
        "Order placed successfully",
        "Order #" + ordered + " confirmed · <a href=\"" + historyHref + "\">View history</a>"
      );
      return;
    }
    if (params.get("added") === "1") {
      show(
        "Added to cart successfully",
        'Ready in your bag · <a href="' + ctx() + '/buy">Buy now</a>'
      );
      return;
    }
    if (params.get("updated") === "1") {
      show("Updated successfully", "Your profile details were saved.");
    }
  }

  w.LHToast = { show: show };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", bootFromQuery);
  } else {
    bootFromQuery();
  }
})(window);
