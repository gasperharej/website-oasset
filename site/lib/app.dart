import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'i18n/lang.dart';
import 'i18n/page_ctx.dart';
import 'pages/home.dart';
// import 'pages/pricing.dart';
import 'routes.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(
      routes: [
        Route(
          path: Routes.homeSl,
          title: 'Domov',
          builder: (_, __) => Home(ctx: const PageCtx(lang: Lang.sl, enPath: Routes.homeEn, slPath: Routes.homeSl)),
        ),
        Route(
          path: Routes.homeEn,
          title: 'Home',
          builder: (_, __) => Home(ctx: const PageCtx(lang: Lang.en, enPath: Routes.homeEn, slPath: Routes.homeSl)),
        ),

        // Example subpage pair:
        // Route(
        //   path: Routes.pricingEn,
        //   title: 'Pricing',
        //   builder: (_, __) => Pricing(ctx: const PageCtx(lang: Lang.en, enPath: Routes.pricingEn, slPath: Routes.pricingSl)),
        // ),
        // Route(
        //   path: Routes.pricingSl,
        //   title: 'Cenik',
        //   builder: (_, __) => Pricing(ctx: const PageCtx(lang: Lang.sl, enPath: Routes.pricingEn, slPath: Routes.pricingSl)),
        // ),
      ],
    );
  }
}