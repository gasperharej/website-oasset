/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'package:jaspr/dom.dart';
// Server-specific Jaspr import.
import 'package:jaspr/server.dart';

// Imports the [App] component.
import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(Document(
    title: 'OAsset',
    styles: [
      css.import('https://fonts.googleapis.com/css?family=Roboto'),
      css.import('styles.css'), // no leading "/"
      css('html, body').styles(
        width: 100.percent,
        minHeight: 100.vh,
        padding: .zero,
        margin: .zero,
        fontFamily: const .list([FontFamily('Roboto'), FontFamilies.sansSerif]),
      ),
      css('h1').styles(
        margin: .unset,
        fontSize: 4.rem,
      ),
    ],
    head: [
      Component.element(
        tag: 'base',
        attributes: {'href': '/website-oasset/'}, // GitHub Pages project-site base path
      ),
      Component.element(
        tag: 'link',
        attributes: {'rel': 'icon', 'type': 'image/svg+xml', 'href': 'images/only_logo.svg'},
      ),
      Component.element(
        tag: 'link',
        attributes: {
          'rel': 'stylesheet',
          'href':
              'https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=check_circle'
        },
      ),
      Component.element(
        tag: 'script',
        attributes: {'src': 'sticky-topbar.js', 'defer': ''},
      ),
      Component.element(
        tag: 'script',
        attributes: {'src': 'copy_toast.js', 'defer': ''},
      ),
      Component.element(
        tag: 'script',
        attributes: {'src': 'seo_links.js', 'defer': ''},
      ),
      Component.element(
        tag: 'script',
        attributes: {'src': 'ellipses.js', 'defer': ''},
      ),
    ],
    body: App(),
  ));
}
