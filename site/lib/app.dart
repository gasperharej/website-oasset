import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/header.dart';
import 'pages/about.dart';
import 'pages/home.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    final cssLink = Component.element(
      tag: 'link',
      attributes: const {'rel': 'stylesheet', 'href': 'styles.css'},      
      children: const [],
    );

    return div(classes: 'main', [
      cssLink,
      const Header(),
      Router(routes: [
        Route(path: '/', title: 'Home', builder: (context, state) => const Home()),
        Route(path: '/about', title: 'About', builder: (context, state) => const About()),
      ]),
    ]);
  }
}