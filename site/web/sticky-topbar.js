(() => {
    const landing = document.querySelector('.landing'); // your scroll container
    const hero = document.querySelector('.hero');
    const bar = document.getElementById('stickyBar');
    if (!landing || !hero || !bar) return;
  
    const setShown = (shown) => bar.classList.toggle('isShown', !!shown);
    const LANG_KEY = 'oasset.lang';
    const normalizeLang = (lang) => (lang === 'Sl' ? 'Sl' : 'En');
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
      try {
        localStorage.setItem(LANG_KEY, value);
      } catch (_) {}
    };
    window.__setLang = applyLang;
    try {
      applyLang(localStorage.getItem(LANG_KEY) || 'En', false);
    } catch (_) {
      applyLang('En', false);
    }
  
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