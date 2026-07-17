(function () {
  var QUIZ_KEY = "lh_quiz_ok";
  var AGE_KEY = "lh_age_ok";

  function qs(id) {
    return document.getElementById(id);
  }

  /* ---- First-visit liquor quiz (home only) ---- */
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

    if (form) {
      form.addEventListener("submit", function (e) {
        e.preventDefault();
        var answers = {
          q1: "c",
          q2: "b",
          q3: "a",
          q4: "c"
        };
        var ok = true;
        Object.keys(answers).forEach(function (name) {
          var picked = form.querySelector('input[name="' + name + '"]:checked');
          if (!picked || picked.value !== answers[name]) ok = false;
        });

        if (ok) {
          try { localStorage.setItem(QUIZ_KEY, "1"); } catch (err) {}
          document.documentElement.classList.remove("lh-quiz-lock");
          gate.classList.add("is-done");
          setTimeout(function () {
            if (gate.parentNode) gate.parentNode.removeChild(gate);
          }, 400);
        } else if (fail) {
          form.classList.add("hidden");
          fail.classList.remove("hidden");
          fail.hidden = false;
        }
      });
    }

    if (retry && form && fail) {
      retry.addEventListener("click", function () {
        fail.classList.add("hidden");
        fail.hidden = true;
        form.classList.remove("hidden");
        form.reset();
      });
    }
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
