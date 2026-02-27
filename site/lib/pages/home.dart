import 'package:jaspr/jaspr.dart';

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

Component div_({String? id, String? classes, String? style, Map<String, String>? attrs, List<Component> children = const []}) =>
    el('div', id: id, classes: classes, style: style, attrs: attrs, children: children);

Component section_({String? id, String? classes, List<Component> children = const []}) =>
    el('section', id: id, classes: classes, children: children);

Component footer_({String? classes, List<Component> children = const []}) => el('footer', classes: classes, children: children);
Component h1_({String? classes, List<Component> children = const []}) => el('h1', classes: classes, children: children);
Component h2_({String? classes, List<Component> children = const []}) => el('h2', classes: classes, children: children);
Component p_({String? classes, List<Component> children = const []}) => el('p', classes: classes, children: children);
Component ul_({String? classes, List<Component> children = const []}) => el('ul', classes: classes, children: children);
Component li_({List<Component> children = const []}) => el('li', children: children);
Component a_({required String href, String? classes, List<Component> children = const []}) =>
    el('a', classes: classes, attrs: {'href': href}, children: children);
Component img_({required String src, required String alt, String? classes, String? style}) =>
    el('img', classes: classes, style: style, attrs: {'src': src, 'alt': alt});

/* ========= Image paths (put these in web/images/) ========= */

class ImgPath {
  static const logo = 'images/logo.png';
  static const hero = 'images/hero_shot.png';
  static const badgePlay = 'images/play_badge.png';
  static const badgeApp = 'images/app_badge.png';
  static const heroPhone1 = 'images/hero_phone_1.png';
  static const heroPhone2 = 'images/hero_phone_2.png';
  static const work1 = 'images/work_1.png';
  static const work2 = 'images/work_2.png';
  static const cert1 = 'images/cert_1.png';
  static const cert2 = 'images/cert_2.png';
}

/* ========= Page ========= */
/* Keep class name Home if your template routes '/' to Home(). */

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return div_(classes: 'landing', children: [
      const HeroSection(),

      const FeatureSection(
        id: 'work-orders',
        title: 'Work orders',
        altBackground: false,
        visualLeft: true,
        bullets: [
          'Create, assign, and track work orders in real-time, all from your mobile device.',
          'Utilize both preventive and reactive work orders to minimize long-term costs and enhance asset longevity.',
          'Prioritize tasks with urgency levels and due dates, and keep everyone in the loop with real-time status updates.',
          'Incorporate predefined procedures into your work orders to ensure standardized and compliant task execution.',
          'Work orders are completed after inspection and approval from a responsible person, ensuring quality and compliance.',
        ],
        cardA: ImgPath.work1,
        cardB: ImgPath.work2,
      ),

      const FeatureSection(
        id: 'asset-management',
        title: 'Asset management',
        altBackground: true,
        visualLeft: false,
        bullets: [
          'Manage all your assets in one place, from machinery to office equipment.',
          'Easily access the comprehensive service history for each asset.',
          'Utilize QR/bar scans for quick and accurate asset identification and task assignment.',
          'Keep track of all your assets, their locations and details with our organized and searchable database.',
          'Assign assets to specific users or teams for efficient workflow management.',
        ],
        cardA: null,
        cardB: null,
      ),

      const FeatureSection(
        id: 'communication',
        title: 'Communication',
        altBackground: true,
        visualLeft: true,
        bullets: [
          'Keep everybody connected in one place with our built-in-messaging system.',
          'Maintain seamless communication within work orders through our dedicated chat based comment section.',
          'Share important updates, files, and photos through our secure and user-friendly interface.',
          'Receive push notifications for immediate attention to critical issues.',
        ],
        cardA: null,
        cardB: null,
      ),

      const FeatureSection(
        id: 'user-management',
        title: 'User management',
        altBackground: true,
        visualLeft: false,
        bullets: [
          '4 user roles Admin, Full user, Operator, Partner operator with customization available to suit different role requirements.',
          'Assign assets and work orders based on user roles for efficient workflow.',
          'Monitor user activity metrics, such as time spent on work orders and number of work orders currently assigned.',
          'Track performance metrics for each user to ensure quality work.',
          'Seamlessly integrate external contractors into your work order processes.',
        ],
        cardA: null,
        cardB: null,
      ),

      const FeatureSection(
        id: 'bim',
        title: 'BIM integration',
        altBackground: true,
        visualLeft: true,
        bullets: [
          'Take the final step in your Building Information Modeling (BIM) journey with our app.',
          'Seamlessly integrate your BIM data into our system for a holistic approach to facility management.',
          'From asset tracking to work order management, make your BIM implementation complete.',
        ],
        cardA: null,
        cardB: null,
      ),

      const LearningCta(),
      const FooterSection(),
    ]);
  }
}

/* ========= Components ========= */

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Component build(BuildContext context) {
    return section_(classes: 'hero', children: [
      div_(classes: 'container heroInner', children: [
        // Top nav row
        div_(classes: 'navRow', children: [
          div_(classes: 'brand', children: [
            img_(src: ImgPath.logo, alt: 'OAsset', classes: 'brandLogo'),
            el('span', classes: 'brandText', children: [t('OAsset')]),
          ]),
          div_(classes: 'navRight', children: [
            el('button', classes: 'langBtn', attrs: {'type': 'button'}, children: [
              el('span', classes: 'langIcon'),
              t('Slo'),
            ]),
            a_(href: '#get-started', classes: 'pillBtn', children: [t('Get Started')]),
          ]),
        ]),

        // Main hero grid
        div_(classes: 'heroGrid', children: [
          div_(classes: 'heroText', children: [
            h1_(classes: 'h1', children: [t('Systematic maintenance app')]),
            p_(classes: 'sub', children: [
              t('Utilize our app to make maintenance easier, more efficient and lower its costs')
            ]),
            div_(classes: 'badges', children: [
              a_(href: '#', children: [img_(src: ImgPath.badgePlay, alt: 'Google Play', classes: 'storeBadge')]),
              a_(href: '#', children: [img_(src: ImgPath.badgeApp, alt: 'App Store', classes: 'storeBadge')]),
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
  final String id;
  final String title;
  final bool visualLeft;
  final bool altBackground;
  final List<String> bullets;
  final String? cardA;
  final String? cardB;

  const FeatureSection({
    super.key,
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
      h2_(classes: 'title', children: [t(title)]),
      ul_(classes: 'bullets', children: [
        for (final b in bullets)
          li_(children: [
            el('span', classes: 'dot'),
            p_(children: [t(b)]),
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
    return div_(classes: 'placeStack', children:  [
      div_(classes: 'placeholder placeA'),
      div_(classes: 'placeholder placeB'),
    ]);
  }
}

class LearningCta extends StatelessComponent {
  const LearningCta({super.key});

  @override
  Component build(BuildContext context) {
    return section_(classes: 'cta', children: [
      div_(classes: 'container', children: [
        div_(classes: 'ctaGrid', children: [
          div_(classes: 'ctaVisual', children:  [
            div_(classes: 'ctaStack', children: [
              div_(classes: 'ctaCard c1'),
              div_(classes: 'ctaCard c2'),
              div_(classes: 'ctaCard c3'),
            ]),
          ]),
          div_(classes: 'ctaText', children: [
            h2_(classes: 'title', children: [t('Learn how to use our app')]),
            p_(children: [
              t('Get to know our app in our learning center. It covers everything from getting started to managing work orders and using advanced features.')
            ]),
            div_(style: 'margin-top:16px;', children: [
              a_(href: '#', classes: 'ctaBtn', children: [t('Go to learning center'), t(' ▶')]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}

class FooterSection extends StatelessComponent {
  const FooterSection({super.key});

  @override
  Component build(BuildContext context) {
    return footer_(classes: 'footer', children: [
      div_(classes: 'container', children: [
        div_(classes: 'footerRow', children: [
          div_(classes: 'footerLeft', children: [t('© 2026 OAsset. All rights reserved.')]),
          div_(classes: 'footerRight', children: [
            t('by Optimiraj d.o.o.'), el('br'),
            t('e: info@optimiraj.com'),
            div_(classes: 'badgeColumn', children: [
              div_(classes: 'cert', children: [
                img_(src: ImgPath.cert1, alt: 'Certificate 1', style: 'width:100%;height:auto;border-radius:10px;display:block;'),
              ]),
              div_(classes: 'cert', children: [
                img_(src: ImgPath.cert2, alt: 'Certificate 2', style: 'width:100%;height:auto;border-radius:10px;display:block;'),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }
}