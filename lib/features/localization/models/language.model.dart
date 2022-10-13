class Language {
  final String name;
  final String flag;
  final String code;
  Language(this.name, this.flag, this.code);
  static List<Language> languages() => <Language>[
        Language('English', 'assets/images/flags/en.png', 'en'),
        Language('Tiếng Việt', 'assets/images/flags/vi.png', 'vi'),
      ];
}
