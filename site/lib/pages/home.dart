import 'package:jaspr/jaspr.dart';
import '../i18n/page_ctx.dart';
import '../i18n/i18n.dart'; // tx(...)
import '../i18n/lang.dart';
import '../routes.dart';

/* ========= Jaspr element helpers ========= */

Component el(
  String tag, {
  String? id,
  String? classes,
  String? style,
  Map<String, String>? attrs,
  List<Component> children = const [],
}) {
  final a = <String, String>{};
  if (id != null && id.isNotEmpty) a['id'] = id;
  if (classes != null && classes.isNotEmpty) a['class'] = classes;
  if (style != null && style.isNotEmpty) a['style'] = style;
  if (attrs != null) a.addAll(attrs);
  return Component.element(tag: tag, attributes: a.isEmpty ? null : a, children: children);
}

Component t(String s) => Component.text(s);

Component i18n(String key, String fallback) =>
    el('span', attrs: {'data-i18n': key}, children: [t(fallback)]);

Component div_({String? id, String? classes, String? style, Map<String, String>? attrs, List<Component> children = const []}) =>
    el('div', id: id, classes: classes, style: style, attrs: attrs, children: children);

Component section_({String? id, String? classes, List<Component> children = const []}) =>
    el('section', id: id, classes: classes, children: children);

Component footer_({String? classes, List<Component> children = const []}) => el('footer', classes: classes, children: children);
Component h1_({String? classes, List<Component> children = const []}) => el('h1', classes: classes, children: children);
Component h2_({String? classes, List<Component> children = const []}) => el('h2', classes: classes, children: children);
Component h3_({String? classes, List<Component> children = const []}) => el('h3', classes: classes, children: children);
Component p_({String? classes, List<Component> children = const []}) => el('p', classes: classes, children: children);
Component span_({String? classes, List<Component> children = const []}) => el('span', classes: classes, children: children);
Component ul_({String? classes, List<Component> children = const []}) => el('ul', classes: classes, children: children);
Component li_({List<Component> children = const []}) => el('li', children: children);
Component a_({required String href, String? classes, List<Component> children = const []}) =>
    el('a', classes: classes, attrs: {'href': href}, children: children);
Component img_({required String src, required String alt, String? classes, String? style}) =>
    el('img', classes: classes, style: style, attrs: {'src': src, 'alt': alt});

/* ========= Link helper (base-tag friendly) ========= */

String hrefFromRoutePath(String routePath) => routePath;

/* ========= Image paths (put these in web/images/) ========= */

class ImgPath {
  static const logo = 'images/only_logo.svg';
  static const logoWhite = 'images/logo_white.svg';
  static const logoBlack = 'images/logo_black.svg';
  static const hero = 'images/hero_shot.png';
  static const badgePlay = 'images/play_badge.svg';
  static const badgeApp = 'images/app_badge.svg';
  static const heroPhone1 = 'images/hero_phone_1.png';
  static const heroPhone2 = 'images/hero_phone_2.png';
  static const work1 = 'images/work_1.png';
  static const work2 = 'images/work_2.png';
  static const cert1 = 'images/cert_1.png';
  static const cert2 = 'images/cert_2.png';
  static const tickPricing = 'images/tick_pricing.png';
}

/* ========= Page ========= */

class Home extends StatelessComponent {
  final PageCtx ctx;
  const Home({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    return div_(
      classes: 'landing',
      attrs: {
        'onclick':
            "document.querySelectorAll('.langDrop.open').forEach(function(dd){dd.classList.remove('open');});"
      },
      children: [
        StickyTopBar(ctx: ctx),
        HeroSection(ctx: ctx),

        FeatureSection(
          ctx: ctx,
          id: 'work-orders',
          title: 'Work orders',
          altBackground: false,
          visualLeft: true,
          bullets: const [
            'Create, assign, and track work orders in real-time, all from your mobile device.',
            'Utilize both preventive and reactive work orders to minimize long-term costs and enhance asset longevity.',
            'Prioritize tasks with urgency levels and due dates, and keep everyone in the loop with real-time status updates.',
            'Incorporate predefined procedures into your work orders to ensure standardized and compliant task execution.',
            'Work orders are completed after inspection and approval from a responsible person, ensuring quality and compliance.',
          ],
          cardA: ImgPath.work1,
          cardB: ImgPath.work2,
        ),

        FeatureSection(
          ctx: ctx,
          id: 'asset-management',
          title: 'Asset management',
          altBackground: true,
          visualLeft: false,
          bullets: const [
            'Manage all your assets in one place, from machinery to office equipment.',
            'Easily access the comprehensive service history for each asset.',
            'Utilize QR/bar scans for quick and accurate asset identification and task assignment.',
            'Keep track of all your assets, their locations and details with our organized and searchable database.',
            'Assign assets to specific users or teams for efficient workflow management.',
          ],
          cardA: null,
          cardB: null,
        ),

        FeatureSection(
          ctx: ctx,
          id: 'communication',
          title: 'Communication',
          altBackground: true,
          visualLeft: true,
          bullets: const [
            'Keep everybody connected in one place with our built-in-messaging system.',
            'Maintain seamless communication within work orders through our dedicated chat based comment section.',
            'Share important updates, files, and photos through our secure and user-friendly interface.',
            'Receive push notifications for immediate attention to critical issues.',
          ],
          cardA: null,
          cardB: null,
        ),

        FeatureSection(
          ctx: ctx,
          id: 'user-management',
          title: 'User management',
          altBackground: true,
          visualLeft: false,
          bullets: const [
            '4 user roles Admin, Full user, Operator, Partner operator with customization available to suit different role requirements.',
            'Assign assets and work orders based on user roles for efficient workflow.',
            'Monitor user activity metrics, such as time spent on work orders and number of work orders currently assigned.',
            'Track performance metrics for each user to ensure quality work.',
            'Seamlessly integrate external contractors into your work order processes.',
          ],
          cardA: null,
          cardB: null,
        ),

        FeatureSection(
          ctx: ctx,
          id: 'bim',
          title: 'BIM integration',
          altBackground: true,
          visualLeft: true,
          bullets: const [
            'Take the final step in your Building Information Modeling (BIM) journey with our app.',
            'Seamlessly integrate your BIM data into our system for a holistic approach to facility management.',
            'From asset tracking to work order management, make your BIM implementation complete.',
          ],
          cardA: null,
          cardB: null,
        ),

        LearningCta(ctx: ctx),
        PricingSection(ctx: ctx),
        FooterSection(ctx: ctx),
      ],
    );
  }
}

/* ========= Components ========= */

class StickyTopBar extends StatelessComponent {
  final PageCtx ctx;
  const StickyTopBar({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    final isSl = ctx.lang == Lang.sl;

    return div_(id: 'stickyBar', classes: 'stickyBar', children: [
      div_(classes: 'container', children: [
        div_(classes: 'stickyRow', children: [
          el('a', classes: 'brand brandBtn', attrs: {
            'href': hrefFromRoutePath(isSl ? '${ctx.slPath}/' : ctx.enPath),
          }, children: [
            img_(src: ImgPath.logoBlack, alt: 'OAsset', classes: 'brandLogo'),
          ]),
          div_(classes: 'stickyRight', children: [
            // Links
            el('a', classes: 'stickyLink', attrs: {
              'href': '#',
              'data-scroll-target': 'learning-center',
            }, children: [
              tx(ctx.lang, 'nav.learning_center', 'Learning center')
            ]),
            el('span', classes: 'navGapDouble', attrs: {'aria-hidden': 'true'}),
            el('a', classes: 'stickyLink', attrs: {
              'href': '#',
              'data-scroll-target': 'pricing',
            }, children: [
              tx(ctx.lang, 'nav.pricing', 'Pricing')
            ]),
            el('span', classes: 'navGapDouble', attrs: {'aria-hidden': 'true'}),
          
            // Buttons
            a_(
              href: hrefFromRoutePath(Routes.signIn),
              classes: 'stickyBtn stickyBtnOutline',
              children: [tx(ctx.lang, 'nav.sign_in', 'Sign In')],
            ),
            el('a', classes: 'stickyBtn stickyBtnSolid', attrs: {
              'href': '#',
              'data-copy': 'info@oasset.app',
              'data-toast-key': 'toast.email_copied',
            }, children: [
              tx(ctx.lang, 'nav.contact_us', 'Contact us')
            ]),
          
            // Language dropdown (reuse the same langDrop markup)
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
                        'href': hrefFromRoutePath('${ctx.slPath}/'),
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

class HeroSection extends StatelessComponent {
  final PageCtx ctx;
  const HeroSection({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    final isSl = ctx.lang == Lang.sl;

    return section_(classes: 'hero', children: [
      div_(classes: 'container heroInner', children: [
        // Top nav row
        div_(classes: 'navRow', children: [
          el('a', classes: 'brand brandBtn', attrs: {
            'href': hrefFromRoutePath(isSl ? '${ctx.slPath}/' : ctx.enPath),
          }, children: [
            img_(src: ImgPath.logoWhite, alt: 'OAsset', classes: 'brandLogo'),
          ]),
          div_(classes: 'navRight', children: [
            // Links
            el('a', classes: 'navLink', attrs: {
              'href': '#',
              'data-scroll-target': 'learning-center',
            }, children: [
              tx(ctx.lang, 'nav.learning_center', 'Learning center')
            ]),
            el('span', classes: 'navGapDouble', attrs: {'aria-hidden': 'true'}),
            el('a', classes: 'navLink', attrs: {
              'href': '#',
              'data-scroll-target': 'pricing',
            }, children: [
              tx(ctx.lang, 'nav.pricing', 'Pricing')
            ]),
            el('span', classes: 'navGapDouble', attrs: {'aria-hidden': 'true'}),
          
            // Buttons
            a_(
              href: hrefFromRoutePath(Routes.signIn),
              classes: 'navBtn navBtnOutline',
              children: [tx(ctx.lang, 'nav.sign_in', 'Sign In')],
            ),
            el('a', classes: 'navBtn navBtnSolid', attrs: {
              'href': '#',
              'data-copy': 'info@oasset.app',
              'data-toast-key': 'toast.email_copied',
            }, children: [
              tx(ctx.lang, 'nav.contact_us', 'Contact us')
            ]),
          
            // Language dropdown (your existing block, unchanged)
            div_(classes: 'navLang', children: [
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
                        'href': hrefFromRoutePath('${ctx.slPath}/'),
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

        // Main hero grid
        div_(classes: 'heroGrid', children: [
          div_(classes: 'heroText', children: [
            h1_(classes: 'h1', children: [
              tx(ctx.lang, 'hero.title', 'Systematic maintenance app'),
            ]),
            p_(classes: 'sub', children: [
              tx(
                ctx.lang,
                'hero.subtitle',
                'Utilize our app to make maintenance easier, more efficient and lower its costs',
              ),
            ]),
            div_(classes: 'badges', children: [
              a_(
                href: 'https://play.google.com/store/',
                children: [img_(src: ImgPath.badgePlay, alt: 'Google Play', classes: 'storeBadge')],
              ),
              a_(
                href: 'https://www.apple.com/app-store/',
                children: [img_(src: ImgPath.badgeApp, alt: 'App Store', classes: 'storeBadge')],
              ),
            ]),
          ]),

          // Visual: big screenshot + 2 phone overlays
          div_(classes: 'heroVisualWrap', children: [
            div_(classes: 'heroVisual', children: [
              img_(src: ImgPath.hero, alt: 'Hero screenshot', classes: 'heroShot'),
              div_(classes: 'phoneCard phoneA', children: [
                img_(src: ImgPath.heroPhone1, alt: 'App screen 1'),
              ]),
              div_(classes: 'phoneCard phoneB', children: [
                img_(src: ImgPath.heroPhone2, alt: 'App screen 2'),
              ]),
            ]),
          ]),
        ]),
      ]),
      div_(classes: 'heroBottom'),
    ]);
  }
}

class FeatureSection extends StatelessComponent {
  final PageCtx ctx;

  final String id;
  final String title;
  final bool visualLeft;
  final bool altBackground;
  final List<String> bullets;
  final String? cardA;
  final String? cardB;

  const FeatureSection({
    super.key,
    required this.ctx,
    required this.id,
    required this.title,
    required this.visualLeft,
    required this.bullets,
    required this.cardA,
    required this.cardB,
    this.altBackground = false,
  });

  @override
  Component build(BuildContext context) {
    final textCol = div_(classes: 'colText', children: [
      h2_(classes: 'title', children: [
        tx(ctx.lang, 'feature.$id.title', title),
      ]),
      ul_(classes: 'bullets', children: [
        for (var i = 0; i < bullets.length; i++)
          li_(children: [
            el('span', classes: 'dot'),
            p_(children: [
              tx(ctx.lang, 'feature.$id.bullet.${i + 1}', bullets[i]),
            ]),
          ]),
      ]),
    ]);

    final visualCol = div_(classes: 'colVisual', children: [
      (cardA != null && cardB != null)
          ? OverlapCards(aSrc: cardA!, bSrc: cardB!)
          : const PlaceholderStack(),
    ]);

    final cols = visualLeft ? <Component>[visualCol, textCol] : <Component>[textCol, visualCol];

    return section_(
      id: id,
      classes: altBackground ? 'section sectionAlt' : 'section',
      children: [
        div_(classes: 'container', children: [
          div_(classes: 'sectionGrid', children: cols),
        ]),
      ],
    );
  }
}

class OverlapCards extends StatelessComponent {
  final String aSrc;
  final String bSrc;
  const OverlapCards({super.key, required this.aSrc, required this.bSrc});

  @override
  Component build(BuildContext context) {
    return div_(classes: 'cards', children: [
      div_(classes: 'phoneCard phoneA', children: [img_(src: aSrc, alt: 'Card A')]),
      div_(classes: 'phoneCard phoneB', children: [img_(src: bSrc, alt: 'Card B')]),
    ]);
  }
}

class PlaceholderStack extends StatelessComponent {
  const PlaceholderStack({super.key});

  @override
  Component build(BuildContext context) {
    return div_(classes: 'placeStack', children: [
      div_(classes: 'placeholder placeA'),
      div_(classes: 'placeholder placeB'),
    ]);
  }
}

class LearningCta extends StatelessComponent {
  final PageCtx ctx;
  const LearningCta({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    return section_(id: 'learning-center', classes: 'cta', children: [
      div_(classes: 'container', children: [
        div_(classes: 'ctaGrid', children: [
          div_(classes: 'ctaVisual', children: [
            div_(classes: 'ctaStack', children: [
              div_(classes: 'ctaCard c1'),
              div_(classes: 'ctaCard c2'),
              div_(classes: 'ctaCard c3'),
            ]),
          ]),
          div_(classes: 'ctaText', children: [
            h2_(classes: 'title', children: [
              tx(ctx.lang, 'cta.title', 'Learn how to use our app'),
            ]),
            p_(children: [
              tx(
                ctx.lang,
                'cta.body',
                'Get to know our app in our learning center. It covers everything from getting started to managing work orders and using advanced features.',
              ),
            ]),
            div_(style: 'margin-top:16px;', children: [
              a_(href: '#', classes: 'ctaBtn', children: [
                tx(ctx.lang, 'cta.button', 'Go to learning center'),
                t(' ▶'),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}

class PricingSection extends StatelessComponent {
  final PageCtx ctx;
  const PricingSection({super.key, required this.ctx});

  Component _checkItem(Component text) {
    return li_(children: [
      span_(classes: 'material-symbols-rounded pricingCheck', children: [t('check_circle')]),
      span_(classes: 'pricingItemText', children: [text]),
    ]);
  }

  @override
  Component build(BuildContext context) {
    return section_(id: 'pricing', classes: 'pricing', children: [
      div_(classes: 'container', children: [
        div_(classes: 'pricingPanel', children: [
          h2_(classes: 'pricingHeading', children: [
            tx(ctx.lang, 'pricing.heading', 'Pricing'),
          ]),

          div_(classes: 'pricingGrid', children: [
            // Premium (outlined)
            div_(classes: 'pricingCard pricingCardPremium', children: [
              h3_(classes: 'pricingPlan', children: [
                tx(ctx.lang, 'pricing.premium.title', 'Premium'),
              ]),
              div_(classes: 'pricingPriceBlock', children: [
                div_(classes: 'pricingPriceValue', children: [t('€37')]),
                div_(classes: 'pricingPriceUnit', children: [
                  tx(ctx.lang, 'pricing.premium.unit', 'per user*/month'),
                ]),
              ]),

              el('a', classes: 'pricingBtn pricingBtnOutline', attrs: {
                'href': '#',
                'data-copy': 'info@oasset.app',
                'data-toast-key': 'toast.email_copied',
              }, children: [
                tx(ctx.lang, 'pricing.contact', 'Contact us')
              ]),

              div_(classes: 'pricingIncludes', children: [
                tx(ctx.lang, 'pricing.includes', "What’s included:"),
              ]),
              ul_(classes: 'pricingList', children: [
                _checkItem(tx(ctx.lang, 'pricing.premium.f1', 'Infinite work orders')),
                _checkItem(tx(ctx.lang, 'pricing.premium.f2', 'Infinite Assets')),
                _checkItem(tx(ctx.lang, 'pricing.premium.f3', 'Infinite Custom Procedures')),
              ]),

              div_(classes: 'pricingFootnote', children: [
                tx(ctx.lang, 'pricing.premium.foot', '*user is individual per person account'),
              ]),
            ]),

            // Enterprise (filled)
            div_(classes: 'pricingCard pricingCardEnterprise', children: [
              h3_(classes: 'pricingPlan', children: [
                tx(ctx.lang, 'pricing.enterprise.title', 'Enterprise'),
              ]),
              div_(classes: 'pricingPriceBlock', children: [
                div_(classes: 'pricingPriceValue', children: [
                  tx(ctx.lang, 'pricing.enterprise.letstalk', "Let’s talk"),
                ]),
                div_(classes: 'pricingPriceUnit', children: [
                  tx(ctx.lang, 'pricing.enterprise.unit', 'Custom pricing'),
                ]),
              ]),

              el('a', classes: 'pricingBtn pricingBtnSolid', attrs: {
                'href': '#',
                'data-copy': 'info@oasset.app',
                'data-toast-key': 'toast.email_copied',
              }, children: [
                tx(ctx.lang, 'pricing.contact', 'Contact us')
              ]),

              div_(classes: 'pricingIncludes', children: [
                tx(ctx.lang, 'pricing.enterprise.includes', 'Everything in Premium and:'),
              ]),
              ul_(classes: 'pricingList', children: [
                _checkItem(tx(ctx.lang, 'pricing.enterprise.f1', 'Photo 360 viewer')),
                _checkItem(tx(ctx.lang, 'pricing.enterprise.f2', 'BIM 3D Viewer')),
                _checkItem(tx(ctx.lang, 'pricing.enterprise.f3', 'Custom GIS implementation')),
                _checkItem(tx(ctx.lang, 'pricing.enterprise.f4', 'Custom integrations')),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}

class FooterSection extends StatelessComponent {
  final PageCtx ctx;
  const FooterSection({super.key, required this.ctx});

  @override
  Component build(BuildContext context) {
    final isSl = ctx.lang == Lang.sl;

    // Update these when you add real pages.
    final termsHref = hrefFromRoutePath(isSl ? '/sl/terms-of-service' : '/terms-of-service');
    final privacyHref = hrefFromRoutePath(isSl ? '/sl/privacy-policy' : '/privacy-policy');
    final legalHref = hrefFromRoutePath(isSl ? '/sl/legal' : '/legal');

    return footer_(classes: 'footer', children: [
      div_(classes: 'container', children: [
        div_(classes: 'footerGrid', children: [
          // Top-left
          div_(classes: 'footerCopy', children: [
            div_(classes: 'footerCopyRow', children: [
              span_(classes: 'footerCopyIcon', children: [t('©')]),
              tx(ctx.lang, 'footer.copyright', '2026 OAsset. All rights reserved.'),
            ]),
          ]),

          // Top-right
          div_(classes: 'footerBy', children: [
            tx(ctx.lang, 'footer.by', 'by Optimiraj d.o.o.'),
          ]),
          
          div_(classes: 'footerEmailWrap', children: [
            el('a', classes: 'footerEmail', attrs: {
              'href': '#',
              'data-copy': 'info@oasset.app',
              'data-toast-key': 'toast.email_copied',
            }, children: [
              t('e: info@oasset.app'),
            ]),
          ]),

          // Bottom-left
          div_(classes: 'footerLinks', children: [
            a_(href: termsHref, classes: 'footerBtn', children: [
              tx(ctx.lang, 'footer.terms', 'Terms of service'),
            ]),
            a_(href: privacyHref, classes: 'footerBtn', children: [
              tx(ctx.lang, 'footer.privacy', 'Privacy policy'),
            ]),
            a_(href: legalHref, classes: 'footerBtn', children: [
              tx(ctx.lang, 'footer.legal', 'Legal'),
            ]),
          ]),

          // Bottom-right
          div_(classes: 'footerCerts', children: [
            div_(classes: 'footerCert', children: [
              img_(src: ImgPath.cert1, alt: 'ISO certificate'),
            ]),
            div_(classes: 'footerCert', children: [
              img_(src: ImgPath.cert2, alt: 'ISO certificate'),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}