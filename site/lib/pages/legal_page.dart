import 'package:jaspr/jaspr.dart';

import '../i18n/lang.dart';
import '../i18n/page_ctx.dart';
import '../i18n/i18n.dart';
import '../routes.dart';

// Reuse helpers + FooterSection + ImgPath from home.dart to keep styling identical.
import 'home.dart' show
  el, t, div_, section_, h1_, h2_, p_, a_, img_,
  FooterSection, ImgPath, hrefFromRoutePath;

class LegalPage extends StatelessComponent {
  final PageCtx ctx;
  const LegalPage({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    final copy = _legalCopy(ctx.lang);

    return div_(
      classes: 'legalPage',
      attrs: {
        'onclick':
            "document.querySelectorAll('.langDrop.open').forEach(function(dd){dd.classList.remove('open');});"
      },
      children: [
        LegalStickyBar(ctx: ctx),

        // Auto-scroll to section based on route OR hash.
        el('script', children: [
          t(r"""
(function () {
  function sectionFromPath(path) {
    if (!path) return null;
    if (path.endsWith('/privacy-policy')) return 'privacy';
    if (path.endsWith('/terms-of-service')) return 'terms';
    return null;
  }

  function targetId() {
    var id = (location.hash || '').replace('#', '');
    if (!id) id = sectionFromPath(location.pathname);
    return id || null;
  }

  function scrollToSection(id) {
    if (!id) return;
    var targetEl = document.getElementById(id);
    if (!targetEl) return false;

    var scroller = document.querySelector('.legalPage');
    if (!scroller) {
      targetEl.scrollIntoView({ block: 'start' });
      return true;
    }

    var sticky = document.getElementById('stickyBar');
    var stickyH = sticky ? sticky.getBoundingClientRect().height : 0;
    var scrollerRect = scroller.getBoundingClientRect();
    var targetRect = targetEl.getBoundingClientRect();
    var targetTopInScroller = scroller.scrollTop + (targetRect.top - scrollerRect.top);
    var extraGap = 12; // keep heading visually below sticky bar
    var top = Math.max(0, targetTopInScroller - stickyH - extraGap);

    scroller.scrollTo({ top: top, behavior: 'auto' });
    return true;
  }

  function runWithRetries() {
    var id = targetId();
    if (!id) return;

    // Multiple passes because SPA hydration/render can reset scroll position.
    scrollToSection(id);
    setTimeout(function () { scrollToSection(id); }, 60);
    setTimeout(function () { scrollToSection(id); }, 180);
    setTimeout(function () { scrollToSection(id); }, 420);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', runWithRetries);
  } else {
    runWithRetries();
  }

  window.addEventListener('load', runWithRetries);
  window.addEventListener('pageshow', runWithRetries);
  window.addEventListener('hashchange', runWithRetries);
  window.addEventListener('popstate', runWithRetries);
})();
""")
        ]),

        div_(classes: 'legalMain', children: [
          div_(classes: 'container legalContent', children: [
            section_(id: 'terms', classes: 'legalSection', children: [
              h1_(classes: 'legalH1', children: [t(copy.termsTitle)]),
              for (final p in copy.termsParagraphs)
                p_(classes: 'legalP', children: [t(p)]),
            ]),

            section_(id: 'privacy', classes: 'legalSection', children: [
              h2_(classes: 'legalH2', children: [t(copy.privacyTitle)]),
              for (final p in copy.privacyParagraphs)
                p_(classes: 'legalP', children: [t(p)]),
            ]),

            section_(id: 'legal', classes: 'legalSection', children: [
              h2_(classes: 'legalH2', children: [t(copy.legalTitle)]),
              for (final p in copy.legalParagraphs)
                p_(classes: 'legalP', children: [t(p)]),
            ]),
          ]),
        ]),

        // same footer as homepage
        FooterSection(ctx: ctx),
      ],
    );
  }
}

class LegalStickyBar extends StatelessComponent {
  final PageCtx ctx;
  const LegalStickyBar({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    final isSl = ctx.lang == Lang.sl;

    // Only: brand + lang + sign in + contact us
    return div_(id: 'stickyBar', classes: 'stickyBar isShown stickyBarLegal', children: [
      div_(classes: 'container', children: [
        div_(classes: 'stickyRow', children: [
          el('a', classes: 'brand brandBtn', attrs: {
            'href': hrefFromRoutePath(isSl ? '${Routes.homeSl}/' : Routes.homeEn),
          }, children: [
            img_(src: ImgPath.logoBlack, alt: 'OAsset', classes: 'brandLogo'),
          ]),

          div_(classes: 'stickyRight', children: [
            // Sign in
            a_(
              href: hrefFromRoutePath(Routes.signIn),
              classes: 'stickyBtn stickyBtnOutline',
              children: [tx(ctx.lang, 'nav.sign_in', 'Sign In')],
            ),

            // Contact us (copy)
            el('a', classes: 'stickyBtn stickyBtnSolid', attrs: {
              'href': '#',
              'data-copy': 'info@oasset.app',
              'data-toast-key': 'toast.email_copied',
            }, children: [
              tx(ctx.lang, 'nav.contact_us', 'Contact us')
            ]),

            // Language dropdown
            div_(classes: 'stickyLang', children: [
              div_(classes: 'langDrop', attrs: {'onclick': 'event.stopPropagation();'}, children: [
                el('a', classes: 'langTrigger', attrs: {
                  'href': '#',
                  'onclick':
                      "event.preventDefault(); event.stopPropagation(); this.closest('.langDrop').classList.toggle('open');"
                }, children: [
                  el('span', classes: 'globeIcon', attrs: {'aria-hidden': 'true'}),
                  el('span', classes: 'langValue', children: [t(ctx.lang.label)]),
                ]),
                el('div', classes: 'langMenu', children: [
                  el('a',
                      classes: isSl ? 'langItem' : 'langItem active',
                      attrs: {
                        'href': hrefFromRoutePath(ctx.enPath),
                        'data-lang': 'En',
                        'onclick': "event.stopPropagation(); this.closest('.langDrop').classList.remove('open');"
                      },
                      children: [
                        el('span', classes: 'langItemLabel', children: [t('English')]),
                        el('span', classes: 'langCheck', children: [t('✓')]),
                      ]),
                  el('a',
                      classes: isSl ? 'langItem active' : 'langItem',
                      attrs: {
                        'href': hrefFromRoutePath(ctx.slPath),
                        'data-lang': 'Sl',
                        'onclick': "event.stopPropagation(); this.closest('.langDrop').classList.remove('open');"
                      },
                      children: [
                        el('span', classes: 'langItemLabel', children: [t('Slovenščina')]),
                        el('span', classes: 'langCheck', children: [t('✓')]),
                      ]),
                ]),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}

class _LegalCopy {
  final String termsTitle;
  final String privacyTitle;
  final String legalTitle;
  final List<String> termsParagraphs;
  final List<String> privacyParagraphs;
  final List<String> legalParagraphs;

  const _LegalCopy({
    required this.termsTitle,
    required this.privacyTitle,
    required this.legalTitle,
    required this.termsParagraphs,
    required this.privacyParagraphs,
    required this.legalParagraphs,
  });
}

_LegalCopy _legalCopy(Lang lang) {
  if (lang == Lang.sl) {
    return const _LegalCopy(
      termsTitle: 'Pogoji uporabe',
      privacyTitle: 'Politika zasebnosti',
      legalTitle: 'Pravno obvestilo',
      termsParagraphs: [
        'Tukaj vpiši slovensko besedilo pogojev uporabe. Razdeli ga na več odstavkov.',
        'TEST TEXT: To je testno besedilo za razdelek Pogoji uporabe.',
        'TEST TEXT SLO TERMS 01: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 02: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 03: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 04: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 05: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 06: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 07: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 08: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 09: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 10: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 11: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO TERMS 12: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
      ],
      privacyParagraphs: [
        'Tukaj vpiši slovensko besedilo politike zasebnosti.',
        'TEST TEXT: To je testno besedilo za razdelek Politika zasebnosti.',
        'TEST TEXT SLO PRIVACY 01: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 02: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 03: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 04: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 05: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 06: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 07: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 08: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 09: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 10: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 11: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO PRIVACY 12: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
      ],
      legalParagraphs: [
        'Tukaj vpiši slovensko pravno obvestilo.',
        'TEST TEXT: To je testno besedilo za razdelek Pravno obvestilo.',
        'TEST TEXT SLO LEGAL 01: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 02: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 03: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 04: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 05: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 06: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 07: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 08: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 09: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 10: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 11: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
        'TEST TEXT SLO LEGAL 12: Dolgo testno besedilo za preverjanje drsenja do pravilnega odstavka.',
      ],
    );
  }

  return const _LegalCopy(
    termsTitle: 'Terms of Service',
    privacyTitle: 'Privacy Policy',
    legalTitle: 'Legal',
    termsParagraphs: [
      'Paste your Terms of Service text here. Split it into multiple paragraphs.',
      'TEST TEXT: This is test text for the Terms of Service section.',
      'TEST TEXT EN TERMS 01: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 02: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 03: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 04: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 05: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 06: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 07: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 08: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 09: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 10: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 11: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN TERMS 12: Long test paragraph used to validate scroll target precision.',
    ],
    privacyParagraphs: [
      'Paste your Privacy Policy text here.',
      'TEST TEXT: This is test text for the Privacy Policy section.',
      'TEST TEXT EN PRIVACY 01: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 02: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 03: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 04: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 05: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 06: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 07: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 08: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 09: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 10: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 11: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN PRIVACY 12: Long test paragraph used to validate scroll target precision.',
    ],
    legalParagraphs: [
      'Paste your legal notice here.',
      'TEST TEXT: This is test text for the Legal section.',
      'TEST TEXT EN LEGAL 01: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 02: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 03: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 04: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 05: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 06: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 07: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 08: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 09: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 10: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 11: Long test paragraph used to validate scroll target precision.',
      'TEST TEXT EN LEGAL 12: Long test paragraph used to validate scroll target precision.',
    ],
  );
}