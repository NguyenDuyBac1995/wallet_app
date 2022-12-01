class Translate {
  String? context;
  String? key;

  Translate({this.context, this.key});

  Translate.fromJson(Map<String, dynamic> json) {
    context = json['TranslateContext'];
    key = json['TranslateKey'];
  }
}
