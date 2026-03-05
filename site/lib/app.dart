import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'i18n/lang.dart';
import 'i18n/page_ctx.dart';
import 'pages/home.dart';
import 'pages/legal_page.dart';
import 'routes.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        Route(
          path: Routes.homeEn,
          title: 'Home',
          builder: (_, __) => Home(ctx: const PageCtx(lang: Lang.en, enPath: Routes.homeEn, slPath: Routes.homeSl)),
        ),
        Route(
          path: Routes.homeSl,
          title: 'Domov',
          builder: (_, __) => Home(ctx: const PageCtx(lang: Lang.sl, enPath: Routes.homeEn, slPath: Routes.homeSl)),
        ),

        Route(
          path: Routes.termsEn,
          title: 'Terms of Service',
          builder: (_, __) => LegalPage(ctx: const PageCtx(lang: Lang.en, enPath: Routes.termsEn, slPath: Routes.termsSl)),
        ),
        Route(
          path: Routes.termsSl,
          title: 'Pogoji uporabe',
          builder: (_, __) => LegalPage(ctx: const PageCtx(lang: Lang.sl, enPath: Routes.termsEn, slPath: Routes.termsSl)),
        ),

        Route(
          path: Routes.privacyEn,
          title: 'Privacy Policy',
          builder: (_, __) => LegalPage(ctx: const PageCtx(lang: Lang.en, enPath: Routes.privacyEn, slPath: Routes.privacySl)),
        ),
        Route(
          path: Routes.privacySl,
          title: 'Politika zasebnosti',
          builder: (_, __) => LegalPage(ctx: const PageCtx(lang: Lang.sl, enPath: Routes.privacyEn, slPath: Routes.privacySl)),
        ),

        Route(
          path: Routes.legalEn,
          title: 'Legal',
          builder: (_, __) => LegalPage(ctx: const PageCtx(lang: Lang.en, enPath: Routes.legalEn, slPath: Routes.legalSl)),
        ),
        Route(
          path: Routes.legalSl,
          title: 'Pravno obvestilo',
          builder: (_, __) => LegalPage(ctx: const PageCtx(lang: Lang.sl, enPath: Routes.legalEn, slPath: Routes.legalSl)),
        ),
      ],
    );
  }
}