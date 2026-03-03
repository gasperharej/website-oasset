(function () {
    // Keep toast messages language-aware without depending on i18n.js.
    const MESSAGES = {
      En: {
        "toast.email_copied": "Email copied to clipboard!",
      },
      Sl: {
        "toast.email_copied": "E-pošta kopirana v odložišče!",
      },
    };

    function currentLang() {
      const htmlLang = (document.documentElement.lang || "").toLowerCase();
      if (htmlLang.startsWith("sl")) return "Sl";

      const baseEl = document.querySelector("base");
      let basePath = "";
      if (baseEl && baseEl.href) {
        try {
          const u = new URL(baseEl.href, window.location.origin);
          basePath = u.pathname || "";
          if (basePath.length > 1 && basePath.endsWith("/")) {
            basePath = basePath.slice(0, -1);
          }
        } catch (_) {}
      }

      let path = window.location.pathname || "/";
      if (basePath && path.startsWith(basePath)) {
        path = path.slice(basePath.length) || "/";
      }
      if (!path.startsWith("/")) path = "/" + path;

      return path === "/sl" || path.startsWith("/sl/") ? "Sl" : "En";
    }
  
    function ensureToastEl() {
      let toast = document.getElementById("copy-toast");
      if (toast) return toast;
  
      toast = document.createElement("div");
      toast.id = "copy-toast";
      toast.className = "copyToast";
  
      const icon = document.createElement("span");
      icon.className = "copyToastIcon";
      icon.textContent = "✓";
  
      const msg = document.createElement("span");
      msg.className = "copyToastMsg";
  
      toast.appendChild(icon);
      toast.appendChild(msg);
  
      toast.addEventListener("click", function () {
        toast.classList.remove("show");
        clearTimeout(window.__copyToastTimer);
      });
  
      document.body.appendChild(toast);
      return toast;
    }
  
    function showToast(key) {
      const toast = ensureToastEl();
      toast.dataset.toastKey = key;
  
      const msg = toast.querySelector(".copyToastMsg");
      if (msg) {
        const lang = currentLang();
        msg.textContent =
          (MESSAGES[lang] && MESSAGES[lang][key]) ||
          (MESSAGES.En && MESSAGES.En[key]) ||
          "Copied to clipboard!";
      }
  
      toast.classList.add("show");
      clearTimeout(window.__copyToastTimer);
      window.__copyToastTimer = setTimeout(function () {
        toast.classList.remove("show");
      }, 2500);
    }
  
    async function copyText(text) {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        await navigator.clipboard.writeText(text);
        return;
      }
      // fallback
      const ta = document.createElement("textarea");
      ta.value = text;
      ta.setAttribute("readonly", "");
      ta.style.position = "fixed";
      ta.style.left = "-9999px";
      document.body.appendChild(ta);
      ta.select();
      document.execCommand("copy");
      document.body.removeChild(ta);
    }
  
    document.addEventListener("click", function (e) {
      const a = e.target.closest("[data-copy]");
      if (!a) return;
  
      e.preventDefault();
  
      const text = a.getAttribute("data-copy") || "";
      const toastKey = a.getAttribute("data-toast-key") || "toast.email_copied";
  
      copyText(text)
        .then(function () { showToast(toastKey); })
        .catch(function () { showToast(toastKey); });
    });
  })();