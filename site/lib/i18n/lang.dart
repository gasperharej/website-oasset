enum Lang { en, sl }

extension LangX on Lang {
  String get code => this == Lang.sl ? 'sl' : 'en';
  String get label => this == Lang.sl ? 'Sl' : 'En';
}