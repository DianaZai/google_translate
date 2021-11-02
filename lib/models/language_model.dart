class LanguageModel {
  String language;

  LanguageModel.fromJson(Map<String, dynamic> json)
      : language = json['language'];
}
