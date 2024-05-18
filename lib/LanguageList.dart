import 'package:flutter/material.dart';

class Language {
  final int id;
  final String name;
  //final String flag;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);
  @override
  bool operator ==(Object other) => other is Language && other.id == id;
  @override
  int get hasCode => id.hashCode;
  // language lists
  static List<Language> setLanguage() {
    return <Language>[
      Language(1, '🇪🇹 Amharic', 'am'),
      Language(2, '🇺🇸 English', 'en'),
    ];
  }
}
