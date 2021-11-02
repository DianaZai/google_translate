class TranslationModel {
  String translatedText;

  TranslationModel.fromJson(Map<String, dynamic> json)
      : translatedText = json['translatedText'];
}
