(() => {
    const landing = document.querySelector('.landing'); // your scroll container
    const hero = document.querySelector('.hero');
    const bar = document.getElementById('stickyBar');
    if (!landing || !hero || !bar) return;
  
    const setShown = (shown) => bar.classList.toggle('isShown', !!shown);
    const normalizeLang = (lang) => (lang === 'Sl' ? 'Sl' : 'En');
    const currentLangFromUrlOrHtml = () => {
      const htmlLang = (document.documentElement.lang || '').toLowerCase();
      if (htmlLang.startsWith('sl')) return 'Sl';

      const baseEl = document.querySelector('base');
      let basePath = '';
      if (baseEl && baseEl.href) {
        try {
          const u = new URL(baseEl.href, window.location.origin);
          basePath = u.pathname || '';
          if (basePath.length > 1 && basePath.endsWith('/')) {
            basePath = basePath.slice(0, -1);
          }
        } catch (_) {}
      }

      let path = window.location.pathname || '/';
      if (basePath && path.startsWith(basePath)) {
        path = path.slice(basePath.length) || '/';
      }
      if (!path.startsWith('/')) path = '/' + path;
      return path === '/sl' || path.startsWith('/sl/') ? 'Sl' : 'En';
    };
    const animateLangValue = (el, value) => {
      if (el.textContent === value) return;
      if (el.__langFadeTimer) {
        clearTimeout(el.__langFadeTimer);
        el.__langFadeTimer = null;
      }
      el.style.transition = 'opacity 120ms ease';
      el.style.opacity = '0.82';
      el.__langFadeTimer = setTimeout(() => {
        el.textContent = value;
        el.style.opacity = '1';
        el.__langFadeTimer = null;
      }, 60);
    };
    const applyLang = (lang, animate = true) => {
      const value = normalizeLang(lang);
      document.querySelectorAll('.langValue').forEach((el) => {
        if (animate) {
          animateLangValue(el, value);
        } else {
          el.textContent = value;
          el.style.opacity = '1';
        }
      });
      document.querySelectorAll('.langDrop').forEach((drop) => {
        drop.querySelectorAll('.langItem').forEach((item) => {
          item.classList.toggle('active', item.getAttribute('data-lang') === value);
        });
        drop.classList.remove('open');
      });
    };
    window.__setLang = applyLang;
    applyLang(currentLangFromUrlOrHtml(), false);
    window.addEventListener('popstate', () => applyLang(currentLangFromUrlOrHtml(), false));
    window.addEventListener('pageshow', () => applyLang(currentLangFromUrlOrHtml(), false));
  
    if ('IntersectionObserver' in window) {
      const io = new IntersectionObserver(([entry]) => setShown(!entry.isIntersecting), {
        root: landing,
        threshold: 0,
      });
      io.observe(hero);
    } else {
      const onScroll = () => setShown(landing.scrollTop >= hero.offsetHeight - 1);
      landing.addEventListener('scroll', onScroll, { passive: true });
      onScroll();
    }
  })();