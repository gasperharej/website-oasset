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
        tag: 'script',
        attributes: {'src': 'sticky-topbar.js', 'defer': ''},
      ),
    ],
    body: App(),
  ));
}
