// docs/i18n.js
// Production-ready, URL-driven i18n for:
//   EN: /...                (no trailing slash)
//   SL: /.../sl             (no trailing slash)
//   EN subpages: /pricing
//   SL subpages: /sl/pricing
//
// Behavior guarantees:
// - URL is the source of truth (never "/sl" + English at the same time)
// - No trailing slash normalization (except for non-file paths)
// - Works under a <base href="/repo/"> subpath on GitHub Pages
// - Re-applies translations after hydration / DOM updates
//
// Required markup:
// - text nodes wrapped as: <span data-i18n="key">fallback</span>
// - language menu items: .langItem[data-lang="En"] and .langItem[data-lang="Sl"]
// - small label: .langValue
// - logo links: a.brandBtn (we set href to correct home per lang)

(function () {
  "use strict";

  const STORAGE_KEY = "lang"; // optional: remembers last choice when user visits "/" directly

  // =============================
  // 1) Dictionary
  // =============================
  const dict = {
    En: {
      "nav.sign_in": "Sign in",
      "lang.english": "English",
      "lang.slovenian": "Slovenščina",

      "hero.title": "Systematic maintenance app",
      "hero.subtitle":
        "Utilize our app to make maintenance easier, more efficient and lower its costs",

      "feature.work-orders.title": "Work orders",
      "feature.work-orders.bullet.1":
        "Create, assign, and track work orders in real-time, all from your mobile device.",
      "feature.work-orders.bullet.2":
        "Utilize both preventive and reactive work orders to minimize long-term costs and enhance asset longevity.",
      "feature.work-orders.bullet.3":
        "Prioritize tasks with urgency levels and due dates, and keep everyone in the loop with real-time status updates.",
      "feature.work-orders.bullet.4":
        "Incorporate predefined procedures into your work orders to ensure standardized and compliant task execution.",
      "feature.work-orders.bullet.5":
        "Work orders are completed after inspection and approval from a responsible person, ensuring quality and compliance.",

      "feature.asset-management.title": "Asset management",
      "feature.asset-management.bullet.1":
        "Manage all your assets in one place, from machinery to office equipment.",
      "feature.asset-management.bullet.2":
        "Easily access the comprehensive service history for each asset.",
      "feature.asset-management.bullet.3":
        "Utilize QR/bar scans for quick and accurate asset identification and task assignment.",
      "feature.asset-management.bullet.4":
        "Keep track of all your assets, their locations and details with our organized and searchable database.",
      "feature.asset-management.bullet.5":
        "Assign assets to specific users or teams for efficient workflow management.",

      "feature.communication.title": "Communication",
      "feature.communication.bullet.1":
        "Keep everybody connected in one place with our built-in-messaging system.",
      "feature.communication.bullet.2":
        "Maintain seamless communication within work orders through our dedicated chat based comment section.",
      "feature.communication.bullet.3":
        "Share important updates, files, and photos through our secure and user-friendly interface.",
      "feature.communication.bullet.4":
        "Receive push notifications for immediate attention to critical issues.",

      "feature.user-management.title": "User management",
      "feature.user-management.bullet.1":
        "4 user roles Admin, Full user, Operator, Partner operator with customization available to suit different role requirements.",
      "feature.user-management.bullet.2":
        "Assign assets and work orders based on user roles for efficient workflow.",
      "feature.user-management.bullet.3":
        "Monitor user activity metrics, such as time spent on work orders and number of work orders currently assigned.",
      "feature.user-management.bullet.4":
        "Track performance metrics for each user to ensure quality work.",
      "feature.user-management.bullet.5":
        "Seamlessly integrate external contractors into your work order processes.",

      "feature.bim.title": "BIM integration",
      "feature.bim.bullet.1":
        "Take the final step in your Building Information Modeling (BIM) journey with our app.",
      "feature.bim.bullet.2":
        "Seamlessly integrate your BIM data into our system for a holistic approach to facility management.",
      "feature.bim.bullet.3":
        "From asset tracking to work order management, make your BIM implementation complete.",

      "cta.title": "Learn how to use our app",
      "cta.body":
        "Get to know our app in our learning center. It covers everything from getting started to managing work orders and using advanced features.",
      "cta.button": "Go to learning center",

      "footer.copyright": "© 2026 OAsset. All rights reserved.",
      "footer.by": "by Optimiraj d.o.o.",

      "toast.email_copied": "Email copied to clipboard!",
    },

    Sl: {
      "nav.sign_in": "Prijava",
      "lang.english": "English",
      "lang.slovenian": "Slovenščina",

      "hero.title": "Aplikacija za sistematično vzdrževanje",
      "hero.subtitle":
        "Z našo aplikacijo bo vzdrževanje enostavnejše, učinkovitejše in cenejše.",

      "feature.work-orders.title": "Delovni nalogi",
      "feature.work-orders.bullet.1":
        "Ustvarjajte, dodeljujte in spremljajte delovne naloge v realnem času – neposredno z mobilne naprave.",
      "feature.work-orders.bullet.2":
        "Uporabljajte preventivne in korektivne naloge za zmanjšanje dolgoročnih stroškov ter podaljšanje življenjske dobe sredstev.",
      "feature.work-orders.bullet.3":
        "Določite prioritete z nivoji nujnosti in roki ter vse obveščajte s sprotnimi posodobitvami statusa.",
      "feature.work-orders.bullet.4":
        "Vključite vnaprej pripravljene postopke v delovne naloge za standardizirano in skladno izvedbo.",
      "feature.work-orders.bullet.5":
        "Delovne naloge so zaključene po pregledu in odobritvi odgovorne osebe, kar zagotavlja kakovost in skladnost.",

      "feature.asset-management.title": "Upravljanje sredstev",
      "feature.asset-management.bullet.1":
        "Upravljajte vsa sredstva na enem mestu – od strojev do pisarniške opreme.",
      "feature.asset-management.bullet.2":
        "Enostavno dostopajte do celotne servisne zgodovine posameznega sredstva.",
      "feature.asset-management.bullet.3":
        "Uporabljajte skeniranje QR/črtne kode za hitro in natančno identifikacijo sredstev ter dodeljevanje nalog.",
      "feature.asset-management.bullet.4":
        "Spremljajte sredstva, njihove lokacije in podrobnosti v urejeni ter iskalni podatkovni bazi.",
      "feature.asset-management.bullet.5":
        "Dodeljujte sredstva posameznim uporabnikom ali ekipam za učinkovitejši potek dela.",

      "feature.communication.title": "Komunikacija",
      "feature.communication.bullet.1":
        "Vse povežite na enem mestu z vgrajenim sistemom sporočanja.",
      "feature.communication.bullet.2":
        "Omogočite nemoteno komunikacijo znotraj delovnih nalog prek namenskega klepeta/komentarjev.",
      "feature.communication.bullet.3":
        "Delite pomembne posodobitve, datoteke in fotografije prek varnega in uporabniku prijaznega vmesnika.",
      "feature.communication.bullet.4":
        "Prejemajte potisna obvestila za takojšnjo pozornost pri kritičnih zadevah.",

      "feature.user-management.title": "Upravljanje uporabnikov",
      "feature.user-management.bullet.1":
        "4 vloge uporabnikov: Admin, Polni uporabnik, Operater, Partnerski operater – z možnostjo prilagoditev.",
      "feature.user-management.bullet.2":
        "Dodeljujte sredstva in delovne naloge glede na vloge za učinkovitejši potek dela.",
      "feature.user-management.bullet.3":
        "Spremljajte metrike aktivnosti uporabnikov, npr. porabljen čas in število trenutno dodeljenih delovnih nalog.",
      "feature.user-management.bullet.4":
        "Spremljajte kazalnike uspešnosti posameznih uporabnikov za zagotavljanje kakovosti dela.",
      "feature.user-management.bullet.5":
        "Enostavno vključite zunanje izvajalce v procese delovnih nalog.",

      "feature.bim.title": "BIM integracija",
      "feature.bim.bullet.1":
        "Z našo aplikacijo naredite zadnji korak na poti BIM (Building Information Modeling).",
      "feature.bim.bullet.2":
        "Brezhibno integrirajte BIM podatke v sistem za celovit pristop k upravljanju objektov.",
      "feature.bim.bullet.3":
        "Od sledenja sredstev do upravljanja delovnih nalog – dopolnite svojo BIM implementacijo.",

      "cta.title": "Naučite se uporabljati našo aplikacijo",
      "cta.body":
        "Spoznajte našo aplikacijo v učnem centru. Pokriva vse – od prvih korakov do upravljanja delovnih nalog in naprednih funkcij.",
      "cta.button": "V učni center",

      "footer.copyright": "© 2026 OAsset. Vse pravice pridržane.",
      "footer.by": "izdelal Optimiraj d.o.o.",

      "toast.email_copied": "E-pošta kopirana v odložišče!",
    },
  };

  // =============================
  // 2) Path helpers (GitHub Pages + no-trailing-slash)
  // =============================
  function isFilePath(p) {
    return /\/[^\/]+\.[a-z0-9]+$/i.test(p);
  }

  function stripTrailingSlash(p) {
    return p.length > 1 && p.endsWith("/") ? p.slice(0, -1) : p;
  }

  // returns "" or "/repo"
  function baseNoTrail() {
    const baseEl = document.querySelector("base");
    if (!baseEl) return "";
    try {
      const u = new URL(baseEl.href, window.location.origin);
      const p = u.pathname || "/";
      if (p === "/") return "";
      return p.endsWith("/") ? p.slice(0, -1) : p;
    } catch {
      return "";
    }
  }

  // pathname relative to base, always starting with "/"
  function relPath() {
    const base = baseNoTrail(); // "" or "/repo"
    let p = stripTrailingSlash(window.location.pathname);

    if (base && p.startsWith(base)) p = p.slice(base.length);
    if (!p.startsWith("/")) p = "/" + p;
    return p === "" ? "/" : p; // "/", "/sl", "/pricing", "/sl/pricing"
  }

  function isSlRel(p) {
    return p === "/sl" || p.startsWith("/sl/");
  }

  function langFromUrl() {
    return isSlRel(relPath()) ? "Sl" : "En";
  }

  // current page tail WITHOUT language prefix, always starting with "/"
  function tailWithoutLang() {
    const p = relPath();
    if (p === "/sl") return "/";
    if (p.startsWith("/sl/")) return p.slice(3); // remove "/sl"
    return p;
  }

  // Build URL for same page in target lang (no trailing slash):
  // EN: /pricing
  // SL: /sl/pricing
  function urlForLang(lang) {
    const base = baseNoTrail(); // "" or "/repo"
    const tail = tailWithoutLang(); // "/" or "/pricing"
    const prefix = base || "";

    if (lang === "Sl") {
      return prefix + (tail === "/" ? "/sl" : "/sl" + tail);
    }
    return prefix + tail;
  }

  // Home URL for given lang:
  // EN: /
  // SL: /sl
  function homeUrlForLang(lang) {
    const prefix = baseNoTrail() || "";
    return lang === "Sl" ? prefix + "/sl" : (prefix || "/");
  }

  function canonicalizeUrlNoTrailingSlash() {
    // Never touch file URLs
    const p = window.location.pathname;
    if (isFilePath(p)) return;

    const want = stripTrailingSlash(p);
    if (want !== p) {
      history.replaceState(
        {},
        "",
        want + (window.location.search || "") + (window.location.hash || "")
      );
    }
  }

  // =============================
  // 3) Translation + UI sync
  // =============================
  function tr(lang, key) {
    return (
      (dict[lang] && dict[lang][key]) ||
      (dict.En && dict.En[key]) ||
      null
    );
  }

  function applyLang(lang) {
    if (lang !== "En" && lang !== "Sl") lang = "En";

    document.documentElement.lang = lang === "Sl" ? "sl" : "en";

    // translate all nodes
    document.querySelectorAll("[data-i18n]").forEach((node) => {
      const key = node.getAttribute("data-i18n");
      if (!key) return;
      const next = tr(lang, key);
      if (typeof next === "string") node.textContent = next;
      // if missing -> keep fallback already in HTML
    });

    // En / Sl label in triggers
    document.querySelectorAll(".langValue").forEach((node) => {
      node.textContent = lang;
    });

    // active class in menus
    document.querySelectorAll(".langItem").forEach((a) => {
      a.classList.toggle("active", a.getAttribute("data-lang") === lang);
    });

    // Make logo always go to correct homepage for current lang
    document.querySelectorAll("a.brandBtn").forEach((a) => {
      a.setAttribute("href", homeUrlForLang(lang));
    });
  }

  function closeLangDrops() {
    document.querySelectorAll(".langDrop.open").forEach((dd) => {
      dd.classList.remove("open");
    });
  }

  // URL is the truth; localStorage only used to pick default when user visits "/"
  function preferredLangWhenOnRoot() {
    const saved = localStorage.getItem(STORAGE_KEY);
    return saved === "Sl" ? "Sl" : "En";
  }

  function setLang(lang, opts) {
    const options = Object.assign(
      { syncUrl: true, replaceUrl: false, closeMenus: true },
      opts || {}
    );

    if (lang !== "En" && lang !== "Sl") return;

    localStorage.setItem(STORAGE_KEY, lang);

    if (options.syncUrl) {
      const target = urlForLang(lang);
      const current = stripTrailingSlash(window.location.pathname);
      if (current !== target) {
        if (options.replaceUrl) history.replaceState({}, "", target);
        else history.pushState({}, "", target);

        // Let jaspr_router react (client)
        window.dispatchEvent(new PopStateEvent("popstate"));
      }
    }

    applyLang(lang);
    if (options.closeMenus) closeLangDrops();
  }

  // =============================
  // 4) Public hooks (your HTML onclick uses these)
  // =============================
  window.__tr = function (key) {
    const lang = langFromUrl();
    return tr(lang, key) || key;
  };

  window.__setLang = function (lang) {
    setLang(lang, { syncUrl: true, replaceUrl: false });
  };

  // =============================
  // 5) Init + hydration safety
  // =============================
  function initFromUrl() {
    canonicalizeUrlNoTrailingSlash();

    // URL decides language, except: when exactly on EN root "/" you may want last choice
    const rel = relPath();
    let lang = langFromUrl();

    if (rel === "/" && lang === "En") {
      // optional: keep last choice if user keeps returning to "/" directly
      // comment next line if you want "/" to always be English
      lang = preferredLangWhenOnRoot();
      if (lang === "Sl") {
        // move to /sl (no trailing slash)
        setLang("Sl", { syncUrl: true, replaceUrl: true });
        return;
      }
    }

    // Just translate; do not rewrite URL (URL already correct)
    applyLang(lang);
  }

  // Back/forward: URL wins
  window.addEventListener("popstate", function () {
    applyLang(langFromUrl());
  });

  // First paint
  document.addEventListener("DOMContentLoaded", initFromUrl);

  // After load (in case hydration swaps nodes)
  window.addEventListener("load", function () {
    applyLang(langFromUrl());
  });

  // Re-apply translations when Jaspr/hydration updates DOM
  let moTimer = null;
  const mo = new MutationObserver(function () {
    clearTimeout(moTimer);
    moTimer = setTimeout(function () {
      applyLang(langFromUrl());
    }, 0);
  });
  mo.observe(document.documentElement, { childList: true, subtree: true });
})();