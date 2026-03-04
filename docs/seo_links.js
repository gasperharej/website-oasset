(function () {
  "use strict";

  function stripTrailingSlash(pathname) {
    return pathname.length > 1 && pathname.endsWith("/")
      ? pathname.slice(0, -1)
      : pathname;
  }

  function basePathNoTrail() {
    var baseEl = document.querySelector("base");
    if (!baseEl || !baseEl.href) return "";
    try {
      var u = new URL(baseEl.href, window.location.origin);
      var p = u.pathname || "/";
      if (p === "/") return "";
      return p.endsWith("/") ? p.slice(0, -1) : p;
    } catch (_) {
      return "";
    }
  }

  function relPath() {
    var base = basePathNoTrail();
    var p = stripTrailingSlash(window.location.pathname || "/");
    if (base && p.startsWith(base)) p = p.slice(base.length) || "/";
    if (!p.startsWith("/")) p = "/" + p;
    return p;
  }

  function normalizeForLang(rel, lang) {
    var tail = rel;
    if (tail === "/sl") tail = "/";
    else if (tail.startsWith("/sl/")) tail = tail.slice(3);

    if (lang === "sl") {
      return tail === "/" ? "/sl/" : "/sl" + tail;
    }
    return tail;
  }

  function ensureLink(rel, hrefLang) {
    var selector = hrefLang
      ? 'link[rel="' + rel + '"][hreflang="' + hrefLang + '"]'
      : 'link[rel="' + rel + '"]:not([hreflang])';
    var el = document.head.querySelector(selector);
    if (!el) {
      el = document.createElement("link");
      el.setAttribute("rel", rel);
      if (hrefLang) el.setAttribute("hreflang", hrefLang);
      document.head.appendChild(el);
    }
    return el;
  }

  function applySeoLinks() {
    var base = basePathNoTrail();
    var origin = window.location.origin;
    var rel = relPath();

    var enPath = normalizeForLang(rel, "en");
    var slPath = normalizeForLang(rel, "sl");
    var canonicalPath = rel.startsWith("/sl") ? slPath : enPath;

    var canonical = ensureLink("canonical");
    canonical.setAttribute("href", origin + base + canonicalPath);

    var altEn = ensureLink("alternate", "en");
    altEn.setAttribute("href", origin + base + enPath);

    var altSl = ensureLink("alternate", "sl");
    altSl.setAttribute("href", origin + base + slPath);

    var altDefault = ensureLink("alternate", "x-default");
    altDefault.setAttribute("href", origin + base + enPath);
  }

  document.addEventListener("DOMContentLoaded", applySeoLinks);
  window.addEventListener("popstate", applySeoLinks);
  window.addEventListener("load", applySeoLinks);
})();
