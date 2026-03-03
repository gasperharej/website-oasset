import 'package:jaspr/jaspr.dart';
import '../pages/home.dart' show i18n; // or wherever your i18n(...) helper lives
import 'lang.dart';
import 'sl.dart';

String _fallbackFor(Lang lang, String key, String enText) {
  if (lang == Lang.en) return enText;
  return kSl[key] ?? enText; // if missing SL key, you’ll see EN (helps you catch gaps)
}

Component tx(Lang lang, String key, String enText) {
  return i18n(key, _fallbackFor(lang, key, enText));
}