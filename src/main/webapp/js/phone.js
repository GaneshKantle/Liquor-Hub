(function (w) {
  "use strict";

  function normalize(raw) {
    if (!raw) return "";
    var s = String(raw).trim();
    var plus = s.charAt(0) === "+";
    s = s.replace(/[\s().\-]/g, "");
    if (plus && s.charAt(0) !== "+") {
      s = "+" + s.replace(/\+/g, "");
    } else if (!plus) {
      s = s.replace(/\+/g, "");
    }
    return s;
  }

  function isValid(raw) {
    var phone = normalize(raw);
    if (!phone) return false;
    if (/^\d{10}$/.test(phone)) return true;
    return /^\+[1-9]\d{7,14}$/.test(phone);
  }

  var HINT =
    "Use 10 digits (e.g. 9876543210) or international with country code (e.g. +919876543210).";

  function bind(form, phoneInput, errorEl) {
    if (!form || !phoneInput) return;

    function sync() {
      var ok = !phoneInput.value || isValid(phoneInput.value);
      phoneInput.classList.toggle("is-invalid", !ok && !!phoneInput.value);
      if (errorEl) errorEl.hidden = ok || !phoneInput.value;
      return ok;
    }

    phoneInput.addEventListener("input", sync);
    phoneInput.addEventListener("blur", sync);

    form.addEventListener("submit", function (e) {
      var normalized = normalize(phoneInput.value);
      phoneInput.value = normalized;
      if (!isValid(normalized)) {
        e.preventDefault();
        phoneInput.classList.add("is-invalid");
        if (errorEl) {
          errorEl.hidden = false;
          errorEl.textContent = HINT;
        }
        phoneInput.focus();
      }
    });
  }

  w.LHPhone = { normalize: normalize, isValid: isValid, hint: HINT, bind: bind };
})(window);
