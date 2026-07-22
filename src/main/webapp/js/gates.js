(function () {
  var QUIZ_KEY = "lh_quiz_ok";
  var AGE_KEY = "lh_age_ok";

  function qs(id) {
    return document.getElementById(id);
  }

  /* ---- First-visit liquor quiz (compact stepper) ---- */
  function initQuiz() {
    var gate = qs("lhQuizGate");
    if (!gate) return;

    try {
      if (localStorage.getItem(QUIZ_KEY) === "1") {
        gate.remove();
        return;
      }
    } catch (e) { /* private mode */ }

    gate.hidden = false;
    gate.classList.remove("hidden");
    document.documentElement.classList.add("lh-quiz-lock");

    var form = qs("lhQuizForm");
    var fail = qs("lhQuizFail");
    var retry = qs("lhQuizRetry");
    var nextBtn = qs("lhQuizNext");
    var backBtn = qs("lhQuizBack");
    var submitBtn = qs("lhQuizSubmit");
    var stepNum = qs("lhQuizStepNum");
    var hint = qs("lhQuizHint");
    var slides = form ? form.querySelectorAll(".lh-quiz__slide") : [];
    var dots = gate.querySelectorAll(".lh-quiz__dot");
    var step = 0;
    var total = slides.length || 4;
    var answers = { q1: "c", q2: "b", q3: "a", q4: "c" };

    function qName(i) {
      return "q" + (i + 1);
    }

    function hasAnswer(i) {
      return !!(form && form.querySelector('input[name="' + qName(i) + '"]:checked'));
    }

    function showStep(i) {
      step = i;
      for (var s = 0; s < slides.length; s++) {
        var on = s === step;
        slides[s].hidden = !on;
        slides[s].classList.toggle("is-active", on);
      }
      for (var d = 0; d < dots.length; d++) {
        dots[d].classList.toggle("is-on", d === step);
        dots[d].classList.toggle("is-done", d < step);
      }
      if (stepNum) stepNum.textContent = String(step + 1);
      if (backBtn) backBtn.hidden = step === 0;
      if (nextBtn) nextBtn.hidden = step >= total - 1;
      if (submitBtn) submitBtn.hidden = step < total - 1;
      if (hint) {
        hint.hidden = true;
      }
    }

    function passQuiz() {
      try { localStorage.setItem(QUIZ_KEY, "1"); } catch (err) {}
      document.documentElement.classList.remove("lh-quiz-lock");
      gate.classList.add("is-done");
      setTimeout(function () {
        if (gate.parentNode) gate.parentNode.removeChild(gate);
      }, 380);
    }

    if (nextBtn) {
      nextBtn.addEventListener("click", function () {
        if (!hasAnswer(step)) {
          if (hint) hint.hidden = false;
          return;
        }
        if (step < total - 1) showStep(step + 1);
      });
    }

    if (backBtn) {
      backBtn.addEventListener("click", function () {
        if (step > 0) showStep(step - 1);
      });
    }

    if (form) {
      form.addEventListener("change", function () {
        if (hint) hint.hidden = true;
      });

      form.addEventListener("submit", function (e) {
        e.preventDefault();
        if (!hasAnswer(step)) {
          if (hint) hint.hidden = false;
          return;
        }
        var ok = true;
        Object.keys(answers).forEach(function (name) {
          var picked = form.querySelector('input[name="' + name + '"]:checked');
          if (!picked || picked.value !== answers[name]) ok = false;
        });

        if (ok) {
          passQuiz();
        } else if (fail) {
          form.classList.add("hidden");
          form.hidden = true;
          fail.hidden = false;
        }
      });
    }

    if (retry && form && fail) {
      retry.addEventListener("click", function () {
        fail.hidden = true;
        form.hidden = false;
        form.classList.remove("hidden");
        form.reset();
        showStep(0);
      });
    }

    showStep(0);
  }

  /* ---- Age 13+ after login (dashboard) ---- */
  function initAge() {
    var gate = qs("lhAgeGate");
    if (!gate) return;

    try {
      if (sessionStorage.getItem(AGE_KEY) === "1") {
        gate.remove();
        return;
      }
      if (sessionStorage.getItem(AGE_KEY) === "0") {
        gate.hidden = false;
        gate.classList.remove("hidden");
        var under = qs("lhAgeUnder");
        var ask = qs("lhAgeAsk");
        if (ask) ask.classList.add("hidden");
        if (under) {
          under.classList.remove("hidden");
          under.hidden = false;
        }
        return;
      }
    } catch (e) {}

    gate.hidden = false;
    gate.classList.remove("hidden");

    var yes = qs("lhAgeYes");
    var no = qs("lhAgeNo");
    var ask = qs("lhAgeAsk");
    var under = qs("lhAgeUnder");

    if (yes) {
      yes.addEventListener("click", function () {
        try { sessionStorage.setItem(AGE_KEY, "1"); } catch (err) {}
        gate.classList.add("is-done");
        setTimeout(function () {
          if (gate.parentNode) gate.parentNode.removeChild(gate);
        }, 350);
      });
    }

    if (no) {
      no.addEventListener("click", function () {
        try { sessionStorage.setItem(AGE_KEY, "0"); } catch (err) {}
        if (ask) ask.classList.add("hidden");
        if (under) {
          under.classList.remove("hidden");
          under.hidden = false;
        }
      });
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", function () {
      initQuiz();
      initAge();
    });
  } else {
    initQuiz();
    initAge();
  }
})();
